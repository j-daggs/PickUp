import 'package:intl/intl.dart';

class Event {
  String username;
  String sport;
  DateTime starttime;
  var duration;
  DateTime dateposted;
  String address;
  String skill;
  String description;

  Event(
      this.username,
      this.sport,
      this.starttime,
      this.duration,
      this.dateposted,
      this.address,
      this.skill,
      this.description);

  get getDate => DateFormat.yMd().format(dateposted);
  get getTime => DateFormat.jm().format(starttime);
}
/*
var sampleDate1 = DateTime(2022, 15, 3, 15, 30);
var sampleDate2 = DateTime(2022, 20, 4, 9, 00);
var sampleDate3 = DateTime(2022, 18, 2, 17, 15);
var sampleEvents = [
  Event(
      "user1",
      "Tennis",
      sampleDate1,
      2,
      sampleDate1,
      "1234 Tennis Dr. Wilmington, NC",
      "Beginner",
      "Looking for another beginner level player to play a singles match.",
      ['comment1', 'comment2'],
      123),
  Event(
      "user2",
      "Soccer",
      sampleDate2,
      3,
      sampleDate2,
      "589 Seahawk Dr. Wilimington, NC",
      "Intermediate",
      "5v5 soccer game, already have 7 need 3 more",
      ['comment3', 'comment4'],
      8756),
  Event(
      "user3",
      "Basketball",
      sampleDate3,
      1.5,
      sampleDate3,
      "927 Market St. Wilimington, NC",
      "Expert",
      "4v4 pickup basketball game, I have a team and am looking for another team of 4.",
      ['comment5', 'comment6'],
      9768)
];
*/