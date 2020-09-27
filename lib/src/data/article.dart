import 'package:flutter/material.dart';

class ArticlesModel extends ChangeNotifier {
  List<Article> articles;

  updateArticles(List<Article> articles) {
    this.articles = articles;
  }
}

class Article {
  String title;
  String description;
  String url;

  Article.fromJson(Map<dynamic, dynamic> json) {
    this.title = json['title'];
    this.description = json['description'];
    this.url = json['url'];
  }
}
