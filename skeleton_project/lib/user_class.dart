class User {
  // Instance variables
  String? username;
  String? password;
  String? email;

  // Constructor
  User(String this.username, String this.password, String this.email);

  void setUsername(String username) {
    this.username = username;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String? getUsername() {
    return username;
  }

  String? getPassword() {
    return password;
  }

  String? getEmail() {
    return email;
  }
}

User user1 = User("Jaj7271", "Jaj72777", "Jaj7271@uncw.edu");
User user2 = User("djd1234", "djd72247", "fds1032@uncw.edu");
User user3 = User("tjs2224", "tjd9222", "tjs2234@uncw.edu");

var sample_users = [user1, user2, user3];
