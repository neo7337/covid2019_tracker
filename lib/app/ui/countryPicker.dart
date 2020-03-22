import 'dart:collection';

import 'package:covid_tracker/app/repositories/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/app/ui/countryData.dart' as countryData;
import 'package:provider/provider.dart';

class CountryPicker extends StatefulWidget {
  
  CountryPicker({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CountryPicker> {
  String dropdownValue = 'IN';
  HashMap<String, String> countriesList = new HashMap<String, String>();
  HashMap<String, String> _countriesList = new HashMap<String, String>();
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final countriesList = await dataRepository.getCountries();
    //print(countriesList.toString());
    setState(() {
      _countriesList = countriesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          countryData.CountryData().updateData(dropdownValue);
        },
        items: _countriesList
            .map((description, value) {
                return MapEntry(
                    description,
                    DropdownMenuItem<String>(
                      value: value,
                      child: Text(description + '('+value+')'),
                    ));
              })
              .values
              .toList(),
      ),
    );
  }
}
