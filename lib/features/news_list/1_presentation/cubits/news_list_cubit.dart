import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/usecases/get_article_list_use_case.dart';

class NewsListCubit extends Cubit<NewsListState> {
  final GetArticleListUseCase getArticleListUseCase;

  NewsListCubit({required this.getArticleListUseCase}) : super(const NewsListLoading());

  Future<void> fetchNewsList() async {
    emit(const NewsListLoading());

    try {
      final List<Article> articles = await getArticleListUseCase();
      emit(NewsListLoaded(articles));
    } catch (e) {
      emit(
        NewsListError(
          'Failed loading news. Please check your connection and try again.',
        ),
      );
    }
  }
}
