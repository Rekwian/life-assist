/* eslint-disable import/prefer-default-export */
import { defineStore } from 'pinia';
import MacroIngredient from 'store/entity/meal/MacroIngredient';
import MacroMeal from 'store/entity/meal/MacroMeal';
import Portion from 'store/entity/meal/Portion';
import Meal from 'store/entity/meal/Meal';
import Ingredient from 'store/entity/meal/Ingredient';
import Step from 'store/entity/meal/Step';
import MealIngredient from 'store/entity/meal/MealIngredient';
import Schedule from 'store/entity/meal/Schedule';
import Workspace from 'store/entity/common/Workspace';
import User from 'store/entity/common/User';

function defineApiStore(entity, model) {
  const client = useSupabaseClient().from(entity);
  const collection = ref({});
  const init = ref(false);

  const list = computed(() => Object.values(collection.value));

  const itemBy = (property, value) => computed(() => {
    const targetedValue = Object
      .values(collection.value)
      .find((item) => item[property] === value);

    return targetedValue;
  });

  async function getDataFromApi() {
    const { data } = await client.select('*');
    const storedObject = {};
    const Entity = model;

    data.forEach((item) => Object.assign(storedObject, { [item.id]: new Entity(item) }));

    collection.value = storedObject;
    init.value = true;
  }

  return { collection, getDataFromApi, init, itemBy, list };
}

export const useMacroIngredientStore = defineStore(
  'meal.useMacroIngredientStore',
  () => defineApiStore('macro_ingredient', MacroIngredient),
);
export const useMacroMealStore = defineStore(
  'meal.useMacroMealStore',
  () => defineApiStore('macro_meal', MacroMeal),
);
export const usePortionStore = defineStore(
  'meal.usePortionStore',
  () => defineApiStore('portion', Portion),
);
export const useMealStore = defineStore(
  'meal.useMealStore',
  () => defineApiStore('meal', Meal),
);
export const useIngredientStore = defineStore(
  'meal.useIngredientStore',
  () => defineApiStore('ingredient', Ingredient),
);
export const useScheduleStore = defineStore(
  'meal.useScheduleStore',
  () => defineApiStore('schedule', Schedule),
);
export const useStepStore = defineStore(
  'meal.useStepStore',
  () => defineApiStore('step', Step),
);
export const useMealIngredientStore = defineStore(
  'meal.useMealIngredientStore',
  () => defineApiStore('meal_ingredient', MealIngredient),
);
export const useWorkspaceStore = defineStore(
  'meal.useWorkspaceStore',
  () => defineApiStore('workspace', Workspace),
);

export const api = {
  useIngredientStore,
  useMacroIngredientStore,
  useMacroMealStore,
  useMealIngredientStore,
  useMealStore,
  usePortionStore,
  useScheduleStore,
  useStepStore,
  useWorkspaceStore,
};

export const useAuthStore = defineStore(
  'default',
  () => {
    const authClient = useSupabaseClient();
    const user = ref(null);

    async function getUser() {
      try {
        const { data } = await authClient.auth.getUser();
        if (data.user) {
          user.value = new User(data.user);
        }
      } catch (error) {
        console.error(error);
      }
    }

    return {
      getUser, user,
    };
  },
);
