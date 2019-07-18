import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/main.dart';
import 'package:umimamoru_flutter/presentation/selector/state.dart';

class ChildItem extends StatelessWidget {
  final String name;
  final String region;
  SearchListState _searchListState;
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
            _searchListState.handleSearchEnd();
          },
        ));
  }
}