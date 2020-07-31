import 'package:osca_dart/app/xml_helpers.dart';
import 'package:xml/xml.dart';

///<mgns1:Message xmlns:mgns1="http://datenlotsen.de">
///    <mgns1:studentEvent>
///        <mgns1:courseID>353683406070081</mgns1:courseID>
///        <mgns1:courseDataID>353683406048082</mgns1:courseDataID>
///        <mgns1:courseNumber>11B0459-1-SE-EuI</mgns1:courseNumber>
///        <mgns1:courseName>Wissenschaftliches Arbeiten und Methoden</mgns1:courseName>
///        <mgns1:eventType>Lehrveranstaltung</mgns1:eventType>
///        <mgns1:eventCategory>Seminar</mgns1:eventCategory>
///        <mgns1:semesterID>15020000</mgns1:semesterID>
///        <mgns1:semesterName>WiSe 2014/15</mgns1:semesterName>
///        <mgns1:creditPoints>0.0000</mgns1:creditPoints>
///        <mgns1:hoursPerWeek>4</mgns1:hoursPerWeek>
///        <mgns1:smallGroups>0</mgns1:smallGroups>
///        <mgns1:courseLanguage>Deutsch</mgns1:courseLanguage>
///        <mgns1:facultyName>Fakultät Ingenieurwissenschaften und Informatik</mgns1:facultyName>
///        <mgns1:maxStudents>0</mgns1:maxStudents>
///        <mgns1:instructorsString>Prof. Dr. Heinz-Josef Eikerling; Dr. Ralf Hagemann; Thomas Schüler</mgns1:instructorsString>
///        <mgns1:moduleName>Wissenschaftliches Arbeiten und Methoden</mgns1:moduleName>
///        <mgns1:moduleNumber>11B0459</mgns1:moduleNumber>
///        <mgns1:listener>0</mgns1:listener>
///        <mgns1:acceptedStatus>1</mgns1:acceptedStatus>
///        <mgns1:materialPresent>0</mgns1:materialPresent>
///        <mgns1:infoPresent>1</mgns1:infoPresent>
///    </mgns1:studentEvent>
///</mgns1:Message>
class Course {
  Course();

  factory Course.parse(XmlElement element) {
    return Course()
      ..courseID = int.parse(findElementOrNull(element, 'mgns1:courseID')?.text)
      ..courseDataID = findElementOrNull(element, 'mgns1:courseDataID')?.text
      ..courseNumber = findElementOrNull(element, 'mgns1:courseNumber')?.text
      ..courseName = findElementOrNull(element, 'mgns1:courseName')?.text
      ..eventType = findElementOrNull(element, 'mgns1:eventType')?.text
      ..eventCategory = findElementOrNull(element, 'mgns1:eventCategory')?.text
      ..semesterID = findElementOrNull(element, 'mgns1:semesterID')?.text
      ..semesterName = findElementOrNull(element, 'mgns1:semesterName')?.text
      ..creditPoints = findElementOrNull(element, 'mgns1:creditPoints')?.text
      ..hoursPerWeek = findElementOrNull(element, 'mgns1:hoursPerWeek')?.text
      ..smallGroups = findElementOrNull(element, 'mgns1:smallGroups')?.text
      ..courseLanguage =
          findElementOrNull(element, 'mgns1:courseLanguage')?.text
      ..facultyName = findElementOrNull(element, 'mgns1:facultyName')?.text
      ..maxStudents = findElementOrNull(element, 'mgns1:maxStudents')?.text
      ..instructorsString =
          findElementOrNull(element, 'mgns1:instructorsString')?.text
      ..moduleName = findElementOrNull(element, 'mgns1:moduleName')?.text
      ..moduleNumber = findElementOrNull(element, 'mgns1:moduleNumber')?.text
      ..listener = findElementOrNull(element, 'mgns1:listener')?.text
      ..acceptedStatus =
          findElementOrNull(element, 'mgns1:acceptedStatus')?.text
      ..materialPresent =
          findElementOrNull(element, 'mgns1:materialPresent')?.text
      ..infoPresent = findElementOrNull(element, 'mgns1:infoPresent')?.text;
  }

  /// ist leider nicht eindeutig
  int courseID;

  /// ist eindeutig
  String courseDataID;
  String courseNumber;
  String courseName;
  String eventType;
  String eventCategory;
  String semesterID;
  String semesterName;
  String creditPoints;
  String hoursPerWeek;
  String smallGroups;
  String courseLanguage;
  String facultyName;
  String maxStudents;
  String instructorsString;
  String moduleName;
  String moduleNumber;
  String listener;
  String acceptedStatus;
  String materialPresent;
  String infoPresent;

  static List<Course> fromXml(String xmlString) {
    final document = parse(xmlString);
    final rootElement = document.findElements('mgns1:Message').first;

    return rootElement.findElements('mgns1:studentEvent').map((element) {
      return Course.parse(element);
    }).toList();
  }
}
