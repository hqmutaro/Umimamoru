import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/info_display.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list;
  Map<String, String> _region;
  bool _isSearching;
  String _searchText = "";

  _SearchListState() {
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
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _isSearching ? _buildSearchList() : _buildList(),
        ),
      )
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => ChildItem(contact, _region[contact], this)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => ChildItem(contact, _region[contact], this)).toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(contact, _region[contact], this)).toList();
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
            _handleSearchStart();
          }
          else {
            _handleSearchEnd();
          }
        });
      })
    ];

    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      backgroundColor: Colors.green[400],
      actions: widget,
      leading: IconButton(
        icon: Icon(Icons.navigate_before),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search, color: Colors.white);
      this.appBarTitle = Text("地域リスト", style: TextStyle(color: Colors.white));
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  final String region;
  _SearchListState _searchListState;
  ChildItem(this.name, this.region, this._searchListState);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.beach_access, color: Colors.pinkAccent,),
          title: Text(
              "${this.name}",
            style: TextStyle(
              fontSize: 25.0
            ),
          ),
          subtitle: Text("${this.region}"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoDisplay(this.name, this.region)));
            _searchListState._handleSearchEnd();
          },
        ));
  }
}