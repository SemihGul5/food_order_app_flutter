import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/ui/cubits/yemek_detay_cubit.dart';
import 'package:lottie/lottie.dart';

class YemekDetay extends StatefulWidget {
  Yemekler yemek;
  YemekDetay(this.yemek);

  @override
  State<YemekDetay> createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  int yemekAdet=1;
  late int yemekFiyat;
  bool sepetAnimasyon=false;

  @override
  void initState() {
    super.initState();
    yemekFiyat =int.parse(widget.yemek.yemek_fiyat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detay",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){},
            icon: const Icon(Icons.favorite_border),color: Colors.white,)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text(widget.yemek.yemek_adi,style: const TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w400),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("${widget.yemek.yemek_fiyat} ₺",style: const TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w400),),
            ),
            Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if(yemekAdet!=1){
                          yemekAdet--;
                          yemekFiyat=yemekAdet*int.parse(widget.yemek.yemek_fiyat);
                        }
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.remove,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Text(yemekAdet.toString(),style: const TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w400),),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        yemekAdet++;
                        yemekFiyat=yemekAdet*int.parse(widget.yemek.yemek_fiyat);
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${yemekFiyat.toString()} ₺",style: const TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.w400),),
                  sepetAnimasyon ? Lottie.asset(
                    'lottie/add_cart.json',
                    width: 100,
                    height: 100,
                    repeat: false,
                  ):

                  ElevatedButton(
                    onPressed: (){
                      sepeteEkle(
                        widget.yemek.yemek_adi,
                        widget.yemek.yemek_resim_adi,
                        int.parse(widget.yemek.yemek_fiyat),
                        yemekAdet
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                    child: const Text("Sepete Ekle",style: TextStyle(color: Colors.white),),

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void sepeteEkle (
      String yemek_adi,
      String yemek_resim_adi,
      int yemek_fiyat,
      int yemek_siparis_adet) async {
    context.read<YemekDetayCubit>().sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);
    setState(() {
      sepetAnimasyon=true;
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      sepetAnimasyon = false;
    });
  }

}
