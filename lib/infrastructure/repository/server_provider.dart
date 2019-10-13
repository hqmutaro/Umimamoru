import 'package:http/http.dart' as http;

class ServerProvider {

  final String _url = "http://35.247.121.242:8080/Umimamoru/umimamoru";

  Future<http.Response> response(String path, String param) async{
    return await http.get(
        url + path + param,
        headers: {"content-type": "application/json"}
    );
  }

  Future<bool> isActivity() {
    return http.get(url + "/net?net=0")
        .then((response) {
          print(response);
          if (response == null) return false;
          var statusCode = response.statusCode;
          print("StatusCode: $statusCode");
          if (statusCode != 200) {
            return false;
          }
       return true;
    }).catchError((error) {
      return false;
    });
  }

  String get url => _url;
}