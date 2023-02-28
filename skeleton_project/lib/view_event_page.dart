import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion titleSection
    Widget eventDetails = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Sport:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Skill Level:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Location:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Date:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Time:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Comments:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'View Event',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: Column(
          children: [eventDetails],
        ),
      ),
    );
  }
}
