import 'package:flutter/material.dart';
import 'package:gastro_go/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:gastro_go/presentation/bloc/favorite/favorite_event.dart';
import 'package:gastro_go/presentation/ui/restaurant_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final favoritesBox = await Hive.openBox('favoritesBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoritesBloc(box: favoritesBox)..add(LoadFavorites()),
        ),
      ],
      child: MaterialApp(
        title: 'Gastro Go',
        debugShowCheckedModeBanner: false,
        home: const RestaurantListPage(),
      ),
    ),
  );
}

