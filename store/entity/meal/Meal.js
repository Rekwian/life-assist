import { api } from 'store';
import Timestamp from 'store/trait/Timestamp';
import Macro from './Macro';

export default class Meal extends Timestamp {
  id = null;
  name = null;
  nb_portion = null;
  workspace_id = null;

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

  get ingredients() {
    const ingredientStore = api.useIngredientStore();
    const useMealIngredientStore = api.useMealIngredientStore();

    const ingredientList = useMealIngredientStore.list
      .filter((ingredientMeal) => ingredientMeal.meal_id === this.id)
      .map((ingredientMeal) => {
        const ingredient = ingredientStore.itemBy('id', ingredientMeal.ingredient_id).value;

        Object.assign(ingredient, {
          portion: ingredientMeal.portion_id,
          quantity: ingredientMeal.quantity,
        });

        return ingredient;
      });

    return ingredientList;
  }

  get macro() {
    const portionStore = api.usePortionStore();

    const macroItem = this.ingredients.reduce((acc, curr) => {
      const portionId = curr.portion;
      let { quantity } = curr;

      if (portionId) {
        const portion = portionStore.itemBy('id', portionId).value;
        quantity *= portion.quantity;
      }

      Object.entries(curr.macro).forEach(([key, value]) => {
        if (Number.isNaN(value)) { return; }

        acc[key] += (value / 100) * quantity;
      });

      return acc;
    }, new Macro());

    macroItem.id = `macro-of-${this.id}`;

    return macroItem;
  }
}
