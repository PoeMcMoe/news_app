import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_cubit.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/1_presentation/widgets/app_article_card.dart';
import 'package:news_app/main.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewsListCubit>()..fetchNewsList(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<NewsListCubit, NewsListState>(
          builder: (context, state) {
            if (state is NewsListLoading) {
              return _buildLoadingIndicator();
            } else if (state is NewsListLoaded) {
              return _buildNewsList(context, state);
            } else if (state is NewsListError) {
              return _buildError(state, context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
    title: const Text('News'),
    elevation: 2.0,
  );

  Widget _buildNewsList(
    BuildContext context,
    NewsListLoaded state,
  ) => RefreshIndicator(
    onRefresh: () => context.read<NewsListCubit>().fetchNewsList(),
    child: ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: state.articleList.length,
      itemBuilder: (_, index) => AppArticleCard(article: state.articleList[index]),
    ),
  );

  Widget _buildError(NewsListError state, BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          _buildErrorMessage(state, context),
          _buildRetryButton(context),
        ],
      ),
    ),
  );

  Widget _buildErrorIcon() => const Icon(
    Icons.error_outline,
    size: 64.0,
    color: Colors.red,
  );

  Widget _buildErrorMessage(NewsListError state, BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      state.message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );

  Widget _buildRetryButton(BuildContext context) => ElevatedButton.icon(
    onPressed: () => context.read<NewsListCubit>().fetchNewsList(),
    icon: const Icon(Icons.refresh),
    label: const Text('Retry'),
  );

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
