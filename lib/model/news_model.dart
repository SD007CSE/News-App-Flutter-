// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsModel {
  final String? author;
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? url;
  final String? publishedAt;
  final String? content;

  NewsModel(
      {this.author,
      this.title,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'newsUrl': url,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      urlToImage: map['urlToImage'] != null ? map['urlToImage'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      publishedAt: map['publishedAt'] != null ? map['publishedAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
