import 'dart:convert';
import 'package:quiver/collection.dart';

class JsonObject extends DelegatingMap<String, dynamic> {
  final Map<String, dynamic> jsonMap;

  JsonObject(this.jsonMap);

  JsonObject.fromString(String jsonString) : jsonMap = json.decode(jsonString);

  @override
  Map<String, dynamic> get delegate => jsonMap;

  @override
  String toString() => json.encode(jsonMap);

  String toStringPretty() {
    JsonEncoder encoder = JsonEncoder.withIndent('   ');
    return encoder.convert(jsonMap);
  }
}

class JsonArray<T> extends DelegatingList<T> {
  final List<T> jsonArray;

  JsonArray.list(this.jsonArray);

  factory JsonArray(String jsonString, [T converter(value)]) {
    List<dynamic> array = (json.decode(jsonString));

    try {
      //Tries to convert the members into JsonObjects
      final auxArray = array.map((value) => JsonObject(value)).toList();
      array = auxArray;
    } catch (e) {}

    if (converter != null) {
      final auxArray = array.map(converter).toList();
      array = auxArray;
    }

    return JsonArray<T>.list(array);
  }

  @override
  List<T> get delegate => jsonArray;

  @override
  String toString() => json.encode(jsonArray, toEncodable: (obj) => obj.toString());

  String toStringPretty() {
    JsonEncoder encoder = JsonEncoder.withIndent('   ', (obj) => obj.toString());
    return encoder.convert(jsonArray);
  }
}
