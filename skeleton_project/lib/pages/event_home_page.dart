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

// Hardcoded list for the drop down menu
const List<String> sportList = <String>[
  'All',
  'Football',
  'Volleyball',
  'Basketball',
  'Soccer',
  'Kickball',
  'Baseball',
  'Wiffleball',
  'Rugby'
];

// This page is the page a user sees after logging in
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.scrolledUnderElevation});
  static const String _title = 'PickUP';

  final double? scrolledUnderElevation;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownSportsValue = sportList.first;

  final bool shadowColor = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HomePage._title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(HomePage._title),
          scrolledUnderElevation: widget.scrolledUnderElevation,
          shadowColor: Colors.grey,
          backgroundColor: Colors.green,
          actions: <Widget>[
            dropDownSportsMenu(),
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
        body: filterStream(),
      ),
      color: Colors.grey,
      debugShowCheckedModeBanner: false,
    );
  }

  // The stream will auto reload the body of the page upon changing the dropDownSportsValue
  filterStream() {
    if (dropDownSportsValue != sportList.first) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Event')
            .where('Sport', isEqualTo: dropDownSportsValue)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return cardBuilder(snapshot);
        },
      );
    } else {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Event').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return cardBuilder(snapshot);
        },
      );
    }
  }

  Widget cardBuilder(data) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: data.data!.docs.length,
              itemBuilder: (context, index) {
                dynamic snap = data.data!.docs[index].data();
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
                                builder: (context) => const ViewEvent(),
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

  Widget dropDownSportsMenu() {
    return DropdownButton<String>(
      value: dropDownSportsValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        dropDownSportsValue = value!;
        setState(() {
          dropDownSportsValue;
        });
      },
      items: sportList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: Colors.black,
    );
  }
}
