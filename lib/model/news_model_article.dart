import 'dart:convert';

import 'package:news_app/model/news_model.dart';


class NewsModelArticle {
  final List<NewsModel> articles;

  NewsModelArticle({required this.articles});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'articles': articles.map((article) => article.toMap()).toList(),
    };
  }

  factory NewsModelArticle.fromMap(Map<String, dynamic> map) {
    return NewsModelArticle(
      articles: List<NewsModel>.from(
        (map['articles'] as List<dynamic>).map<NewsModel>(
          (item) => NewsModel.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModelArticle.fromJson(String source) => NewsModelArticle.fromMap(json.decode(source) as Map<String, dynamic>);
}