<template lang="pug">
component(:is="tag" :class="$style.uiButton" :type="type")
  template(v-if="loading")
    icon(name="line-md:loading-loop")

  template(v-else)
    slot
</template>

<script setup>
import { NuxtLink } from '#components'

const props = defineProps({
  href: { default: null, type: String },
  loading: { default: () => false, type: Boolean },
  to: { default: null, type: [String, Object] },
  type: { default: () => 'button', type: String },
});

const tag = computed(() => {
  if (props.href || props.to) {
    return NuxtLink;
  }

  return 'button';
});
</script>

<style lang="sass" module>
.uiButton
  background-color: var(--color-background)
  border: 0
  border-radius: 8px
  color: var(--color-background-text)
  cursor: pointer
  font-size: 1rem
  padding: 10px 20px
  transition: .2s

  &:hover
    background-color: var(--color-background-hover)
</style>
