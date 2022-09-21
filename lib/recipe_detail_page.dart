import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'colors.dart';
import 'models.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe data;

  const RecipeDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _PageState();
}

class _PageState extends State<RecipeDetailPage> {
  bool _isExistence = false;
  bool _isCoocking = true;
  String textComment = '';
  String pathValue = '';

  var now = DateTime.now();

  var formatter = DateFormat('dd.MM.yyyy');
  String formattedDate = '';
  var listComment = [Comment(' ', '', '', '', '')];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    listComment = widget.data.comments.toList();

    formattedDate = formatter.format(now);

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: _isCoocking
            ? null
            : PreferredSize(
                child: Container(
                  height: 60,
                  color: AppColors.primaryGreen,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Таймер',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white)),
                        Timer(time: 2700),
                      ]),
                ),
                preferredSize: const Size.fromHeight(60)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);

            setState(() {});
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text(
          'Рецепт',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: AppColors.dackGreen),
        ),
        centerTitle: true,
        backgroundColor: _isCoocking ? Colors.white : AppColors.primaryGreen,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Image.asset(
              "assets/images/megafon.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(widget.data.nameRecipe,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                          maxLines: 2),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.data.favorite = !widget.data.favorite;
                          });
                        },
                        icon: (widget.data.favorite)
                            ? const Icon(Icons.favorite,
                                color: AppColors.primaryGreen)
                            : const Icon(Icons.favorite, color: Colors.black))
                  ],
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/clock.png",
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.data.timeCoocking,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.primaryGreen),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Stack(alignment: Alignment.bottomRight, children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(widget.data.imagePath),
                          fit: BoxFit.cover,
                          alignment: Alignment.center)),
                ),
                (widget.data.favorite)
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
              ]),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text('Ингредиенты',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.dackGreen)),
              ),
              const SizedBox(height: 18),
              Container(
                  height: 33 * widget.data.ingredients.length.toDouble(),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.data.ingredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _IngredientsWidget(
                          ingredient: widget.data.ingredients.elementAt(index));
                    },
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: _isExistence
                          ? Border.all(color: AppColors.primaryGreen, width: 3)
                          : Border.all(color: AppColors.dackGray, width: 3))),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isExistence = !_isExistence;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 3.0, color: AppColors.dackGreen),
                      padding: const EdgeInsets.fromLTRB(53, 12, 53, 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: const Text(
                    'Проверить наличие',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.dackGreen),
                  )),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text('Шаги приготовления',
                    style: TextStyle(
                        color: AppColors.dackGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 138 * widget.data.steps.length.toDouble(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.data.steps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _CardOfStep(
                      step: widget.data.steps.elementAt(index),
                      coocking: _isCoocking,
                    );
                  },
                ),
              ),
              _isCoocking
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isCoocking = !_isCoocking;
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(53, 12, 53, 12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.dackGreen),
                      ),
                      child: const Text(
                        'Начать готовить',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isCoocking = !_isCoocking;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 3.0, color: AppColors.dackGreen),
                          padding: const EdgeInsets.fromLTRB(53, 12, 53, 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        'Закончить готовить',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.dackGreen),
                      ),
                    ),
              const Divider(
                thickness: 2,
                color: AppColors.grayText,
                height: 52,
              ),
              Column(
                children: [
                  NewWidget(
                      widget: widget,
                      formattedDate: formattedDate,
                      listComment: listComment),
                  TextField(
                      controller: _controller,
                      keyboardType: TextInputType.name,
                      onSubmitted: (String value) {
                        setState(() {
                          textComment = value;
                          var newComment = Comment(
                              value,
                              'anna',
                              'assets/images/avatar.png',
                              pathValue,
                              formattedDate);
                          // print(pathValue);

                          listComment.add(newComment);
                          _controller.clear();
                        });
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              onPressed: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        GetImage());
                              },
                              //  async {
                              //   pathValue = await Navigator.push(
                              //       context,
                              //       PageRouteBuilder(
                              //         opaque: false,
                              //         pageBuilder: (context, _, __) => Photo(),
                              //         transitionsBuilder: (__,Animation<double> animation,___,Widget child)
                              //         {
                              //           return FadeTransition(opacity: animation,child:ScaleTransition(scale: ,))
                              //         }
                              //       ));
                              //   // print(pathValue);
                              //   // print(widget.data.comments.last.pathPhoto);
                              // },
                              icon: const Icon(
                                Icons.photo,
                                color: AppColors.dackGreen,
                              )),
                          suffixIconColor: AppColors.dackGreen,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: AppColors.dackGreen, width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: AppColors.dackGreen, width: 2),
                          ),
                          hintText: "оставить комментарий",
                          hintStyle: const TextStyle(
                              color: AppColors.grayText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetImage extends StatefulWidget {
  const GetImage({
    Key? key,
  }) : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickerImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
      }
    });
  }

  Future getImageFromGallery() async {
    final pickerImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        ListTile(
            title: const Text('Камера'),
            onTap: () {
              getImageFromCamera();
              // Navigator.of(context).pop(_image);
            }),
        ListTile(
          title: Text(_image.toString()),
          onTap: () {
            getImageFromGallery();
            Navigator.of(context).pop(_image);
          },
        )
      ],
    );
  }
}

