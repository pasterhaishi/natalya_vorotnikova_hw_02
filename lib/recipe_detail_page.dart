import 'package:flutter/material.dart';
import 'colors.dart';
import 'models.dart';
import 'package:intl/intl.dart';

// import 'package:natalya_vorotnikova_hw_02/data_of_recipes.dart';

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

  var now = DateTime.now();

  var formatter = DateFormat('dd.MM.yyyy');
  String formattedDate = '';
  var listComment = [Comment(' ', '', '', '', '')];

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        backgroundColor: Colors.white,
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
                    Text(
                      widget.data.nameRecipe,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
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
                (widget.data.coocking > 0)
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
                            child: Text(
                              widget.data.coocking.toString(),
                              style: const TextStyle(
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
              ElevatedButton(
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.dackGreen),
                ),
                child: const Text(
                  'Начать готовить',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
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
                      keyboardType: TextInputType.name,
                      onSubmitted: (String value) {
                        setState(() {
                          textComment = value;
                          var newComment = Comment(
                              value,
                              'anna',
                              'assets/images/avatar.png',
                              'assets/images/comment_image.png',
                              formattedDate);

                          listComment.add(newComment);
                        });
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              onPressed: () {},
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

class _CardOfComment extends StatefulWidget {
  const _CardOfComment({
    Key? key,
    required this.formattedDate,
    required this.comment,
  }) : super(key: key);

  final String formattedDate;

  final Comment comment;

  @override
  State<_CardOfComment> createState() => _CardOfCommentState();
}

class _CardOfCommentState extends State<_CardOfComment> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Image.asset(widget.comment.pathAvatar),
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
                  Text(widget.comment.author,
                      style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  // ignore: unnecessary_string_interpolations
                  Text('${widget.formattedDate}',
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
                child: Text(widget.comment.text,
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
