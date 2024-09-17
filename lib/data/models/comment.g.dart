// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      diaryId: json['diaryId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diaryId': instance.diaryId,
      'userId': instance.userId,
      'content': instance.content,
      'createAt': instance.createAt?.toIso8601String(),
    };
