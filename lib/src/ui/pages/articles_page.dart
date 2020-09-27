import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skintel/src/data/article.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    ArticlesModel articlesModel = Provider.of<ArticlesModel>(context);
    return Stack(children: [
      Container(
        color: Colors.amber,
        child: ListView.builder(
            itemCount: articlesModel.articles.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Articles',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: kFontFamilyBold,
                          fontSize: 40,
                          color: Colors.black),
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () async {
                  String url = articlesModel.articles[index].url;

                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.sun, color: Colors.amber),
                    title: Text(
                      articlesModel.articles[index].title,
                      style: TextStyle(
                        fontFamily: kFontFamilyNormal,
                      ),
                    ),
                    subtitle: Text(
                      articlesModel.articles[index].description,
                      style: TextStyle(
                        fontFamily: kFontFamilyNormal,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: Image.asset(
          'assets/images/skintel_white.png',
          height: 60,
        ),
      ),
    ]);
  }
}
