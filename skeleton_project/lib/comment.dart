/// A class Implementing a Comment object. Includes instance variables dateTime (DateTime), username (String), text (String)
class Comment {
  /// instance variable dateTime (type:DateTime) for keeping the date and time of the comment
  DateTime dateTime;
  /// instance variable username (type:String) for keeping the username associated with the comment
  String username;
  /// instance variable text (type:String) for keeping the text associated with the comment
  String text;
  /// List of Comment instances for testing
  static List testingList = [comment1, comment2, comment3, comment4, comment5, comment1, comment2, comment3]; 

  /// The Comment class constructor. 
  /// Format for initializing a Comment object: var comment = Comment(DateTime, String, String);
  Comment(this.dateTime , this.username, this.text);

  /// getter for dateTime 
  DateTime get getDateTime => dateTime;
  /// setter for dateTime, accepts a variable of type DateTime
  set setDateTime(DateTime dateTime) => this.dateTime = dateTime;

  /// getter for username 
  String get getUsername => username;
  // setter for username, accepts a variable of type String 
  set setUsername(String username) => this.username = username;

  /// getter for text 
  String get getText => text;
  /// setter for text , accepts a variable of type String
  set setText(String text) => this.text = text;
  
  /// Overridden toString() method for printing a Comment instance in the format 'username: text (dateTime)'
  @override
  String toString() => '$username: $text ($dateTime)';

  /// instance of Comment for testing
  static var comment1 = Comment(DateTime.now(),"John D", "I will be attending!");
  /// instance of Comment for testing
  static var comment2 = Comment(DateTime.now(),"Nick B", "I'm going to share this event around, would like more people than last time.");
  /// instance of Comment for testing
  static var comment3 = Comment(DateTime.now(),"Jacob J", "I've attended this host's pickup events before, they ran it well!");
  /// instance of Comment for testing
  static var comment4 = Comment(DateTime.now(),"Jacob U", "I can bring extra equipment if needed.");
  /// instance of Comment for testing
  static var comment5 = Comment(DateTime.now(),"Evan P", "Can I bring some extra friends to this event?");
  
  }  
