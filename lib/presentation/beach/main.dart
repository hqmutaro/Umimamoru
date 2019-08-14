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

  Widget title = Text("ビーチリスト", style: TextStyle(color: Colors.white));
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
      "アイウエオビーチ": "沖縄県あいうえお市辺野古",
      "カキクケコビーチ": "沖縄県かきくけこ市辺野古",
      "サシスセソビーチ": "沖縄県さしすせそ市辺野古",
      "タチツテトビーチ": "沖縄県たちつてと市辺野古",
      "ナニヌネノビーチ": "沖縄県なにぬねの市辺野古",
      "ハヒフヘホビーチ": "沖縄県はひふへほ市辺野古",
      "マミムメモビーチ": "沖縄県まみむめも市辺野古",
      "ワイウエヲビーチ": "沖縄県わいうえを市辺野古",
      "ニャニャニャニャニャンビーチ": "沖縄県にゃにゃにゃにゃにゃ市辺野古",
      "ニャーンビーチ": "沖縄県にゃーん市辺野古",
      "ニョニョニョニョニョビーチ": "沖縄県にょにょにょにょにょ市辺野古"
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
                      hintText: "ビーチを検索...",
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
      this.title = Text("ビーチ", style: TextStyle(color: Colors.white));
      this.isSearching = false;
      this.searchController.clear();
    });
  }
}