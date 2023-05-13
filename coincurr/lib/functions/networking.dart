import 'dart:convert';
import 'coin_data.dart';
import 'package:http/http.dart' as http;

String apiKey = "C70AB640-15DC-4B76-B178-CD3D1621A5F5";
// String apiKey = "093F1850-BE06-4D3E-AE35-957AB23B05B4";
class CoinData{

  Future getCoinData(String currency2) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {

      http.Response response = await http.get(Uri.parse(
          "https://rest.coinapi.io/v1/exchangerate/$crypto/$currency2?apikey=$apiKey"));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var price = decodedData['rate'].toStringAsFixed(0);
        cryptoPrices[crypto] = price;
      } else {
        print(response.statusCode);
        throw "Problem with the get request";
      }
    }
    return cryptoPrices;
  }

}