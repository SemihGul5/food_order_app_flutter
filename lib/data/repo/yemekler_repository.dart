import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_order_app_flutter/data/entity/sepet_yemekler.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/data/entity/yemekler_cevap.dart';
import 'package:food_order_app_flutter/data/entity/sepet_yemekler_cevap.dart';
import 'package:food_order_app_flutter/data/sqlite/veritabani_yardimcisi.dart';

class YemeklerRepository{
  List<Yemekler> parseYemekler(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }
  List<SepetYemekler> parseSepetYemekler(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async{
    var URL= "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(URL);
    return parseYemekler(cevap.data.toString());
  }

  Future<void> sepeteEkle(
      String yemek_adi,
      String yemek_resim_adi,
      int yemek_fiyat,
      int yemek_siparis_adet) async{
    var URL="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":"semihgül"};
    await Dio().post(URL,data: FormData.fromMap(veri));
  }

  Future<List<SepetYemekler>> sepettekiYemekleriGetir()async{
    var URL="http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri={"kullanici_adi":"semihgül"};
    var cevap= await Dio().post(URL,data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }

  Future<void> sepettenYemekSil(int sepet_yemek_id)async{
    var URL="http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri={
      "sepet_yemek_id":sepet_yemek_id,
      "kullanici_adi":"semihgül"};
    await Dio().post(URL,data: FormData.fromMap(veri));
  }

  Future<void> favoriKaydet(Yemekler yemek) async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["yemek_id"]=int.parse(yemek.yemek_id);
    bilgiler["yemek_adi"]=yemek.yemek_adi;
    bilgiler["yemek_resim_adi"]=yemek.yemek_resim_adi;
    bilgiler["yemek_fiyat"]=int.parse(yemek.yemek_fiyat);
    await db.insert("favoriler", bilgiler);
  }
  Future<List<Yemekler>> favoriYemekleriYukle() async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM favoriler");
    return List.generate(maps.length, (index) {
      var satir=maps[index];
      return Yemekler(satir["yemek_id"].toString(),satir["yemek_adi"],satir["yemek_resim_adi"],satir["yemek_fiyat"].toString());
    });

  }
  Future<void> sil(int yemek_id) async {
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("favoriler",where: "yemek_id = ?",whereArgs: [yemek_id]);
  }
}