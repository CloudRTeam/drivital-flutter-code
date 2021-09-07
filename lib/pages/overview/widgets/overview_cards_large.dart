import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "Total number of devices",
          value: "7",
          onTap: () {},
          topColor: Colors.green,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Devices with an alert",
          value: "17",
          topColor: Colors.redAccent,
          onTap: () {},
        ),
      ],
    );
  }
}
