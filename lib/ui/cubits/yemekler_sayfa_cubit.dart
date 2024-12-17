import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';

class YemeklerSayfaCubit extends Cubit<List<Yemekler>>{
  YemeklerSayfaCubit():super(<Yemekler>[]);
  var repo=YemeklerRepository();

  Future<void> yemekleriYukle() async{
    var liste=await repo.yemekleriYukle();
    emit(liste);
  }
  Future<void> yemekAra(String arananYemek)async{
    var liste=await repo.yemekleriYukle();
    List<Yemekler> yeniListe=[];
    for(var yemek in liste){
      if(yemek.yemek_adi.toLowerCase().contains(arananYemek.toLowerCase())){
        yeniListe.add(yemek);
      }
    }
    emit(yeniListe);
  }
  Future<void> sirala(String key) async {
    var liste = await repo.yemekleriYukle();
    List<Yemekler> yeniListe = [];

    if (key == "Varsayılan") {
      yeniListe = liste;
    } else if (key == "az") {
      liste.sort((a, b) => a.yemek_adi.compareTo(b.yemek_adi));
      yeniListe = liste;
    } else if (key == "za") {
      liste.sort((a, b) => b.yemek_adi.compareTo(a.yemek_adi));
      yeniListe = liste;
    } else if (key == "enyuksek") {
      liste.sort((a, b) => int.parse(b.yemek_fiyat).compareTo(int.parse(a.yemek_fiyat)));
      yeniListe = liste;
    } else if (key == "endusuk") {
      liste.sort((a, b) => int.parse(a.yemek_fiyat).compareTo(int.parse(b.yemek_fiyat)));
      yeniListe = liste;
    }
    emit(yeniListe);
  }
  Future<void> favorilereEkle(Yemekler yemek) async{
    await repo.favoriKaydet(yemek);
  }
  Future<void> favorilerdenSil(int yemek_id) async{
    await repo.sil(yemek_id);
  }
  Future<List<Yemekler>> favoriYemekleriYukle() async{
    return await repo.favoriYemekleriYukle();
  }
}