import 'package:food_order_app_flutter/data/entity/yemekler.dart';

class YemeklerCevap{
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap(this.yemekler, this.success);

  factory YemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray=json["yemekler"] as List;
    var success=json["success"] as int;
    var yemekler= jsonArray.map((e) => Yemekler.fromJson(e)).toList();

    return YemeklerCevap(yemekler, success);
  }
}