import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/main.dart';
import 'package:my_app/pages/create_event_page.dart';
import 'package:my_app/pages/login_form.dart';
import '../classes/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/pages/view_event_page.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_app/classes/theme_class.dart';

/// User's location
final Position currentLocation =
    userPosition; // the user's current location, for calculating distances from events
/// This function takes in an event address (string) and the current location of the user and returns a double representing the distance from the event.
Future<double> findDistanceFromUser(
    String address, Position currentLocation) async {
  Future<List<Location>> location = locationFromAddress(address);
  List eLocation = await location;
  double eventLatitude = eLocation[0].latitude;
  double eventLongitude = eLocation[0].longitude;

  double distanceInMeters = Geolocator.distanceBetween(currentLocation.latitude,
      currentLocation.longitude, eventLatitude, eventLongitude);
  double milesDistance = 0.00062137 * distanceInMeters;
  return milesDistance;
}

// Hardcoded list for the drop down menu
const List<String> _sportList = <String>[
  'All Sports',
  'Football',
  'Volleyball',
  'Basketball',
  'Soccer',
  'Kickball',
  'Baseball',
  'Wiffleball',
  'Rugby'
];

const List<String> _skillList = [
  'All Skill Levels',
  'Beginner',
  'Intermediate',
  'Advanced',
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
  String dropDownSportsValue = _sportList.first;
  String dropDownSkillValue = _skillList.first;
  final user = FirebaseAuth.instance.currentUser?.uid;
  bool intButtonClick = false;

  final bool shadowColor = false;

  /*signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginForm(
                  showRegisterPage: () {},
                )));
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HomePage._title,
      theme: AppTheme.greenTheme,
      home: Scaffold(
        backgroundColor: lightBackground,
        appBar: AppBar(
          title: const Text(HomePage._title),
          scrolledUnderElevation: widget.scrolledUnderElevation,
          actions: <Widget>[
            _showInterestButton(),
            const SizedBox(
              width: 50,
            ),
            _dropDownSkillMenu(),
            const SizedBox(
              width: 50,
            ),
            _dropDownSportsMenu(),
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
            ),
            const SizedBox(
              width: 65,
            ),
            _logoutButton(),
            const SizedBox(width: 10)
          ],
        ),
        body: _filterStream(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _cardBuilder(QuerySnapshot<Map<String, dynamic>> data) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                dynamic snap = data.docs[index].data();
                // This is the unique document id. You want to pass this
                // as a string to ViewEvent through ViewEvent's constructor
                String currentEventId = data.docs[index].id;

                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 220,
                  width: double.maxFinite,
                  child: InkWell(
                      splashColor: errorColor,
                      hoverColor: primaryLightLowAlpha,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: brightBackground,
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
                                                _displayUsername(snap),
                                                const Spacer(),
                                                _displaySportSkill(snap),
                                                const Spacer(),
                                                _displayDate(snap),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 0),
                                                _displayDuration(snap),
                                                const Spacer(),
                                                _displayAddress(snap)
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(height: 10),
                                                _displayDescription(snap),
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
                                // First currentEventId is the constructor to tell ViewEvent
                                // what we are passing it
                                // Second one is actual value of event ID
                                builder: (context) =>
                                    ViewEvent(currentEventId: currentEventId),
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

  Widget _displayUsername(snap) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: '${snap['Username']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryLight,
              fontSize: headerFontSize),
        ),
      ),
    );
  }

  Widget _displaySportSkill(snap) {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
          text: '${snap['Sport']} \n',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryLight,
              fontSize: headerFontSize),
          children: <TextSpan>[
            TextSpan(
                text: '${snap['Skill']}',
                style: const TextStyle(
                  color: blackText,
                  fontSize: bodyFontSize,
                )),
          ],
        ),
      ),
    );
  }

  Widget _displayDate(snap) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text:
              'Start Time: ${DateFormat.yMMMd().format(snap['StartTime'].toDate())} - ${DateFormat.jm().format(snap['StartTime'].toDate())}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: primaryLight, fontSize: 20),
        ),
      ),
    );
  }

  Widget _displayDuration(snap) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${snap['Duration']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryLight,
              fontSize: headerFontSize),
        ),
      ),
    );
  }

  Widget _displayAddress(snap) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          text: '${snap['Address']}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryLight,
              fontSize: headerFontSize),
        ),
      ),
    );
  }

  Widget _displayDescription(snap) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          text: '${snap['Description']}',
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: lightText,
              fontSize: headerFontSize),
        ),
      ),
    );
  }

  Widget _dropDownSportsMenu() {
    return DropdownButton<String>(
      value: dropDownSportsValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: const TextStyle(color: brightText),
      underline: Container(
        height: 2,
        color: brightColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        dropDownSportsValue = value!;
        setState(() {
          dropDownSportsValue;
        });
      },
      items: _sportList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: primaryLight,
    );
  }

  Widget _dropDownSkillMenu() {
    return DropdownButton<String>(
      value: dropDownSkillValue,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: const TextStyle(color: brightText),
      underline: Container(
        height: 2,
        color: brightColor,
      ),
      onChanged: (String? newvalue) {
        // This is called when the user selects an item.
        dropDownSkillValue = newvalue!;
        setState(() {
          dropDownSkillValue;
        });
      },
      items: _skillList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: primaryLight,
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: const Text('Logout'));
  }

// The stream will auto reload the body of the page upon changing the dropDownSportsValue
  _filterStream() {
    // Skill value changed but sport did NOT
    if (dropDownSkillValue != _skillList.first &&
        dropDownSportsValue == _sportList.first) {
      if (intButtonClick) {
        //if skill changed, sport did not change, interest button is clicked
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .where('Skill', whereIn: [dropDownSkillValue, _skillList.first])
              .where('Interested', arrayContains: user)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _cardBuilder(snapshot.data!);
          },
        );
      } else {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Event').where('Skill',
              whereIn: [dropDownSkillValue, _skillList.first]).snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              return _cardBuilder(snapshot.data!);
            }
            return const Text('No data');
          },
        );
      }
    }
    // Sport changed but skill did NOT
    if (dropDownSkillValue == _skillList.first &&
        dropDownSportsValue != _sportList.first) {
      if (intButtonClick) {
        //if sport changed, skill did not change, interest button is clicked
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .where('Sport', isEqualTo: dropDownSportsValue)
              .where('Interested', arrayContains: user)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _cardBuilder(snapshot.data!);
          },
        );
      } else {
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
            if (snapshot.hasData && snapshot.data != null) {
              return _cardBuilder(snapshot.data!);
            }
            return const Text('No Data');
          },
        );
      }
    }
    // Nothing changed
    if (dropDownSkillValue == _skillList.first &&
        dropDownSportsValue == _sportList.first) {
      if (intButtonClick) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .where('Interested', arrayContains: user)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _cardBuilder(snapshot.data!);
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
            if (snapshot.hasData && snapshot.data != null) {
              return _cardBuilder(snapshot.data!);
            }
            return const Text('No Data');
          },
        );
      }
    }
    // Both changed
    if (dropDownSkillValue != _skillList.first &&
        dropDownSportsValue != _sportList.first) {
      if (intButtonClick) {
        //if both are changed and interest button is clicked
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .where('Sport', isEqualTo: dropDownSportsValue)
              .where('Skill', whereIn: [dropDownSkillValue, _skillList.first])
              .where('Interested', arrayContains: user)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _cardBuilder(snapshot.data!);
          },
        );
      } else {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Event')
              .where('Sport', isEqualTo: dropDownSportsValue)
              .where('Skill',
                  whereIn: [dropDownSkillValue, _skillList.first]).snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              return _cardBuilder(snapshot.data!);
            }
            return const Text('No Data');
          },
        );
      }
    }
  }

  Widget _showInterestButton() {
    return IconButton(
      onPressed: () {
        intButtonClick = !intButtonClick;
        setState(() {
          intButtonClick;
          debugPrint('$intButtonClick');
        });
      },
      tooltip: 'Show Your Interested Events',
      icon: intButtonClick
          ? Icon(Icons.star_rounded)
          : Icon(Icons.star_outline_rounded),
      color: Colors.white,
      iconSize: 30,
    );
  }
}

class ButtonController extends GetxController {
  final getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> saveLikeCount(bool isLiked) async {
    getStorage.write("isLiked", !isLiked);
    return !isLiked;
  }
}
