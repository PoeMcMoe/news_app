import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/context_extensions.dart';
import 'package:news_app/features/news_list/1_presentation/widgets/app_date_row.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_cubit.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_state.dart';
import 'package:news_app/main.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsDetailsCubit>(
      create: (_) => NewsDetailsCubit(
        article: article,
        urlLauncherHelper: getIt(),
      ),
      child: _NewsDetailsScreenBase(),
    );
  }
}

class _NewsDetailsScreenBase extends StatelessWidget {
  const _NewsDetailsScreenBase();

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<NewsDetailsCubit, NewsDetailsState>(
    builder: (context, state) => Scaffold(
      floatingActionButton: _fabBuilder(context, state),
      body: buildBody(state, context),
    ),
    listener: (BuildContext context, NewsDetailsState state) {
      if (state is NewsDetailsError) {
        _showErrorSnackBar(context, state.message);
      }
    },
  );

  Widget? _fabBuilder(BuildContext context, NewsDetailsState state) {
    return switch (state) {
      NewsDetailsInitial(:final article) => _buildReadArticleFAB(context, article),
      NewsDetailsError(:final article) => _buildReadArticleFAB(context, article),
    };
  }

  Widget buildBody(NewsDetailsState state, BuildContext context) => switch (state) {
    NewsDetailsInitial(:final article) => _buildArticleDetails(context, article),
    NewsDetailsError(:final article) => _buildArticleDetails(context, article),
  };

  CustomScrollView _buildArticleDetails(
    BuildContext context,
    Article article,
  ) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, article),
        _buildContent(context, article),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, Article article) => SliverAppBar(
    expandedHeight: article.urlToImage.isNotNullOrBlank ? 300.0 : 100.0,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: article.urlToImage.isNotNullOrBlank
          ? _buildArticleImage(article.urlToImage!) //
          : null,
    ),
  );

  Widget _buildArticleImage(String imageUrl) => Image.network(
    imageUrl,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => _buildImageError(),
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return _buildLoadingImage(loadingProgress);
    },
  );

  Widget _buildLoadingImage(ImageChunkEvent loadingProgress) => Container(
    color: Colors.grey[200],
    child: Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            : null,
      ),
    ),
  );

  Widget _buildImageError() => Container(
    color: Colors.grey[300],
    child: const Icon(
      Icons.image_not_supported,
      size: 64.0,
      color: Colors.grey,
    ),
  );

  Widget _buildContent(
    BuildContext context,
    Article article,
  ) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 128.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.title?.isNotEmpty == true) _buildTitle(context, article),
          _buildMetadata(context, article),
          _buildContentText(context, article),
        ],
      ),
    ),
  );

  Widget _buildTitle(BuildContext context, Article article) => Text(
    article.title!,
    style: context.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      height: 1.2,
    ),
  );

  Widget _buildMetadata(BuildContext context, Article article) => Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.author?.isNotEmpty == true) _buildAuthorRow(context, article),
        _buildDateRow(article),
      ],
    ),
  );

  Widget _buildDateRow(Article article) => AppDateRow(date: article.publishedAt);

  Widget _buildAuthorRow(BuildContext context, Article article) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(
          Icons.person_outline,
          size: 16.0,
        ),
        Expanded(
          child: Text(
            article.author!,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildContentText(BuildContext context, Article article) => Text(
    article.content ?? '',
    style: context.textTheme.bodyLarge?.copyWith(
      height: 1.6,
    ),
  );

  Widget? _buildReadArticleFAB(
    BuildContext context,
    Article article,
  ) => article.url?.isNotEmpty == true
      ? FloatingActionButton.extended(
          onPressed: () => context.read<NewsDetailsCubit>().launchArticleUrl(),
          icon: const Icon(Icons.open_in_new),
          label: const Text('Read Full Article'),
        )
      : null;

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
