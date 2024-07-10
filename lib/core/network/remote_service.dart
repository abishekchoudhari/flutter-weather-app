import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_constants.dart';


class RemoteService {
  final ApiConstants _apiConstants = Get.put(ApiConstants());

  weatherReport(location, apiKey) async {
    try {
      final url = Uri.parse(
          '${_apiConstants.weatherBaseUrl}?location=$location&apikey=$apiKey');
      var response = await http.get(url);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
