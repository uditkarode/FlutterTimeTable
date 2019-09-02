import 'package:flutter/material.dart';
import 'package:time_table/globals.dart';
import 'package:time_table/SizeConfig.dart';
import 'package:intl/intl.dart';

class RemainingPeriods extends StatefulWidget {
  RemainingPeriodsState createState() => remainingState;
}

// -----------------------------------------------------------------------------

class RemainingPeriodsState extends State<RemainingPeriods> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int actualCount = -1;
    return ListView.builder(
      itemCount: timeTable.length * 2,
      padding: EdgeInsets.all(2.5),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(color: Colors.grey);
        else
          actualCount++;
        return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(timeTable[actualCount].name,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                        color: Color(0xffDCEDC8))),
                RichText(
                  textAlign: TextAlign.end,
                  text: new TextSpan(
                    style: new TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                      color: Color(0xffFFF9C4),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: DateFormat("hh:mm")
                              .format(timeTable[actualCount].startsAt)),
                      TextSpan(
                          text: '-',
                          style: TextStyle(fontSize: 25, color: Color(0xffFFCDD2))),
                      TextSpan(
                          text: DateFormat("hh:mm a")
                              .format(timeTable[actualCount].endsAt)),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}