import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skintel/src/data/article.dart';

class ArticleService {
  final FirebaseFirestore _firestore;

  ArticleService(this._firestore);

  CollectionReference get _articlesCollection =>
      _firestore.collection('articles');

  getArticles() async {
    List<Article> articles = [];

    QuerySnapshot snapshot = await _articlesCollection.get();

    for (var articleDoc in snapshot.docs) {
      articles.add(Article.fromJson(articleDoc.data()));
    }

    return articles;
  }
}
