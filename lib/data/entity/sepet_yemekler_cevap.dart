import 'package:food_order_app_flutter/data/entity/sepet_yemekler.dart';

class SepetYemeklerCevap{
  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerCevap(this.sepet_yemekler, this.success);

  factory SepetYemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray=json["sepet_yemekler"] as List;
    var success=json["success"] as int;
    var yemekler= jsonArray.map((e) => SepetYemekler.fromJson(e)).toList();
    return SepetYemeklerCevap(yemekler, success);
  }
}