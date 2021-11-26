import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/components/header_with_icon.dart';
import 'package:trashure_new/components/setoran_card.dart';
import 'package:trashure_new/models/history.dart';
import 'package:trashure_new/models/profile_provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
        child: Stack(
          children: [
            FutureBuilder(
              future: _apiService.getHistories(
                  Provider.of<ProfileProvider>(context, listen: false).id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<History>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<History> histories = snapshot.data;
                  if (histories == null) {
                    return Center(
                      child: Text("Anda belum melakukan penyetoran."),
                    );
                  }
                  return _buildListView(histories);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            HeaderWithIcon('Setoran'),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<History> histories) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 110, 16, 0),
      child: ListView.builder(
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
      ),
    );
  }
}
