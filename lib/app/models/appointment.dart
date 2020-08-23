import 'package:osca_dart/app/xml_helpers.dart';
import 'package:xml/xml.dart';

///<mgns1:appointment>
///  <mgns1:timetableID>368643369650270</mgns1:timetableID>
///  <mgns1:timetableDate>2018-12-14</mgns1:timetableDate>
///  <mgns1:timeFromFull>10:00:00</mgns1:timeFromFull>
///  <mgns1:timeToFull>11:30:00</mgns1:timeToFull>
///  <mgns1:roomString>SL0111</mgns1:roomString>
///  <mgns1:timeFrom>10:00</mgns1:timeFrom>
///  <mgns1:timeTo>11:30</mgns1:timeTo>
///  <mgns1:appointmentName>Stochastische Prozesse</mgns1:appointmentName>
///  <mgns1:appointmentType>course</mgns1:appointmentType>
///  <mgns1:instructorString>Prof. Dr. Jürgen Biermann</mgns1:instructorString>
///  <mgns1:materialPresent>false</mgns1:materialPresent>
///  <mgns1:appointmentNameShort></mgns1:appointmentNameShort>
///</mgns1:appointment>
class Appointment {
  Appointment({
    this.timetableID,
    this.timetableDate,
    this.timeFromFull,
    this.timeToFull,
    this.roomString,
    this.timeFrom,
    this.timeTo,
    this.appointmentName,
    this.appointmentType,
    this.instructorString,
    this.materialPresent,
    this.appointmentNameShort,
  });

  factory Appointment.parse(XmlElement element) {
    return Appointment(
      timetableID: findElementOrNull(element, 'mgns1:timetableID')?.text,
      timetableDate: findElementOrNull(element, 'mgns1:timetableDate')?.text,
      timeFromFull: findElementOrNull(element, 'mgns1:timeFromFull')?.text,
      timeToFull: findElementOrNull(element, 'mgns1:timeToFull')?.text,
      roomString: findElementOrNull(element, 'mgns1:roomString')?.text,
      timeFrom: findElementOrNull(element, 'mgns1:timeFrom')?.text,
      timeTo: findElementOrNull(element, 'mgns1:timeTo')?.text,
      appointmentName:
          findElementOrNull(element, 'mgns1:appointmentName')?.text,
      appointmentType:
          findElementOrNull(element, 'mgns1:appointmentType')?.text,
      instructorString:
          findElementOrNull(element, 'mgns1:instructorString')?.text,
      materialPresent:
          findElementOrNull(element, 'mgns1:materialPresent')?.text,
      appointmentNameShort:
          findElementOrNull(element, 'mgns1:appointmentNameShort')?.text,
    );
  }

  final String timetableID;
  final String timetableDate;
  final String timeFromFull;
  final String timeToFull;
  final String roomString;
  final String timeFrom;
  final String timeTo;
  final String appointmentName;
  final String appointmentType;
  final String instructorString;
  final String materialPresent;
  final String appointmentNameShort;

  static List<Appointment> fromXml(String xmlString) {
    final document = parse(xmlString);
    final rootElement = document.findElements('mgns1:Message').first;

    return rootElement.findElements('mgns1:appointment').map((element) {
      return Appointment.parse(element);
    }).toList();
  }
}
