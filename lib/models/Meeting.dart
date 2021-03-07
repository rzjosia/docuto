import 'dart:ui';

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String patientEmail;

  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, this.patientEmail);

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'eventName': this.eventName,
    'from': this.from,
    'to': this.to,
    'background': this.background.toString(),
    'allDay': this.isAllDay,
    'patientEmail': this.patientEmail
  };

}
