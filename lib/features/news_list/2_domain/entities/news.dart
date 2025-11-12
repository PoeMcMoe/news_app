import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String source;
  final DateTime publishedAt;
  final String? author;
  final String? url;

  const News({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.source,
    required this.publishedAt,
    this.author,
    this.url,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        source,
        publishedAt,
        author,
        url,
      ];
}
