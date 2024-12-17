import 'package:flutter/material.dart';
import 'package:food_order_app_flutter/ui/views/favoriler.dart';
import 'package:food_order_app_flutter/ui/views/sepet.dart';
import 'package:food_order_app_flutter/ui/views/yemekler_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int selectedIndex=0;
  var pages=[const YemeklerSayfa(),const Sepet(),const Favoriler()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar:BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Anasayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Sepet"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favoriler"),
        ],
        currentIndex: selectedIndex,
        backgroundColor: Colors.deepOrangeAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
      ),
    );
  }
}
