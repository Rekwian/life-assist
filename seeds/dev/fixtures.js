/* eslint-disable guard-for-in */
/* eslint-disable no-restricted-syntax */
const { createClient } = require('@supabase/supabase-js');
const { faker } = require('@faker-js/faker');
const sampleSize = require('lodash/sampleSize');
const sample = require('lodash/sample');
const { formatISO, startOfYesterday, startOfTomorrow } = require('date-fns');

require('dotenv').config();

const macroFaker = () => ({
  alimentary_fiber: faker.number.int({ max: 10 }),
  carbohydrate: faker.number.int({ max: 10 }),
  kilocalorie: faker.number.int({ max: 700 }),
  kilojoule: faker.number.int({ max: 10 }),
  oily_material: faker.number.int({ max: 10 }),
  protein: faker.number.int({ max: 10 }),
  salt: faker.number.int({ max: 10 }),
  saturated_fatty_acid: faker.number.int({ max: 10 }),
  sugar: faker.number.int({ max: 10 }),
});

async function seedUsers(knex, workspaceId) {
  const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
  const { data: { users } } = await supabase.auth.admin.listUsers();

  await Promise.all(users.map((user) => supabase.auth.admin.deleteUser(user.id)));
  const { data: { user } } = await supabase.auth.admin.createUser({ email: 'admin@gmail.com', email_confirm: true, password: '0000' });

  await knex('workspace_user').del();
  await knex('workspace_user').insert({
    user_id: user.id,
    workspace_id: workspaceId,
  });
}

async function seedWorkspaces(knex) {
  await knex('workspace').del();
  return knex('workspace').insert({}).returning('id');
}

async function seedIngredients(knex, workspaceId) {
  await knex('ingredient').del();

  const list = [];

  for (let i = 0; i < 20; i += 1) {
    const ingredient = {
      name: faker.lorem.words({ max: 3, min: 1 }),
      workspace_id: workspaceId,
    };
    const brand = faker.lorem.words({ max: 3 });

    if (brand) {
      Object.assign(ingredient, { brand });
    }

    list.push(ingredient);
  }

  return knex('ingredient').insert(list).returning('id');
}

async function seedMeals(knex, workspaceId) {
  await knex('meal').del();
  await knex('meal_ingredient').del();

  const mealist = [];

  for (let i = 0; i < 10; i += 1) {
    mealist.push({
      name: faker.lorem.words({ max: 3, min: 1 }),
      nb_portion: faker.number.int({ max: 10 }),
      workspace_id: workspaceId,
    });
  }

  return knex('meal').insert(mealist).returning('id');
}

async function seendMealIngredient(knex, meals, ingredients) {
  await knex('meal_ingredient').del();

  const mealIngredientList = [];

  meals.forEach((meal) => {
    sampleSize(ingredients, faker.number.int({ max: ingredients.length })).forEach((ingredient) => {
      mealIngredientList.push({
        ingredient_id: ingredient.id,
        meal_id: meal.id,
      });
    });
  });

  return knex('meal_ingredient').insert(mealIngredientList).returning('id');
}

async function seedPortions(knex, ingredients) {
  await knex('portion').del();

  const portionList = [];

  ingredients.forEach((ingredient) => {
    portionList.push({
      ingredient_id: ingredient.id,
      quantity: faker.number.int({ max: 10 }),
      unit: 'cl',
    });
  });

  return knex('portion').insert(portionList).returning('id');
}

async function seedMacroMeals(knex, meals) {
  await knex('macro_meal').del();

  const list = [];

  sampleSize(meals, faker.number.int({ max: meals.length })).forEach((meal) => {
    list.push({
      ...macroFaker(),
      meal_id: meal.id,
    });
  });

  return knex('macro_meal').insert(list).returning('id');
}
async function seedMacroIngredients(knex, ingredients) {
  await knex('macro_ingredient').del();

  const list = [];

  ingredients.forEach((ingredient) => {
    list.push({
      ...macroFaker(),
      ingredient_id: ingredient.id,
    });
  });

  return knex('macro_ingredient').insert(list).returning('id');
}

async function seedSteps(knex, workspaceId) {
  await knex('step').del();

  const list = [];

  ['petit déjeuner', 'déjeuner', 'diner'].forEach((step, key) => {
    list.push({
      name: step,
      order: key,
      workspace_id: workspaceId,
    });
  });

  return knex('step').insert(list).returning('id');
}

async function seedSchedules(knex, workspaceId, meals, steps) {
  await knex('schedule').del();

  const scheduleList = [];

  for (let i = 0; i < 10; i += 1) {
    scheduleList.push({
      date: faker.date.between({
        from: formatISO(startOfYesterday()),
        to: formatISO(startOfTomorrow()),
      }),
      meal_id: sample(meals).id,
      quantity: faker.number.int({ max: 300, min: 100 }),
      step_id: sample(steps).id,
      workspace_id: workspaceId,
    });
  }

  return knex('schedule').insert(scheduleList).returning('id');
}

exports.seed = async (knex) => {
  const workspace = await seedWorkspaces(knex);
  const workspaceId = workspace[0].id;

  await seedUsers(knex, workspaceId);

  const ingredients = await seedIngredients(knex, workspaceId);
  const steps = await seedSteps(knex, workspaceId);

  const meals = await seedMeals(knex, workspaceId, ingredients);

  seendMealIngredient(knex, meals, ingredients);

  await seedPortions(knex, ingredients);
  await seedMacroMeals(knex, meals);
  await seedMacroIngredients(knex, ingredients);
  await seedSchedules(knex, workspaceId, meals, steps);
};
