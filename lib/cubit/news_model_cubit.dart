import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:news_app/model/news_model_article.dart';
import 'package:http/http.dart' as http;

part 'news_model_state.dart';

class NewsModelCubit extends Cubit<NewsModelState> {
  NewsModelCubit() : super(NewsModelInitial());

  Future<void> getNews(String ctgry) async {
    emit(const NewsModelInitial());

    try {
      String URL =
          "https://newsapi.org/v2/top-headlines?country=us&category=${ctgry}&apiKey=effaad8bf0e44798ab7051c04d961733";
      final response = await http.get(Uri.parse(URL));

      if (response.statusCode == 200) {
        var data = NewsModelArticle.fromMap(
          jsonDecode(response.body),
        );
        emit(NewsModelLoaded(newsModel: data));
      }
    } catch (e) {
      emit(
        NewsModelError(
          newsError: e.toString(),
        ),
      );
    }
  }
}
