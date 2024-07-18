import 'package:feast_bliss/data/entity/yemekler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../data/entity/Card.dart';
import '../../constants.dart';

class SepetSayfa extends StatefulWidget {
  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    kurulum();
  }

  Future<void> kurulum() async {
    var androidAyari = const AndroidInitializationSettings('@mipmap/ic_launcher'); // Notification icon
    var iosAyari = const DarwinInitializationSettings(); // Notification settings
    var kurulumAyari = InitializationSettings(android: androidAyari, iOS: iosAyari);

    await flp.initialize(kurulumAyari, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      bildirimSecildi(notificationResponse);
    });
  }

  Future<void> bildirimSecildi(NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    if (payload != null) {
      print('Bildirim Seçildi : $payload');
    }
  }

  Future<void> bildirimGoster() async {
    var androidBildirimDetay = const AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: 'ChannelDescription',
      priority: Priority.high,
      importance: Importance.max,
    );
    var iosBildirimDetay = const DarwinNotificationDetails();
    var bildirimDetay = NotificationDetails(android: androidBildirimDetay, iOS: iosBildirimDetay);
    await flp.show(0, 'Feast Bliss', 'Sipariş Verildi', bildirimDetay, payload: 'Payload İçerik');
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    int totalPrice = cart.calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SEPETİM'),
        backgroundColor: Colors.orange.shade300,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                var item = cart.items[index];
                int yemekSiparisAdedi = int.tryParse(item.yemek_siparis_adedi ?? '1') ?? 1;
                int yemekFiyati = int.tryParse(item.yemek_fiyat ?? '0') ?? 0;
                int toplamFiyat = (yemekFiyati * yemekSiparisAdedi);

                return Dismissible(
                  key: Key(item.yemek_id), // Unique key for each item
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      cart.removeItem(item);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.yemek_adi} silindi')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 100,
                            child: Image.network(
                              'http://kasimadalan.pe.hu/yemekler/resimler/${item.yemek_resim_adi}',
                            ),
                          ),
                        ),
                        kKartAra,
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.yemek_adi,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "₺$yemekFiyati",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "$yemekSiparisAdedi",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kKartAra,
                        SizedBox(
                          width: 70,
                          child: Text(
                            '₺$toplamFiyat',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Display total price
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Toplam Fiyat: ₺$totalPrice',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              bildirimGoster();
            },
            child: Text('Sepeti Onayla', style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade300,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
          kKartAra,
        ],
      ),
    );
  }
}
