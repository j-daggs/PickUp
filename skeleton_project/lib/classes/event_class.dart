import 'package:intl/intl.dart';

class Event {
  String username;
  String sport;
  DateTime starttime;
  String duration;
  DateTime dateposted;
  String address;
  String skill;
  String description;
  List interested;

  Event(
      this.username,
      this.sport,
      this.starttime,
      this.duration,
      this.dateposted,
      this.address,
      this.skill,
      this.description,
      this.interested);

  get getDate => DateFormat.yMd().format(dateposted);
  get getTime => DateFormat.jm().format(starttime);
}
