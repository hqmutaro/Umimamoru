import 'package:http/http.dart' as http;

class ServerProvider {

  final String _url = "http://35.247.121.242:8080/Umimamoru/umimamoru";

  Future<http.Response> response(String path, String param) async{
    return await http.get(
        url + path + param,
        headers: {"content-type": "application/json"}
    );
  }

  Future<bool> isActivity() async{
    var response = await http.get(url, headers: {"content-type": "application/json"});
    return response != null;
  }

  String get url => _url;
}