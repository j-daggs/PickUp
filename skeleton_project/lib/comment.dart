import 'package:flutter/material.dart';
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
  String toString() => '$username: $text';

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

/// Statefule Widget - Page to hold comment section, comment section will be integrated into Event Page
class CommentPage extends StatefulWidget{
  const CommentPage ({super.key, required this.title});
  final String title;
  @override
  State<CommentPage> createState() => _MyCommentPage();
}
/// State class for Comment Page - _MyCommentPage
class _MyCommentPage extends State<CommentPage>{
  List commentList = Comment.testingList;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'This Page implements a Modal Bottom Sheet for a Comment Section. Press the floating button to view.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(  // button that opens the comment section, a Modal Bottom Sheet
        onPressed: () => showModalBottomSheet(
          context: context, 
          builder: (context) => buildSheet(),  // Call to buildSheet() method that builds the sheet into the comment section
          ),
        child: const Icon(Icons.comment_rounded), // add comment icon to floating button
      ),
    );
  }
  
  /// build for Modal Bottom Sheet Comment section
  Widget buildSheet() => DraggableScrollableSheet(
    initialChildSize: 1.0,
    builder: (_, controller) => Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16),      
      child:
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: TextField( 
              controller: textController,
              decoration: const InputDecoration(
              border:  OutlineInputBorder(),
              hintText: 'Add a comment',
              ),
              onSubmitted: (String value) {
                            if (textController.text.isNotEmpty) { 
              setState((){ 
              commentList.insert(0, Comment(DateTime.now(), "username", textController.text));
              textController.clear();
              Navigator.of(context).pop();
              showModalBottomSheet(context: context, builder: (context) => buildSheet());
        });}
              },
            ),
          ),
        body:commentList.isNotEmpty 
          ? ListView.builder(
    // crossAxisAlignment: CrossAxisAlignment.start,
    // comments added for testing 
            itemCount: commentList.length,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  title: Text('${commentList[index]}'),
                  trailing: Text('${commentList[index].dateTime.month.toString()}-${commentList[index].dateTime.day.toString().padLeft(2,'0')}-${commentList[index].dateTime.year.toString().padLeft(2,'0')} (${commentList[index].dateTime.hour.toString().padLeft(2,'0')}:${commentList[index].dateTime.minute.toString().padLeft(2,'0')})'),
            ),
            );
            },
            )
          : const Center (
              child: Text("No Comments yet.")),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_comment_rounded),
          onPressed: (){
            if (textController.text.isNotEmpty) { 
              setState((){ 
              commentList.insert(0, Comment(DateTime.now(), "username", textController.text));
              textController.clear();
              Navigator.of(context).pop();
              showModalBottomSheet(context: context, builder: (context) => buildSheet());
        });
            }        
      },
      ),
      ),
      ),
  ),
  );
}

