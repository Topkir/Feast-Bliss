import 'dart:convert';
import 'package:dio/dio.dart';
import '../entity/yemek_cevap.dart';
import '../entity/yemekler.dart';

class YemeklerDaoRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = 'http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php';
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<void> kaydet(
      String yemek_adi,
      String yemek_fiyat,
      String yemek_resim_adi,
      String yemek_id,
      String yemek_siparis_adedi) async {
    var url = 'http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php';
    var veri = {
      'yemek_adi': yemek_adi,
      'yemek_fiyat': yemek_fiyat,
      'yemek_resim_adi': yemek_resim_adi,
      'yemek_id': yemek_id,
      'yemek_siparis_adedi': yemek_siparis_adedi,
    };

    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print('Yemek kaydet : ${cevap.data.toString()}');
  }

  Future<void> sil(String yemek_id) async {
    var url = 'http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php';
    var veri = {'yemek_id': yemek_id};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print('Yemek Sil : ${cevap.data.toString()}');
  }


}
