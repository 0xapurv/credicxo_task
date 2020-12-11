import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:credicxo_task/api/api_key.dart';
import 'package:credicxo_task/bloc/bookmarks_bloc.dart';
import 'package:credicxo_task/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:credicxo_task/utils/theme..dart';
import 'package:credicxo_task/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:credicxo_task/models/music_model.dart';
import 'package:http/http.dart' as http;
import 'package:credicxo_task/bloc/connectivity_bloc.dart';
import 'package:credicxo_task/bloc/loading_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hive/hive.dart';

class MusicInfo extends StatefulWidget {
  final MusicModel song;
  final int id;

  MusicInfo({
    this.song,
    this.id
  });

  @override
  _MusicInfoState createState() => _MusicInfoState();
}

class _MusicInfoState extends State<MusicInfo> {
  StreamSubscription subscription;

  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        context.bloc<ConnectivityBloc>().add(ConnectivityEvent.off);
      } else {
        context.bloc<ConnectivityBloc>().add(ConnectivityEvent.on);
      }
    });
  }

  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Text("${widget.song.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.4,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                          fontFamily: "RobotoRegular")),
                ),
                background: Image.asset("assets/music.jpg",fit: BoxFit.fill,)),
          ),
        ];
      }, body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Background(),
            BlocBuilder<ConnectivityBloc, bool>(builder: (_, connected) {
              if (connected == true) {
                if (widget.song.lyrics == null) {
                  fetchSongData();
                } else {
                  context.bloc<LoadingBloc>().add(LoadingEvent.off);
                }
                return BlocBuilder<LoadingBloc, bool>(builder: (_, loading) {
                  if (loading == true) {
                    return Loading();
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      //color: Colors.red,
                      child: ListView(
                        children: <Widget>[
                          _bookMarkButton(),
                          descriptionCard(),
                          linksCard(),
                          lyricsCard(),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  }
                });
              } else {
                return Center(
                    child: Chip(
                        label: Text(
                  "Not Connected",
                  style: TextStyle(color: Colors.purple, fontSize: 30),
                  textAlign: TextAlign.center,
                )));
              }
            })
          ],
        );
      })),
    );
  }

  Widget _bookMarkButton() {
    return BlocBuilder<BookMarkBloc, BookMarkEvent>(builder: (_, event) {
      String getText() {
        String txt;
        if (event == BookMarkEvent.neutral) {
          txt = widget.song.isSaved ? "Remove bookmark" : 'Bookmark this song';
        } else {
          txt = event == BookMarkEvent.added
              ? "Remove bookmark"
              : 'Bookmark this song';
        }
        return txt;
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        //width: MediaQuery.of(context).size.width * 0.5,
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          color: Colors.blue,
          onPressed: () {
            if (event == BookMarkEvent.neutral) {
              widget.song.isSaved ? _remBookmark() : _addBookmark();
            } else {
              event == BookMarkEvent.added ? _remBookmark() : _addBookmark();
            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: Text(
              getText(),
              style: TextStyle(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'RobotoMedium'),
            ),
          ),
        ),
      );
    });
  }

  Widget descriptionCard() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                '${'Description'} ',
                style: subtitle,
              ),
            ),
            Divider(),
            new Text(
              "Song Name:\t\t\t${widget.song.name}\n\n"
              "Artist Name:\t\t\t${widget.song.artistName}\n\n"
              "Album Name:\t\t\t${widget.song.albumName}\n\n"
              "Explicit:\t\t\t${widget.song.explicit == '0' ? "No" : "Yes"}\n\n"
              "Rating:\t\t\t${widget.song.rating}\n\n"
              "Favourites:\t\t\t${widget.song.favs}\n\n",
              style: description,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget linksCard() {
    return Card(
        color: Colors.white.withOpacity(0.9),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  ' Links :',
                  style: subtitle,
                ),
              ),
            Divider(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    //color: Colors.white,

                    ),
                child: IconButton(
                  onPressed: () {
                    launch(widget.song.url);
                  },
                  icon: Icon(FontAwesomeIcons.music),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    //color: Colors.white,

                    ),
                child: IconButton(
                  onPressed: () {
                    launch(widget.song.lyricUrl);
                  },
                  icon: Icon(FontAwesomeIcons.envelopeOpenText),
                ),
              ),
            ],
          ),
        ));
  }

  Widget lyricsCard() {
    return Card(
        color: Colors.white.withOpacity(0.9),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  ' Lyrics :',
                  style: subtitle,
                ),
              ),
              Divider(
                thickness:2,
              ),
              Text(
                widget.song.lyrics,
                style: description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  Widget background() {
    return Center(
      child: Image.asset('assets/song.png',
      fit: BoxFit.fill,),
    );
  }

  _addBookmark() async {
    Box _trackBox = await Hive.openBox('trackBox');
    widget.song.isSaved = true;
    _trackBox.add(widget.song);

    Fluttertoast.showToast(
        msg: "This song is added to bookmarks successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    context.bloc<BookMarkBloc>().add(BookMarkEvent.added);
  }

  _remBookmark() async {
    Box _trackBox = await Hive.openBox('trackBox');
    for (int i = 0; i < _trackBox.length; i++) {
      MusicModel track = _trackBox.getAt(i);
      if (track.trackId == widget.song.trackId) {
        widget.song.isSaved = false;
        track.delete();
      }
      context.bloc<BookMarkBloc>().add(BookMarkEvent.removed);
    }

    Fluttertoast.showToast(
        msg: "This song is removed from bookmarks successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void getMusicInfo() async {
    //data already stored in MusicModel
    http.Response response = await http.get(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${widget.song.trackId}&apikey=$apiKey');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
    } else {
      throw Exception('Failed to load track data');
    }
  }

  void getSongLyrics() async {
    http.Response response = await http.get(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${widget.song.trackId}&apikey=$apiKey');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print("Lyrics response=$json");
      String lyrics = json['message']['body']['lyrics']['lyrics_body'];
      widget.song.lyrics = lyrics;
    } else {
      throw Exception('Failed to load track data');
    }
  }

  void fetchSongData() async {
    await getSongLyrics();
    // await getMusicInfo();
    context.bloc<LoadingBloc>().add(LoadingEvent.off);
  }
}
