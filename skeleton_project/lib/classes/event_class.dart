class Event {
  String username;
  String sport;
  DateTime starttime;
  var duration;
  DateTime dateposted;
  String address;
  String skill;
  String description;
  List comments;
  int postid;

  Event(this.username, this.sport, this.starttime, this.duration, this.dateposted,
      this.address, this.skill, this.description, this.comments, this.postid);
  
  

  static final getEvent = [
    {
      'username': 'Bob',
      'sport': 'Tennis',
      'starttime': '1330',
      'endtime': '1530',
      'date': '03/15/2023',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Intermediate',
      'description': 'Hot single looking to play a singles match.',
      'postid': '123'
    },
    {
      'username': 'George',
      'sport': 'Basketball',
      'starttime': '1330',
      'endtime': '1530',
      'date': '03/15/2023',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Beginner',
      'description':
          'I am george w. bush and my favorite cheese is chuck e cheese.',
      'postid': '123'
    },
    {
      'username': 'Ronald',
      'sport': 'Darts',
      'starttime': '1330',
      'endtime': '1530',
      'date': '04/21/2068',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Beginner',
      'description': 'Looking to play a singles match.',
      'postid': '123'
    },
    {
      'username': 'Hamburgaler',
      'sport': 'Stealing',
      'starttime': '1330',
      'endtime': '1530',
      'date': '03/15/2023',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Expert',
      'description': 'Looking to play a singles match.',
      'postid': '123'
    },
    {
      'username': 'Clyde',
      'sport': 'Bowling',
      'starttime': '1330',
      'endtime': '1530',
      'date': '03/15/2023',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Beginner',
      'description':
          'I have too much to say because I believe that everything i have to say is important. 42',
      'postid': '123'
    },
    {
      'username': 'Tyler',
      'sport': 'Kickball',
      'starttime': '1330',
      'endtime': '1530',
      'date': '03/15/2023',
      'address': '1234 Tennis Dr. Wilmington, NC',
      'skill': 'Beginner',
      'description': 'Must be tall enough to ride splash mountain.',
      'postid': '123'
    }
  ];
}

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
