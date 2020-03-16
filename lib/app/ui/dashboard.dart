import 'dart:collection';

import 'package:covid_tracker/app/repositories/data_repository.dart';
import 'package:covid_tracker/app/ui/endpoint_card.dart';
import 'package:covid_tracker/app/ui/updateCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _confirmedCases, _deaths, _lastUpdate, _recovered;
  HashMap<String, String> responseMap = new HashMap<String, String>();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final responseMap = await dataRepository.getEndpointData();
    print(responseMap);
    setState(() => _confirmedCases = responseMap['Confirmed']);
    setState(() => _deaths = responseMap['Deaths']);
    setState(() => _recovered = responseMap['Recovered']);
    setState(() => _lastUpdate = responseMap['LastUpdate']);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            EndpointCard(
              label: 'Confirmed Cases',
              value: _confirmedCases
            ),
            EndpointCard(
              label: 'Recovered Cases',
              value: _recovered
            ),
            EndpointCard(
              label: 'Deaths',
              value: _deaths,
            ),
            UpdateCard(
              label: 'Last Update',
              value: _lastUpdate
            ),
          ],
        ),
      ),
    );
  }
}