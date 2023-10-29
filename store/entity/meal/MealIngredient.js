import Timestamp from 'store/trait/Timestamp';

export default class MealIngredient extends Timestamp {
  id = null;
  ingredient_id = null;
  meal_id = null;
  portion_id = null;
  quantity = null;

  constructor(data = null) {
    super();

    if (data) {
      this.normalizeData(data);
    }
  }

  normalizeData(data) {
    Object.entries(data).forEach(([key, value]) => {
      if (key in this) { this[key] = value; }
    });
  }

  get portion() {
    const portionStore = api.usePortionStore();
    return new Portion(portionStore.itemBy('id', this.portion_id).value);
  }

  get ingredient() {
    const ingredientStore = api.useIngredientStore();
    return new Ingredient(ingredientStore.itemBy('id', this.ingredient_id).value);
  }

  get meal() {
    const mealStore = api.useMealStore();
    return new Meal(mealStore.itemBy('id', this.meal_id).value);
  }
}
