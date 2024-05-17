// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtworkAdapter extends TypeAdapter<Artwork> {
  @override
  final int typeId = 0;

  @override
  Artwork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artwork(
      name: fields[0] as String,
      artist: fields[1] as String,
      date: fields[2] as String,
      imglocation: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Artwork obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.imglocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtworkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
