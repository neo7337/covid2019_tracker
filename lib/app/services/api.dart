import 'package:flutter/foundation.dart';
import 'package:covid_tracker/app/services/api_keys.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'covid19.mathdro.id';
  static final String basePath = 'api/';
  static final String countriesPath = 'api/countries';

  Uri endpointUri() => Uri(
    scheme: 'https',
    host: host,
    path: '$basePath'
  );
  Uri countriesUri() => Uri(
    scheme: 'https',
    host: host,
    path: '$countriesPath'
  );

  Uri countryInfoUri(String country) => Uri(
    scheme: 'https',
    host: host,
    path: '$countriesPath'+'/'+country
  );

}