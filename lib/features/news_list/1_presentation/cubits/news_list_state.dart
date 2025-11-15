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

class NewsListLoadingMore extends NewsListState {
  final List<Article> articles;

  const NewsListLoadingMore({required this.articles});
}

class NewsListLoaded extends NewsListState {
  final List<Article> articles;

  const NewsListLoaded({
    required this.articles,
  });

  NewsListLoaded copyWith({
    List<Article>? articles,
    int? currentPage,
  }) => NewsListLoaded(
    articles: articles ?? this.articles,
  );

  @override
  List<Object?> get props => [articles];
}

class NewsListError extends NewsListState {
  final String message;

  const NewsListError(this.message);

  @override
  List<Object?> get props => [message];
}
