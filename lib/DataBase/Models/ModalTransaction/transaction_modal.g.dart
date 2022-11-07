// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModalAdapter extends TypeAdapter<TransactionModal> {
  @override
  final int typeId = 3;

  @override
  TransactionModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModal(
      notes: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as CategoryType,
      categoryTransaction: fields[4] as CategoryModel,
    )..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, TransactionModal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.notes)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.categoryTransaction)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionDbAmountAdapter extends TypeAdapter<TransactionDbAmount> {
  @override
  final int typeId = 4;

  @override
  TransactionDbAmount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionDbAmount(
      income: fields[1] as double,
      id: fields[0] as String?,
      expence: fields[2] as double,
      total: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionDbAmount obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.expence)
      ..writeByte(3)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionDbAmountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
