import 'package:equatable/equatable.dart';
import 'package:news_app/features/news_list/2_domain/entities/news.dart';

abstract class NewsListState extends Equatable {
  const NewsListState();

  @override
  List<Object?> get props => [];
}

class NewsListInitial extends NewsListState {
  const NewsListInitial();
}

class NewsListLoading extends NewsListState {
  const NewsListLoading();
}

class NewsListLoaded extends NewsListState {
  final List<News> newsList;

  const NewsListLoaded(this.newsList);

  @override
  List<Object?> get props => [newsList];
}

class NewsListError extends NewsListState {
  final String message;

  const NewsListError(this.message);

  @override
  List<Object?> get props => [message];
}
