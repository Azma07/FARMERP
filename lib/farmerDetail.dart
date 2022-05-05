import 'package:flutter/material.dart';
import 'package:farm/model/farmer.dart';

class FarmerDetail extends StatelessWidget {
  final String value;
  const FarmerDetail({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FARMER DETAILS"),
      ),
      body: Column(
        children: <Widget>[
          Text('$value'),
        ],

      ),
    );
  }
}
