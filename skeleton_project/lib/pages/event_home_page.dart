import 'package:flutter/material.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:my_app/pages/create_event_page.dart';

const List<String> list = <String>[
  'Basketball',
  'Kickball',
  'Ultimate Frisbee',
  'Bowling'
];

// This page is the page a user sees after logging in
class HomePage extends StatelessWidget {
  var sampleEvents = Event.getEvent;

  static const String _title = 'PickUP';

  bool shadowColor = false;
  double? scrolledUnderElevation;

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
          body: cardBuilder(sampleEvents)),
      color: Colors.grey,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget cardBuilder(data) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 5,
                      child: InkWell(
                        splashColor: Colors.green.withAlpha(50),
                        onTap: () {
                          debugPrint('Card tapped. ${data[index]}}');
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: Colors.black),
                            ),
                            color: Color.fromARGB(98, 255, 255, 255),
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
                                                displayUsername(data[index]),
                                                const Spacer(),
                                                displaySportSkill(data[index]),
                                                const Spacer(),
                                                displayDate(data[index]),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 0),
                                                displayTime(data[index]),
                                                const Spacer(),
                                                displayAddress(data[index])
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                displayDescription(data[index]),
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
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget displayUsername(data) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: '${data['username']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displaySportSkill(data) {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
          text: '${data['sport']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data['skill']}',
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

  Widget displayDate(data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '${data['date']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayTime(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${data['starttime']} to ${data['endtime']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayAddress(data) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          text: '${data['address']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }

  Widget displayDescription(data) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          text: '${data['description']}',
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
