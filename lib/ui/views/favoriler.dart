import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/ui/cubits/favoriler_cubit.dart';
import 'package:food_order_app_flutter/ui/cubits/yemekler_sayfa_cubit.dart';
import 'package:food_order_app_flutter/ui/views/yemek_detay.dart';
import 'package:lottie/lottie.dart';

class Favoriler extends StatefulWidget {
  const Favoriler({super.key});

  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  @override
  void initState() {
    super.initState();
    context.read<FavorilerCubit>().favoriYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favori Yemeklerim",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body:BlocBuilder<FavorilerCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: yemeklerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.3),
                  itemBuilder: (context,index){
                    var yemek=yemeklerListesi[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetay(yemek)));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 0.35,
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      context.read<FavorilerCubit>().favorilerdenSil(int.parse(yemek.yemek_id));
                                    });
                                  },
                                  icon: const Icon(Icons.favorite, color: Colors.deepOrangeAccent,),
                                )
                              ],
                            ),

                            SizedBox(
                                width: 120,height: 120,
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                            Text(yemek.yemek_adi,style: const TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.w400),),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${yemek.yemek_fiyat} ₺",style: const TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.w400),),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.add),color: Colors.deepOrangeAccent,iconSize: 25,),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            );
          }else{
            return Center(
              child: Lottie.asset("lottie/empty.json",repeat: true,width: 300,height: 300,fit: BoxFit.contain),
            );
          }
        },

      ),
    );
  }
}
