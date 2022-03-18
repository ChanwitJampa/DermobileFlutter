// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnSitePlotAdapter extends TypeAdapter<OnSitePlot> {
  @override
  final int typeId = 2;

  @override
  OnSitePlot read(BinaryReader reader) {
    // final numOfFields = reader.readByte();
    // final fields = <int, dynamic>{
    //   for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    // };
    return OnSitePlot(
      reader.readInt(),
      reader.readString(),
      reader.readInt(),
      reader.readString(),
      reader.readInt(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),
      reader.readInt(),
      reader.readInt(),
      reader.readDouble(),
      reader.readDouble(),
      reader.readInt(),
      reader.readInt(),
      reader.readDouble(),
      reader.readDouble(),
      reader.readInt(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),

      // fields[0] as int,
      // fields[1] as String,
      // fields[2] as String,
      // fields[3] as int,
      // fields[4] as String,
      // fields[5] as int,
      // fields[6] as String,
      // fields[7] as String,
      // fields[8] as String,
      // fields[9] as String,
      // fields[10] as String,
      // fields[11] as int,
      // fields[12] as int,
      // fields[13] as int,
      // fields[14] as double,
      // fields[15] as double,
      // fields[16] as int,
      // fields[17] as int,
      // fields[18] as double,
      // fields[19] as double,
      // fields[20] as int,
      // fields[21] as String,
      // fields[22] as String,
      // fields[23] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OnSitePlot obj) {
    writer
      ..writeInt(obj.pltId)
      ..writeString(obj.barcode)
      ..writeInt(obj.repNo)
      ..writeString(obj.abbrc)
      ..writeInt(obj.entno)
      ..writeString(obj.notet)
      ..writeString(obj.plotImgPath)
      ..writeString(obj.plotImgPathS)
      ..writeString(obj.plotImgBoxPath)
      ..writeString(obj.plotImgBoxPathS)
      ..writeInt(obj.uploadDate)
      ..writeInt(obj.eartnA)
      ..writeInt(obj.dlernA)
      ..writeDouble(obj.dlerpA)
      ..writeDouble(obj.drwapA)
      ..writeInt(obj.eartnM)
      ..writeInt(obj.dlernM)
      ..writeDouble(obj.dlerpM)
      ..writeDouble(obj.drwapM)
      ..writeInt(obj.approveDate)
      ..writeString(obj.plotProgress)
      ..writeString(obj.plotStatus)
      ..writeString(obj.plotActive)
      ..writeInt(obj.isUpload);

    // ..writeByte(24)
    // ..writeByte(0)
    // ..write(obj.plotId)
    // ..writeByte(1)
    // ..write(obj.barcode)
    // ..writeByte(2)
    // ..write(obj.pltId)
    // ..writeByte(3)
    // ..write(obj.repNo)
    // ..writeByte(4)
    // ..write(obj.abbrc)
    // ..writeByte(5)
    // ..write(obj.entno)
    // ..writeByte(6)
    // ..write(obj.notet)
    // ..writeByte(7)
    // ..write(obj.plotImgPath)
    // ..writeByte(8)
    // ..write(obj.plotImgPathS)
    // ..writeByte(9)
    // ..write(obj.plotImgBoxPath)
    // ..writeByte(10)
    // ..write(obj.plotImgBoxPathS)
    // ..writeByte(11)
    // ..write(obj.uploadDate)
    // ..writeByte(12)
    // ..write(obj.eartnA)
    // ..writeByte(13)
    // ..write(obj.dlernA)
    // ..writeByte(14)
    // ..write(obj.dlerpA)
    // ..writeByte(15)
    // ..write(obj.drwapA)
    // ..writeByte(16)
    // ..write(obj.eartnM)
    // ..writeByte(17)
    // ..write(obj.dlernM)
    // ..writeByte(18)
    // ..write(obj.dlerpM)
    // ..writeByte(19)
    // ..write(obj.drwapM)
    // ..writeByte(20)
    // ..write(obj.approveDate)
    // ..writeByte(21)
    // ..write(obj.plotProgress)
    // ..writeByte(22)
    // ..write(obj.plotStatus)
    // ..writeByte(23)
    // ..write(obj.plotActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnSitePlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
