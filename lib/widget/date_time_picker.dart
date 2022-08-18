import 'package:admin/globals.dart';
import 'package:admin/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DatabaseService db = DatabaseService();

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  TextEditingController timeInput = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    timeInput.text = ""; //set the initial value of text field
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: timePicker(),
        ),
      ],
    ));
  }

  Widget timePicker() => Container(
          child: Center(
              child: TextField(
        controller: timeInput, //editing controller of this TextField
        decoration: InputDecoration(
            icon: Icon(Icons.timer), labelText: "Select Departure Time"),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          TimeOfDay pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            //print(pickedTime.format(context)); //print picked time
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
                String parseTime = DateFormat("0000-00-00 HH:mm:ss").format(parsedTime);
            //converting to DateTime.
            departureTime = parseTime;
            print(departureTime);
            setState(() {
              timeInput.text = DateFormat('h:mm a').format(parsedTime);
            });
          } else {
            print("Time is not selected");
          }
        },
      )));
}
