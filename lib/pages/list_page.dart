import 'package:firebase/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth.dart';

import '../models/foods.dart';
import '../models/foods_api.dart';
import '../utils/image_constants.dart';
import '../widgets/recipe_card.dart';

class ListPage extends StatefulWidget {
  ListPage({super.key});

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
    _recipes = await FoodsApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: false,
                  pinned: true,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      ImageConstants.bg_italian_food,
                      fit: BoxFit.cover,
                    ),
                    centerTitle: true,
                    title: const Text("Italian Foods",
                        style: TextStyle(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
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
