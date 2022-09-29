import 'dart:convert';
import 'package:http/http.dart' as http;
import 'beer.dart';


class BeerData {
  Future<dynamic> fetchBeerData(String apiID) async {
    var response = await http.get(Uri.https('api.punkapi.com', '/v2/beers/$apiID'));
    var beerlist;
    if (response.statusCode == 200) {
        beerlist = (jsonDecode(response.body) as List)
          .map((jsonData) => Beer.fromJson(jsonData))
          .toList();
      //print(beerlist);

    } else {
      //print(response.statusCode);
      throw 'Problem with the get request';
    }
    return beerlist;
  }
}
