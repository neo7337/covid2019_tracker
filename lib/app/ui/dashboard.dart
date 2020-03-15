import 'package:covid_tracker/app/repositories/data_repository.dart';
import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases, _confirmedCases, _deaths, _casesSuspected, _recovered;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    final deaths = await dataRepository.getEndpointData(Endpoint.deaths);
    final casesConfirmed = await dataRepository.getEndpointData(Endpoint.casesConfirmed);
    final casesSuspected = await dataRepository.getEndpointData(Endpoint.casesSuspected);
    final recovered = await dataRepository.getEndpointData(Endpoint.recovered);
    setState(() => _cases = cases);
    setState(() => _deaths = deaths);
    setState(() => _confirmedCases = casesConfirmed);
    setState(() => _casesSuspected = casesSuspected);
    setState(() => _recovered = recovered);

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
              label: 'Cases',
              endpoint: Endpoint.cases,
              value: _cases,
            ),
            EndpointCard(
              label: 'Confirmed Cases',
              endpoint: Endpoint.casesConfirmed,
              value: _confirmedCases
            ),
            EndpointCard(
              label: 'Suspected Cases',
              endpoint: Endpoint.casesSuspected,
              value: _casesSuspected
            ),
            EndpointCard(
              label: 'Recovered Cases',
              endpoint: Endpoint.recovered,
              value: _recovered
            ),
            EndpointCard(
              label: 'Deaths',
              endpoint: Endpoint.deaths,
              value: _deaths,
            )
          ],
        ),
      ),
    );
  }
}