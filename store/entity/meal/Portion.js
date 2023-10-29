import Timestamp from 'store/trait/Timestamp';

export default class Portion extends Timestamp {
  id = null;
  ingredient_id = null;
  unit = null;
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
}
