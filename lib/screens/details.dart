import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ninja_trips/models/Doctor.dart';
import 'package:ninja_trips/shared/meetingDataSource.dart';
import 'package:ninja_trips/shared/menu.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/Meeting.dart';

class Details extends StatefulWidget {
  final Doctor doctor;

  Details({@required this.doctor});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _subjectText, _startTimeText, _endTimeText, _dateText, _timeDetails;

  @override
  void initState() {
    _subjectText = '';
    _startTimeText = '';
    _endTimeText = '';
    _dateText = '';
    _timeDetails = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dr. ${widget.doctor.title()}'),
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
                tag: 'location-img-${widget.doctor.img}',
                child: Image.asset(
                  'images/${widget.doctor.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(widget.doctor.title(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[800])),
                subtitle: Text('''
Adresse : ${widget.doctor.address} à ${widget.doctor.location}
Specialité : ${widget.doctor.specialty}
Numéro : ${widget.doctor.phoneNumber}
 
Selectionnez une date dans le calendrier : ''',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        letterSpacing: 1)),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: SfCalendar(
                  onTap: calendarTapped,
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
    var meetings = widget.doctor.appointments;
    return meetings;
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meeting appointmentDetails = details.appointments[0];
      _subjectText = appointmentDetails.eventName;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.from)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.from).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text('$_subjectText')),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '$_dateText',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(_timeDetails,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("E-mail ${appointmentDetails.patientEmail}")
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Fermer'))
            ],
          );
        },
      );
    } else {
      _subjectText = "Rendez-vous malade";
      _startTimeText = DateFormat('hh:mm a').format(details.date).toString();
      _endTimeText = DateFormat('hh:mm a')
          .format(details.date.add(Duration(hours: 1)))
          .toString();
      _dateText = DateFormat('dd/MM/yyyy').format(details.date).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text('$_subjectText')),
            content: Container(
              height: 80,
              child: Column(children: <Widget>[
                Text('Dr ${widget.doctor.title()}'),
                Text('Le $_dateText'),
                Text('De $_startTimeText à $_endTimeText'),
              ]),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () async {
                    String email = FirebaseAuth.instance.currentUser.email;
                    Meeting appointment = Meeting(
                        _subjectText,
                        details.date,
                        details.date.add(Duration(hours: 1)),
                        Colors.green,
                        false,
                        email);
                    widget.doctor.addAppointment(appointment);

                    setState(() {});

                    Navigator.of(context).pop();
                  },
                  child: new Text('Prendre RDV'))
            ],
          );
        },
      );
    }
  }
}
