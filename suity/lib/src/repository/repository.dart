import 'package:suity/src/models/fetchCoins_models/fetch_coins_models.dart';
import 'package:dio/dio.dart';

import 'hidden.dart';

class Repository {
  static String mainUrl = "https://pro-api.coinmarketcap.com/v1/";
  final String apiKey = Hidden.apiKey;
  var currencyListingAPI = '${mainUrl}cryptocurrency/listings/latest';
  Dio _dio = Dio();
  Future<BigDataModel> getCoins() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return BigDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BigDataModel.withError("error");
    }
  }
}
