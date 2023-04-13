import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:intl/intl.dart';
import '../pages/event_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:http/http.dart' as http;

/// fetchPlacesData is a function that can be called in order to work around the security feature (CORS) of Google Places and the web browser so that it can run without having to disable web security.
Future<http.Response> fetchPlacesData(String address) async {
  final proxyUrl = 'https://cors-anywhere.herokuapp.com/';
  final apiUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$address&key=<api-key>';
  final response = await http.get(Uri.parse('$proxyUrl$apiUrl'));

  return response;
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});
  static const String title = 'PickUp';
  @override
  State<CreateEventPage> createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {
  // adds event details to Firestore Database in Event collection
  Future addEventDetails(
      final username,
      String sport,
      DateTime starttime,
      String duration,
      DateTime dateposted,
      String address,
      String skill,
      String description,
      List interested) async {
    await FirebaseFirestore.instance.collection('Event').add({
      'Username': username,
      'Sport': sport,
      'StartTime': starttime,
      'Duration': duration,
      "DatePosted": dateposted,
      'Address': address,
      'Skill': skill,
      'Description': description,
      'Interested': interested
    });
  }

  get onPressed => null;
  String dateText = 'select a date';
  String timeText = 'select a time';
  String locationText = 'search for the location';
  Event newEvent = Event('username', "Football", DateTime.now(), "duration",
      DateTime.now(), "add", "Beginner", "description", []);
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
  TextEditingController textControllerLocation = TextEditingController();
  TextEditingController textControllerDate = TextEditingController(); //datetime
  TextEditingController textControllerDuration = TextEditingController();
  TextEditingController textControllerDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
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
              // commented out for now as a solution to work around the security feature (CORS) of Google Places and the web browser causing XMLHttpRequest
              // location searching currently working with 'flutter run -d chrome --web-browser-flag "--disable-web-security"'
              /*Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton.extended(
                    heroTag: "location",
                    // button that opens a Modal Bottom Sheet that contains the location searcher . . .
                    onPressed: () => showModalBottomSheet(
                      // this is what opens the modal bottom sheet that the location searcher will be in
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          buildSheet(), // Call to buildSheet() method that builds the sheet into the location searcher
                    ).then((value) {
                      setState(() {
                        newEvent.address = value;
                        locationText = value;
                      });
                    }),
                    icon: const Icon(Icons.location_on_outlined),
                    label: Text(locationText),
                    ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton.extended(
                      heroTag: "datePicker",
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
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton.extended(
                        heroTag: "timePicker",
                        label: Text(timeText),
                        icon: const Icon(Icons.access_time_filled_rounded),
                        onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(newEvent.starttime),
                          );
                          if (newTime == null) return;
                          setState(() {
                            newEvent.starttime = DateTime(
                                newEvent.starttime.year,
                                newEvent.starttime.month,
                                newEvent.starttime.day,
                                newTime.hour,
                                newTime.minute);
                            timeText =
                                DateFormat.jm().format(newEvent.starttime);
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
          )),
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 80,
          right: 16,
          child: FloatingActionButton.extended(
            heroTag: "back",
            label: const Text("go back"),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.undo_rounded),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            heroTag: "upload",
            label: const Text("upload this pickup event"),
            onPressed: () {
              if (locationText == 'search for the location' ||
                  locationText == 'Oops! you forgot to add a location!') {
                setState(() {
                  locationText = 'Oops! you forgot to add a location!';
                });
              }
              if (dateText == 'select a date') {
                setState(() {
                  dateText = 'Oops! you forgot to pick a date!';
                });
              }
              if (timeText == 'select a time') {
                setState(() {
                  timeText = 'Oops! you forgot to pick a time!';
                });
              }
              if (textControllerDescription.text.isNotEmpty &&
                  textControllerDuration.text.isNotEmpty &&
                  textControllerLocation.text
                      .isNotEmpty /*&&
                  locationText != 'search for the location' &&
                  locationText != 'Oops! you forgot to add a location!'*/
                  &&
                  dateText != 'select a date' &&
                  dateText != 'Oops! you forgot to pick a date!' &&
                  dateText != 'select a date' &&
                  dateText != 'Oops! you forgot to pick a date!' &&
                  timeText != 'select a time' &&
                  timeText != 'Oops! you forgot to pick a time!') {
                newEvent.description = textControllerDescription.text;
                newEvent.address = textControllerLocation.text;
                newEvent.duration = textControllerDuration.text;
                textControllerDescription.clear();
                textControllerLocation.clear();
                textControllerDuration.clear();
                dateText = 'select a date';
                timeText = 'select a time';
                final user =
                    FirebaseAuth.instance.currentUser!.email.toString();
                final userEmail = user.split('@');
                addEventDetails(
                    userEmail.elementAt(0),
                    newEvent.sport,
                    newEvent.starttime,
                    newEvent.duration,
                    newEvent.dateposted,
                    newEvent.address,
                    newEvent.skill,
                    newEvent.description, []);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ]),
    );
  }

  /// build method for Modal Bottom Sheet Location Search section (working with 'flutter run -d chrome --web-browser-flag "--disable-web-security"')
  Widget buildSheet() => Stack(
        children: [
          DraggableScrollableSheet(
            initialChildSize: 1.0,
            builder: (_, controller) => Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: SearchLocation(
                apiKey: "api-key",
                onSelected: (place) async {
                  String address = place.description;
                  // var placesData = await fetchPlacesData(address);
                  // print(placesData);
                  Navigator.pop(context, address);
                },
                placeholder: "Search for a location",
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, 'search for the location');
              },
              child: const Icon(Icons.close),
            ),
          ),
        ],
      );

  /// alternate build sheet method, another approach to searching locations. Interacts with fetchPlacesData defined at the top of the page.
//   Widget buildSheet() => Stack(
//   children: [
//     DraggableScrollableSheet(
//       initialChildSize: 1.0,
//       builder: (_, controller) => Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 hintText: locationText,
//               ),
//               onSubmitted: (query) async {
//                 final placesData = await fetchPlacesData(query);
//                 final locations = parsePlacesData(placesData.body);
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (_) => ListView.builder(
//                     itemCount: locations.length,
//                     itemBuilder: (_, index) => ListTile(
//                       title: Text(locations[index]['name']),
//                       subtitle: Text(locations[index]['formatted_address']),
//                       onTap: () {
//                         Navigator.pop(context, locations[index]['formatted_address']);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//     Positioned(
//       bottom: 16,
//       right: 16,
//       child: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context, 'search for the location');
//         },
//         child: const Icon(Icons.close),
//       ),
//     ),
//   ],
// );

// List<Map<String, dynamic>> parsePlacesData(String responseBody) {
//   final data = json.decode(responseBody);
//   final results = data['results'] as List<dynamic>;
//   return results
//       .map((result) => {
//             'name': result['name'],
//             'formatted_address': result['formatted_address'],
//           })
//       .toList();
// }
// }
}
