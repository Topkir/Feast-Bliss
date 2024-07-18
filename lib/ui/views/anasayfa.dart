import 'package:feast_bliss/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../constants.dart';
import '../../data/entity/yemekler.dart';
import 'detay_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int selectedIndex = -1;

  List<Map<String, String>> listItems = [
    {'image': 'asset/logo/pizza.png', 'title': 'Pizza'},
    {'image': 'asset/logo/tavuk.png', 'title': 'Tavuk'},
    {'image': 'asset/logo/kahve.png', 'title': 'İçecekler'},
    {'image': 'asset/logo/pasta.png', 'title': 'Tatlı'},
  ];

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'asset/animations/shop_cart.json',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              minimum: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('MAĞAZA'),
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('ALIŞVERİŞ'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('AYARLAR'),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('BİLGİ'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
          builder: (context, yemeklerListesi) {
        if (yemeklerListesi.isNotEmpty) {
          return ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 30),
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            text: 'Choose the \n',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Food you love',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        )),
                  ),
                  kAra,
                  SizedBox(
                    width: 380,
                    child: TextField(
                      onChanged: (aramaSonucu) {
                        context.read<AnasayfaCubit>().ara(aramaSonucu);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for a food item',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  kAra,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: const Text(
                          'Kategoriler',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      kKartAra,
                      SizedBox(
                        height: 130,
                        child: SizedBox(
                          height: 130,
                          child: ListView.builder(
                            itemCount: listItems.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  context
                                      .read<AnasayfaCubit>()
                                      .kategoriAra(listItems[index]['title']!);
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: selectedIndex == index
                                          ? Colors.pink
                                          : Colors.transparent,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 32, right: 0, bottom: 1),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 150,
                                          child: Image.asset(
                                            listItems[index]['image']!,
                                            color: selectedIndex == index
                                                ? Colors.pink
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          listItems[index]['title']!,
                                          style: TextStyle(
                                            color: selectedIndex == index
                                                ? Colors.pink
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  kKartAra2,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: const Text(
                          'Yemekler',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      kKartAra,
                      SizedBox(
                        height: 290,
                        child: CarouselSlider.builder(
                          itemCount: yemeklerListesi.length,
                          options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              pageSnapping: true,
                              viewportFraction: 0.6),
                          itemBuilder: (context, index, realIndex) {
                            var yemek = yemeklerListesi[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetaySayfa(
                                      yemek: yemek,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 10,
                                margin: const EdgeInsets.only(
                                    top: 0, left: 0, right: 50, bottom: 0),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.pink[300]!,
                                        Colors.pink[100]!,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.3, 1],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Image.network(
                                          'http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 32),
                                        child: Text(
                                          yemek.yemek_adi,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            " ₺${yemek.yemek_fiyat}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 70),
                                          const Icon(Icons.favorite_border),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
