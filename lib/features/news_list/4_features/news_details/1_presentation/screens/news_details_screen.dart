import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/app/context_extensions.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsDetailsCubit>(
      create: (_) => NewsDetailsCubit(article: article),
      child: Scaffold(
        floatingActionButton: _buildReadArticleFAB(context),
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final hasImage = article.urlToImage?.isNotEmpty == true;

    return SliverAppBar(
      expandedHeight: hasImage ? 300.0 : 100.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: hasImage ? _buildArticleImage() : null,
      ),
    );
  }

  Widget _buildArticleImage() => Image.network(
    article.urlToImage!,
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

  Widget _buildContent(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.title.isNotNullOrEmpty) _buildTitle(context),
          _buildMetadata(context),
          _buildContentText(context),
        ],
      ),
    ),
  );

  Widget _buildTitle(BuildContext context) => Text(
    article.title!,
    style: context.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      height: 1.2,
    ),
  );

  Widget _buildMetadata(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.author?.isNotEmpty == true) _buildAuthorRow(context),
        _buildDateRow(context),
      ],
    ),
  );

  Widget _buildDateRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_outlined,
          size: 20.0,
          color: context.colorScheme.onSurfaceVariant,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            DateFormat('MMMM d, yyyy • HH:mm').format(article.publishedAt),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorRow(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(
          Icons.person_outline,
          size: 20.0,
          color: context.colorScheme.onSurfaceVariant,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              article.author!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildContentText(BuildContext context) => Text(
    article.content ?? '',
    style: context.textTheme.bodyLarge?.copyWith(
      height: 1.6,
    ),
  );

  Widget? _buildReadArticleFAB(BuildContext context) => article.url?.isNotEmpty == true
      ? FloatingActionButton.extended(
          onPressed: () => _launchUrl(context, article.url!),
          icon: const Icon(Icons.open_in_new),
          label: const Text('Read Full Article'),
        )
      : null;

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      final canLaunch = await canLaunchUrl(url);
      if (!canLaunch) {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Cannot open this URL');
        }
        return;
      }

      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Failed to open the article');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error opening article: $e');
      }
    }
  }

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
