import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bitcoin_ticker/coin_data.dart' as Constants;

class NetworkHelper {
  final String apiURL;
  final String apiKey;
  final String cryptoCurrency;

  NetworkHelper({this.apiURL, this.cryptoCurrency, this.apiKey});

  Future<List<dynamic>> getData(String currencyCode) async {
    List<dynamic> currenciesData = [];

    for (String crypto in Constants.cryptoList) {
      var url = '$apiURL$crypto/$currencyCode?$apiKey';
      http.Response response = await http.get(url);
      print('URL:$url');
      var json = jsonDecode(response.body);
      print('RESPONSE: $json');
      currenciesData.add(json);
    }

    return currenciesData;
  }
}
