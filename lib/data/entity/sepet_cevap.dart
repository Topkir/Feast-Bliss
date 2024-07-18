import 'package:feast_bliss/data/entity/sepet.dart';

class SepetCevap {
  List<Sepet> sepet;
  int success;

  SepetCevap({required this.sepet, required this.success});

  factory SepetCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['sepet'] as List;
    var success = json['success'] as int;

    var sepet = jsonArray.map((jsonArrayNesnesi) => Sepet.fromJson(jsonArrayNesnesi)).toList();

    return SepetCevap(sepet: sepet, success: success);
  }
}
