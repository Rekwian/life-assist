<template lang="pug">
div(:id="$style.loginPage")
  form(:class="$style.form" @submit.prevent="handleLogin")
    ui-placeholder @TODO : titre
    fieldset(:class="$style.fields")
      ui-input-text(v-model="username" placeholder="Email" :disabled="loading")
      ui-input-text(
        v-model="password"
        placeholder="Mot de passe"
        type="password"
        :disabled="loading"
      )
    div(:class="$style.actions")
      ui-button(type="submit" :loading="loading") Se connecter
      a J'ai oublié mon mot de passe
</template>

<script setup>
import { useAuthStore } from 'store';

const store = useAuthStore();
const router = useRouter();
const username = ref(null);
const password = ref(null);
const supabase = useSupabaseClient();
const loading = ref(false);
const workspaceStore = useWorkspaceStore();

async function handleLogin() {
  try {
    loading.value = true;
    await supabase.auth.signInWithPassword({
      email: username.value,
      password: password.value,
    });
    loading.value = 'success';

    await store.getUser();

    const defaultWorkspace = workspaceStore.list
      .find((workspace) => workspace.name === 'main') || workspaceStore.list[0];

    router.push({ name: 'workspace', params: { workspace: defaultWorkspace.name } });
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
}
</script>

<style lang="sass" module>
#loginPage
  align-items: center
  display: flex
  justify-content: center
  min-height: 100vh

  .form
    background-color: var(--color-background)
    border-radius: 10px
    padding: 30px
    display: flex
    flex-direction: column
    justify-content: center
    gap: 3rem

  .fields
    display: flex
    flex-direction: column
    gap: 1rem

  .actions
    display: flex
    flex-direction: column
    gap: 1.5rem

  .waitingWindow
    display: grid
    gap: 10px

    > *[data--status=failed]
      color: red
    > *[data--status=success]
      color: green

  .loading
    display: flex
    align-items: center
    gap: 10px
</style>
