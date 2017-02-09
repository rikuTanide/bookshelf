import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class Item {
  String name;
  String author;
}

class AmazonAPI {

  final String _accessKey;
  final String _secretKey;
  final String _associateTag;

  AmazonAPI()
      : _accessKey= new File("secret/awskey").readAsStringSync(),
        _secretKey = new File("secret/awssecretkey").readAsStringSync(),
        _associateTag = new File("secret/associateTag").readAsStringSync();

  Future search(String keyword) async {
    var dt = new DateTime.now().toUtc();
    String signature = _getSignature(keyword, dt);
    var res = await _request(keyword, dt, signature);
    print(res);
    return _parseItems(res).toList();
  }

  DateFormat get _format => new DateFormat("yyyy-MM-ddTHH:mm:ss.000'Z'");

  Iterable<Map> _parseItems(String res) sync* {
    var resXml = xml.parse(res);
    var items = resXml.findAllElements("Item");
    print(items);
    for (xml.XmlElement e in items) {
      try {
        var asin = e
            .findElements("ASIN")
            .first
            .text
            .trim();
        var image = e
            .findElements("LargeImage")
            .first
            .findElements("URL")
            .first
            .text
            .trim();
        var author = e
            .findElements("ItemAttributes")
            .first
            .findElements("Author")
            .first
            .text
            .trim();
        var title = e
            .findElements("ItemAttributes")
            .first
            .findElements("Title")
            .first
            .text
            .split(" ")[0]
            .trim();
        yield {
          "asin" : asin,
          "image" :image,
          "author" : author,
          "title" : title,
        };
      } catch (e) {
        print(e);
      }
    }
  }

  String _getSignature(String keyword, DateTime utcDateTime) {
    var escKeyword = Uri.encodeComponent(keyword);
    var escDateTime = Uri.encodeComponent(_format.format(utcDateTime));
    var canonical = "GET\n"
        "ecs.amazonaws.jp\n"
        "/onca/xml\n"
        "AWSAccessKeyId=$_accessKey&AssociateTag=$_associateTag&Keywords=$escKeyword&MerchantId=Amazon&Operation=ItemSearch&ResponseGroup=Large&SearchIndex=Books&Service=AWSECommerceService&Timestamp=$escDateTime&Version=2011-08-01";
    var signingKey = UTF8.encode(_secretKey);
    var signature = _hmac(signingKey, canonical);

    return BASE64.encode(signature);
  }

  Future _request(String keyword, DateTime utcDateTime,
      String signature) async {
    var formatDateTime = _format.format(utcDateTime);
    var uri = new Uri.https('ecs.amazonaws.jp', '/onca/xml', {
      "AWSAccessKeyId" : _accessKey,
      "AssociateTag":_associateTag,
      "Keywords":keyword,
      "MerchantId": "Amazon",
      "Operation":"ItemSearch",
      "ResponseGroup" : "Large",
      "SearchIndex":"Books",
      "Service":"AWSECommerceService",
      "Timestamp": formatDateTime,
      "Version":"2011-08-01",
      "Signature" : signature,
    });

    var res = await http.get(uri);
    return res.body;
  }


  List<int> _hmac(List<int> key, String toSign) {
    final hmac = new Hmac(sha256, key);
    return hmac
        .convert(UTF8.encode(toSign))
        .bytes;
  }
}
