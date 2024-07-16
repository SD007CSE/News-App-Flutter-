part of 'news_model_cubit.dart';


class NewsModelState extends Equatable {

  const NewsModelState();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NewsModelInitial extends NewsModelState{

  const NewsModelInitial();
  
  @override
  List<Object?> get props => [];
}

class NewsModelLoaded extends NewsModelState{

  final NewsModelArticle newsModel;

  const NewsModelLoaded({required this.newsModel});

  @override
  List<Object?> get props => [newsModel];

}

class NewsModelError extends NewsModelState{

  final String newsError;
  const NewsModelError({this.newsError = "Error"});

  @override
  List<Object?> get props => [newsError];

}