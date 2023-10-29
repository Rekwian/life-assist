// ----- Common Columns -----
const id = (table, knex) => {
  table.uuid('id').defaultTo(knex.fn.uuid())
    .primary()
    .unique()
    .notNullable();
};

const createdAndUpdatedAt = (table, knex) => {
  table.datetime('created_at').defaultTo(knex.fn.now()).notNullable();
  table.datetime('updated_at').defaultTo(knex.fn.now()).notNullable();
};

const macro = (table) => {
  table.integer('kilocalorie').defaultTo('0').notNullable();
  table.integer('kilojoule').defaultTo('0').notNullable();
  table.integer('oily_material').defaultTo('0').notNullable();
  table.integer('saturated_fatty_acid').defaultTo('0').notNullable();
  table.integer('carbohydrate').defaultTo('0').notNullable();
  table.integer('sugar').defaultTo('0').notNullable();
  table.integer('alimentary_fiber').defaultTo('0').notNullable();
  table.integer('protein').defaultTo('0').notNullable();
  table.integer('salt').defaultTo('0').notNullable();
};

// -----  Foreign -----
const mealId = (table) => table
  .uuid('meal_id')
  .references('id')
  .inTable('meal');

const ingredientId = (table) => table
  .uuid('ingredient_id')
  .references('id')
  .inTable('ingredient');

const portionId = (table) => table
  .uuid('portion_id')
  .references('id')
  .inTable('portion');

const workspaceId = (table) => table
  .uuid('workspace_id')
  .references('id')
  .inTable('workspace')
  .onDelete('cascade');

const userId = (table) => table
  .uuid('user_id')
  .references('id')
  .inTable('auth.users');

const stepId = (table) => table
  .uuid('step_id')
  .references('id')
  .inTable('step');

// ----- Tables -----
const createWorkspace = (knex) => knex.schema.createTable('workspace', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);

  table.string('name').notNullable().defaultTo('main');
});

const createIngredient = (knex) => knex.schema.createTable('ingredient', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  workspaceId(table);

  table.string('name').notNullable();
  table.string('brand');
});

const createMeal = (knex) => knex.schema.createTable('meal', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  workspaceId(table);

  table.string('name').notNullable();
  table.smallint('nb_portion').notNullable();
});

const createPortion = (knex) => knex.schema.createTable('portion', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  ingredientId(table).onDelete('cascade').notNullable();

  table.double('quantity').notNullable();
  table.string('unit').notNullable();
});

const createMacroMeal = (knex) => knex.schema.createTable('macro_meal', (table) => {
  id(table, knex);
  mealId(table).onDelete('cascade').notNullable().unique();
  macro(table);
});

const createMacroIngredient = (knex) => knex.schema.createTable('macro_ingredient', (table) => {
  id(table, knex);
  ingredientId(table).onDelete('cascade').notNullable().unique();
  macro(table);
});

const createStep = (knex) => knex.schema.createTable('step', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  workspaceId(table);

  table.string('name').notNullable();
  table.integer('order').notNullable();
});

const createSchedule = (knex) => knex.schema.createTable('schedule', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  ingredientId(table).onDelete('set null');
  mealId(table).onDelete('cascade');
  portionId(table).onDelete('set null');
  stepId(table).onDelete('cascade').notNullable();
  workspaceId(table);

  table.integer('quantity');
  table.date('date').defaultTo(knex.fn.now()).notNullable();
});

// Many To Many Tables
const createWorkspaceUser = (knex) => knex.schema.createTable('workspace_user', (table) => {
  createdAndUpdatedAt(table, knex);
  workspaceId(table);
  userId(table).onDelete('cascade');
});

const createMealIngredient = (knex) => knex.schema.createTable('meal_ingredient', (table) => {
  id(table, knex);
  createdAndUpdatedAt(table, knex);
  mealId(table).onDelete('cascade');
  ingredientId(table).onDelete('cascade');
  portionId(table).onDelete('set null');

  table.double('quantity');
});

exports.up = async (knex) => {
  await createWorkspace(knex);
  await createIngredient(knex);
  await createMeal(knex);
  await createPortion(knex);
  await createMealIngredient(knex);
  await createMacroMeal(knex);
  await createMacroIngredient(knex);
  await createStep(knex);
  await createSchedule(knex);
  await createWorkspaceUser(knex);
};

exports.down = (knex) => knex.schema
  .dropTable('workspace_user')
  .dropTable('schedule')
  .dropTable('step')
  .dropTable('macro_ingredient')
  .dropTable('macro_meal')
  .dropTable('meal_ingredient')
  .dropTable('portion')
  .dropTable('meal')
  .dropTable('ingredient')
  .dropTable('workspace');