// ignore: must_be_immutable
// class Photo extends StatefulWidget {
//   Photo({Key? key}) : super(key: key);

//   String pathImage = '';

//   // String get path {
//   //   return pathImage;
//   // }

//   @override
//   State<Photo> createState() => _PhotoState();
// }

// class _PhotoState extends State<Photo> {
//   // File? _image;

//   Future getImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;

//       // final imageTemporary = File(image.path);
//       final imagePermanent = await saveFilePermanently(image.path);
//       widget.pathImage = imagePermanent.toString();
//       // setState(() {
//       //   widget.pathImage = imagePermanent.toString();
//       //   // this._image = imagePermanent;
//       //   print(imagePermanent);
//       // });
//     } on PlatformException catch (e) {
//       print('Files to pick image: $e');
//     }
//   }

//   Future<File> saveFilePermanently(String imagePath) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final name = basename(imagePath);
//     final image = File('${directory.path}/$name');

//     return File(imagePath).copy(image.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     String pathValue = '';
//     return SimpleDialog(
//       children: <Widget>[
//         ListTile(
//           title: const Text('Камера'),
//           onTap: () {
//             getImage(ImageSource.camera);

//             pathValue = widget.pathImage.toString();
//             Navigator.pop(context, pathValue);
//             print(pathValue);
//           },
//         ),
//         ListTile(
//           title: Text(widget.pathImage.toString()),
//           onTap: () => getImage(ImageSource.gallery),
//         )
//       ],
//     );
//   }
// }

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
    required this.widget,
    required this.formattedDate,
    required this.listComment,
  }) : super(key: key);

  final RecipeDetailPage widget;

  final String formattedDate;
  final List<Comment> listComment;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300 * widget.listComment.length.toDouble(),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listComment.length,
        itemBuilder: (BuildContext context, int index) {
          return _CardOfComment(
            formattedDate: widget.listComment.elementAt(index).data,
            comment: widget.listComment.elementAt(index),
          );
        },
      ),
    );
  }
}

class _CardOfComment extends StatelessWidget {
  const _CardOfComment({
    Key? key,
    required this.formattedDate,
    required this.comment,
  }) : super(key: key);

  final String formattedDate;

  final Comment comment;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Image.asset(comment.pathAvatar),
          ),
          const SizedBox(
            width: 18,
          ),
          Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(comment.author,
                      style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  // ignore: unnecessary_string_interpolations
                  Text('${formattedDate}',
                      style: const TextStyle(
                          color: AppColors.grayText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(comment.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 160,
                  child: Image.asset('assets/images/comment_image.png')),
              const SizedBox(
                height: 48,
              )
            ]),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _CardOfStep extends StatefulWidget {
  _CardOfStep({Key? key, required this.step, required this.coocking})
      : super(key: key);

  final StepRecipe step;
  bool coocking;

  @override
  State<_CardOfStep> createState() => _State();
}

class _State extends State<_CardOfStep> {
  bool? _checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return widget.coocking
        ? Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryGray),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                widget.step.number.toString(),
                style: const TextStyle(
                    color: AppColors.grayText,
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                width: 29,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.step.description,
                    style: const TextStyle(
                        color: AppColors.dackGray,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (value) {},
                        value: false,
                      ),
                    ),
                    Text(
                      widget.step.time,
                      style: const TextStyle(
                          color: AppColors.dackGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )
            ]),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.greenStep),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                widget.step.number.toString(),
                style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 40,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                width: 29,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.step.description,
                    style: const TextStyle(
                        color: AppColors.greenText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: AppColors.dackGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (t) {
                          setState(() {
                            _checkBoxValue = t;
                          });
                        },
                        value: _checkBoxValue,
                      ),
                    ),
                    Text(
                      widget.step.time,
                      style: const TextStyle(
                          color: AppColors.greenText,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )
            ]),
          );
  }
}

@immutable
class Timer extends StatefulWidget {
  const Timer({Key? key, required this.time}) : super(key: key);
  final int time;
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    int levelClock = widget.time;

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animation: StepTween(
        begin: widget.time,
        end: 0,
      ).animate(_controller),
    );
  }
}

// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(timerText,
        style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: Colors.white));
  }
}

class _IngredientsWidget extends StatelessWidget {
  const _IngredientsWidget({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\u2022 ' + ingredient.ingredientName,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            ingredient.measure,
            style: const TextStyle(
                color: AppColors.dackGray,
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
