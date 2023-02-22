class User {
  // Instance variables
  String username;
  String password;
  String email;

  // Constructor
  User(this.username, this.password, this.email);

  // Mutators
  set setUsername(String username) => this.username = username;

  set setPassword(String password) => this.password = password;

  set setEmail(String email) => this.email = email;

  // Accessors
  String get getUsername => username;

  String get getPassword => password;

  String get getEmail => email;
}
// Sample Data
User user1 = User("Jaj7271", "Jaj72777", "Jaj7271@uncw.edu");
User user2 = User("djd1234", "djd72247", "fds1032@uncw.edu");
User user3 = User("tjs2224", "tjd9222", "tjs2234@uncw.edu");

var sampleUsers = [user1, user2, user3];
