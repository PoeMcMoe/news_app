import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    required super.title,
    required super.description,
    required super.urlToImage,
    required super.url,
    required super.author,
    required super.publishedAt,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Article toEntity() => Article(
    title: title,
    description: description,
    content: content,
    urlToImage: urlToImage,
    url: url,
    author: author,
    publishedAt: publishedAt,
  );
}
