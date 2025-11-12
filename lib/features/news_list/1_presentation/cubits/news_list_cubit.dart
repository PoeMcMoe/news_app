import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/2_domain/entities/news.dart';
import 'package:news_app/features/news_list/2_domain/usecases/get_news_list_use_case.dart';

class NewsListCubit extends Cubit<NewsListState> {
  final GetNewsListUseCase getNewsListUseCase;

  NewsListCubit(this.getNewsListUseCase) : super(const NewsListInitial());

  Future<void> fetchNewsList() async {
    emit(const NewsListLoading());

    final List<News> news = await getNewsListUseCase();

    emit(NewsListLoaded(news));
  }
}
