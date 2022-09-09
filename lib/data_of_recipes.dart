import 'models.dart';

class DataofRecipes {
  static List<Recipe> dataOfRecipes = [
    Recipe(
        '123',
        'assets/images/01.png',
        'Лосось в соусе терияки',
        '45 минут',
        [
          Ingredient('Соевый соус', '8 ст. ложек'),
          Ingredient('Вода', ' 8 ст. ложек'),
          Ingredient('Мёд', '3 ст. ложки'),
          Ingredient('Коричневый сахар', '2 ст. ложки'),
          Ingredient('Чеснок', '3 зубчика'),
          Ingredient('Тёртый свежий имбирь', '1 ст. ложка'),
          Ingredient('Лимонный сок', '1¹⁄₂ ст. ложки'),
          Ingredient('Кукурузный крахмал', '1 ст. ложка'),
          Ingredient('Растительное масло', '1 ч. ложка'),
          Ingredient('Филе лосося или сёмги', '680 г'),
          Ingredient('Кунжут', 'по вкусу')
        ],
        [
          StepRecipe(
              1,
              'В маленькой кастрюле соедините соевый соус, 6 столовых ложек воды, мёд, сахар, измельчённый чеснок, имбирь и лимонный сок.',
              false,
              '06:00'),
          StepRecipe(
              2,
              'Поставьте на средний огонь и, помешивая, доведите до лёгкого кипения.',
              false,
              '07:00'),
          StepRecipe(
              3,
              'Смешайте оставшуюся воду с крахмалом. Добавьте в кастрюлю и перемешайте.',
              false,
              '06:00'),
          StepRecipe(
              4,
              'Готовьте, непрерывно помешивая венчиком, 1 минуту. Снимите с огня и немного остудите.',
              false,
              '01:00'),
          StepRecipe(
              5,
              'Смажьте форму маслом и выложите туда рыбу. Полейте её соусом.',
              false,
              '06:00'),
          StepRecipe(
              6,
              'Поставьте в разогретую до 200 °C духовку примерно на 15 минут.',
              false,
              '15:00'),
          StepRecipe(
              7,
              'Перед подачей полейте соусом из формы и посыпьте кунжутом.',
              false,
              '04:00'),
        ],
        false,
        [
          Comment(
              'Я не большой любитель рыбы, но решила приготовить по этому рецепту и просто влюбилась!',
              'anna_obraztsova',
              'assets/images/avatar.png',
              'assets/images/comment_image.png',
              '08.09.2022'),
          Comment(
              'этому рецепту и просто влюбилась!',
              'anna_obraztsova',
              'assets/images/avatar.png',
              'assets/images/comment_image.png',
              '08.09.2022')
        ],
        0),
    Recipe('124', 'assets/images/02.png', 'Поке боул с сыром тофу', '30 минут',
        [], [], false, [], 0),
    Recipe(
        '125',
        'assets/images/03.png',
        'Стейк из говядины по-грузински с кукурузой',
        '1 час 15 минут',
        [],
        [],
        false,
        [],
        0),
    Recipe('126', 'assets/images/04.png', 'Тосты с голубикой и бананом',
        '45 минут', [], [], false, [], 0),
    Recipe('127', 'assets/images/05.png', 'Паста с морепродуктами', '25 минут',
        [], [], false, [], 0),
    Recipe('128', 'assets/images/06.png', 'Бургер с двумя котлетами', '1 час',
        [], [], false, [], 0),
    Recipe('129', 'assets/images/07.png', 'Пицца Маргарита домашняя',
        '25 минут', [], [], false, [], 0),
  ];
}
