import 'package:daysince/db/daysince.db.dart';
import 'package:daysince/models/daysince.model.dart';
import 'package:daysince/widget/cards/daysince_summary.dart';
import 'package:daysince/widget/dialog/add_new_daysince.dart';
import 'package:flutter/material.dart';

class DaysinceList extends StatefulWidget {
  @override
  _DaysinceListState createState() => _DaysinceListState();
}

class _DaysinceListState extends State<DaysinceList> {
  List<Daysince>? daysinces;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    DaysinceDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    daysinces = await DaysinceDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  void addEntry() async {
    final daysince = Daysince(description: 'entry', startDate: DateTime.now());
    await DaysinceDatabase.instance.create(daysince);

    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    Widget openNewDaysinceDialog() => AddNewDaysinceDialog(
          refreshNotes: refreshNotes,
        );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: Column(
          children: [
            Expanded(
              child: daysinces != null
                  ? ListView.builder(
                      itemCount: daysinces!.length,
                      itemBuilder: (_, index) => DaysinceSummaryCard(
                            detail: daysinces![index],
                            refreshNotes: refreshNotes,
                          ))
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => openNewDaysinceDialog()),
        tooltip: 'Add a day to track from',
        child: const Icon(Icons.add),
      ),
    );
  }
}
