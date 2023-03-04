import 'package:flutter/material.dart';

class AddNewDaysinceDialog extends StatefulWidget {
  const AddNewDaysinceDialog({super.key});

  @override
  State<AddNewDaysinceDialog> createState() => _AddNewDaysinceDialog();
}

class _AddNewDaysinceDialog extends State<AddNewDaysinceDialog> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Add a description'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'),
            ElevatedButton(
                child: const Text('Select a Date'),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2200));

                  if (newDate == null) return;
                  setState(() => selectedDate = newDate);
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Add')),
            ElevatedButton(onPressed: () {}, child: Text('Cancel'))
          ],
        )
      ]),
    );
  }
}


// child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Row(
    //         children: [
    //           TextFormField(
    //             decoration: const InputDecoration(
    //                 border: UnderlineInputBorder(),
    //                 labelText: 'Add Start Day Description'),
    //           )
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Text(
    //               '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'),
    //           ElevatedButton(
    //               child: const Text('Select a Date'),
    //               onPressed: () async {
    //                 DateTime? newDate = await showDatePicker(
    //                     context: context,
    //                     initialDate: selectedDate,
    //                     firstDate: DateTime(1900),
    //                     lastDate: DateTime(2200));

    //                 if (newDate == null) return;
    //                 setState(() => selectedDate = newDate);
    //               }),
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           ElevatedButton(onPressed: () {}, child: Text('Add')),
    //           ElevatedButton(onPressed: () {}, child: Text('Cancel'))
    //         ],
    //       )
    //     ],
    //   ),
    // );