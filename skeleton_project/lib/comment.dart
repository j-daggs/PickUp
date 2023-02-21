class Comment {
  final DateTime dateTime;
  final String username;
  final String text;
  // List of Comment instances for testing
  static var testingList = [comment_1, comment_2, comment_3, comment_4, comment_5]; 
  
  // Example of how testingList can be accessed and utilized:
  // var testing = Comment.testingList;
  // var commentOne = testing[0];
  // print(commentOne);
  

  Comment(this.dateTime , this.username, this.text);
  
  @override
  String toString() => '$username: $text ($dateTime)';

  // Format for initializing a Comment object: var comment = Comment(DateTime.now(),"Username", "Comment Text");
  // instances of Comment for testing:
  static var comment_1 = Comment(DateTime.now(),"John D", "I will be attending!");
  static var comment_2 = Comment(DateTime.now(),"Nick B", "I'm going to share this event around, would like more people than last time.");
  static var comment_3 = Comment(DateTime.now(),"Jacob J", "I've attended this host's pickup events before, they ran it well!");
  static var comment_4 = Comment(DateTime.now(),"Jacob U", "I can bring extra equipment if needed.");
  static var comment_5 = Comment(DateTime.now(),"Evan P", "Can I bring some extra friends to this event?");
  
  
  }  
