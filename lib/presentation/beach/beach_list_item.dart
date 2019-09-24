import 'package:flutter/material.dart';
import 'package:umimamoru/presentation/beach/main.dart';
import 'package:umimamoru/presentation/display/display.dart';
import 'package:umimamoru/presentation/display/main.dart';

@immutable
class BeachListItem extends StatelessWidget {

  final String beach;
  final String region;

  final BeachState beachState;
  
  const BeachListItem({
    @required this.beach,
    @required this.region,
    @required this.beachState
  }) :
      assert(beach != null),
      assert(region != null),
      assert(beachState != null);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.beach_access, color: Colors.pinkAccent),
        title: Text(this.beach, style: TextStyle(fontSize: 25.0)),
        subtitle: Text(this.region, style: TextStyle(color: Colors.grey)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayHome(beach: this.beach, region: this.region))
          );
          this.beachState.handleSearchFinish();
        }
      )
    );
  }
}