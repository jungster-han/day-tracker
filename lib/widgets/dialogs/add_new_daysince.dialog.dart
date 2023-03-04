import 'package:daysince/models/daysince_detail.model.dart';
import 'package:flutter/material.dart';

class AddNewDaysinceDialog extends StatefulWidget {
  final Function addToTrackList;
  const AddNewDaysinceDialog({super.key, required this.addToTrackList});

  @override
  State<AddNewDaysinceDialog> createState() => _AddNewDaysinceDialog();
}

class _AddNewDaysinceDialog extends State<AddNewDaysinceDialog> {
  DateTime selectedDate = DateTime.now();

  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Add a description'),
            maxLength: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    widget.addToTrackList(DaysinceDetail(
                        descriptionController.text, selectedDate));
                    Navigator.pop(context);
                  },
                  child: const Text('Add'))
            ],
          ),
        )
      ]),
    );
  }
}
