import 'dart:collection';

import 'package:covid_tracker/app/repositories/data_repository.dart' as dataRepository;
import 'package:covid_tracker/app/services/api_service.dart' as apiService;
import 'package:covid_tracker/app/services/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CountryData extends StatefulWidget {
  CountryData({Key key}) : super(key : key);

  final _CountryDataStatefulWidget obj = new _CountryDataStatefulWidget();
  
  @override
  _CountryDataStatefulWidget createState() => _CountryDataStatefulWidget();

  void updateData(String input) {
    obj.updateData(input);
  }
}

class _CountryDataStatefulWidget extends State<CountryData> {

  String _confirmedLabel, _recoveredLabel, _deathLabel, _confirmedValue, _recoveredValue, _deathValue;
  HashMap<String, String> responseMap = new HashMap<String, String>();
  String _confirmedCases, _deaths, _recovered;
  
  @override
  void initState() {
    super.initState();
    _setData();
    _updateInfo();
  }

  void updateData(String input) {
    print('calling update data ' + input);
    _fetchInfo(input);
  }

  void _updateInfo() {
    setState(() => _confirmedValue = _confirmedCases);
    setState(() => _deathValue = _deaths);
    setState(() => _recoveredValue = _recovered);
  }

  Future<void> _fetchInfo(String input) async {
    print('calling _fetchInfo ' + input);
    final responseMap = await dataRepository.DataRepository(apiService: apiService.APIService(api.API(apiKey: null))).getCountryInfo(input);
    print('country info CountryData.dart' + responseMap.toString());
    setState(() => _confirmedCases = responseMap['Confirmed']);
    setState(() => _deaths = responseMap['Deaths']);
    setState(() => _recovered = responseMap['Recovered']);
  }

  void _setData() {
    setState(() {
      _confirmedLabel = 'Confirmed Cases';
    });
    setState(() {
      _recoveredLabel = 'Recovered Cases';
    });
    setState(() {
      _deathLabel = 'Deaths';
    });
    setState(() => _confirmedValue = '0');
    setState(() => _deathValue = '0');
    setState(() => _recoveredValue = '0');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(
                  _confirmedLabel,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  _confirmedValue != null ? _confirmedValue.toString() : '',
                  style: Theme.of(context).textTheme.display1,
                ),],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(
                  _recoveredLabel,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  _recoveredValue != null ? _recoveredValue.toString() : '',
                  style: Theme.of(context).textTheme.display1,
                ),],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(
                  _deathLabel,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  _deathValue != null ? _deathValue.toString() : '',
                  style: Theme.of(context).textTheme.display1,
                ),],
              ),
            ],
          ),
        ),
      )
    );
  }
}