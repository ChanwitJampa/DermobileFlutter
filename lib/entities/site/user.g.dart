// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnSiteUserAdapter extends TypeAdapter<OnSiteUser> {
  @override
  final int typeId = 0;

  @override
  OnSiteUser read(BinaryReader reader) {
    //final numOfFields = reader.readByte();
    // final fields = <int, dynamic>{
    //   for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    // };
    return OnSiteUser(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),
      reader.readString(),
      reader.readList().cast<OnSiteTrial>(),
      reader.readList().cast<OnSitePlot>(),
      reader.readString(),
    );

    // fields[0] as String,
    // fields[1] as String,
    // fields[2] as String,
    // fields[3] as String,
    // (fields[8] as List).cast<OnSiteTrial>());
  }

  @override
  void write(BinaryWriter writer, OnSiteUser obj) {
    writer
      ..writeString(obj.userName)
      ..writeString(obj.firstName)
      ..writeString(obj.lastName)
      ..writeString(obj.picture)
      ..writeString(obj.token)
      ..writeInt(obj.tokenDateTime)
      ..writeString(obj.passwordDigit)
      ..writeList(obj.onSiteTrials)
      ..writeList(obj.unMatchPlots)
      ..writeString(obj.password);
    // writer
    //   ..writeByte(9)
    //   ..writeByte(0)
    //   ..write(obj.userName)
    //   ..writeByte(1)
    //   ..write(obj.firstName)
    //   ..writeByte(2)
    //   ..write(obj.lastName)
    //   ..writeByte(3)
    //   ..write(obj.picture)
    //   ..writeByte(4)
    //   ..write(obj.onSiteTrials);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnSiteUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
