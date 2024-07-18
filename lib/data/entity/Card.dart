import 'package:flutter/material.dart';
import 'package:feast_bliss/data/entity/yemekler.dart';

class CartModel extends ChangeNotifier {
  final List<Yemekler> _items = [];

  List<Yemekler> get items => _items;

  void addItem(Yemekler yemek) {
    _items.add(yemek);
    notifyListeners();
  }

  void removeItem(Yemekler yemek) {
    _items.remove(yemek);
    notifyListeners();
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (var item in _items) {
      int yemekSiparisAdedi = int.tryParse(item.yemek_siparis_adedi ?? '1') ?? 1;
      int yemekFiyati = int.tryParse(item.yemek_fiyat ?? '0') ?? 0;
      totalPrice += (yemekFiyati * yemekSiparisAdedi);
    }
    return totalPrice;
  }
}
