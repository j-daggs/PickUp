import 'package:flutter/material.dart';
import 'view_event_page.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:intl/intl.dart';
import '../classes/comment.dart';
import '../pages/event_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.title});
  final String title;
  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {
  // adds event details to Firestore Database in Event collection
  Future addEventDetails(
      String sport,
      DateTime starttime,
      String duration,
      DateTime dateposted,
      String address,
      String skill,
      String description) async {
    await FirebaseFirestore.instance.collection('Event').add({
      'Sport:': sport,
      'StartTime': starttime,
      'Duration': duration,
      "DatePosted": dateposted,
      'Address': address,
      'Skill': skill,
      'Description': description
    });
  }

  get onPressed => null;
  String dateText = 'select a date';
  String timeText = 'select a time';
  Event newEvent = Event(
      'username',
      "Football",
      DateTime.now(),
      "duration",
      DateTime.now(),
      "add",
      "Beginner",
      "description",
      Comment.testingList,
      1234);
  List sportList = [
    'Football',
    'Volleyball',
    'Basketball',
    'Soccer',
    'Kickball',
    'Baseball',
    'Wiffleball',
    'Rugby'
  ];
  List skillList = ['Beginner', 'Intermediate', 'Advanced', 'All Skill Levels'];
  //@override
  //_MyHomePage createState() => _MyHomePage();
  //@override

  TextEditingController textControllerLocation = TextEditingController();
  TextEditingController textControllerDate = TextEditingController(); //datetime
  TextEditingController textControllerDuration = TextEditingController();
  TextEditingController textControllerDescription = TextEditingController();
  Event currentEvent = EventData().event2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(2),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Select a sport using the dropdown below: ",
                  textAlign: TextAlign.left),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: DropdownButton(
                hint: const Text("select a sport"),
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                value: newEvent.sport,
                onChanged: (newValue) {
                  setState(() {
                    newEvent.sport = newValue.toString();
                  });
                },
                items: sportList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(2),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Select a skill level using the dropdown below: ",
                  textAlign: TextAlign.left),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: DropdownButton(
                hint: const Text("select a skill level"),
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                value: newEvent.skill,
                onChanged: (newValue) {
                  setState(() {
                    newEvent.skill = newValue.toString();
                  });
                },
                items: skillList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerLocation,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Choose a Location',
                  ),
                  onSubmitted: (String value) {
                    newEvent.address = value;
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton.extended(
                    label: Text(dateText),
                    icon: const Icon(Icons.calendar_today_rounded),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2222),
                      ).then((date) {
                        setState(() {
                          newEvent.starttime = date!;
                          dateText =
                              DateFormat.yMd().format(newEvent.starttime);
                        });
                      });
                    })),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton.extended(
                    label: Text(timeText),
                    icon: const Icon(Icons.access_time_filled_rounded),
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(newEvent.starttime),
                      );
                      if (newTime == null) return;
                      setState(() {
                        newEvent.starttime = DateTime(
                            newEvent.starttime.year,
                            newEvent.starttime.month,
                            newEvent.starttime.day,
                            newTime.hour,
                            newTime.minute);
                        timeText = DateFormat.jm().format(newEvent.starttime);
                      });
                    })),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerDuration,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Duration',
                  ),
                  onSubmitted: (String value) {
                    newEvent.duration = value;
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add a description',
                  ),
                  onSubmitted: (String value) {
                    newEvent.description = value;
                  }),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (textControllerDescription.text.isNotEmpty &&
              textControllerDuration.text.isNotEmpty &&
              textControllerLocation.text.isNotEmpty) {
            newEvent.description = textControllerDescription.text;
            newEvent.address = textControllerLocation.text;
            newEvent.duration = textControllerDuration.text;
            textControllerDescription.clear();
            textControllerLocation.clear();
            textControllerDuration.clear();
            dateText = 'select a date';
            timeText = 'select a time';
            addEventDetails(
                newEvent.sport,
                newEvent.starttime,
                newEvent.duration,
                newEvent.dateposted,
                newEvent.address,
                newEvent.skill,
                newEvent.description);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
