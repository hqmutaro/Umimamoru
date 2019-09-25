import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/umimamoru_theme.dart';
import 'package:umimamoru/presentation/ui/button/previous_button.dart';
import 'package:umimamoru/presentation/beach/beach_list_item.dart';
import 'package:umimamoru/presentation/beach/view_beach_list.dart';

class Beach extends StatefulWidget {

  const Beach({Key key}) : super(key: key);

  @override
  BeachState createState() => BeachState();
}

class BeachState extends State<Beach> {

  Map<String, String> beaches;
  List<String> beachList;

  TextEditingController searchController = TextEditingController();
  String searchText = "";
  bool isSearching;

  Widget title = Text("海水浴場一覧", style: TextStyle(color: Colors.white));
  Icon actionIcon = Icon(Icons.search, color: Colors.white);

  BeachState() {
    searchController.addListener(() {
      if (this.searchController.text.isEmpty) {
        setState(() {
          this.isSearching = false;
          this.searchText = "";
        });
      }
      else {
        setState(() {
          this.isSearching = true;
          this.searchText = this.searchController.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.isSearching = false;
    this.beaches = {
      "シーグラスビーチ": "沖縄県名護市辺野古豊原"
    };
    this.beachList = this.beaches.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: UmimamoruTheme.colorTheme,
          title: this.title,
        actions: <Widget>[
          IconButton(
            icon: this.actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(Icons.close, color: Colors.white);
                  this.title = TextField(
                    controller: this.searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "海水浴場を検索...",
                      hintStyle: TextStyle(color: Colors.white)
                    ),
                  );
                  handleSearchStart();
                }
                else {
                  handleSearchFinish();
                }
              });
            }
          )
        ]
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PreviousButton(message: "ホームに戻る"),
              ViewBeachList(isSearching: this.isSearching, beachState: this)
            ]
          )
        )
      )
    );
  }

  List<BeachListItem> buildList() {
    return this.beachList.map((contact) => BeachListItem(beach: contact, region: this.beaches[contact], beachState: this)).toList();
  }

  List<BeachListItem> buildSearchList() {
    if (this.searchText.isEmpty) {
      return this.beachList.map((contact) => BeachListItem(beach: contact, region: this.beaches[contact], beachState: this)).toList();
    }
    else {
      List<String> searchList = [];
      this.beachList.map((beach) => () {
        if (beach.toLowerCase().contains(this.searchText.toLowerCase())) {
          searchList.add(beach);
        }
      });
      return searchList.map((contact) => BeachListItem(beach: contact, region: this.beaches[contact], beachState: this)).toList();
    }
  }

  // Start search mode.
  void handleSearchStart() {
    setState(() {
      this.isSearching = true;
    });
  }

  // Finish search mode.
  void handleSearchFinish() {
    setState(() {
      this.actionIcon = Icon(Icons.search, color: Colors.white);
      this.title = Text("海水浴場一覧", style: TextStyle(color: Colors.white));
      this.isSearching = false;
      this.searchController.clear();
    });
  }
}