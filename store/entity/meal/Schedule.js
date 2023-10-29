import { api } from 'store';
import Timestamp from 'store/trait/Timestamp';
import Macro from './Macro';
import { useWorkspaceStore } from '~/store';

export default class Schedule extends Timestamp {
  id = null;
  step_id = null;
  ingredient_id = null;
  quantity = 0;
  meal_id = null;
  portion_id = null;
  date = (new Date()).toISOString();
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

  get step() {
    const stepStore = api.useStepStore();
    return stepStore.itemBy('id', this.step_id).value;
  }

  get ingredient() {
    const ingredientStore = api.useIngredientStore();
    return this.ingredient_id && new ingredientStore.itemBy('id', this.ingredient_id).value;
  }

  get meal() {
    const mealStore = api.useMealStore();
    return mealStore.itemBy('id', this.meal_id).value;
  }

  get portion() {
    const portionStore = api.usePortionStore();
    return this.portion_id && portionStore.itemBy('id', this.portion_id).value;
  }

  get ingredientOrMeal() {
    if (this.ingredient_id) {
      return this.ingredient;
    }

    if (this.meal_id) {
      return this.meal;
    }

    return null;
  }

  get macro() {
    if (this.ingredientOrMeal) {
      return this.calcMacro(this.ingredientOrMeal.macro);
    }

    return new Macro();
  }

  get workspace() {
    const workspaceStore = useWorkspaceStore();

    return workspaceStore.collection[this.workspace_id];
  }

  calcMacro(macro) {
    const calculatedMAcro = new Macro();

    if (!macro) { return calculatedMAcro; }

    if (this.meal_id) {
      Object.entries(macro).forEach(([key, value]) => {
        if (Number.isNaN(value)) { return; }

        calculatedMAcro[key] = value / this.quantity;
      });
    }

    if (this.ingredient_id) {
      let ingredientQuantity = this.quantity;

      if (this.portion_id) {
        ingredientQuantity = this.portion.quantity * this.quantity;
      }

      Object.entries(macro).forEach(([key, value]) => {
        if (Number.isNaN(value)) { return; }

        calculatedMAcro[key] = (value / 100) * ingredientQuantity;
      });
    }

    return calculatedMAcro;
  }
}
