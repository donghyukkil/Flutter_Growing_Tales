// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      publishedDate: json['publishedDate'] as String?,
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'thumbnailUrl': instance.thumbnailUrl,
      'pageCount': instance.pageCount,
      'publishedDate': instance.publishedDate,
    };
