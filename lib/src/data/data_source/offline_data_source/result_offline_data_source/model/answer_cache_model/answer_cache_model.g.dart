// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckAnswerCachedModelAdapter
    extends TypeAdapter<CheckAnswerCachedModel> {
  @override
  final int typeId = 4;

  @override
  CheckAnswerCachedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckAnswerCachedModel(
      questionId: fields[1] as String?,
      correct: fields[2] as String?,
      currentIndexOptionSelection: fields[3] as int?,
      answerKey: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CheckAnswerCachedModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.correct)
      ..writeByte(3)
      ..write(obj.currentIndexOptionSelection)
      ..writeByte(4)
      ..write(obj.answerKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckAnswerCachedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
