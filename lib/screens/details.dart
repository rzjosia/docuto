import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ninja_trips/models/Doctor.dart';

class Details extends StatelessWidget {
  final Doctor doctor;

  Details({@required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
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
                  allowedViews: <CalendarView>[
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    CalendarView.month,
                    CalendarView.schedule
                  ],
                  dataSource: _getCalendarDataSource(),
                ),
              ),
            ],
          ),
        ));
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = doctor.appointments;
    if (appointments != null) {
      appointments.forEach((Appointment app) {
        appointments.add(Appointment(
          startTime: app.startTime,
          endTime: app.endTime,
          subject: app.subject,
          color: app.color,
        ));
      });
    }

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}