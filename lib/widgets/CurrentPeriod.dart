import 'package:flutter/material.dart';
import 'package:time_table/globals.dart';
import 'package:time_table/SizeConfig.dart';
import 'package:time_table/utils.dart';

class CurrentPeriod extends StatefulWidget {
  CurrentState createState() => currentPeriodState;
}

// -----------------------------------------------------------------------------

class CurrentState extends State<CurrentPeriod> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text(determinePeriod(),
        style: TextStyle(
            color: Color(0xffDCEDC8),
            fontFamily: 'ProductSans',
            fontSize: SizeConfig.safeBlockHorizontal * 15));
  }
}