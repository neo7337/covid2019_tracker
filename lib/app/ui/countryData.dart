import 'dart:collection';

import 'package:covid_tracker/app/repositories/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CountryData extends StatefulWidget {
  CountryData({Key key}) : super(key : key);

  @override
  _CountryDataStatefulWidget createState() => _CountryDataStatefulWidget();

}

class _CountryDataStatefulWidget extends State<CountryData> {

  String _confirmedLabel, _recoveredLabel, _deathLabel;
  String confirmed = '0', recovered = '0', death = '0';

  String dropdownValue = 'IND';
  HashMap<String, String> countriesList = new HashMap<String, String>();
  HashMap<String, String> _countriesList = new HashMap<String, String>();
  
  @override
  void initState() {
    _setData();
    _updateData();
    super.initState();    
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final countriesList = await dataRepository.getCountries();
    //print('print'+countriesList.toString());
    setState(() {
      _countriesList = countriesList;
    });
  }

  Future<void> fetchCountryData(String input) async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final responseMap = await dataRepository.getCountryInfo(input);
    print('country info CountryData.dart' + responseMap.toString());
    //final obj = new ComplexValueNotifier();
    //obj.setCountryData('hello');
    if(responseMap != null) {
      setState(() {
        confirmed = responseMap['Confirmed'];
      });
      setState(() {
        recovered = responseMap['Recovered'];
      });
      setState(() {
        death = responseMap['Deaths'];
      });
    }
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        fetchCountryData(dropdownValue);
                      },
                      items: _countriesList
                          .map((description, value) {
                              return MapEntry(
                                  description,
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(description + ' ('+value+')'),
                                  ));
                            })
                            .values
                            .toList(),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(
                  _confirmedLabel,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  confirmed,
                  style: Theme.of(context).textTheme.display1,
                ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(
                  _recoveredLabel,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  recovered,
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
                  death,
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