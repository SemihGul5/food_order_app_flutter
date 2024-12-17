import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/data/entity/yemekler.dart';
import 'package:food_order_app_flutter/data/repo/yemekler_repository.dart';
import 'package:food_order_app_flutter/ui/cubits/yemekler_sayfa_cubit.dart';
import 'package:food_order_app_flutter/ui/views/yemek_detay.dart';

class YemeklerSayfa extends StatefulWidget {
  const YemeklerSayfa({super.key});

  @override
  State<YemeklerSayfa> createState() => _YemeklerSayfaState();
}

class _YemeklerSayfaState extends State<YemeklerSayfa> {
  bool aramaYapiliyorMu = false;
  List<Yemekler> favoriYemekler = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriYemekler();
    context.read<YemeklerSayfaCubit>().yemekleriYukle();
  }

  Future<void> _loadFavoriYemekler() async {
    var repo=YemeklerRepository();
    repo.favoriYemekleriYukle();
    favoriYemekler = await context.read<YemeklerSayfaCubit>().favoriYemekleriYukle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
          decoration: const InputDecoration(
              hintText: "Yemek Ara", hintStyle: TextStyle(color: Colors.white)),
          style: const TextStyle(color: Colors.white),
          onChanged: (aranan) {
            context.read<YemeklerSayfaCubit>().yemekAra(aranan);
          },
        )
            : const Text(
          "Yemek Listesi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: aramaYapiliyorMu
            ? [
          IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
              });

              context.read<YemeklerSayfaCubit>().yemekleriYukle();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ]
            : [
          IconButton(
            onPressed: () {
              _showSortingOptions(context);
            },
            icon: const Icon(Icons.import_export),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<YemeklerSayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: yemeklerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                  itemBuilder: (context, index) {
                    var yemek = yemeklerListesi[index];


                    bool isFavori = favoriYemekler.any((favoriYemek) => favoriYemek.yemek_adi == yemek.yemek_adi);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => YemekDetay(yemek)));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 0.35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isFavori) {
                                        context.read<YemeklerSayfaCubit>().favorilerdenSil(int.parse(yemek.yemek_id));
                                        favoriYemekler.removeWhere((fav) => fav.yemek_adi == yemek.yemek_adi);
                                      } else {
                                        context.read<YemeklerSayfaCubit>().favorilereEkle(yemek);
                                        favoriYemekler.add(yemek);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    isFavori ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.network(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                            Text(
                              yemek.yemek_adi,
                              style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${yemek.yemek_fiyat} ₺",
                                  style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                  color: Colors.deepOrangeAccent,
                                  iconSize: 25,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            );
          }
        },
      ),
    );
  }

  void _showSortingOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sıralama Seçenekleri",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const Divider(),
              ListTile(
                title: const Text("Varsayılan"),
                onTap: () {
                  context.read<YemeklerSayfaCubit>().sirala("Varsayılan");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("A-Z"),
                onTap: () {
                  context.read<YemeklerSayfaCubit>().sirala("az");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Z-A"),
                onTap: () {
                  context.read<YemeklerSayfaCubit>().sirala("za");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("En Yüksek Fiyat"),
                onTap: () {
                  context.read<YemeklerSayfaCubit>().sirala("enyuksek");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("En Düşük Fiyat"),
                onTap: () {
                  context.read<YemeklerSayfaCubit>().sirala("endusuk");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
