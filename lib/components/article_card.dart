import 'package:flutter/material.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/screens/tips_screen.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({this.id, this.title, this.image, this.description});

  final int id;
  final String title;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          width: 180,
          height: 156,
          decoration: kCircularHomeContainer.copyWith(
            image: DecorationImage(
              image: NetworkImage("$baseUrl/images/$image"),
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 7.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TipsScreen(id: id)),
        );
      },
    );
  }
}
