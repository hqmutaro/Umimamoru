import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/selector/child_item.dart';
import 'package:umimamoru_flutter/presentation/selector/main.dart';

class SearchListState extends State<SearchList> {
  Widget appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list;
  Map<String, String> _region;
  bool _isSearching;
  String _searchText = "";

  SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    _isSearching = false;
    init();
  }

  init() {
    _region = {
      "アイウエオビーチ" : "あいうえお市辺野古",
      "カキクケコビーチ" : "かきくけこ市辺野古",
      "サシスセソビーチ" : "さしすせそ市辺野古",
      "タチツテトビーチ" : "たちつてと市辺野古",
      "ナニヌネノビーチ" : "なにぬねの市辺野古",
      "ハヒフヘホビーチ" : "はひふへほ市辺野古",
      "マミムメモビーチ" : "まみむめも市辺野古",
      "ワイウエヲビーチ" : "わいうえを市辺野古",
      "ニャニャニャニャニャンビーチ" : "にゃにゃにゃにゃにゃ市辺野古",
      "ニャーンビーチ" : "にゃーん市辺野古",
      "ニョニョニョニョニョビーチ" : "にょにょにょにょにょ市辺野古"
    };
    _list = _region.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: key,
        appBar: buildBar(context),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 25.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: FloatingActionButton(
                              onPressed: () => Navigator.of(context).pop(),
                              backgroundColor: Color(0xFF66BAB7),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                              "ホームに戻る",
                              style: TextStyle(
                                  fontSize: 20.0
                              )
                          )
                        ],
                      )
                  ),
                  SizedBox(
                    height: 510,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      children: _isSearching ? _buildSearchList() : _buildList(),
                    ),
                  )
                ]
            ),
          ),
        )
        );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => ChildItem(beach: contact, region: _region[contact], searchListState: this)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => ChildItem(beach: contact, region: _region[contact], searchListState: this)).toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(beach: contact, region: _region[contact], searchListState: this)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    List<Widget> widget = <Widget>[
      IconButton(icon: actionIcon, onPressed: () {
        setState(() {
          if (this.actionIcon.icon == Icons.search) {
            this.actionIcon = Icon(Icons.close, color: Colors.white,);
            this.appBarTitle = TextField(
              controller: _searchQuery,
              style: TextStyle(
                  color: Colors.white
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
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
    ];

    return AppBar(
      title: appBarTitle,
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF4CBBB4),
      actions: widget
    );
  }

  handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search, color: Colors.white);
      this.appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}