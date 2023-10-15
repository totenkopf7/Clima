import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper{
  NetworkHelper({required this.url});
  final String url;

  Future getData() async{

    Uri uri = Uri.parse(url); // Create a Uri object from the URL string
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      return decodedData;

    }    else {
      print(response.statusCode);

    }
  }

}



//
// print(cTemperature);
// print(condition);
// print(city);
