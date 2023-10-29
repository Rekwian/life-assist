<template lang="pug">
div(:class="$style.uiInputText")
  label(v-if="label") {{ label }}
  div(:class="$style.inputWrapper")
    input(
      :class="$style.input"
      :placeholder="placeholder"
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
      :type="inputType"
    )
    button(
      v-if="type === 'password'"
      :class="$style.showPassword"
      type="button"
      @click="showPassword = !showPassword"
    )
      icon(v-if="showPassword" name="fa6-solid:eye-slash")
      icon(v-else name="fa6-solid:eye")
</template>

<script setup>
const props = defineProps({
  label: String,
  modelValue: String,
  placeholder: String,
  type: String,
});

const showPassword = ref(false);

const inputType = computed(() => {
  if (props.type === 'password' && !showPassword.value) {
    return 'password';
  }

  return 'text';
});

defineEmits(['update:modelValue']);
</script>

<style lang="sass" module>
.uiInputText
  .inputWrapper
    border-bottom: 4px solid var(--color-primary)
    display: flex

  .input
    border: 0
    background-color: transparent
    color: var(--color-background-text)
    width: 100%
    font-size: 1rem
    padding: 14px 5px

    &::placeholder
      opacity: 0.2

  .showPassword
    align-self: center
    background-color: transparent
    border: 0
    color: var(--color-primary-text)
    cursor: pointer
    font-size: 1.2rem
</style>
