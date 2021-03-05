import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Trip {
  final String title;
  final String location;
  final String price;
  final String img;
  List<Appointment> appointments;

  Trip({this.title, this.location, this.price, this.img, this.appointments});
}
