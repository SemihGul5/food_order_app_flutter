import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/sepet_yemekler.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';

class SepetCubit extends Cubit<List<SepetYemekler>> {
  SepetCubit() : super(<SepetYemekler>[]);

  var repo = YemeklerRepository();

  Future<void> sepettekiYemekleriGetir() async {
    var liste = await repo.sepettekiYemekleriGetir();

    Map<String, SepetYemekler> birlesikYemekler = {};
    for (var yemek in liste) {
      if (birlesikYemekler.containsKey(yemek.yemek_adi)) {
        var mevcutYemek = birlesikYemekler[yemek.yemek_adi]!;
        mevcutYemek.yemek_siparis_adet =
            (int.parse(mevcutYemek.yemek_siparis_adet) +
                int.parse(yemek.yemek_siparis_adet))
                .toString();
      } else {
        birlesikYemekler[yemek.yemek_adi] = yemek;
      }
    }

    var birlesikListe = birlesikYemekler.values.toList();

    emit(birlesikListe);
  }

  Future<void> sepettenYemekSil(String yemekAdi) async {
    try {
      var yemekListesi = await repo.sepettekiYemekleriGetir();
      for (var yemek in yemekListesi) {
        if (yemek.yemek_adi == yemekAdi) {
          await repo.sepettenYemekSil(int.parse(yemek.sepet_yemek_id));
        }
      }
      await sepettekiYemekleriGetir();
      } catch (e) {
        emit([]);
      }
  }

  Future<void> sepettekiTumYemekleriSil() async{
    try{
      var yemekListesi = await repo.sepettekiYemekleriGetir();
      for (var yemek in yemekListesi) {
        await repo.sepettenYemekSil(int.parse(yemek.sepet_yemek_id));
      }
      await sepettekiYemekleriGetir();
    }catch(e){
      emit([]);
    }
  }

}
