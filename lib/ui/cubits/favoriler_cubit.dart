import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';
class FavorilerCubit extends Cubit<List<Yemekler>>{
  FavorilerCubit():super(<Yemekler>[]);

  var repo=YemeklerRepository();

  Future<void> favoriYemekleriYukle() async{
    emit(await repo.favoriYemekleriYukle());
  }

  Future<void> favorilerdenSil(int yemek_id) async{
    await repo.sil(yemek_id);
    favoriYemekleriYukle();
  }


}