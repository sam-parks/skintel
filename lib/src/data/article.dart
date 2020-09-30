import 'package:flutter/material.dart';

class ArticlesModel extends ChangeNotifier {
  List<Article> articles;
  Article dailyArticle;

  updateArticles(List<Article> articles, Article dailyArticle) {
    this.articles = articles;
    this.dailyArticle = dailyArticle;
  }
}

class Article {
  String title;
  String description;
  String url;
  String reference;

  Article.fromJson(Map<dynamic, dynamic> json) {
    this.title = json['title'];
    this.description = json['description'];
    this.url = json['url'];
    this.reference = json['reference'];
  }
}
