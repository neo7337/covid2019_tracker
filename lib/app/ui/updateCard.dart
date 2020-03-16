import 'package:flutter/material.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({Key key, this.label, this.value}) : super(key: key);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.headline,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}