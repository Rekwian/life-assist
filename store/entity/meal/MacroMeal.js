import Macro from './Macro';

export default class MacroMeal extends Macro {
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
}
