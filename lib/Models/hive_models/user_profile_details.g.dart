// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelOfUserProfileDetailsAdapter
    extends TypeAdapter<ModelOfUserProfileDetails> {
  @override
  final int typeId = 1;

  @override
  ModelOfUserProfileDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelOfUserProfileDetails(
      userName: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      imagePath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelOfUserProfileDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelOfUserProfileDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
