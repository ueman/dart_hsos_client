import 'dart:convert';

import 'package:osca_dart/web/models/announcement.dart';
import 'package:osca_dart/web/osca_web_client.dart';

class Announcements {
  /// Liefert eine Liste aller Ankündigungen eines Moduls zurück
  /// courseID muss die courseID von einem Course sein
  static Future<List<Announcement>> getAllAnnouncementsForCourse(
      OscaWebClient client, String courseId) async {
    final courseUrl = createUrlForCourse(courseId);

    final response = await client.get(courseUrl);

    final responseBody = response.body;

    final Map<String, dynamic> decoded =
        json.decode(responseBody) as Map<String, dynamic>;

    final root = _AnnouncementListRootObject.fromJson(decoded);

    return root.d.results
        // result ist vom Typ _AnnouncementsListEntry
        .map((result) => convert(result, courseId))
        .toList();
  }

  static Announcement convert(_AnnouncementsListEntry entry, String courseId) {
    return Announcement()
      ..id = entry.gUID
      ..title = entry.title
      ..body = entry.body
      ..created = entry.created
      ..modified = entry.modified
      ..announcementId = entry.id
      ..courseId = courseId;
  }

  static String createUrlForCourse(String courseId) =>
      "https://osca.hs-osnabrueck.de/lms/$courseId/_api/web/lists/getByTitle('Ank%C3%BCndigungen')/items";
}

//==============================================================================
// Übersicht (Liste) der Announcements
// Autogenerierter Code
//==============================================================================

class _AnnouncementListRootObject {
  _AnnouncementListRootObject({this.d});

  _AnnouncementListRootObject.fromJson(Map<String, dynamic> json) {
    d = json['d'] != null
        ? _AnnouncementsListContainer.fromJson(json['d'])
        : null;
  }

  _AnnouncementsListContainer d;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (d != null) {
      data['d'] = d.toJson();
    }
    return data;
  }
}

class _AnnouncementsListContainer {
  _AnnouncementsListContainer({this.results});

