import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/info_display.dart';

class SelectRegion extends StatefulWidget {
  @override
  _SelectRegion createState() => _SelectRegion();
}

class _SelectRegion extends State<SelectRegion> {
  var _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _regionListItems;
  List<String> _searchListItems;

  @override
  void initState() {
    super.initState();
    _regionListItems = List<String>();
    _regionListItems = [
      "foo",
      "bar",
      "foobar",
      "hoge",
      "hogehoge",
    ];
    _regionListItems.sort();
  }

  _SelectRegion() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("地域を選択してください"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: <Widget>[
              _searchBox(),
              _isSearch ? _listView() : _searchListView(),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 50.0),
              )
            ],
          ),
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView() {
    return Flexible(
      child: ListView.builder(
        itemCount: _regionListItems.length,
        itemBuilder: (BuildContext context, int index){
          return RaisedButton(
                key:null,
                onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoDisplay(_regionListItems[index])));
                },
                color: Color(0xFFe0e0e0),
                child: Text("${_regionListItems[index]}"),
              );
        },
      ),
    );
  }

  Widget _searchListView() {
    _searchListItems = List<String>();
    for (int i = 0; i < _regionListItems.length; i++) {
      var item = _regionListItems[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return Flexible(
      child: ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
            key:null,
            onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoDisplay(_regionListItems[index])));
            },
            color: Color(0xFFe0e0e0),
            child: Text("${_regionListItems[index]}"),
          );
        },
      ),
    );
  }
}