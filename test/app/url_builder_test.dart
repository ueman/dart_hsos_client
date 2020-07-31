import 'dart:convert';

import 'package:osca_dart/app/magic/encoder.dart';
import 'package:osca_dart/app/magic/string_utils.dart';
import 'package:osca_dart/app/osca_app_url_builder.dart';
import 'package:test/test.dart';

void main() {
  test('test url', () {
    var wish =
        "https://osca-bew.hs-osnabrueck.de/scripts/mgrqispi.dll?APPNAME=CampusNet&PRGNAME=ACTIONMOBILE&ARGUMENTS=-AGNzGBO2BINxJlU96CyRQw0J6sE3FcJkOR0l9Wyer2QQuw1SExBHj-Ec1mw1TYBW7bbwlRkmkrZf=";
    var url = OscaAppUrlBuilder.examsUrl("123", "STD");
    expect(url, wish);
  });

  test('test md5', () {
    var wish = "5C372A32C9AE748A4C040EBADC51A829";
    var actual = StringUtils.toMd5("Hallo Welt");
    expect(actual, wish);
  });

  test('Encoder Magic Test', () {
    var customResult = "gw4v3slWxwOIDi==";

    var content = Encoder.doMagicWithString("Hallo Welt");

    expect(content, customResult);
  });

  test('Encoder Test', () {
    var wish =
        "17521383925415199212239642531761574977245751414321216125170123100292551483847213420231211431732406994225133156203951561931071120869176178102941017925017468107246219208157125185481621141854250197301164425412580124111328114620514214117113222172471021985152170163571282481331266723097146190561798742082097262222391293214110516514597224207147374916116353224228915918141198208238243210184140992504634204211241208124124921173815339161781781692481002499381782462051221458525020218792";

    var content = Encoder.Encode(utf8.encode(
            "https://osca-bew.hs-osnabrueck.de/scripts/mgrqispi.dll?APPNAME=CampusNet&PRGNAME=ACTIONMOBILE&ARGUMENTS=-AGNzGBO2BINxJlU96CyRQw0J6sE3FcJkOR0l9Wyer2QQuw1SExBHj-Ec1mw1TYBW7bbwlRkmkrZf="))
        .join('');

    expect(content, wish);
  });
}
