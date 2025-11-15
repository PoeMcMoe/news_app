import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/context_extensions.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_cubit.dart';
import 'package:news_app/features/news_list/1_presentation/cubits/news_list_state.dart';
import 'package:news_app/features/news_list/1_presentation/widgets/app_article_card.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/2_domain/usecases/get_article_list_use_case.dart';
import 'package:news_app/main.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsListCubit(
        getArticleListUseCase: getIt<GetArticleListUseCase>(),
      )..fetchNewsList(),
      child: _NewsListScreenBase(),
    );
  }
}

class _NewsListScreenBase extends StatefulWidget {
  const _NewsListScreenBase();

  @override
  State<_NewsListScreenBase> createState() => _NewsListScreenBaseState();
}

class _NewsListScreenBaseState extends State<_NewsListScreenBase> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<NewsListCubit>().state;

      if (_isNearScrollBottom && state is! NewsListMaxReached) {
        context.read<NewsListCubit>().loadMoreNews();
      }
    });
  }

  bool get _isNearScrollBottom {
    if (!_scrollController.hasClients) return false;

    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    final double offset = _scrollController.offset;

    return maxScrollExtent > 0 && offset >= maxScrollExtent - 200;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _buildAppBar(),
    body: BlocBuilder<NewsListCubit, NewsListState>(
      builder: (context, state) => switch (state) {
        NewsListLoading() => _buildLoadingIndicator(),
        NewsListLoaded(:final articles) => _buildNewsList(context, articles),
        NewsListError(:final message) => _buildError(context, message),
        NewsListLoadingMore(:final articles) => _buildNewsList(
          context,
          articles,
          isLoadingMore: true,
        ),
        NewsListMaxReached(:final articles) => _buildNewsList(
          context,
          articles,
          hasReachedMax: true,
        ),
      },
    ),
  );

  PreferredSizeWidget _buildAppBar() => AppBar(
    title: const Text('News'),
    elevation: 2.0,
  );

  Widget _buildNewsList(
    BuildContext context,
    List<Article> articles, {
    bool isLoadingMore = false,
    bool hasReachedMax = false,
  }) => RefreshIndicator(
    onRefresh: () => context.read<NewsListCubit>().fetchNewsList(),
    child: ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: articles.length + 1,
      itemBuilder: (_, index) => _buildListItem(
        index,
        articles,
        isLoadingMore,
        hasReachedMax,
      ),
    ),
  );

  Widget _buildListItem(
    int index,
    List<Article> articles,
    bool isLoadingMore,
    bool hasReachedMax,
  ) {
    if (index == articles.length) {
      if (isLoadingMore) {
        return _buildBottomLoadingIndicator();
      } else if (hasReachedMax) {
        return _buildMaxReachedMessage();
      } else {
        return const SizedBox.shrink();
      }
    }
    return AppArticleCard(article: articles[index])
        .animate()
        .fadeIn(
          duration: 300.ms,
          delay: (index * 50).clamp(0, 300).ms,
        )
        .slideY(
          begin: 0.1,
          end: 0,
          duration: 300.ms,
          delay: (index * 50).clamp(0, 300).ms,
        );
  }

  Widget _buildBottomLoadingIndicator() => const Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget _buildMaxReachedMessage() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Text(
        'Maximum articles limit reached',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget _buildError(
    BuildContext context,
    String message,
  ) => Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          _buildErrorMessage(context, message),
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

  Widget _buildErrorMessage(BuildContext context, String message) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge,
    ),
  );

  Widget _buildRetryButton(BuildContext context) => ElevatedButton.icon(
    onPressed: () => context.read<NewsListCubit>().fetchNewsList(isRefresh: true),
    icon: const Icon(Icons.refresh),
    label: const Text('Retry'),
  );

  Widget _buildLoadingIndicator() => const Center(
    child: CircularProgressIndicator(),
  );
}
