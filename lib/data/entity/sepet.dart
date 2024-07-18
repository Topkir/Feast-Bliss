class Sepet {
  String? sepet_yemek_id;
  String? yemek_adi;
  String? yemek_resim_adi;
  String? sepet_fiyat;
  String? yemek_siparis_ad;
  String kullanici_ad;

  Sepet({
    this.sepet_yemek_id,
    this.yemek_adi,
    this.yemek_resim_adi,
    this.sepet_fiyat,
    this.yemek_siparis_ad,
    required this.kullanici_ad,
  });

  factory Sepet.fromJson(Map<String, dynamic> json) {
    return Sepet(
      sepet_yemek_id: json['sepet_yemek_id'] as String,
      yemek_adi: json['yemek_adi'] as String,
      yemek_resim_adi: json['yemek_resim_adi'] as String,
      sepet_fiyat: json['sepet_fiyat'] as String,
      yemek_siparis_ad: json['yemek_siparis_ad'] as String,
      kullanici_ad: json['Topkir'] as String,
    );
  }
}
//(int.parse(widget.yemek.yemek_fiyat) * yemekSiparisAdedi) + widget.teslimatUcreti - widget.indirimMiktari;