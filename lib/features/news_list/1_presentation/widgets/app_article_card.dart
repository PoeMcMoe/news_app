import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

class AppArticleCard extends StatelessWidget {
  final Article article;

  const AppArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    elevation: 2.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.imageUrl != null && article.imageUrl!.isNotEmpty) _buildImage(),
        _buildArticleDetails(context),
      ],
    ),
  );

  Widget _buildArticleDetails(BuildContext context) {
    final dateFormatter = DateFormat('MMM d, yyyy • HH:mm');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          _buildDescription(context),
          _buildDate(dateFormatter, context),
        ],
      ),
    );
  }

  Widget _buildImage() => ClipRRect(
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(12.0),
    ),
    child: Image.network(
      article.imageUrl!,
      width: double.infinity,
      height: 200.0,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildImageError(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildImageLoadingProgress(loadingProgress);
      },
    ),
  );

  Widget _buildImageLoadingProgress(ImageChunkEvent loadingProgress) => Container(
    height: 200.0,
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
    width: double.infinity,
    height: 200.0,
    color: Colors.grey[300],
    child: const Icon(
      Icons.image_not_supported,
      size: 64.0,
      color: Colors.grey,
    ),
  );

  Widget _buildTitle(BuildContext context) => Text(
    article.title ?? 'No title',
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _buildDescription(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
    child: Text(
      article.description ?? 'No description available',
      style: Theme.of(context).textTheme.bodyMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _buildDate(DateFormat dateFormatter, BuildContext context) => Row(
    children: [
      Icon(
        Icons.access_time,
        size: 16.0,
        color: Colors.grey[600],
      ),
      const SizedBox(width: 4.0),
      Text(
        dateFormatter.format(article.publishedAt),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}
