import 'package:flutter/material.dart';
import 'package:trashure_new/code/cut_text.dart';

class PriceCard extends StatelessWidget {
  PriceCard({this.imageName, this.name, this.price});

  final String imageName;
  final String name;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 240,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/" + imageName + ".jpg"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cutText(18, name),
                      style: TextStyle(fontSize: 18),
                      softWrap: false,
                    ),
                    Text(
                      "Rp" + price.toString() + "/kg",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF5722),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
