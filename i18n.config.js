export default defineI18nConfig(() => ({
  datetimeFormats: {
    en: {
      digit: {
        day: 'numeric',
        month: 'numeric',
        year: '2-digit',
      },
      short: {
        day: 'numeric',
        month: 'short',
        year: '2-digit',
      },
    },
    fr: {
      digit: {
        day: 'numeric',
        month: 'numeric',
        year: '2-digit',
      },
      short: {
        day: 'numeric',
        month: 'short',
        year: '2-digit',
      },
    },
  },
  locales: 'fr',
  messages: {
    en: {
      welcome: 'Welcome',
    },
    fr: {
      welcome: 'Bienvenue',
    },
  },
  numberFormats: {
    en: {
      currency: {
        currency: 'USD',
        style: 'currency',
      },
    },
    fr: {
      currency: {
        currency: 'EUR',
        style: 'currency',
      },
    },
  },
}));
