import 'package:flutter/material.dart';
import 'package:umimamoru_flutter/presentation/selector/main.dart';

@immutable
class ViewBeachList extends StatelessWidget {

  final bool isSearching;
  final SearchListState searchListState;
  const ViewBeachList({@required this.isSearching, @required this.searchListState}) : assert(isSearching != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: this.isSearching ? searchListState.buildSearchList() : searchListState.buildList(),
      ),
    );
  }
}