import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/umimamoru_theme.dart';
import 'package:umimamoru_flutter/presentation/back_bar.dart';
import 'package:umimamoru_flutter/presentation/selector/child_item.dart';
import 'package:umimamoru_flutter/presentation/selector/view_beach_list.dart';

@immutable
class SearchList extends StatefulWidget {

  const SearchList({Key key}) : super(key: key);

  @override
  SearchListState createState() => SearchListState();
}

class SearchListState extends State<SearchList> {

  Map<String, String> region;
  List<String> beach;
  bool isSearching;

  final key = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = TextEditingController();
  String searchText = "";

  Widget appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
  Icon actionIcon = Icon(Icons.search, color: Colors.white);

  SearchListState() {
    searchQuery.addListener(() {
      if (this.searchQuery.text.isEmpty) {
        setState(() {
          this.isSearching = false;
          this.searchText = "";
        });
      }
      else {
        setState(() {
          this.isSearching = true;
          this.searchText = searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    isSearching = false;
    region = {
      "アイウエオビーチ": "あいうえお市辺野古",
      "カキクケコビーチ": "かきくけこ市辺野古",
      "サシスセソビーチ": "さしすせそ市辺野古",
      "タチツテトビーチ": "たちつてと市辺野古",
      "ナニヌネノビーチ": "なにぬねの市辺野古",
      "ハヒフヘホビーチ": "はひふへほ市辺野古",
      "マミムメモビーチ": "まみむめも市辺野古",
      "ワイウエヲビーチ": "わいうえを市辺野古",
      "ニャニャニャニャニャンビーチ": "にゃにゃにゃにゃにゃ市辺野古",
      "ニャーンビーチ": "にゃーん市辺野古",
      "ニョニョニョニョニョビーチ": "にょにょにょにょにょ市辺野古"
    };
    beach = region.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackBar(message: "ホームに戻る"),
              ViewBeachList(isSearching: this.isSearching, searchListState: this)
            ]
          ),
        ),
      ),
    );
  }

  Widget buildBar(BuildContext context) {
    return UmimamoruTheme(
        title: this.appBarTitle,
        widget: <Widget>[
          IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(Icons.close, color: Colors.white);
                this.appBarTitle = TextField(
                  controller: this.searchQuery,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "地域を検索...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );
                handleSearchStart();
              }
              else {
                handleSearchEnd();
              }
            });
          })
        ]
    );
  }

  List<ChildItem> buildList() {
    return this.beach.map((contact) => ChildItem(beach: contact, region: this.region[contact], searchListState: this)).toList();
  }

  List<ChildItem> buildSearchList() {
    if (this.searchText.isEmpty) {
      return this.beach.map((contact) => ChildItem(beach: contact, region: this.region[contact], searchListState: this)).toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < this.beach.length; i++) {
        String name = this.beach.elementAt(i);
        if (name.toLowerCase().contains(this.searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(beach: contact, region: this.region[contact], searchListState: this)).toList();
    }
  }

  handleSearchStart() {
    setState(() {
      this.isSearching = true;
    });
  }

  handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search, color: Colors.white);
      this.appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
      this.isSearching = false;
      this.searchQuery.clear();
    });
  }
}