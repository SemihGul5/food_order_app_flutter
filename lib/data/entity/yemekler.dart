class Yemekler{
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;

  Yemekler(
      this.yemek_id,
      this.yemek_adi,
      this.yemek_resim_adi,
      this.yemek_fiyat);

  factory Yemekler.fromJson(Map<String,dynamic> json){
    return Yemekler(
        json["yemek_id"] as String,
        json["yemek_adi"] as String,
        json["yemek_resim_adi"] as String,
        json["yemek_fiyat"] as String);
  }
}