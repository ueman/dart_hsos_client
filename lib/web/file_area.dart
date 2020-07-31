import 'dart:convert';
import 'package:osca_dart/web/models/course_file.dart';
import 'package:osca_dart/web/osca_web_client.dart';

class FileArea {

  /// Liefert eine Liste aller Dateien eines Moduls-Raums zurück
  /// courseID muss die courseID von einem Course sein
  static Future<List<CourseFile>> getListOfAllFilesForCourse(
      OscaWebClient client,
      String courseId) async {
    var courseUrl = createUrlForCourse(courseId);

    var response = await client.get(courseUrl);

    List<String> fileDescriptionUris = convertToFileDescriptionUrls(response.body);

    var courseFiles = List<CourseFile>();

    // TODO das hier kann bestimmt auch noch parallel ausgeführt 
    // werden, dann gehts vllt fixer
    for (var fileDescriptionUri in fileDescriptionUris) {
      var response = await client.get(fileDescriptionUri);
      var responseBody = response.body;
      var courseFile = convertToCourseFile(responseBody, courseId);
      if (courseFile != null) {
        courseFiles.add(courseFile);
      }
    }

    return courseFiles;
  }

  /// Gibt alle eine URL zur Abfrage mit einer Liste aller Dateien zurück.
  /// Ordner wurden rausgefiltert, siehe auch
  /// https://sharepoint.stackexchange.com/questions/124846/rest-with-filter-for-list-items-in-sharepoint-2013
  static String createUrlForCourse(String courseId) =>
      "https://osca.hs-osnabrueck.de/lms/$courseId/_api/web/lists/getByTitle('Dateibereich')/items?\$filter=startswith(ContentTypeId, '0x0101')";

  static List<String> convertToFileDescriptionUrls(String content) {
    final decoded = json.decode(content);
    final rootObject = _FileListRootObject.fromJson(decoded);

    return rootObject.d.results
        // aus den results nur die Dateien nehmen
        .where((result) => result.isFile())
        // von den Dateien den Link sammeln
        .map((result) => result.file.dDeferred.uri)
        // und zurückgeben
        .toList();
  }

  static CourseFile convertToCourseFile(String content, String courseId) {
    final decoded = json.decode(content);

    var someError  = decoded['error'];
    if (someError != null) {
      // TODO hier gibts irgendeinen Fehler
      // fürs erste wird der einfach ignoriert
      return null;
    }

    final rootObject = _FileInformationRootObject.fromJson(decoded);

    return CourseFile()
      ..name = rootObject.d.name
      ..courseId = courseId
      ..serverRelativeUrl = rootObject.d.serverRelativeUrl
      ..created = rootObject.d.timeCreated
      ..lastModified = rootObject.d.timeLastModified;
  }
}

//==============================================================================
// Übersicht (Liste) der Dateien
// Autogenerierter Code
//==============================================================================

class _FileListRootObject {
  _FileListContainer d;

  _FileListRootObject({this.d});

  _FileListRootObject.fromJson(Map<String, dynamic> json) {
    d = json['d'] != null ? new _FileListContainer.fromJson(json['d']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d != null) {
      data['d'] = this.d.toJson();
    }
    return data;
  }
}

class _FileListContainer {
  List<_FileListElement> results;

  _FileListContainer({this.results});

