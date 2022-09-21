import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';

import 'colors.dart';
import 'models.dart';
import 'data_of_recipes.dart';

class MySpisok extends StatelessWidget {
  const MySpisok({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> dataRecipes = DataofRecipes.dataOfRecipes;
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dataRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RecipeDetailPage(
                                  data: dataRecipes[index],
                                ))),
                    child: _CardOfRecipe(data: dataRecipes[index])),
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.green,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/icons8-пицца-24 (1) 1.png'),
              label: 'Рецепты'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/icons8-пользователь-24 1.png'),
              label: 'Вход'),
        ],
      ),
    );
  }
}

class _CardOfRecipe extends StatelessWidget {
  final Recipe data;
  const _CardOfRecipe({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4.0,
                spreadRadius: 4.0,
                offset: Offset(0, 4),
              )
            ]),
        height: 136,
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Flexible(
            flex: 0,
            child: Image.asset(
              data.imagePath,
              height: 136,
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 30, 14, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    // width: 204,
                    height: 52,
                    child: Text(data.nameRecipe,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    // width: 204,
                    height: 20,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/clock.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(data.timeCoocking,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.primaryGreen),
                            overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
        // ),
      ),
      (data.favorite)
          ? Container(
              width: 66,
              height: 23,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/flag.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '1',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Colors.white),
                  )))
          : const SizedBox(),
    ]);
  }
}
