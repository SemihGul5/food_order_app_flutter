import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/sepet_yemekler.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';
import 'package:food_order_app_flutter/ui/cubits/sepet_cubit.dart';
import 'package:lottie/lottie.dart';

class Sepet extends StatefulWidget {
  const Sepet({super.key});

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  int toplamFiyat = 0;
  List<SepetYemekler> sepetYemekler = [];
  bool siparisOnay=false;

  @override
  void initState() {
    super.initState();
    _toplamTutar();
    context.read<SepetCubit>().sepettekiYemekleriGetir();
  }

  Future<void> _toplamTutar() async {
    int yeniToplamFiyat = 0;
    await context.read<SepetCubit>().sepettekiYemekleriGetir();
    List<SepetYemekler> sepetYemekler = context.read<SepetCubit>().state;
    for (var yemek in sepetYemekler) {
      yeniToplamFiyat += (int.parse(yemek.yemek_siparis_adet) * int.parse(yemek.yemek_fiyat));
    }
    setState(() {
      toplamFiyat = yeniToplamFiyat;
    });
  }


  @override
  Widget build(BuildContext context) {
    _toplamTutar();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<SepetCubit>().sepettekiTumYemekleriSil();
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
          )
        ],
      ),
      body:!siparisOnay ? Column(
        children: [
          Expanded(
            child: BlocBuilder<SepetCubit, List<SepetYemekler>>(
              builder: (context, yemeklerListesi) {
                sepetYemekler = yemeklerListesi;
                if (yemeklerListesi.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: yemeklerListesi.length,
                      itemBuilder: (context, index) {
                        var yemek = yemeklerListesi[index];
                        return Card(
                          color: Colors.white,
                          elevation: 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.network(
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    yemek.yemek_adi,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                    child: Text(
                                      "Fiyat: ${yemek.yemek_fiyat} ₺",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Adet: ${yemek.yemek_siparis_adet}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          context.read<SepetCubit>().sepettenYemekSil(yemek.yemek_adi);
                                        });

                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.deepOrangeAccent,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${(int.parse(yemek.yemek_siparis_adet) * int.parse(yemek.yemek_fiyat))} ₺",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return  Center(
                    child: Lottie.asset("lottie/cart_empty.json",repeat: true,width: 300,height: 300,fit: BoxFit.contain),
                  );
                }
              },
            ),
          ),
          Visibility(
            visible: toplamFiyat!=0 ? true: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    "Toplam:",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "$toplamFiyat ₺", // Display the total price
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: toplamFiyat!=0 ? true: false ,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child:ElevatedButton(
                  onPressed: () {
                    siparisVerildi();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  child: const Text(
                    "Siparişi Onayla",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ): Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("lottie/food_order.json",repeat: true,width: 300,height: 300),
            const Text("Siparişiniz alındı. En kısa sürede size ulaşacak")
          ],
        )


      )
    );
  }

  void siparisVerildi() async {
    context.read<SepetCubit>().sepettekiTumYemekleriSil();
    setState(() {
      siparisOnay=true;
    });
  }
}
