import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Skintel",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.wb_sunny),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Articles',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: kFontFamilyBold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (index == 1) {
                return articleOfTheDay(articlesModel.articles[index]);
              }

              return GestureDetector(
                onTap: () async {
                  String url = articlesModel.articles[index].url.trim();

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
                        fontFamily: kFontFamilyBold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articlesModel.articles[index].description,
                          style: TextStyle(
                            fontFamily: kFontFamilyNormal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: RichText(
                            text: TextSpan(
                                text: "Reference: ",
                                style: TextStyle(
                                    fontFamily: kFontFamilyBold,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text:
                                        articlesModel.articles[index].reference,
                                    style: TextStyle(
                                      fontFamily: kFontFamilyNormal,
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    ]);
  }

  articleOfTheDay(Article article) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              String url = article.url.trim();

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Card(
              elevation: 5,
              child: Container(
                height: 190,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        "Article of the Day",
                        minFontSize: 24,
                        style: TextStyle(
                          fontFamily: kFontFamilyBold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      color: Colors.amberAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.sun, color: Colors.amber),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        article.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: kFontFamilyBold, fontSize: 18),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AutoSizeText(
                          article.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: kFontFamilyNormal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: RichText(
                        text: TextSpan(
                            text: "Reference: ",
                            style: TextStyle(
                                fontFamily: kFontFamilyBold,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: article.reference,
                                style: TextStyle(
                                  fontFamily: kFontFamilyNormal,
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
