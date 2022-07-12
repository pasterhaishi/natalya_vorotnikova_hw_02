import 'package:flutter/material.dart';
import 'colors.dart';

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

class Recipe {
  String imagePath = '';
  String nameRecipe = '';
  String timeCoocking = '';

  Recipe(this.imagePath, this.nameRecipe, this.timeCoocking);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> dataRecipes = [
    Recipe('assets/images/01.png', 'Лосось в соусе терияки', '45 минут'),
    Recipe('assets/images/02.png', 'Поке боул с сыром тофу', '30 минут'),
    Recipe('assets/images/03.png', 'Стейк из говядины по-грузински с кукурузой',
        '1 час 15 минут'),
    Recipe('assets/images/04.png', 'Тосты с голубикой и бананом', '45 минут'),
    Recipe('assets/images/05.png', 'Паста с морепродуктами', '25 минут'),
    Recipe('assets/images/06.png', 'Бургер с двумя котлетами', '1 час'),
    Recipe('assets/images/07.png', 'Пицца Маргарита домашняя', '25 минут'),
  ];
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: dataRecipes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: _CardOfRecipe(data: dataRecipes[index]),
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
    return Container(
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
      child: Expanded(
        child: Row(children: [
          SizedBox(
            width: 149,
            height: 136,
            child: Image.asset(data.imagePath),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 30, 0, 0),
            child: Column(
              children: [
                SizedBox(
                  width: 208,
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
                  width: 208,
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
        ]),
      ),
    );
  }
}
