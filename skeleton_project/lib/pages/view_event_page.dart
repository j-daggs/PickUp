// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:intl/intl.dart';
import '../classes/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';

/*class ViewEventPage extends StatelessWidget {
  const ViewEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Event',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ViewEvent(),
    );
  }
}*/

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});
  @override
  _ViewEvent createState() => _ViewEvent();
}

class _ViewEvent extends State<ViewEvent> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  Future addCommentDetails(
      DateTime dateTime, String username, String text) async {
    await FirebaseFirestore.instance
        .collection('Event')
        .doc('FH1WXlX8A6u4e9qdcv6C')
        .collection('Comments')
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
    Event currentEvent = Event(
        'Username',
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
      } else {
        currentEvent.interested.add(user);
      }
      debugPrint('${currentEvent.interested}');

      /// send your request here
      // final bool success= await sendRequest();

      /// if failed, you can do nothing
      // return success? !isLiked:isLiked;

      return !isLiked;
    }

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
              child: Text('Date: ${currentEvent.getDate}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Start Time: ${currentEvent.getTime}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Duration: ${currentEvent.duration}',
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
              child: LikeButton(
            size: 50,
            likeBuilder: ((isTapped) {
              return Icon(
                Icons.star,
                color: isTapped ? Colors.yellow[600] : Colors.blueGrey,
                size: 50,
              );
            }),
            onTap: onInterestButtonTapped,
          )
              /*onPressed: () {
                  setState(() {
                    click = !click;
                  });
                  if (currentEvent.interested.contains(user)) {
                    currentEvent.interested.remove(user);
                    setState(() {
                      snap.update({
                        "Interested": FieldValue.arrayUnion([user])
                      }); //not wokring
                    });
                  } else {
                    currentEvent.interested.add(user);
                    setState(() {
                      snap.update({
                        "Interested": FieldValue.arrayRemove([user])
                      });
                    });
                  }
                  debugPrint('${currentEvent.interested}');
                },
                tooltip: 'Interested',
                child: Icon(
                    (click == false)
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 40,
                    color: Colors.yellow),
            
              )*/
              ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              // button that opens the comment section, a Modal Bottom Sheet
              onPressed: () => showModalBottomSheet(
                // this is what opens the modal bottom sheet that the comment section will be in
                context: context,
                builder: (context) =>
                    buildSheet(), // Call to buildSheet() method that builds the sheet into the comment section
              ),
              child: const Icon(Icons
                  .comment_rounded), // add comment icon to floating button)
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
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add a comment',
                  ),
                  onSubmitted: (String value) {
                    if (textController.text.isNotEmpty) {
                      setState(() {
                        commentList.insert(
                            0,
                            Comment(DateTime.now(), user.toString(),
                                textController.text));
                        addCommentDetails(DateTime.now(), user.toString(),
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
              body: commentList.isNotEmpty
                  ? ListView.builder(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // comments added for testing
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('${commentList[index]}'),
                            trailing: Text(
                                '${commentList[index].dateTime.month.toString()}-${commentList[index].dateTime.day.toString().padLeft(2, '0')}-${commentList[index].dateTime.year.toString().padLeft(2, '0')} (${Comment.militaryToNormal(commentList[index].dateTime.hour, commentList[index].dateTime.minute)})'),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No Comments yet.")),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add_comment_rounded),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    setState(() {
                      commentList.insert(
                          0,
                          Comment(DateTime.now(), user.toString(),
                              textController.text));
                      addCommentDetails(
                          DateTime.now(), user.toString(), textController.text);
                    });
                  }
                },
              ),
            ),
          ),
        ),
      );
}

class InterestButton extends StatefulWidget {
  const InterestButton({Key? key}) : super(key: key);
  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  bool click = true;
  @override
  Widget build(BuildContext context) {
    Icon icon = Icon(Icons.star_border_rounded, size: 35);
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          click = !click;
        });
        /*if (event.interested.contains(user)) {
          interested.remove(user);
        } else {
          interested.add(user);
        }
        print(interested);
      */
      },
      tooltip: 'Interested',
      child: Icon(
          (click == false) ? Icons.star_rounded : Icons.star_border_rounded,
          size: 40,
          color: Colors.yellow),
    );
  }
}
