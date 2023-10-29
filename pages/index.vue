<template lang="pug">
div(:id="$style.signupPage")
  form(:class="$style.form")
    fieldset(:class="$style.fields")
      label(:class="$style.label") {{ fieldsetStep.label }}
      ui-input-text(v-model="fieldsetStep.value" :placeholder="fieldsetStep.placeholder")

    div(:class="$style.actions")
      ui-button(v-if="currentStep > 0" @click="currentStep -= 1") Précedent
      ui-button(@click="currentStep += 1") Suivant
</template>

<script setup>
const currentStep = ref(0);
const form = ref([
  {
    label: 'Veuillez saisir votre email',
    placeholder: 'Email',
    value: null,
  },
  {
    label: 'Veuillez saisir votre pseudo',
    placeholder: 'Pseudo',
    value: null,
  },
  {
    label: 'Veuillez saisir votre mot de passe',
    placeholder: 'Mot de passe',
    value: null,
  },
]);

const fieldsetStep = computed(() => form.value[currentStep.value]);
</script>

<style lang="sass" module>
#signupPage
  align-items: center
  display: flex
  flex-direction: column
  justify-content: center
  min-height: 100vh

  .label
    font-size: var(--text-size-big)

  .form
    align-items: center
    display: flex
    flex-direction: column
    gap: 3rem

  .fields
    align-items: center
    display: flex
    flex-direction: column
    gap: 3rem

  .actions
    color: blue
</style>
