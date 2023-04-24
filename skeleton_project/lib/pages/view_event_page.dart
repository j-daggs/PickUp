// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:intl/intl.dart';
import 'package:my_app/classes/theme_class.dart';
import 'package:my_app/pages/event_home_page.dart';
import '../classes/comment.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';

class ViewEvent extends StatefulWidget {
  // Initializing currentEventId
  String currentEventId;
  // Making currentEventId a required part of the constructor
  ViewEvent({Key? key, required this.currentEventId}) : super(key: key);
  @override
  State<ViewEvent> createState() => _ViewEvent();
}

class _ViewEvent extends State<ViewEvent> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  var buttonController = ButtonController();
  Future addCommentDetails(
      DateTime dateTime, String username, String text) async {
    await FirebaseFirestore.instance
        .collection('Event')
        // Accessing currentEventId through the different states using widget.
        .doc(widget.currentEventId)
        .collection('Comment')
        .add({'DateTime': dateTime, 'Username': username, 'Text': text});
  }

  List commentList = Comment.testingList;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final snap = ModalRoute.of(context)!.settings.arguments as dynamic;
    debugPrint('Snap: $snap');
    DateTime dateTimeStartTime = (snap['StartTime']).toDate();
    DateTime dateTimeDatePosted = (snap['DatePosted']).toDate();
    final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    final userName = userEmail.split('@');
    Event currentEvent = Event(
        userName.elementAt(0),
        snap['Sport'],
        dateTimeStartTime,
        snap['Duration'],
        dateTimeDatePosted,
        snap['Address'],
        snap['Skill'],
        snap['Description'],
        snap['Interested']);
    final user = FirebaseAuth.instance.currentUser?.uid;

    Future<bool> onInterestButtonTapped(bool isLiked) async {
      if (currentEvent.interested.contains(user)) {
        currentEvent.interested.remove(user);
        await FirebaseFirestore.instance
            .collection('Event')
            .doc(widget.currentEventId)
            .update({
          "Interested": FieldValue.arrayRemove([user]),
        });
        debugPrint('${currentEvent.interested}');
        debugPrint('$isLiked');
        return buttonController.saveLikeCount(isLiked);
      } else {
        currentEvent.interested.add(user);
        await FirebaseFirestore.instance
            .collection('Event')
            .doc(widget.currentEventId)
            .update({
          "Interested": FieldValue.arrayUnion([user]),
        });
        debugPrint('${currentEvent.interested}');
        debugPrint('$isLiked');
        return buttonController.saveLikeCount(isLiked);
      }
    }

    return Scaffold(
      backgroundColor: lightBackground,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Sport: ${currentEvent.sport}',
                style: TextStyle(
                    fontSize: largeFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Skill: ${currentEvent.skill}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Location: ${currentEvent.address}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Date: ${currentEvent.getDate}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Start Time: ${currentEvent.getTime}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Duration: ${currentEvent.duration}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Description: ${currentEvent.description}',
                  style: TextStyle(
                      fontSize: largeFontSize, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: LikeButton(
              size: 50,
              mainAxisAlignment: MainAxisAlignment.end,
              likeCount: currentEvent.interested.isNotEmpty
                  ? currentEvent.interested.length
                  : 0,
              countPostion: CountPostion.top,
              countBuilder: (int? count, bool isLiked, String text) {
                var color = isLiked ? primaryAccent : darkColor;
                return Text(
                  text,
                  style: TextStyle(
                    color: blackText,
                    fontSize: bodyFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              likeBuilder: ((isLiked) {
                return Icon(
                  Icons.star_rounded,
                  color: isLiked ? primaryAccent : darkColor,
                  size: 50,
                );
              }),
              onTap: onInterestButtonTapped,
              isLiked: currentEvent.interested.contains(user) ? true : false,
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: greenPrimary,
              // button that opens the comment section, a Modal Bottom Sheet
              onPressed: () => showModalBottomSheet(
                // this is what opens the modal bottom sheet that the comment section will be in
                context: context,
                builder: (context) =>
                    buildSheet(), // Call to buildSheet() method that builds the sheet into the comment section
              ),
              child: const Icon(
                Icons.comment_rounded,
                color: brightColor,
              ), // add comment icon to floating button)
            ),
          ),
        ]),
      ),
    );
  }

  /// build method for Modal Bottom Sheet Comment section
  Widget buildSheet() => DraggableScrollableSheet(
        initialChildSize: 1.0,
        builder: (_, controller) => Container(
          color: lightBackground,
          padding: const EdgeInsets.all(16),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: AppTheme.greenTheme,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryLight,
                title: TextField(
                  cursorColor: darkColor,
                  controller: textController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: primaryLight),
                    ),
                    hintText: 'Start typing a comment',
                  ),
                  onSubmitted: (String value) {
                    if (textController.text.isNotEmpty) {
                      final userEmail =
                          FirebaseAuth.instance.currentUser!.email.toString();
                      final userName = userEmail.split('@');
                      setState(() {
                        commentList.insert(
                            0,
                            Comment(DateTime.now(), userName.elementAt(0),
                                textController.text));
                        addCommentDetails(DateTime.now(), userName.elementAt(0),
                            textController.text);
                        textController.clear();
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => buildSheet());
                      });
                    }
                  },
                ),
              ),
              // uses streambuilder just like home page
              // Grabs snapshot of all comments within specific event
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Event')
                    .doc(widget.currentEventId)
                    .collection('Comment')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Text("No comments yet");
                  }
                  // Returns a list view with comments queried from database
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // Instantiates instance of snapshot
                      dynamic commentSnap = snapshot.data!.docs[index].data();
                      return Card(
                        child: ListTile(
                          leading: Text('${commentSnap['Username']}:'),
                          title: Text(commentSnap['Text']),
                          trailing: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${DateFormat.M().format(commentSnap['DateTime'].toDate())}-${DateFormat.d().format(commentSnap['DateTime'].toDate()).padLeft(2, '0')}-${DateFormat.y().format(commentSnap['DateTime'].toDate()).padLeft(2, '0')} (${DateFormat.jm().format(commentSnap['DateTime'].toDate())})',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: greenPrimary,
                child: const Icon(Icons.add_comment_rounded),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    final userEmail =
                        FirebaseAuth.instance.currentUser!.email.toString();
                    final userName = userEmail.split('@');
                    setState(() {
                      commentList.insert(
                          0,
                          Comment(DateTime.now(), userName.elementAt(0),
                              textController.text));
                      addCommentDetails(DateTime.now(), userName.elementAt(0),
                          textController.text);
                    });
                  }
                },
              ),
            ),
          ),
        ),
      );
}
