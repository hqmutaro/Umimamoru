import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/beach/main.dart';

class ViewBeachList extends StatelessWidget {

  final bool isSearching;
  final BeachState beachState;

  const ViewBeachList({
    @required this.isSearching,
    @required this.beachState
  }) :
        assert(isSearching != null),
        assert(beachState != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: this.isSearching ? this.beachState.buildSearchList() : this.beachState.buildList()
      ),
    );
  }
}