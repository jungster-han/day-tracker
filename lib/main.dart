import 'package:daysince/models/daysince_detail.model.dart';
import 'package:daysince/widgets/cards/daysince_summary_card.dart';
import 'package:daysince/widgets/dialogs/add_new_daysince.dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // option of days since,
  // time since, (year, month, days, hours, minutes, seconds)
  // hours since,
  List<DaysinceDetail> deets = <DaysinceDetail>[
    DaysinceDetail('Days since we met', DateTime(2021, 05, 05)),
    DaysinceDetail('Days since we ate out', DateTime(2023, 02, 28)),
  ];

  void addToTrackList(DaysinceDetail newDaysince) {
    setState(() {
      deets = [...deets, newDaysince];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget addNewDaysince() =>
        AddNewDaysinceDialog(addToTrackList: addToTrackList);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: deets.length,
                itemBuilder: (_, index) => DaysinceSummaryCard(
                  detail: deets[index],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => addNewDaysince()),
        tooltip: 'Add a day to track from',
        child: const Icon(Icons.add),
      ),
    );
  }
}
