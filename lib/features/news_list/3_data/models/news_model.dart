import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news_list/2_domain/entities/news.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends News {
  const NewsModel({
    required super.id,
    required super.title,
    required super.description,
    super.imageUrl,
    required super.source,
    required super.publishedAt,
    super.author,
    super.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  News toEntity() => News(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        source: source,
        publishedAt: publishedAt,
        author: author,
        url: url,
      );
}
