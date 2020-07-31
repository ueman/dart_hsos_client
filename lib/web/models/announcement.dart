/// Stellt eine Ankündigung dar
class Announcement {
  String id;

  String title;

  /// Url zum eigentlichen Announcement aus dem dieser POCO herausgeparst wurde
  String url() =>
      "https://osca.hs-osnabrueck.de/lms/$courseId/Lists/ank/DispForm.aspx?ID=$announcementId";

  /// Inhalt der Ankündigung
  String body;

  String courseId;

  /// Erstelldatum
  String created;

  /// Datum an dem die Ankündigung geändert wurde
  String modified;

  /// Gibt an, die wievielte Ankündigung dies ist.
  int announcementId;
}
