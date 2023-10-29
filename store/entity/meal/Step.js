import Timestamp from 'store/trait/Timestamp';

export default class Step extends Timestamp {
  id = null;
  name = null;
  order = null;

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
