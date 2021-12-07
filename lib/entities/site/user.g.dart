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
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnSiteUser(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as DateTime,
      fields[7] as String,
      (fields[8] as List).cast<OnSiteTrial>(),
    );
  }

  @override
  void write(BinaryWriter writer, OnSiteUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.picture)
      ..writeByte(5)
      ..write(obj.token)
      ..writeByte(6)
      ..write(obj.tokenDateTime)
      ..writeByte(7)
      ..write(obj.passwordDigit)
      ..writeByte(8)
      ..write(obj.onSiteTrials);
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
