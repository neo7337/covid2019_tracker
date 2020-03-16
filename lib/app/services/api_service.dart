import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid_tracker/app/services/api.dart';

class APIService {
  APIService(this.api);
  final API api;

  HashMap<String, String> responseMap = new HashMap<String, String>();

  Future<HashMap<String, String>> getEndpointData() async {
    final uri = api.endpointUri();
    print(uri);
    final response = await http.get(
      uri.toString(),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      responseMap['Confirmed']=json.decode(response.body)["confirmed"]["value"].toString();
      responseMap['Recovered']=json.decode(response.body)["recovered"]["value"].toString();
      responseMap['Deaths']=json.decode(response.body)["deaths"]["value"].toString();
      responseMap['LastUpdate']=json.decode(response.body)["lastUpdate"];
      return responseMap;
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}