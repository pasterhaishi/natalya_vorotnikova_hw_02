import 'ingredients.dart';
import 'comments.dart';
import 'steps.dart';

class Recipe {
  String id = '';
  String imagePath = '';
  String nameRecipe = '';
  String timeCoocking = '';
  Iterable<Ingredient> ingredients = [];
  Iterable<StepRecipe> steps = [];
  bool favorite = false;
  Iterable<Comment> comments = [];

  Recipe(this.id, this.imagePath, this.nameRecipe, this.timeCoocking,
      this.ingredients, this.steps, this.favorite, this.comments);
}
