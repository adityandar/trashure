import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/components/article_card.dart';
import 'package:trashure_new/components/chart.dart';
import 'package:trashure_new/components/setoran_card.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/article.dart';
import 'package:trashure_new/models/history.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/models/weekly.dart';
import 'package:trashure_new/screens/history_screen.dart';
import 'package:trashure_new/screens/notification_screen.dart';
import 'package:trashure_new/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  // header
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trashure', style: kBoldHeadlineHomeText),
                    Row(
                      //2 icon kanan
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.notifications,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 120,
                  width: double.maxFinite,
                  decoration: kCircularHomeContainer.copyWith(
                      color: Theme.of(context).primaryColor),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFF689F38),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DOMPET',
                                style: kWalletHomeText,
                              ),
                              Consumer<ProfileProvider>(
                                builder: (context, profile, child) {
                                  return Text(
                                    "Rp ${profile.balance}",
                                    style: kWalletHomeText,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 19,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<ProfileProvider>(
                                builder: (context, profile, child) {
                                  String level = profile.getLevel();
                                  return Text(
                                    "Level: $level",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                              ),
                              Consumer<ProfileProvider>(
                                builder: (context, profile, child) {
                                  String connected =
                                      (profile.connectedTrashbag != null)
                                          ? "#" + profile.connectedTrashbag
                                          : "Tidak terhubung";
                                  return Text(
                                    "Trashbag: $connected",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 336,
                  width: double.maxFinite,
                  decoration: kCircularHomeContainer,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Sampah Terkumpul',
                        style: kBoldHeadlineHomeText,
                      ),
                      SizedBox(height: 30),
                      FutureBuilder(
                        future: _apiService.getWeekly(
                            Provider.of<ProfileProvider>(context, listen: false)
                                .id),
                        builder: (BuildContext context,
                            AsyncSnapshot<Weekly> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Something wrong with message: ${snapshot.error.toString()}"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Weekly weekly = snapshot.data;
                            return Chart(weekly);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Setoran',
                            style: kBoldHeadlineHomeText,
                          ),
                          GestureDetector(
                            child: Text(
                              'Lihat semua',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.maxFinite,
                        child: FutureBuilder(
                          future: _apiService.getHistories(
                              Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<History>> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Something wrong with message: ${snapshot.error.toString()}"),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<History> histories = snapshot.data;
                              return _buildListView(histories);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tips',
                        style: kBoldHeadlineHomeText.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        child: FutureBuilder(
                          future: _apiService.getArticles(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Article>> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Something wrong with message: ${snapshot.error.toString()}"),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<Article> articles = snapshot.data;
                              return _buildArticles(articles);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<History> histories) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        History history = histories[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SetoranCard(
            trashbagID: history.id_trashbag,
            date: history.date,
            finished: (history.status == 1),
          ),
        );
      },
      itemCount: (histories != null)
          ? (histories.length >= 3)
              ? 3
              : histories.length
          : 0,
    );
  }

  Widget _buildArticles(List<Article> articles) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Article article = articles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ArticleCard(
              id: article.id,
              title: article.title,
              image: article.image,
              description: article.description,
            ),
          );
        },
        itemCount: (articles != null) ? articles.length : 0,
      ),
    );
  }
}
