import 'package:flutter/material.dart';
import 'package:umimamoru/infrastructure/repository/server_beach_repository.dart';
import 'package:umimamoru/presentation/beach/main.dart';
import 'package:umimamoru/presentation/display/display.dart';
import 'package:umimamoru/presentation/display/main.dart';

@immutable
class BeachListItem extends StatelessWidget {

  final String beachName;
  final String region;

  final BeachState beachState;
  
  const BeachListItem({
    @required this.beachName,
    @required this.region,
    @required this.beachState
  }) :
      assert(beachName != null),
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
        title: Text(this.beachName, style: TextStyle(fontSize: 25.0)),
        subtitle: Text(this.region, style: TextStyle(color: Colors.grey)),
        onTap: () async{
          var beach = await ServerBeachRepository().beachData(this.beachName);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayHome(beach: beach))
          );
          this.beachState.handleSearchFinish();
        }
      )
    );
  }
}