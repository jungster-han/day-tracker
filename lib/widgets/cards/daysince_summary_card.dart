// import 'package:flutter/material.dart';

import 'package:daysince/db/daysince_db.dart';
import 'package:daysince/models/daysince_detail.model.dart';
import 'package:daysince/widgets/dialogs/edit_daysince_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  Widget editDaySince() => EditDaysinceDialog(detail: widget.detail);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) {
              DaysinceDatabase.instance.removeDaysince(widget.detail.id!);
            },
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => editDaySince());
        },
        child: Card(
          child: Column(children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Days since ${widget.detail.description}',
                    style: const TextStyle(fontSize: 18)),
              ),
              subtitle: Text(
                  '${getDaysBetween(widget.detail.startingDate, DateTime.now())} days',
                  style: const TextStyle(fontSize: 16)),
            )
          ]),
        ),
      ),
    );
  }
}
