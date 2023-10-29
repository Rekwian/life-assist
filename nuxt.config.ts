// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  alias: {
    store: '/store',
  },
  css: [
    'reset-css',
    'animate.css',
    '@/assets/css/theme.sass',
  ],
  devtools: { enabled: true },
  modules: [
    // http://localhost:3001 - https://supabase.com/docs - https://supabase.nuxtjs.org
    '@nuxtjs/supabase',
    // https://github.com/nuxt-modules/icon - https://iconify.design/ - https://icon-sets.iconify.design/
    'nuxt-icon',
    // https://pinia.vuejs.org - https://pinia.vuejs.org/ssr/nuxt.html
    '@pinia/nuxt',
    // https://vue-i18n.intlify.dev - https://v8.i18n.nuxtjs.org
    '@nuxtjs/i18n',
  ],
});
