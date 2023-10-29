import { api, useAuthStore } from 'store';

async function initUser() {
  const authStore = useAuthStore();

  if (!authStore.user) {
    await authStore.getUser();
  }
}

async function initStore() {
  const authStore = useAuthStore();

  // Get store
  if (authStore.user) {
    await Promise.all(Object.values(api).map(async (useStore) => {
      const store = useStore();
      if (!store.init) {
        await store.getDataFromApi();
      }
    }));
  }
}

export default defineNuxtRouteMiddleware(async () => {
  // Stop middleware on serverside
  if (process.server) { return; }

  await initUser();
  await initStore();
});
