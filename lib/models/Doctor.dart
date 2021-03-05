class Doctor {
  String id;
  String surname;
  String firstName;
  String address;
  String phoneNumber;
  String specialty;
  int price;
  String img;
  String location;


  Doctor(this.id, this.surname, this.firstName, this.address, this.location, this.phoneNumber,
      this.specialty, this.price, this.img);

  static fromJSON(Map<String, dynamic> json) => Doctor(
      json['id'],
      json['surname'],
      json['firstName'],
      json['address'],
      json['location'],
      json['phoneNumber'],
      json['specialty'],
      json['price'],
      json['img']);

    String title() => '$firstName $surname';
}
