// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String?,
  source: json['source'] as String,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  author: json['author'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'source': instance.source,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'author': instance.author,
  'url': instance.url,
};
