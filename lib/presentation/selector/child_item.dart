import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/info/main.dart';
import 'package:umimamoru_flutter/presentation/selector/state.dart';

class ChildItem extends StatelessWidget {

  final String beach;
  final String region;

  final SearchListState searchListState;

  const ChildItem({
    @required this.beach,
    @required this.region,
    @required this.searchListState
  }) : assert(beach != null),
        assert(region != null),
        assert(searchListState != null);

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
            this.beach,
            style: TextStyle(
                fontSize: 25.0
            ),
          ),
          subtitle: Text("${this.region}"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InfoDisplay(beach: this.beach, region: this.region)));
            searchListState.handleSearchEnd();
          },
        ));
  }
}