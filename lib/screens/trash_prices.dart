import 'package:flutter/material.dart';
import 'package:trashure_new/components/header_title.dart';
import 'package:trashure_new/components/price_card.dart';

class TrashPrices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 114),
                  PriceCard(
                    imageName: 'tprice1',
                    name: 'Sampah plastik',
                    price: 3500,
                  ),
                  SizedBox(height: 20),
                  PriceCard(
                    imageName: 'tprice2',
                    name: 'Sampah kaleng',
                    price: 5000,
                  ),
                  SizedBox(height: 20),
                  PriceCard(
                    imageName: 'tprice3',
                    name: 'Sampah kardus',
                    price: 4000,
                  ),
                  SizedBox(height: 20),
                  PriceCard(
                    imageName: 'tprice1',
                    name: 'Sampah lain',
                    price: 1500,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            HeaderTitle('Harga sampah'),
          ],
        ),
      ),
    );
  }
}
