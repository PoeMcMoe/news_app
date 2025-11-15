// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  title: json['title'] as String?,
  description: json['description'] as String?,
  urlToImage: json['urlToImage'] as String?,
  url: json['url'] as String?,
  author: json['author'] as String?,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  content: json['content'] as String?,
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'urlToImage': instance.urlToImage,
      'url': instance.url,
      'author': instance.author,
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
