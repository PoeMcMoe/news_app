import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ArticleModel extends Article {
  @JsonKey(name: 'urlToImage')
  final String? urlToImage;

  const ArticleModel({
    super.title,
    super.description,
    this.urlToImage,
    required super.publishedAt,
  }) : super(imageUrl: urlToImage);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Article toEntity() => Article(
        title: title,
        description: description,
        imageUrl: imageUrl,
        publishedAt: publishedAt,
      );
}
