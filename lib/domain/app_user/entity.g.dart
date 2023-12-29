// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userIcon: json['userIcon'] as String,
      updatedAt: dateTimeToServerTimeConverter.fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userIcon': instance.userIcon,
      'updatedAt': dateTimeToServerTimeConverter.toJson(instance.updatedAt),
    };
