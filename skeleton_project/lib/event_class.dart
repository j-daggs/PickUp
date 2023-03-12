import 'dart:ffi';
import 'dart:js_util';

class Event {
  String username;
  String sport;
  DateTime starttime;
  DateTime endtime;
  DateTime date;
  String address;
  String skill;
  String description;
  List comments;
  int postid;

  Event(this.username, this.sport, this.starttime, this.endtime, this.date,
      this.address, this.skill, this.description, this.comments, this.postid);
}

var sampleDate1 = DateTime.utc(2023, 15, 3, 15, 30);
var sampleDate2 = DateTime.utc(2023, 20, 4, 9, 00);
var sampleDate3 = DateTime.utc(2023, 18, 2, 17, 15);
var SAMPLE_EVENTS = [
  Event(
      "user1",
      "Tennis",
      sampleDate1,
      sampleDate1,
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
      sampleDate2,
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
      sampleDate3,
      sampleDate3,
      "927 Market St. Wilimington, NC",
      "Expert",
      "4v4 pickup basketball game, I have a team and am looking for another team of 4.",
      ['comment5', 'comment6'],
      9768)
];
