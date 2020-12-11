// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicModelAdapter extends TypeAdapter<MusicModel> {
  @override
  final int typeId = 1;

  @override
  MusicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicModel(
      trackId: fields[0] as String,
      lyrics: fields[1] as String,
      name: fields[2] as String,
      rating: fields[3] as String,
      instrumental: fields[4] as String,
      explicit: fields[5] as String,
      hasLyrcis: fields[6] as String,
      hasSubs: fields[7] as String,
      hasSync: fields[8] as String,
      favs: fields[9] as String,
      albumId: fields[10] as String,
      albumName: fields[11] as String,
      artistId: fields[12] as String,
      artistName: fields[13] as String,
      url: fields[14] as String,
      lyricUrl: fields[15] as String,
      time: fields[16] as String,
      isSaved: fields[17] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MusicModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.trackId)
      ..writeByte(1)
      ..write(obj.lyrics)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.instrumental)
      ..writeByte(5)
      ..write(obj.explicit)
      ..writeByte(6)
      ..write(obj.hasLyrcis)
      ..writeByte(7)
      ..write(obj.hasSubs)
      ..writeByte(8)
      ..write(obj.hasSync)
      ..writeByte(9)
      ..write(obj.favs)
      ..writeByte(10)
      ..write(obj.albumId)
      ..writeByte(11)
      ..write(obj.albumName)
      ..writeByte(12)
      ..write(obj.artistId)
      ..writeByte(13)
      ..write(obj.artistName)
      ..writeByte(14)
      ..write(obj.url)
      ..writeByte(15)
      ..write(obj.lyricUrl)
      ..writeByte(16)
      ..write(obj.time)
      ..writeByte(17)
      ..write(obj.isSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
