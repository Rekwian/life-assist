import Timestamp from 'store/trait/Timestamp';

export default class Meal extends Timestamp {
  id = null;
  name = 'main';

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
