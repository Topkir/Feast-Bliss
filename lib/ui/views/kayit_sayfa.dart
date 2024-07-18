import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //sayfanın yukarı taşmasını engeller.
      appBar: AppBar(title: const Text('Kayıt Sayfa'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,
                decoration: InputDecoration(hintText: 'Kişi Ad'),
              ),
              TextField(controller: tfKisiTel,
                decoration: InputDecoration(hintText: 'Kişi Tel'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(onPressed: () {
                context.read<KayitSayfaCubit>().kaydet(tfKisiAdi.text, tfKisiTel.text);
              }, child: Text('Kaydet'),),
            ],
          ),
        ),
      ),
    );
  }
}
