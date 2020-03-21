import 'package:flutter/material.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({Key key, this.label, this.value}) : super(key: key);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: RichText(
        text: TextSpan(
          text: label+' ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: value, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        textAlign: TextAlign.center,
      )
    );
  }
}