import 'package:flutter/material.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/code/change_date.dart';
import 'package:trashure_new/components/back_clickable.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/article.dart';

class TipsScreen extends StatefulWidget {
  TipsScreen({this.id});

  final int id;

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _apiService.getArticles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Article> articles = snapshot.data;
              Article article = articles[articles.length - widget.id];
              return _buildArticle(article);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildArticle(Article article) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 16, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackClickable(),
            SizedBox(height: 7),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    changeDate(article.date),
                    style: TextStyle(color: Color(0x35000000)),
                  ),
                  SizedBox(height: 13),
                  Container(
                    width: double.maxFinite,
                    height: 230,
                    decoration: kCircularHomeContainer.copyWith(
                      image: DecorationImage(
                        image: NetworkImage("$baseUrl/images/${article.image}"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(article.description),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
