import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ServerRequest {

  FutureOr<dynamic> request() async{
    var url = "http://35.247.121.242:8080/Umimamoru/umimamoru/net/flow"
        "?net=0";
    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    return json.decode(response.body);
  }
}