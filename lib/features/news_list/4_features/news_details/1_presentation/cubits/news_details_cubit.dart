import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/helpers/url_launcher_helper.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_state.dart';

class NewsDetailsCubit extends Cubit<NewsDetailsState> {
  final UrlLauncherHelper urlLauncherHelper;
  final Article article;

  NewsDetailsCubit({
    required this.article,
    required this.urlLauncherHelper,
  }) : super(NewsDetailsInitial(article));

  Future<void> launchArticleUrl() async {
    try {
      //If URL is empty fab should not built
      // leaving the user with no way to trigger this, hence the null check
      await urlLauncherHelper.openUrl(article.url!);
    } catch (exception, stack) {
      debugPrint(
        'NewsDetailsCubit. launchArticleUrl failed: $exception,\n$stack',
      );
      emit(
        NewsDetailsError(
          //Subsequent errors were not being displayed so I added the errorId
          errorId: UniqueKey().toString(),
          article: article,
          message: 'Url could not be opened.',
        ),
      );
    }
  }
}
