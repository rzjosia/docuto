import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_trips/models/Meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Meeting.dart';

class Doctor extends Appointment {
  String id;
  String surname;
  String firstName;
  String address;
  String phoneNumber;
  String specialty;
  int price;
  String img;
  String location;
  List<Meeting> appointments;


  Doctor(
      this.id,
      this.surname,
      this.firstName,
      this.address,
      this.location,
      this.phoneNumber,
      this.specialty,
      this.price,
      this.img,
      this.appointments) {
    this.appointments = this.appointments ?? <Meeting>[];
  }
  static fromJSON(Map<String, dynamic> json) => Doctor(json['id'], json['surname'], json['firstName'], json['address'],
      json['location'], json['phoneNumber'], json['specialty'], json['price'], json['img'], json['appointments']);

  addAppointment(Meeting appointment) async {
    appointments.add(appointment);
    var collectionReference = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(this.id)
        .update(<String, dynamic>{
      'appointments': appointments.map((e) => e.toJSON()).toList()
    });
    print(appointments.map((e) => e.toJSON()).toList());
  }

  String title() => '$firstName $surname';
}
