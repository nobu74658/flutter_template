// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAuthImpl _$$UserAuthImplFromJson(Map<String, dynamic> json) =>
    _$UserAuthImpl(
      userId: json['userId'] as String,
      email: json['email'] as String?,
      createdAt:
          onlyOneDateTimeToServerTimeConverter.fromJson(json['createdAt']),
      updatedAt: dateTimeToServerTimeConverter.fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$UserAuthImplToJson(_$UserAuthImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'createdAt':
          onlyOneDateTimeToServerTimeConverter.toJson(instance.createdAt),
      'updatedAt': dateTimeToServerTimeConverter.toJson(instance.updatedAt),
    };
