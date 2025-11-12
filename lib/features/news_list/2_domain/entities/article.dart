import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime publishedAt;

  const Article({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        imageUrl,
        publishedAt,
      ];
}
