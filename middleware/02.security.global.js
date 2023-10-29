import { api, useAuthStore } from 'store';

export default defineNuxtRouteMiddleware(async (to) => {
  // Stop middleware on serverside
  if (process.server) { return; }

  // Get store
  const authStore = useAuthStore();
  const anonRoutes = ['index', 'login'];

  // If user exist and is in anon routes, redirect
  if (authStore.user) {
    // Redirect if user is in anon route.
    if (anonRoutes.includes(to.name)) {
      const workspaceStore = api.useWorkspaceStore();
      const defaultWorkspace = workspaceStore.list
        .find((workspace) => workspace.name === 'main') || workspaceStore.list[0];

      return navigateTo({
        name: 'workspace',
        params: { workspace: defaultWorkspace.name },
      });
    }

    return;
  }

  // If user does not exist and try to access to non-annon route, redirect to login.
  if (!authStore.user && !anonRoutes.includes(to.name)) {
    return navigateTo({ name: 'login' });
  }
});
