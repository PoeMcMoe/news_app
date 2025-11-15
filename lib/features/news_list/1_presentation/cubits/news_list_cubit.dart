import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/usecases/get_article_list_use_case.dart';

const int _articlesPageSize = 10;
const int _maxArticles = 30;

class NewsListCubit extends Cubit<NewsListState> {
  final GetArticleListUseCase getArticleListUseCase;

  final List<Article> _currentArticles = [];
  int _pageIndex = 1;

  NewsListCubit({required this.getArticleListUseCase}) : super(const NewsListLoading());

  Future<void> fetchNewsList({bool isRefresh = false}) async {
    try {
      emit(const NewsListLoading());

      if (isRefresh) {
        _currentArticles.clear();
        _pageIndex = 1;
      }

      final List<Article> articles = await getArticleListUseCase(
        page: _pageIndex++,
        pageSize: _articlesPageSize,
      );

      _currentArticles.addAll(articles);

      emit(NewsListLoaded(articles: articles));
    } catch (e) {
      debugPrint('NewsListCubit. fetchNewsList failed: $e');
      emit(
        const NewsListError(
          'Failed loading news. Please check your connection and try again.',
        ),
      );
    }
  }

  Future<void> loadMoreNews() async {
    if (_currentArticles.length >= _maxArticles) {
      emit(NewsListMaxReached(articles: _currentArticles));
      return;
    }

    emit(NewsListLoadingMore(articles: _currentArticles));

    try {
      final List<Article> newArticles = await getArticleListUseCase(
        page: _pageIndex++,
        pageSize: _articlesPageSize,
      );

      _currentArticles.addAll(newArticles);

      if (_currentArticles.length >= _maxArticles) {
        emit(NewsListMaxReached(articles: _currentArticles));
      } else {
        emit(NewsListLoaded(articles: _currentArticles));
      }
    } catch (e) {
      debugPrint('NewsListCubit. loadMoreNews failed: $e');
      emit(
        NewsListError(
          'Failed loading more news. '
          'Please check your connection and try again.',
        ),
      );
    }
  }
}
