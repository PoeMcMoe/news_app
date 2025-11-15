import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? title;
  final String? description;
  final String? content;
  final String? urlToImage;
  final String? url;
  final String? author;
  final DateTime publishedAt;

  const Article({
    required this.title,
    required this.description,
    required this.content,
    required this.urlToImage,
    required this.url,
    required this.author,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    content,
    urlToImage,
    url,
    author,
    publishedAt,
  ];
}
