import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app_flutter/ui/cubits/favoriler_cubit.dart';
import 'package:food_order_app_flutter/ui/cubits/sepet_cubit.dart';
import 'package:food_order_app_flutter/ui/cubits/yemek_detay_cubit.dart';
import 'package:food_order_app_flutter/ui/cubits/yemekler_sayfa_cubit.dart';
import 'package:food_order_app_flutter/ui/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>YemeklerSayfaCubit()),
        BlocProvider(create: (context)=>YemekDetayCubit()),
        BlocProvider(create: (context)=>SepetCubit()),
        BlocProvider(create: (context)=>FavorilerCubit()),
      ],
      child: MaterialApp(
        title: 'Food Order App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
