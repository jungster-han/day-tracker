// import 'package:flutter/material.dart';

import 'package:daysince/models/daysince_detail.model.dart';
import 'package:flutter/material.dart';

class DaysinceSummaryCard extends StatefulWidget {
  DaysinceDetail detail;
  DaysinceSummaryCard({super.key, required this.detail});

  @override
  State<DaysinceSummaryCard> createState() => _DaysinceSummaryCardState();
}

class _DaysinceSummaryCardState extends State<DaysinceSummaryCard> {
  int getDaysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          title: Text(widget.detail.description),
          subtitle: Text(
              '${getDaysBetween(widget.detail.startingDate, DateTime.now())} days'),
        )
      ]),
    );
  }
}
