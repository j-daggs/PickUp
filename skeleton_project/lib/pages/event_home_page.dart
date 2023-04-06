import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/pages/create_event_page.dart';
import '../classes/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/pages/view_event_page.dart';
import 'package:my_app/classes/event_class.dart';

final Position currentLocation =
    userPosition; // the user's current location, for calculating distances from events

const List<String> list = <String>[
  'Basketball',
  'Kickball',
  'Ultimate Frisbee',
  'Bowling'
];

// This page is the page a user sees after logging in
class HomePage extends StatelessWidget {
  // var sampleEvents = SAMPLE_EVENTS;

  const HomePage({super.key, this.scrolledUnderElevation});
  static const String _title = 'PickUP';

  final bool shadowColor = false;
  final double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor: Colors.grey,
          backgroundColor: Colors.green,
          actions: <Widget>[
            const DropdownSports(),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateEventPage()),
                );
              },
              tooltip: 'Create an Event',
              icon: const Icon(Icons.add_box_outlined),
              color: Colors.white,
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Event').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              return cardBuilder(snapshot.data!);
            }
            return const Text("No data");
          },
        ),
      ),
      color: Colors.grey,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget cardBuilder(QuerySnapshot<Map<String, dynamic>> data) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                dynamic snap = data.docs[index].data();
                // TODO: This is the unique document id. You want to pass this
                // as a string to ViewEvent through ViewEvent's constructor
                String currentEventId = data.docs[index].id;

                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 220,
                  width: double.maxFinite,
                  child: InkWell(
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: Colors.black),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Stack(children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                            right: 10,
                                            bottom: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 0),
                                                displayUsername(snap),
                                                const Spacer(),
                                                displaySportSkill(snap),
                                                const Spacer(),
                                                displayDate(snap),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 0),
                                                displayDuration(snap),
                                                const Spacer(),
                                                displayAddress(snap)
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 10),
                                                displayDescription(snap),
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                      onTap: () {
                        debugPrint('Card tapped. $snap}');
                        Navigator.push(
                            // send data to next page
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewEvent(currentEventId: currentEventId),
                                settings: RouteSettings(
                                  arguments: snap,
                                )));
                      }),
                );
              }),
        ),
      ],
    );
  }

  Widget displayUsername(snap) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: '${snap['Username']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displaySportSkill(snap) {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
          text: '${snap['Sport']} \n',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '${snap['Skill']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget displayDate(snap) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text:
              'Start Time: ${DateFormat.yMMMd().format(snap['StartTime'].toDate())}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayDuration(snap) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${snap['Duration']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayAddress(snap) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          text: '${snap['Address']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayDescription(snap) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          text: '${snap['Description']}',
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
              fontSize: 20),
        ),
      ),
    );
  }
}

class DropdownSports extends StatefulWidget {
  const DropdownSports({super.key});

  @override
  State<DropdownSports> createState() => _DropdownSportsState();
}

class _DropdownSportsState extends State<DropdownSports> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: Colors.black,
    );
  }
}
