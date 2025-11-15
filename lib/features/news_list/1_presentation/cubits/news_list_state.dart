import 'package:equatable/equatable.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

sealed class NewsListState extends Equatable {
  const NewsListState();

  @override
  List<Object?> get props => [];
}

class NewsListLoading extends NewsListState {
  const NewsListLoading();
}

class NewsListLoaded extends NewsListState {
  final List<Article> articles;

  const NewsListLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class NewsListError extends NewsListState {
  final String message;

  const NewsListError(this.message);

  @override
  List<Object?> get props => [message];
}
