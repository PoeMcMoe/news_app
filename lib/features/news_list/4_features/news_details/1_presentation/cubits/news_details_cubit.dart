import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

class NewsDetailsCubit extends Cubit<NewsListState> {

  NewsDetailsCubit({required Article article}) : super(const NewsListInitial());
}
