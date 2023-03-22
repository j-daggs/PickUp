import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/classes/event_class.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final sampleEvents = Event.getEvent;

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            // Builds stream to pull events from database
            body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Event').snapshots(),
              builder: (context,
              // Grabs snapshot of database events and uses this as context
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Returns cardBuilder with instance of snapshot(database)
                return cardBuilder(snapshot);
              },
            )));
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
                                        left: 10, top: 5, right: 10, bottom: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const SizedBox(height: 0),
                                            //displayUsername(data[index]),
                                            const Spacer(),
                                            displaySportSkill(snap),
                                            const Spacer(),
                                            // displayDate(data[index]),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: <Widget>[
                                            const SizedBox(height: 0),
                                            // displayTime(data[index]),
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
                );
              }),
        ),
      ],
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
          text: data['Sport'],
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: data['Skill'],
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
          text: '${data['StartTime']}',
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
          text: '${data['StartTime']} to end time',
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
          text: data['Address'],
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
          text: data['Description'],
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
              fontSize: 20),
        ),
      ),
    );
  }
}