  _AnnouncementsListContainer.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <_AnnouncementsListEntry>[];
      json['results'].forEach((v) {
        results.add(_AnnouncementsListEntry.fromJson(v));
      });
    }
  }

  List<_AnnouncementsListEntry> results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _AnnouncementsListEntry {
  _AnnouncementsListMetadata mMetadata;
  _AnnouncementsListFirstUniqueAncestorSecurableObject
      firstUniqueAncestorSecurableObject;
  _AnnouncementsListRoleAssignments roleAssignments;
  _AnnouncementsListAttachmentFiles attachmentFiles;
  _AnnouncementsListContentType contentType;
  _AnnouncementsListFieldValuesAsHtml fieldValuesAsHtml;
  _AnnouncementsListFieldValuesAsText fieldValuesAsText;
  _AnnouncementsListFieldValuesForEdit fieldValuesForEdit;
  _AnnouncementsListFile file;
  _AnnouncementsListFolder folder;
  _AnnouncementsListParentList parentList;
  int fileSystemObjectType;
  int id;
  int iD;
  String contentTypeId;
  String title;
  String modified;
  String created;
  int authorId;
  int editorId;
  String oDataUIVersionString;
  bool attachments;
  String gUID;
  String body;
  Null expires;

  _AnnouncementsListEntry(
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
      this.title,
      this.modified,
      this.created,
      this.authorId,
      this.editorId,
      this.oDataUIVersionString,
      this.attachments,
      this.gUID,
      this.body,
      this.expires});

  _AnnouncementsListEntry.fromJson(Map<String, dynamic> json) {
    mMetadata = json['__metadata'] != null
        ? new _AnnouncementsListMetadata.fromJson(json['__metadata'])
        : null;
    firstUniqueAncestorSecurableObject =
        json['FirstUniqueAncestorSecurableObject'] != null
            ? new _AnnouncementsListFirstUniqueAncestorSecurableObject.fromJson(
                json['FirstUniqueAncestorSecurableObject'])
            : null;
    roleAssignments = json['RoleAssignments'] != null
        ? new _AnnouncementsListRoleAssignments.fromJson(
            json['RoleAssignments'])
        : null;
    attachmentFiles = json['AttachmentFiles'] != null
        ? new _AnnouncementsListAttachmentFiles.fromJson(
            json['AttachmentFiles'])
        : null;
    contentType = json['ContentType'] != null
        ? new _AnnouncementsListContentType.fromJson(json['ContentType'])
        : null;
    fieldValuesAsHtml = json['FieldValuesAsHtml'] != null
        ? _AnnouncementsListFieldValuesAsHtml.fromJson(
            json['FieldValuesAsHtml'])
        : null;
    fieldValuesAsText = json['FieldValuesAsText'] != null
        ? new _AnnouncementsListFieldValuesAsText.fromJson(
            json['FieldValuesAsText'])
        : null;
    fieldValuesForEdit = json['FieldValuesForEdit'] != null
        ? new _AnnouncementsListFieldValuesForEdit.fromJson(
            json['FieldValuesForEdit'])
        : null;
    file = json['File'] != null
        ? new _AnnouncementsListFile.fromJson(json['File'])
        : null;
    folder = json['Folder'] != null
        ? new _AnnouncementsListFolder.fromJson(json['Folder'])
        : null;
    parentList = json['ParentList'] != null
        ? new _AnnouncementsListParentList.fromJson(json['ParentList'])
        : null;
    fileSystemObjectType = json['FileSystemObjectType'];
    id = json['Id'];
    iD = json['ID'];
    contentTypeId = json['ContentTypeId'];
    title = json['Title'];
    modified = json['Modified'];
    created = json['Created'];
    authorId = json['AuthorId'];
    editorId = json['EditorId'];
    oDataUIVersionString = json['OData__UIVersionString'];
    attachments = json['Attachments'];
    gUID = json['GUID'];
    body = json['Body'];
    expires = json['Expires'];
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
    data['Title'] = this.title;
    data['Modified'] = this.modified;
    data['Created'] = this.created;
    data['AuthorId'] = this.authorId;
    data['EditorId'] = this.editorId;
    data['OData__UIVersionString'] = this.oDataUIVersionString;
    data['Attachments'] = this.attachments;
    data['GUID'] = this.gUID;
    data['Body'] = this.body;
    data['Expires'] = this.expires;
    return data;
  }
}

class _AnnouncementsListMetadata {
  String id;
  String uri;
  String etag;
  String type;

  _AnnouncementsListMetadata({this.id, this.uri, this.etag, this.type});

  _AnnouncementsListMetadata.fromJson(Map<String, dynamic> json) {
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

class _AnnouncementsListFirstUniqueAncestorSecurableObject {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFirstUniqueAncestorSecurableObject({this.dDeferred});

  _AnnouncementsListFirstUniqueAncestorSecurableObject.fromJson(
      Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListDeferred {
  String uri;

  _AnnouncementsListDeferred({this.uri});

  _AnnouncementsListDeferred.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    return data;
  }
}

class _AnnouncementsListRoleAssignments {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListRoleAssignments({this.dDeferred});

  _AnnouncementsListRoleAssignments.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListAttachmentFiles {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListAttachmentFiles({this.dDeferred});

  _AnnouncementsListAttachmentFiles.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListContentType {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListContentType({this.dDeferred});

  _AnnouncementsListContentType.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListFieldValuesAsHtml {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFieldValuesAsHtml({this.dDeferred});

  _AnnouncementsListFieldValuesAsHtml.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListFieldValuesAsText {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFieldValuesAsText({this.dDeferred});

  _AnnouncementsListFieldValuesAsText.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListFieldValuesForEdit {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFieldValuesForEdit({this.dDeferred});

  _AnnouncementsListFieldValuesForEdit.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListFile {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFile({this.dDeferred});

  _AnnouncementsListFile.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListFolder {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListFolder({this.dDeferred});

  _AnnouncementsListFolder.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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

class _AnnouncementsListParentList {
  _AnnouncementsListDeferred dDeferred;

  _AnnouncementsListParentList({this.dDeferred});

  _AnnouncementsListParentList.fromJson(Map<String, dynamic> json) {
    dDeferred = json['__deferred'] != null
        ? new _AnnouncementsListDeferred.fromJson(json['__deferred'])
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
