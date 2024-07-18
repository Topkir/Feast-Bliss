import 'package:feast_bliss/ui/cubit/anasayfa_cubit.dart';
import 'package:feast_bliss/ui/cubit/detay_sayfa_cubit.dart';
import 'package:feast_bliss/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:feast_bliss/ui/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/entity/Card.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AnasayfaCubit()..yemekleriYukle(),),
          BlocProvider(create: (context) => DetaySayfaCubit(),),
          BlocProvider(create: (context) => SepetSayfaCubit(),),
        ],
        child: MaterialApp(
          //debugShowMaterialGrid: true,
          debugShowCheckedModeBanner: false,
          title: 'FeastBliss',

          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF7F6FF),
            //colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF7F6FF)),
            useMaterial3: true,
          ),
          home: Anasayfa(),
        ),
      ),
    );
  }
}

