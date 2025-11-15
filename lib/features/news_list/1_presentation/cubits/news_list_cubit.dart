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
  bool _isLoadingMore = false;

  NewsListCubit({required this.getArticleListUseCase}) : super(const NewsListLoading());

  Future<void> fetchNewsList({bool isRefresh = false}) async {
    try {
      emit(const NewsListLoading());

      if (isRefresh) {
        _resetPagination();
      }

      final List<Article> articles = await _loadNextPage();
      _currentArticles.addAll(articles);

      emit(NewsListLoaded(articles: _currentArticles));
    } catch (error) {
      debugPrint('NewsListCubit. fetchNewsList failed: $error');
      emit(
        const NewsListError(
          'Failed loading news. Please check your connection and try again.',
        ),
      );
    }
  }

  Future<List<Article>> _loadNextPage() async {
    return await getArticleListUseCase(
      page: _pageIndex++,
      pageSize: _articlesPageSize,
    );
  }

  void _resetPagination() {
    _currentArticles.clear();
    _pageIndex = 1;
  }

  Future<void> loadMoreNews() async {
    try {
      var maxArticlesReached = _currentArticles.length + _articlesPageSize > _maxArticles;
      if (_isLoadingMore || maxArticlesReached) return;
      _isLoadingMore = true;

      emit(NewsListLoadingMore(articles: _currentArticles));

      final List<Article> newArticles = await _loadNextPage();
      _currentArticles.addAll(newArticles);

      if (maxArticlesReached) {
        emit(NewsListMaxReached(articles: _currentArticles));
      } else {
        emit(NewsListLoaded(articles: _currentArticles));
      }
    } catch (error) {
      debugPrint('NewsListCubit. loadMoreNews failed: $error');
      emit(
        NewsListError(
          'Failed loading more news. '
          'Please check your connection and try again.',
        ),
      );
    } finally {
      _isLoadingMore = false;
    }
  }
}
