import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(null);

  Future<void> kaydet(String yemek_adi, String yemek_fiyat, String yemek_resim_adi, String yemek_id) async {
    var url = 'http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php';
    var veri = {
      'yemek_adi': yemek_adi,
      'yemek_fiyat': yemek_fiyat,
      'yemek_resim_adi': yemek_resim_adi,
      'yemek_id': yemek_id,
    };
    var cevap = await Dio().post(url, data: veri);
    print('Yemek kaydet : ${cevap.data.toString()}');
  }
}
