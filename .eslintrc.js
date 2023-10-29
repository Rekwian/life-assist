module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    'airbnb-base',
    'plugin:vue/vue3-recommended',
    'plugin:vue-pug/vue3-recommended',
  ],
  overrides: [
    {
      env: {
        node: true,
      },
      files: [
        '.eslintrc.{js,cjs}',
      ],
      parserOptions: {
        sourceType: 'script',
      },
    },
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: [
    'vue',
  ],
  rules: {
    'consistent-return': 'off',
    'import/no-extraneous-dependencies': 'off',
    'lines-between-class-members': ['error', 'always', { exceptAfterSingleLine: true }],
    'no-param-reassign': 'off',
    'no-undef': 0,
    'no-unused-vars': ['error', { argsIgnorePattern: '_' }],
    'no-use-before-define': 'off',
    'object-curly-newline': 'off',
    'sort-keys': ['warn', 'asc'],
    'vue/html-quotes': 'off',
    'vue/max-attributes-per-line': 'off',
  },
  settings: {
    'import/resolver': {
      'eslint-import-resolver-custom-alias': {
        alias: {
          '@': './',
          assets: './assets',
          store: './store',
        },
      },
    },
  },
};
