import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_app/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_app/ui/cubit/detay_sayfa_cubit.dart';
import 'package:kisiler_app/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:kisiler_app/ui/views/anasayfa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
Platform.isAndroid ?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyATDtCW7rL7dkF1upb9_jPqiceXfNQX_nA",
      appId: "1:363734801879:android:966205122979bb8f873f92",
      messagingSenderId: "363734801879",
      projectId: "fir-b35c2",
    ),
  ): await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KayitSayfaCubit(),),
        BlocProvider(create: (context) => DetaySayfaCubit(),),
        BlocProvider(create: (context) => AnasayfaCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Anasayfa(),
      ),
    );
  }
}
