import 'package:flutter/material.dart';
import 'package:ninja_trips/shared/meetingDataSource.dart';
import 'package:ninja_trips/shared/menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ninja_trips/models/Doctor.dart';

import '../models/Meeting.dart';

class Details extends StatelessWidget {
  final Doctor doctor;

  Details({@required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dr. ${doctor.title()}'),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        drawer: Menu.getMenu(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Hero(
                tag: 'location-img-${doctor.img}',
                child: Image.asset(
                  'images/${doctor.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(doctor.title(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[800])),
                subtitle: Text('''
Adresse : ${doctor.address} à ${doctor.location}
Specialité : ${doctor.specialty}
Numéro : ${doctor.phoneNumber}
 
Selectionnez une date dans le calendrier : ''',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300], letterSpacing: 1)),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: SfCalendar(
                  view: CalendarView.month,
                  showDatePickerButton: true,
                  allowViewNavigation: true,
                  showNavigationArrow: true,
                  allowedViews: <CalendarView>[
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    CalendarView.month,
                    CalendarView.schedule
                  ],
                  dataSource: MeetingDataSource(_getDataSource()),
                  appointmentTimeTextFormat: 'HH:mm',
                  monthViewSettings: MonthViewSettings(showAgenda: true),
                ),
              ),
            ],
          ),
        ));
  }

  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
