import 'package:dio/dio.dart';
import 'package:feast_bliss/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/yemekler.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();
  List<Yemekler> tumYemekler = [];

  Future<void> yemekleriYukle() async {
    tumYemekler = await yrepo.yemekleriYukle();
    emit(tumYemekler);
  }

  Future<void> ara(String aramakelimesi) async {
    if (aramakelimesi.isEmpty) {
      emit(tumYemekler); // Arama kelimesi boşsa tüm yemekleri göster
    } else {
      var bulunanYemekler = tumYemekler.where((yemek) {
        return yemek.yemek_adi.toLowerCase().contains(aramakelimesi.toLowerCase());
      }).toList();
      emit(bulunanYemekler);
    }
  }

  void kategoriAra(String kategori) {
    List<Yemekler> filteredYemekler = [];

    switch (kategori) {
      case 'Pizza':
        filteredYemekler = [
          Yemekler(yemek_adi: 'Pizza', yemek_resim_adi: 'pizza.png', yemek_fiyat: '20', yemek_id: ''),
          Yemekler(yemek_adi: 'Lazanya', yemek_resim_adi: 'lazanya.png', yemek_fiyat: '25', yemek_id: ''),
          Yemekler(yemek_adi: 'Makarna', yemek_resim_adi: 'makarna.png', yemek_fiyat: '25', yemek_id: ''),
        ];
        break;
      case 'Tavuk':
        filteredYemekler = [
          Yemekler(yemek_adi: 'Izgara Somon', yemek_resim_adi: 'izgarasomon.png', yemek_fiyat: '55', yemek_id: ''),
          Yemekler(yemek_adi: 'Izgara Tavuk', yemek_resim_adi: 'izgaratavuk.png', yemek_fiyat: '27', yemek_id: ''),
          Yemekler(yemek_adi: 'Köfte', yemek_resim_adi: 'kofte.png', yemek_fiyat: '27', yemek_id: ''),
        ];
        break;
      case 'İçecekler':
        filteredYemekler = [
          Yemekler(yemek_adi: 'Ayran', yemek_resim_adi: 'ayran.png', yemek_fiyat: '5', yemek_id: ''),
          Yemekler(yemek_adi: 'Fanta', yemek_resim_adi: 'fanta.png', yemek_fiyat: '10', yemek_id: ''),
          Yemekler(yemek_adi: 'Kahve', yemek_resim_adi: 'kahve.png', yemek_fiyat: '15', yemek_id: ''),
          Yemekler(yemek_adi: 'Su', yemek_resim_adi: 'su.png', yemek_fiyat: '1', yemek_id: ''),
        ];
        break;
      case 'Tatlı':
        filteredYemekler = [
          Yemekler(yemek_adi: 'Baklava', yemek_resim_adi: 'baklava.png', yemek_fiyat: '25', yemek_id: ''),
          Yemekler(yemek_adi: 'Kadayıf', yemek_resim_adi: 'kadayif.png', yemek_fiyat: '22', yemek_id: ''),
          Yemekler(yemek_adi: 'Sütlaç', yemek_resim_adi: 'sutlac.png', yemek_fiyat: '10', yemek_id: ''),
          Yemekler(yemek_adi: 'Tiramisu', yemek_resim_adi: 'tiramisu.png', yemek_fiyat: '23', yemek_id: ''),
        ];
        break;
    }

    emit(filteredYemekler);
  }


}
