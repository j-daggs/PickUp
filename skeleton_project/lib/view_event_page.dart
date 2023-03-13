// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'event_class.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Event',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class EventData {
  Event event1 = Event(
      "user1",
      "Tennis",
      sampleDate1,
      2,
      sampleDate1,
      "1234 Tennis Dr. Wilmington, NC",
      "Beginner",
      "Looking for another beginner level player to play a singles match.",
      ['comment1', 'comment2'],
      123);
  Event event2 = Event(
      "user2",
      "Soccer",
      sampleDate2,
      3,
      sampleDate2,
      "589 Seahawk Dr. Wilimington, NC",
      "Intermediate",
      "5v5 soccer game, already have 7 need 3 more",
      ['comment3', 'comment4'],
      8756);
  Event event3 = Event(
      "user3",
      "Basketball",
      sampleDate3,
      1.5,
      sampleDate3,
      "927 Market St. Wilimington, NC",
      "Expert",
      "4v4 pickup basketball game, I have a team and am looking for another team of 4.",
      ['comment5', 'comment6'],
      9768);
}

class MyHomePage extends StatelessWidget {
  get onPressed => null;
  Event currentEvent = EventData().event3;

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMd().format(currentEvent.date);
    String time = DateFormat.jm().format(currentEvent.date);
    String month = currentEvent.date.month.toString();
    String day = currentEvent.date.day.toString();
    String year = currentEvent.date.year.toString();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Sport: ${currentEvent.sport}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Skill: ${currentEvent.skill}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Location: ${currentEvent.address}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Date: $date',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Start Time: $time',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Duration: ${currentEvent.duration} hrs',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Description: ${currentEvent.description}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InterestButton(),
          ),
        ]),
      ),
    );
  }
}

class InterestButton extends StatefulWidget {
  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  @override
  Widget build(BuildContext context) {
    var current = EventData().event1.postid;
    var interested = [];
    Icon icon = Icon(Icons.star_border_rounded, size: 35);
    int iconNumber = 0;
    return FloatingActionButton(
      child: icon,
      onPressed: () {
        if (interested.contains(current)) {
          interested.remove(current);
        } else {
          interested.add(current);
        }
        if (iconNumber == 0) {
          icon = Icon(
            Icons.circle,
            size: 35,
          );
          iconNumber = 1;
        } else {
          icon = Icon(
            Icons.star_border_rounded,
            size: 35,
          );
          iconNumber = 0;
        }
        print(interested);
      },
      tooltip: 'Interested',
    );
  }
}
