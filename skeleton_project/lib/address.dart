class Address {
  String streetName;
  String city;
  String state;
  String zipcode;

  // Class Contructor
  Address(this.streetName, this.city, this.state, this.zipcode);

  // Setters
  set setStreetName(String streetName) => this.streetName = streetName;

  set setCity(String city) => this.city = city;

  set setState(String state) => this.state = state;

  set setZipCode(String zipCode) => this.zipcode = zipCode;

  // Getters
  get getStreetName => streetName;

  get getCity => city;

  get getState => state;

  get getZipCode => zipcode;
}

Address address1 = Address("280 Woodsia Way", "Wilmington", "NC", "28411");
Address address2 = Address("302 Racine Drive", "Wilmington", "NC", "28403");
Address address3 = Address("5006 Carlton Drive", "Wilmington", "NC", "28403");

var addressArray = [address1, address2, address3]
