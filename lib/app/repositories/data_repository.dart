import 'dart:collection';

import 'package:covid_tracker/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  Future<HashMap<String, String>> getEndpointData() async {
    try {
      return await apiService.getEndpointData();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        return await apiService.getEndpointData();
      }
      rethrow;
    }
  }
}