import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Details extends StatelessWidget {
  final Trip trip;
  Details({@required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Hero(
                tag: 'location-img-${trip.img}',
                child: Image.asset(
                  'images/${trip.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(trip.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[800])),
                subtitle: Text('''
Adresse : ${trip.address} à ${trip.location}
Specialité : ${trip.specialty}
Numéro : ${trip.number}

Selectionnez une date dans le calendrier : ''',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300], letterSpacing: 1)),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: SfCalendar(
                  view: CalendarView.month,
                ),
              ),
            ],
          ),
        ));
  }
}
