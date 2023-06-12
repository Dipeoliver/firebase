import 'package:firebase/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth.dart';

import '../models/foods.dart';
import '../models/foods_api.dart';
import '../utils/image_constants.dart';
import '../widgets/recipe_card.dart';

class ListPage extends StatefulWidget {
  final String countryKey;

  ListPage(this.countryKey, {super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Foods> _recipes;
  bool _isLoading = true;

  final User? user = Auth().currentUser;

  Future<void> sigNout() async {
    await Auth().sigNout();
  }

  Widget _title() {
    return const Text('Foods VNT');
  }

  Widget _userUid() {
    return Text(user?.email ?? "User mail");
  }

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await FoodsApi.getRecipe(widget.countryKey);
    setState(() {
      _isLoading = false;
    });
  }

  String getCountryAppBar(String countryKey) {
    switch (countryKey) {
      case "Italian":
        return ImageConstants.bg_italian_food;
        break;
      case "German":
        return ImageConstants.bg_germany_food;
        break;
      case "Mexican":
        return ImageConstants.bg_mexican_food;
        break;
      default:
        return ImageConstants.bg_japanese_food;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoading ? Colors.black : Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 8,
              color: Color.fromARGB(255, 128, 7, 4),
            ))
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: false,
                  pinned: true,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      getCountryAppBar(widget.countryKey),
                      fit: BoxFit.cover,
                    ),
                    centerTitle: true,
                    title: Text(widget.countryKey,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ) //TextStyle
                        ), //Text
                  ), //FlexibleSpaceBar
                  expandedHeight: 200,
                  backgroundColor: const Color.fromARGB(255, 128, 7, 4),
                  leading: IconButton(
                    icon: Image.asset('assets/images/logo.png'),
                    tooltip: 'Menu',
                    onPressed: () {},
                  ), //IconButton
                  actions: <Widget>[
                    IconButton(
                      color: Colors.white,
                      iconSize: 40.0,
                      icon: const Icon(Icons.home),
                      tooltip: 'Home Page',
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ), //IconButton
                  ], //<Widget>[]
                ), //SliverAppB
                SliverList.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                        title: _recipes[index].name,
                        thumbnailUrl: _recipes[index].images);
                  },
                )
              ],
            ),
    );
  }
}
