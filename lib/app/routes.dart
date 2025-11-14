import 'package:go_router/go_router.dart';
import 'package:news_app/features/news_list/1_presentation/screens/news_list_screen.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/screens/news_details_screen.dart';

class Routes {
  static GoRoute newsListRoute = GoRoute(
    name: '/',
    path: '/',
    builder: (context, state) => NewsListScreen(),
    routes: [
      newDetailsRoute,
    ],
  );

  static GoRoute newDetailsRoute = GoRoute(
    name: 'news-details',
    path: 'news-details',
    builder: (context, state) => NewsDetailsScreen(
      article: state.extra as Article,
    ),
  );
}
