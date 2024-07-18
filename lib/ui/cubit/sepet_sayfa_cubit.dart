import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<void> {
  SepetSayfaCubit() : super(null);

  final yrepo = YemeklerDaoRepository(); // Define yrepo

  Future<void> sil(String yemek_id) async {
    await yrepo.sil(yemek_id); // Ensure sil method is implemented in repository
    await YemekleriYukle(); // This needs to be defined
  }

  Future<void> YemekleriYukle() async {

  }
}
