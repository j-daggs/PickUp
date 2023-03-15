import 'package:flutter/material.dart';
import 'view_event_page.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:intl/intl.dart';
import '../classes/comment.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.title});
  final String title;
  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}
class _CreateEventPage extends State<CreateEventPage> {
  get onPressed => null;
  Event newEvent = Event('username', "sport", DateTime.now(), "duration", DateTime.now(), "add", "skill", "description", Comment.testingList, 1234);
  //@override
  //_MyHomePage createState() => _MyHomePage();
  //@override
  
  TextEditingController textControllerSport = TextEditingController();
  TextEditingController textControllerSkill = TextEditingController();
  TextEditingController textControllerLocation = TextEditingController();
  TextEditingController textControllerDate = TextEditingController(); //datetime
  TextEditingController textControllerStart = TextEditingController(); //datetime
  TextEditingController textControllerDuration = TextEditingController();
  Event currentEvent = EventData().event2;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerSport,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'What is the Sport',
                  ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerSkill,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Skill Level',
                  ),
              onSubmitted: (String value){
                  newEvent.skill = value;
                }
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
                onSubmitted: (String value){
                  newEvent.address = value;
                }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerStart,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a StartTime',
                  ),
                  onSubmitted: (String value){
                    newEvent.starttime = DateTime();
                }
                  ),
            ),
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
                onSubmitted: (String value){
                  newEvent.duration = value;
                }
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextField(
                  controller: textControllerDuration,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add a description',
                  ),
              onSubmitted: (String value){
                newEvent.description = value;
              }
                  ),
            ),
          ),
        ]),
      ),
    );
  }
}