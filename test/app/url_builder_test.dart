import 'package:flutter_test/flutter_test.dart';
import 'package:osca_dart/app/encryption/key_crypter_dart.dart';
import 'package:osca_dart/app/osca_app_url_builder.dart';

void main() {
  test('test url', () {
    var wish =
        "https://osca-bew.hs-osnabrueck.de/scripts/mgrqispi.dll?APPNAME=CampusNet&PRGNAME=ACTIONMOBILE&ARGUMENTS=-AGNzGBO2BINxJlU96CyRQw0J6sE3FcJkOR0l9Wyer2QQuw1SExBHj-Ec1mw1TYBW7bbwlRkmkrZf=";
    var url = OscaAppUrlBuilder.examsUrl("123", "STD");
    expect(url, wish);
  });

  test('test md5', () {
    var wish = "5C372A32C9AE748A4C040EBADC51A829";
    var actual = KeyCrypterScrypt.md5("Hallo Welt");
    expect(actual, wish);
  });
}
