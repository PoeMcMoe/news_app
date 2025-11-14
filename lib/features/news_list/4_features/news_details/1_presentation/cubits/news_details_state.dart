import 'package:equatable/equatable.dart';
import 'package:news_app/features/news_list/2_domain/entities/article.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();

  @override
  List<Object?> get props => [];
}

class NewsDetailsInitial extends NewsDetailsState {
  final Article article;

  const NewsDetailsInitial(this.article);
}

class NewsDetailsError extends NewsDetailsState {
  final String message;

  const NewsDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
