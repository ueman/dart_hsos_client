import 'package:osca_dart/app/models/belongs_to_semester.dart';
import 'package:osca_dart/app/xml_helpers.dart';
import 'package:xml/xml.dart';

/// Ein Exam sieht im XML beispielsweise so aus:
///<mgns1:Message xmlns:mgns1="http://datenlotsen.de">
///    <mgns1:studentExam>
///        <mgns1:examID>365096437789974</mgns1:examID>
///        <mgns1:examName>Abschlussarbeit und Kolloquium</mgns1:examName>
///        <mgns1:context>11B0037 Bachelorarbeit und Kolloquium - Informatik</mgns1:context>
///        <mgns1:contextType>course</mgns1:contextType>
///        <mgns1:subject/>
///        <mgns1:beginDate>20.11.2017</mgns1:beginDate>
///        <mgns1:dueDate/>
///        <mgns1:timeFrom>12:00</mgns1:timeFrom>
///        <mgns1:timeTo>12:45</mgns1:timeTo>
///        <mgns1:grade>1,30</mgns1:grade>
///        <mgns1:gradeDescription>sehr gut</mgns1:gradeDescription>
///        <mgns1:instructorString/>
///        <mgns1:status>bestanden</mgns1:status>
///        <mgns1:statusSystem>1</mgns1:statusSystem>
///        <mgns1:semesterID>15026000</mgns1:semesterID>
///        <mgns1:semesterName>WiSe 2017/18</mgns1:semesterName>
///    </mgns1:studentExam>
/// </mgns1:Message>
class Exam implements BelongsToSemester {
  Exam({
    this.examID,
    this.examName,
    this.context,
    this.contextType,
    this.subject,
    this.beginDate,
    this.dueDate,
    this.timeFrom,
    this.timeTo,
    this.grade,
    this.gradeDescription,
    this.instructorString,
    this.status,
    this.statusSystem,
    this.semesterID,
    this.semesterName,
  });

  factory Exam.parse(XmlElement element) {
    return Exam(
      examID: int.parse(findElementOrNull(element, 'mgns1:examID')?.text),
      examName: findElementOrNull(element, 'mgns1:examName')?.text,
      context: findElementOrNull(element, 'mgns1:context')?.text,
      contextType: findElementOrNull(element, 'mgns1:contextType')?.text,
      subject: findElementOrNull(element, 'mgns1:subject')?.text,
      beginDate: findElementOrNull(element, 'mgns1:beginDate')?.text,
      dueDate: findElementOrNull(element, 'mgns1:dueDate')?.text,
      timeFrom: findElementOrNull(element, 'mgns1:timeFrom')?.text,
      timeTo: findElementOrNull(element, 'mgns1:timeTo')?.text,
      grade: findElementOrNull(element, 'mgns1:grade')?.text,
      gradeDescription:
          findElementOrNull(element, 'mgns1:gradeDescription')?.text,
      instructorString:
          findElementOrNull(element, 'mgns1:instructorString')?.text,
      status: findElementOrNull(element, 'mgns1:status')?.text,
      statusSystem: findElementOrNull(element, 'mgns1:statusSystem')?.text,
      semesterID: findElementOrNull(element, 'mgns1:semesterID')?.text,
      semesterName: findElementOrNull(element, 'mgns1:semesterName')?.text,
    );
  }

  final int examID;

  /// Name der Prüfung, also Abschlussarbeit/Kolloquium/Prüfungsleistung
  final String examName;

  /// Name des Moduls
  final String context;

  String get realName {
    // context sieht beispielweise so aus:
    // "11B0192-2-PR-EuI Grundlagen Programmierung (Praktikum) - Gr. 1MI"
    // Wir wollen aber den Foo ab dem ersten Space.
    return context.split(' ').skip(1).join(' ');
  }

  /// Modul, Kurs oder so
  final String contextType;

  final String subject;

  /// Im Format 20.11.2017
  final String beginDate;

  /// Im Format 20.11.2017
  final String dueDate;

  /// Im Format 12:00
  final String timeFrom;

  /// Im Format 12:00
  final String timeTo;

  /// Note als Zahl, zB. 1,7
  final String grade;

  /// Textuelle Beschreibung der Note
  /// z.B: sehr gut, gut, etc
  final String gradeDescription;

  /// Name des Lehrenden
  final String instructorString;

  /// Textuelle beschreibung von statusSystem
  final String status;

  /// Typ des Status
  /// 0 = noch nicht veröffentlicht
  /// 1 = bestanden
  /// 2 = noch nicht veröffentlicht
  /// 3 = nicht bestanden
  /// 4 = entschuldigt
  final String statusSystem;

  @override
  final String semesterID;

  /// Name des Semester, "WiSe18/19"
  @override
  final String semesterName;

  static List<Exam> fromXml(String xmlString) {
    final document = parse(xmlString);
    final rootElement = document.findElements('mgns1:Message').first;

    return rootElement.findElements('mgns1:studentExam').map((element) {
      return Exam.parse(element);
    }).toList();
  }
}
