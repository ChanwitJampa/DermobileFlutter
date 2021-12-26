// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnSiteTrialAdapter extends TypeAdapter<OnSiteTrial> {
  @override
  final int typeId = 1;

  @override
  OnSiteTrial read(BinaryReader reader) {
    // final numOfFields = reader.readByte();
    // final fields = <int, dynamic>{
    //   for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    // };
    return OnSiteTrial(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),
      reader.readInt(),
      reader.readList().cast<OnSitePlot>(),

      // fields[0] as String,
      // fields[1] as String,
      // fields[2] as String,
      // fields[3] as String,
      // fields[4] as int,
      // fields[5] as int,
      // (fields[6] as List).cast<OnSitePlot>(),
    );
  }

  @override
  void write(BinaryWriter writer, OnSiteTrial obj) {
    writer
      ..writeString(obj.trialId)
      ..writeString(obj.aliasName)
      ..writeString(obj.trialActive)
      ..writeString(obj.trialStatus)
      ..writeInt(obj.createDate)
      ..writeInt(obj.lastUpdate)
      ..writeList(obj.onSitePlots);

    // ..writeByte(7)
    // ..writeByte(0)
    // ..write(obj.trialId)
    // ..writeByte(1)
    // ..write(obj.aliasName)
    // ..writeByte(2)
    // ..write(obj.trialActive)
    // ..writeByte(3)
    // ..write(obj.trialStatus)
    // ..writeByte(4)
    // ..write(obj.createDate)
    // ..writeByte(5)
    // ..write(obj.lastUpdate)
    // ..writeByte(6)
    // ..write(obj.onSitePlots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnSiteTrialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
