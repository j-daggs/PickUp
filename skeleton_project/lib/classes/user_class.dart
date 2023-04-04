class User {
  // Instance variables
  String username;
  String password;
  String email;
  List interested;

  // Constructor
  User(this.username, this.password, this.email, this.interested);

  // Mutators
  set setUsername(String username) => this.username = username;

  set setPassword(String password) => this.password = password;

  set setEmail(String email) => this.email = email;

  // Accessors
  String get getUsername => username;

  String get getPassword => password;

  String get getEmail => email;
}
