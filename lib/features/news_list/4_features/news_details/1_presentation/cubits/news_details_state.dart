import 'package:equatable/equatable.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

sealed class NewsDetailsState extends Equatable {

  const NewsDetailsState();

  @override
  List<Object?> get props => [];
}

class NewsDetailsInitial extends NewsDetailsState {
  final Article article;

  const NewsDetailsInitial(this.article);
}

class NewsDetailsError extends NewsDetailsState {
  final String message;
  final Article article;

  const NewsDetailsError({required this.message, required this.article});

  @override
  List<Object?> get props => [article, message];
}
