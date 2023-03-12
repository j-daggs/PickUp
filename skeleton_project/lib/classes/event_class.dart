import 'dart:ffi';
import 'dart:js_util';

class Event {
  String username;
  String sport;
  int starttime;
  int endtime;
  String date;
  String address;
  String skill;
  String description;
  int postid;

  Event(this.username, this.sport, this.starttime, this.endtime, this.date,
      this.address, this.skill, this.description, this.postid);

  //getter and setter for username
  String get getUsername => username;
  set setUsername(String name) => username = name;

  //getter and setter for sport
  String get getSport => sport;
  set setSport(String sportname) => sport = sportname;

  //getter and setter for starttime
  int get getStartTime => starttime;
  set setStartTime(int time) => starttime = time;

  //getter and setter for endtime
  int get getEndTime => endtime;
  set setEndTime(int time) => endtime = time;

  //getter and setter for date
  String get getDate => date;
  set setDate(String eventdate) => date = eventdate;

  //getter and setter for address
  String get getAddress => address;
  set setAddress(String eventaddress) => address = eventaddress;

  //getter and setter for skill
  String get getSkillLevel => skill;
  set setSkillLevel(String skilllevel) => skill = skilllevel;

  //getter and setter for description
  String get getDescription => description;
  set setDescription(String eventdescription) => description = eventdescription;

  //getter and setter for postid
  int get getPostID => postid;
  set setPostID(int id) => postid = id;
}

var SAMPLE_EVENTS = [
  Event(
      "user1",
      "Tennis",
      1330,
      1530,
      "03/15/2023",
      "1234 Tennis Dr. Wilmington, NC",
      "Beginner",
      "Looking for another beginner level player to play a singles match.",
      123),
  Event(
      "user2",
      "Soccer",
      0900,
      1200,
      "04/20/2023",
      "589 Seahawk Dr. Wilimington, NC",
      "Intermediate",
      "5v5 soccer game, already have 7 need 3 more",
      8756),
  Event(
      "user3",
      "Basketball",
      1700,
      2000,
      "02/28/2023",
      "927 Market St. Wilimington, NC",
      "Expert",
      "4v4 pickup basketball game, I have a team and am looking for another team of 4.",
      9768)
];
