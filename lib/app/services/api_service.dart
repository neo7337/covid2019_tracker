import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid_tracker/app/services/api.dart';

class Countries {
  final String name;
  final String iso3;
  Countries(this.name, this.iso3);
}

class APIService {
  APIService(this.api);
  final API api;

  HashMap<String, String> responseMap = new HashMap<String, String>();
  List<String> countriesMap = new List<String>();
  HashMap<String, String> countriesList = new HashMap<String, String>();

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

  Future<HashMap<String, String>> getCountryInfo(String country) async {
    final uri = api.countryInfoUri(country);
    print(uri);
    final response = await http.get(
      uri.toString(),
      headers: {'Accept': 'application/json'}
    );
    if(response.statusCode == 200){
      print('country info '+ json.decode(response.body).toString());
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

  Future<HashMap<String, String>> getCountries() async {
    final uri = api.countriesUri();
    print(uri);
    final response = await http.get(uri.toString(), headers: {'Accept': 'application/json'});
    if(response.statusCode == 200 ){
      print('Countries List fetched');
      Map<String, dynamic> decodedMap = jsonDecode(response.body);
      List<dynamic> dynamicList = decodedMap['countries'];
      List<Countries> countries = new List<Countries>();
      dynamicList.forEach((f) {
        Countries s = APIService.fromJsonMap(f);
        countries.add(s);
      });
      countries.forEach( (val) => {
        if(val.iso3 != null)
          countriesList[val.name.toString()]=val.iso3.toString()
      });
      return countriesList;
    }
    print(
        'Countries Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Countries fromJsonMap(Map<String, dynamic> json) {
    String name = json['name'];
    String iso3 = json['iso3'];
    Countries s = new Countries(name, iso3);
    return s;
  }
}