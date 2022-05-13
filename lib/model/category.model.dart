import 'package:get/get.dart';

class CategoryModel {
  CategoryModel({
    required String key,
    required String name,
    required String color,
  }) {
    this.key = key;
    this.name = name;
    this.color = color;
  }

  final RxString _key = RxString("");
  set key(String value) => _key.value = value;
  String get key => _key.value;

  final RxString _name = RxString("");
  set name(String value) => _name.value = value;
  String get name => _name.value;

  final RxString _color = RxString("");
  set color(String value) => _color.value = value;
  String get color => _color.value;
}
