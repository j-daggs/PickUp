/// A class Implementing a Comment object. Includes instances variables dateTime (DateTime), username (String), text (String)
class Comment {
  /// instance variable dateTime (type:DateTime) for keeping the date and time of the comment
  DateTime dateTime;
  /// instance variable username (type:String) for keeping the username associated with the comment
  String username;
  /// instance variable text (type:String) for keeping the text associated with the comment
  String text;
  /// List of Comment instances for testing
  static var testingList = [comment_1, comment_2, comment_3, comment_4, comment_5]; 
  
  /// The Comment class constructor. 
  /// Format for initializing a Comment object: var comment = Comment(DateTime.now(),"Username", "Comment Text");
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
  set setText(String text) => this.text = username;
  
  /// Overridden toString() method for printing a Comment instance in the format 'username: text (dateTime)'
  @override
  String toString() => '$username: $text ($dateTime)';

  /// instance of Comment for testing
  static var comment_1 = Comment(DateTime.now(),"John D", "I will be attending!");
  /// instance of Comment for testing
  static var comment_2 = Comment(DateTime.now(),"Nick B", "I'm going to share this event around, would like more people than last time.");
  /// instance of Comment for testing
  static var comment_3 = Comment(DateTime.now(),"Jacob J", "I've attended this host's pickup events before, they ran it well!");
  /// instance of Comment for testing
  static var comment_4 = Comment(DateTime.now(),"Jacob U", "I can bring extra equipment if needed.");
  /// instance of Comment for testing
  static var comment_5 = Comment(DateTime.now(),"Evan P", "Can I bring some extra friends to this event?");
  
  
  }  
