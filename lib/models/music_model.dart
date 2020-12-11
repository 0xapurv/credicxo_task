import 'package:hive/hive.dart';

part 'music_model.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject{
  @HiveField(0)
  String trackId;
  @HiveField(1)
  String lyrics;
  @HiveField(2)
  String name;
  @HiveField(3)
  String rating;
  @HiveField(4)
  String instrumental;
  @HiveField(5)
  String explicit;
  @HiveField(6)
  String hasLyrcis;
  @HiveField(7)
  String hasSubs;
  @HiveField(8)
  String hasSync;
  @HiveField(9)
  String favs;
  @HiveField(10)
  String albumId;
  @HiveField(11)
  String albumName;
  @HiveField(12)
  String artistId;
  @HiveField(13)
  String artistName;
  @HiveField(14)
  String url;
  @HiveField(15)
  String lyricUrl;
  @HiveField(16)
  String time;
  @HiveField(17)
  bool isSaved;

  MusicModel(
      {this.trackId,
      this.lyrics,
      this.name,
      this.rating,
      this.instrumental,
      this.explicit,
      this.hasLyrcis,
      this.hasSubs,
      this.hasSync,
      this.favs,
      this.albumId,
      this.albumName,
      this.artistId,
      this.artistName,
      this.url,
      this.lyricUrl,
      this.time,
      this.isSaved,});

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
        trackId: json['track_id'].toString() ?? 'redr0b0t',
        name: json['track_name'].toString() ?? 'demons',
        rating: json['track_rating'].toString(),
        instrumental: json['instrumental'].toString(),
        explicit: json['explicit'].toString(),
        hasLyrcis: json['has_lyrics'].toString(),
        hasSubs: json['has_subtitles'].toString(),
        hasSync: json['has_richsync'].toString(),
        favs: json['num_favourite'].toString(),
        albumId: json['album_id'].toString(),
        albumName: json['album_name'].toString(),
        artistId: json['artist_id'].toString(),
        artistName: json['artist_name'].toString() ?? 'Imagine dragons',
        url: json['track_share_url'].toString(),
        lyricUrl: json['track_edit_url'].toString(),
        isSaved: false
    );
  }
}
