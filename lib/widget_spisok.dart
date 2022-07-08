import 'package:flutter/material.dart';
import 'colors.dart';

class MySpisok extends StatelessWidget {
  const MySpisok({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DataOfRecipe {
  String imagePath = '';
  String nameRecipe = '';
  String timeCoocking = '';

  DataOfRecipe(this.imagePath, this.nameRecipe, this.timeCoocking);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DataOfRecipe> dataRecipes = [
    DataOfRecipe('assets/images/01.png', 'Лосось в соусе терияки', '45 минут'),
    DataOfRecipe('assets/images/02.png', 'Поке боул с сыром тофу', '30 минут'),
    DataOfRecipe('assets/images/03.png',
        'Стейк из говядины по-грузински с кукурузой', '1 час 15 минут'),
    DataOfRecipe(
        'assets/images/04.png', 'Тосты с голубикой и бананом', '45 минут'),
    DataOfRecipe('assets/images/05.png', 'Паста с морепродуктами', '25 минут'),
    DataOfRecipe('assets/images/06.png', 'Бургер с двумя котлетами', '1 час'),
    DataOfRecipe(
        'assets/images/07.png', 'Пицца Маргарита домашняя', '25 минут'),
  ];
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: 50),
            _Spisok_recipes(dataOfRecipe: dataRecipes),
          ],
        ),
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

class _Spisok_recipes extends StatelessWidget {
  final List<DataOfRecipe> dataOfRecipe;
  const _Spisok_recipes({
    Key? key,
    required this.dataOfRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children:
            dataOfRecipe.map((data) => _Card_of_recipe(data: data)).toList(),
      ),
    );
  }
}

class _Card_of_recipe extends StatelessWidget {
  final DataOfRecipe data;
  const _Card_of_recipe({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.SHADOW,
              blurRadius: 4.0,
              spreadRadius: 4.0,
              offset: Offset(0, 4),
            )
          ]),
      height: 136,
      child: Expanded(
        child: Row(children: [
          Container(
            width: 149,
            height: 136,
            child: Image.asset(data.imagePath),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 30, 0, 0),
            child: Column(
              children: [
                Container(
                  width: 208,
                  height: 52,
                  child: Text(data.nameRecipe,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 22)),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: 208,
                  height: 20,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/clock.png",
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data.timeCoocking,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.PRIMARY_GREEN))
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
