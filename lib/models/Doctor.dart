class Doctor {
  String id;
  String surname;
  String firstName;
  String address;
  String phoneNumber;
  String specialty;
  double price;
  String img;
  String location;
  String _title;


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
      'doctor1.png');

    String title() => '$firstName $surname';
}
