import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_state.dart';

class NewsDetailsCubit extends Cubit<NewsDetailsState> {
  NewsDetailsCubit({required Article article}) : super(NewsDetailsInitial(article));
}
