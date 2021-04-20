// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveWatchlistModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchProfileAdapter extends TypeAdapter<WatchProfile> {
  @override
  final int typeId = 0;

  @override
  WatchProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchProfile(
      profile: (fields[0] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, WatchProfile obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.profile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
