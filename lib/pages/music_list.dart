import 'dart:convert';
import 'dart:async';
import 'package:credicxo_task/api/api_key.dart';
import 'package:credicxo_task/models/music_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:credicxo_task/bloc/connectivity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_task/widgets/song_card.dart';
import 'package:credicxo_task/widgets/loading.dart';
import 'package:credicxo_task/widgets/background.dart';
import 'package:connectivity/connectivity.dart';

//import 'package:credicxo_task/pages/api_error.dart';
import 'package:credicxo_task/widgets/empty_card.dart';
import 'package:credicxo_task/bloc/loading_bloc.dart';
import 'package:credicxo_task/pages/saved_music_list.dart';
import 'package:credicxo_task/bloc/bookmarks_bloc.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List<MusicModel> songs;
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
      appBar: AppBar(
        title: Text("Credicxo"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _bookMarkPage();
                },
                child: Icon(
                  Icons.bookmark_border,
                  size: 26.0,
                ),
              )
          ),
        ],

      ),


      body: Stack(children: <Widget>[
        Background(),
        BlocBuilder<ConnectivityBloc, bool>(builder: (_, connected) {
          if (connected == true) {
            songs ?? fetchMusic();
            return _streamSongs();
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
      ]),
    );
  }

  Widget _streamSongs() {
    return BlocBuilder<LoadingBloc, bool>(builder: (_, loading) {
      if (loading == true) {
        return Loading();
      } else {
        return songs.length == 0
            ? EmptyCard(type: "Tracks(APIkey Error")
            : ListView.builder(
                itemCount : songs.length,
                itemBuilder: (context, index) {
                  print(songs[index].name);
                  return SongCard(
                    song: songs[index],
                    id : index
                  );
                });
      }
    });
  }

  void fetchMusic() async {
    http.Response response = await http.get(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apiKey');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var message = json['message'];
      var header = message['header'];
      var body = message['body'];
      List tracksJSON = [];
      if (body.length == 0) {
        print("api error");
        print("response body is null");
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ApiError()));
      } else {
        tracksJSON = body['track_list'];
        print(tracksJSON[3]);
      }
      songs = (tracksJSON).map((i) => MusicModel.fromJson(i['track'])).toList();
      context.bloc<LoadingBloc>().add(LoadingEvent.off);
    } else {
      throw Exception('Failed to load tracks');
    }
  }

  _bookMarkPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (_) => LoadingBloc(),
                  ),
                  BlocProvider(
                    create: (_) => BookMarkBloc(),
                  ),
                ], child: SavedMusicList())));
  }
}
