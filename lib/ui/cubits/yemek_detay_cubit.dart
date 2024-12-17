import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';
class YemekDetayCubit extends Cubit<void>{
  YemekDetayCubit():super(0);

  var repo=YemeklerRepository();

  Future<void> sepeteYemekEkle(
      String yemek_adi,
      String yemek_resim_adi,
      int yemek_fiyat,
      int yemek_siparis_adet) async{

    await repo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);

  }




}