  _FileListContainer.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<_FileListElement>();
      json['results'].forEach((v) {
        results.add(new _FileListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _FileListElement {
  _Metadata mMetadata;
  _FirstUniqueAncestorSecurableObject firstUniqueAncestorSecurableObject;
  _RoleAssignments roleAssignments;
  _AttachmentFiles attachmentFiles;
  _ContentType contentType;
  _FieldValuesAsHtml fieldValuesAsHtml;
  _FieldValuesAsText fieldValuesAsText;
  _FieldValuesForEdit fieldValuesForEdit;
  _File file;
  _Folder folder;
  _ParentList parentList;
  int fileSystemObjectType;
  int id;
  int iD;
  String contentTypeId;
  String created;
  int authorId;
  String modified;
  int editorId;
  Null oDataCopySource;
  Null checkoutUserId;
  String oDataUIVersionString;
  String gUID;
  String title;

  _FileListElement(
      {this.mMetadata,
      this.firstUniqueAncestorSecurableObject,
      this.roleAssignments,
      this.attachmentFiles,
      this.contentType,
      this.fieldValuesAsHtml,
      this.fieldValuesAsText,
      this.fieldValuesForEdit,
      this.file,
      this.folder,
      this.parentList,
      this.fileSystemObjectType,
      this.id,
      this.iD,
      this.contentTypeId,
      this.created,
      this.authorId,
      this.modified,
      this.editorId,
      this.oDataCopySource,
      this.checkoutUserId,
      this.oDataUIVersionString,
      this.gUID,
      this.title});

  /// Wenn FileSystemObjectType gleich 0 ist, ist dies eine Datei
  /// Weitere Informationen hier: https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-csom/ee537053(v%3Doffice.15)
  bool isFile() => fileSystemObjectType == 0;

  _FileListElement.fromJson(Map<String, dynamic> json) {
    mMetadata = json['__metadata'] != null
        ? new _Metadata.fromJson(json['__metadata'])
        : null;
    firstUniqueAncestorSecurableObject =
        json['FirstUniqueAncestorSecurableObject'] != null
            ? new _FirstUniqueAncestorSecurableObject.fromJson(
                json['FirstUniqueAncestorSecurableObject'])
            : null;
    roleAssignments = json['RoleAssignments'] != null
        ? new _RoleAssignments.fromJson(json['RoleAssignments'])
        : null;
    attachmentFiles = json['AttachmentFiles'] != null
        ? new _AttachmentFiles.fromJson(json['AttachmentFiles'])
        : null;
    contentType = json['ContentType'] != null
        ? new _ContentType.fromJson(json['ContentType'])
        : null;
    fieldValuesAsHtml = json['FieldValuesAsHtml'] != null
        ? new _FieldValuesAsHtml.fromJson(json['FieldValuesAsHtml'])
        : null;
    fieldValuesAsText = json['FieldValuesAsText'] != null
        ? new _FieldValuesAsText.fromJson(json['FieldValuesAsText'])
        : null;
    fieldValuesForEdit = json['FieldValuesForEdit'] != null
        ? new _FieldValuesForEdit.fromJson(json['FieldValuesForEdit'])
        : null;
    file = json['File'] != null ? new _File.fromJson(json['File']) : null;
    folder =
        json['Folder'] != null ? new _Folder.fromJson(json['Folder']) : null;
    parentList = json['ParentList'] != null
        ? new _ParentList.fromJson(json['ParentList'])
        : null;
    fileSystemObjectType = json['FileSystemObjectType'];
    id = json['Id'];
    iD = json['ID'];
    contentTypeId = json['ContentTypeId'];
    created = json['Created'];
    authorId = json['AuthorId'];
    modified = json['Modified'];
    editorId = json['EditorId'];
    oDataCopySource = json['OData__CopySource'];
    checkoutUserId = json['CheckoutUserId'];
    oDataUIVersionString = json['OData__UIVersionString'];
    gUID = json['GUID'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mMetadata != null) {
      data['__metadata'] = this.mMetadata.toJson();
    }
    if (this.firstUniqueAncestorSecurableObject != null) {
      data['FirstUniqueAncestorSecurableObject'] =
          this.firstUniqueAncestorSecurableObject.toJson();
    }
    if (this.roleAssignments != null) {
      data['RoleAssignments'] = this.roleAssignments.toJson();
    }
    if (this.attachmentFiles != null) {
      data['AttachmentFiles'] = this.attachmentFiles.toJson();
    }
    if (this.contentType != null) {
      data['ContentType'] = this.contentType.toJson();
    }
    if (this.fieldValuesAsHtml != null) {
      data['FieldValuesAsHtml'] = this.fieldValuesAsHtml.toJson();
    }
    if (this.fieldValuesAsText != null) {
      data['FieldValuesAsText'] = this.fieldValuesAsText.toJson();
    }
    if (this.fieldValuesForEdit != null) {
      data['FieldValuesForEdit'] = this.fieldValuesForEdit.toJson();
    }
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.folder != null) {
      data['Folder'] = this.folder.toJson();
    }
    if (this.parentList != null) {
      data['ParentList'] = this.parentList.toJson();
    }
    data['FileSystemObjectType'] = this.fileSystemObjectType;
    data['Id'] = this.id;
    data['ID'] = this.iD;
    data['ContentTypeId'] = this.contentTypeId;
    data['Created'] = this.created;
    data['AuthorId'] = this.authorId;
    data['Modified'] = this.modified;
    data['EditorId'] = this.editorId;
    data['OData__CopySource'] = this.oDataCopySource;
    data['CheckoutUserId'] = this.checkoutUserId;
    data['OData__UIVersionString'] = this.oDataUIVersionString;
    data['GUID'] = this.gUID;
    data['Title'] = this.title;
    return data;
  }
}

class _Metadata {
  String id;
  String uri;
  String etag;
  String type;

  _Metadata({this.id, this.uri, this.etag, this.type});

  _Metadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uri = json['uri'];
    etag = json['etag'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uri'] = this.uri;
    data['etag'] = this.etag;
    data['type'] = this.type;
    return data;
  }
}

class _FirstUniqueAncestorSecurableObject {
  _Deferred dDeferred;

  _FirstUniqueAncestorSecurableObject({this.dDeferred});

  _FirstUniqueAncestorSecurableObject.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _Deferred {
  String uri;

  _Deferred({this.uri});

  _Deferred.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    return data;
  }
}

class _RoleAssignments {
  _Deferred dDeferred;

  _RoleAssignments({this.dDeferred});

  _RoleAssignments.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _AttachmentFiles {
  _Deferred dDeferred;

  _AttachmentFiles({this.dDeferred});

  _AttachmentFiles.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _ContentType {
  _Deferred dDeferred;

  _ContentType({this.dDeferred});

  _ContentType.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _FieldValuesAsHtml {
  _Deferred dDeferred;

  _FieldValuesAsHtml({this.dDeferred});

  _FieldValuesAsHtml.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _FieldValuesAsText {
  _Deferred dDeferred;

  _FieldValuesAsText({this.dDeferred});

  _FieldValuesAsText.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _FieldValuesForEdit {
  _Deferred dDeferred;

  _FieldValuesForEdit({this.dDeferred});

  _FieldValuesForEdit.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _File {
  _Deferred dDeferred;

  _File({this.dDeferred});

  _File.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _Folder {
  _Deferred dDeferred;

  _Folder({this.dDeferred});

  _Folder.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _ParentList {
  _Deferred dDeferred;

  _ParentList({this.dDeferred});

  _ParentList.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _Deferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

//==============================================================================
// Details einer Datei
// Autogenerierter Code
//==============================================================================

class _FileInformationRootObject {
  _FileInformationContainer d;

  _FileInformationRootObject({this.d});

  _FileInformationRootObject.fromJson(Map<String, dynamic> json) {
    d = json['d'] != null
        ? new _FileInformationContainer.fromJson(json['d'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d != null) {
      data['d'] = this.d.toJson();
    }
    return data;
  }
}

class _FileInformationContainer {
  _SharePointFileMetadata mMetadata;
  _SharePointAuthor author;
  _SharePointFileCheckedOutByUser checkedOutByUser;
  _SharePointFileListItemAllFields listItemAllFields;
  _SharePointFileLockedByUser lockedByUser;
  _SharePointFileModifiedBy modifiedBy;
  _SharePointFileVersions versions;
  String checkInComment;
  int checkOutType;
  String contentTag;
  int customizedPageStatus;
  String eTag;
  bool exists;
  String length;
  int level;
  int majorVersion;
  int minorVersion;
  String name;
  String serverRelativeUrl;
  String timeCreated;
  String timeLastModified;
  String title;
  int uIVersion;
  String uIVersionLabel;

  _FileInformationContainer(
      {this.mMetadata,
      this.author,
      this.checkedOutByUser,
      this.listItemAllFields,
      this.lockedByUser,
      this.modifiedBy,
      this.versions,
      this.checkInComment,
      this.checkOutType,
      this.contentTag,
      this.customizedPageStatus,
      this.eTag,
      this.exists,
      this.length,
      this.level,
      this.majorVersion,
      this.minorVersion,
      this.name,
      this.serverRelativeUrl,
      this.timeCreated,
      this.timeLastModified,
      this.title,
      this.uIVersion,
      this.uIVersionLabel});

  _FileInformationContainer.fromJson(Map<String, dynamic> json) {
    mMetadata = json['__metadata'] != null
        ? new _SharePointFileMetadata.fromJson(json['__metadata'])
        : null;
    author = json['Author'] != null
        ? new _SharePointAuthor.fromJson(json['Author'])
        : null;
    checkedOutByUser = json['CheckedOutByUser'] != null
        ? new _SharePointFileCheckedOutByUser.fromJson(json['CheckedOutByUser'])
        : null;
    listItemAllFields = json['ListItemAllFields'] != null
        ? new _SharePointFileListItemAllFields.fromJson(
            json['ListItemAllFields'])
        : null;
    lockedByUser = json['LockedByUser'] != null
        ? new _SharePointFileLockedByUser.fromJson(json['LockedByUser'])
        : null;
    modifiedBy = json['ModifiedBy'] != null
        ? new _SharePointFileModifiedBy.fromJson(json['ModifiedBy'])
        : null;
    versions = json['Versions'] != null
        ? new _SharePointFileVersions.fromJson(json['Versions'])
        : null;
    checkInComment = json['CheckInComment'];
    checkOutType = json['CheckOutType'];
    contentTag = json['ContentTag'];
    customizedPageStatus = json['CustomizedPageStatus'];
    eTag = json['ETag'];
    exists = json['Exists'];
    length = json['Length'];
    level = json['Level'];
    majorVersion = json['MajorVersion'];
    minorVersion = json['MinorVersion'];
    name = json['Name'];
    serverRelativeUrl = json['ServerRelativeUrl'];
    timeCreated = json['TimeCreated'];
    timeLastModified = json['TimeLastModified'];
    title = json['Title'];
    uIVersion = json['UIVersion'];
    uIVersionLabel = json['UIVersionLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mMetadata != null) {
      data['__metadata'] = this.mMetadata.toJson();
    }
    if (this.author != null) {
      data['Author'] = this.author.toJson();
    }
    if (this.checkedOutByUser != null) {
      data['CheckedOutByUser'] = this.checkedOutByUser.toJson();
    }
    if (this.listItemAllFields != null) {
      data['ListItemAllFields'] = this.listItemAllFields.toJson();
    }
    if (this.lockedByUser != null) {
      data['LockedByUser'] = this.lockedByUser.toJson();
    }
    if (this.modifiedBy != null) {
      data['ModifiedBy'] = this.modifiedBy.toJson();
    }
    if (this.versions != null) {
      data['Versions'] = this.versions.toJson();
    }
    data['CheckInComment'] = this.checkInComment;
    data['CheckOutType'] = this.checkOutType;
    data['ContentTag'] = this.contentTag;
    data['CustomizedPageStatus'] = this.customizedPageStatus;
    data['ETag'] = this.eTag;
    data['Exists'] = this.exists;
    data['Length'] = this.length;
    data['Level'] = this.level;
    data['MajorVersion'] = this.majorVersion;
    data['MinorVersion'] = this.minorVersion;
    data['Name'] = this.name;
    data['ServerRelativeUrl'] = this.serverRelativeUrl;
    data['TimeCreated'] = this.timeCreated;
    data['TimeLastModified'] = this.timeLastModified;
    data['Title'] = this.title;
    data['UIVersion'] = this.uIVersion;
    data['UIVersionLabel'] = this.uIVersionLabel;
    return data;
  }
}

class _SharePointFileMetadata {
  String id;
  String uri;
  String type;

  _SharePointFileMetadata({this.id, this.uri, this.type});

  _SharePointFileMetadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uri = json['uri'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uri'] = this.uri;
    data['type'] = this.type;
    return data;
  }
}

class _SharePointAuthor {
  _SharePointFileDeferred dDeferred;

  _SharePointAuthor({this.dDeferred});

  _SharePointAuthor.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _SharePointFileDeferred {
  String uri;

  _SharePointFileDeferred({this.uri});

  _SharePointFileDeferred.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    return data;
  }
}

class _SharePointFileCheckedOutByUser {
  _SharePointFileDeferred dDeferred;

  _SharePointFileCheckedOutByUser({this.dDeferred});

  _SharePointFileCheckedOutByUser.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _SharePointFileListItemAllFields {
  _SharePointFileDeferred dDeferred;

  _SharePointFileListItemAllFields({this.dDeferred});

  _SharePointFileListItemAllFields.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _SharePointFileLockedByUser {
  _SharePointFileDeferred dDeferred;

  _SharePointFileLockedByUser({this.dDeferred});

  _SharePointFileLockedByUser.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _SharePointFileModifiedBy {
  _SharePointFileDeferred dDeferred;

  _SharePointFileModifiedBy({this.dDeferred});

  _SharePointFileModifiedBy.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}

class _SharePointFileVersions {
  _SharePointFileDeferred dDeferred;

  _SharePointFileVersions({this.dDeferred});

  _SharePointFileVersions.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _SharePointFileDeferred.fromJson(json['__deferred'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dDeferred != null) {
      data['__deferred'] = this.dDeferred.toJson();
    }
    return data;
  }
}
