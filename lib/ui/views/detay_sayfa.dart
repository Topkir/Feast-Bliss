import 'package:feast_bliss/ui/views/anasayfa.dart';
import 'package:feast_bliss/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/entity/Card.dart';
import '../../data/entity/yemekler.dart';
import '../../constants.dart';

class DetaySayfa extends StatefulWidget {
  final Yemekler yemek;
  final int teslimatUcreti;
  final int indirimMiktari;

  const DetaySayfa({
    required this.yemek,
    this.teslimatUcreti = 10,
    this.indirimMiktari = 10,
  });

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int yemekSiparisAdedi = 1;
  late int toplamFiyat;

  @override
  void initState() {
    super.initState();
    toplamFiyat = (int.parse(widget.yemek.yemek_fiyat) * yemekSiparisAdedi) + widget.teslimatUcreti - widget.indirimMiktari;
  }

  void miktarAzalt() {
    if (yemekSiparisAdedi > 1) {
      setState(() {
        yemekSiparisAdedi--;
        toplamFiyat = (int.parse(widget.yemek.yemek_fiyat) * yemekSiparisAdedi) + widget.teslimatUcreti - widget.indirimMiktari;
      });
    }
  }

  void miktarArtir() {
    setState(() {
      yemekSiparisAdedi++;
      toplamFiyat = (int.parse(widget.yemek.yemek_fiyat) * yemekSiparisAdedi) + widget.teslimatUcreti - widget.indirimMiktari;
    });
  }



  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.favorite_border,
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange[300]!,
                          Colors.orange[100]!,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 100,
                            child: Image.network(
                              'http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}',
                            ),
                          ),
                        ),
                        kKartAra,
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                widget.yemek.yemek_adi,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                " ₺${widget.yemek.yemek_fiyat}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kKartAra,
                        SizedBox(
                          width: 160,
                          child: Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: miktarAzalt,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$yemekSiparisAdedi',
                                  style: const TextStyle(
                                    height: 6,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: miktarArtir,
                                ),
                              ],
                            ),
                          ),
                        ),
                        kKartAra,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 620,),
                SafeArea(
                  minimum: EdgeInsets.only(right: 10,left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange[300]!,
                          Colors.orange[100]!,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        kButtonArasi2,
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              widget.yemek.yemek_siparis_adedi = yemekSiparisAdedi.toString();
                              cart.addItem(widget.yemek);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(),));
                            },
                            child: Text(
                              'Sepete Ekle',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                    
                        kButtonArasi2,
                        Expanded(
                          flex: 1,
                          child: Text(
                            '₺$toplamFiyat',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                    
                            ),
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
