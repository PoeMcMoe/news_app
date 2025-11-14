import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';
import 'package:news_app/features/news_list/4_features/news_details/1_presentation/cubits/news_details_cubit.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsDetailsCubit>(
      create: (_) => NewsDetailsCubit(article: article),
      child: _buildBody(),
    );
  }

  Widget _buildBody() => const Placeholder();
}
