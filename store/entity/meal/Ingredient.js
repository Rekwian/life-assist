import Timestamp from 'store/trait/Timestamp';
import Macro from './Macro';
import { useMacroIngredientStore, usePortionStore } from 'store';

export default class Ingredient extends Timestamp {
  id = null;
  name = null;
  private = null;
  brand = null;
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

  get macro() {
    const macroStore = useMacroIngredientStore();
    const macroItem = macroStore.itemBy('ingredient_id', this.id);

    return new Macro(macroItem);
  }

  get portions() {
    const portionStore = usePortionStore();

    return portionStore.list
      .filter((portion) => portion.ingredient_id === this.id)
      .map((portion) => portion);
  }
}
