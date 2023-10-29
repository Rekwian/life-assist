<template lang="pug">
//- ClientOnly to get width value
client-only
  teleport(to="body" :disabled="width > md")
    div(v-if="!item" :class="$style.emptyRecipe")
      h2
        | Sélectionnez un plat
        br
        | pour afficher sa recette
    div(v-else :class="$style.wrapper")
      div(:class="$style.recipe")
        h2(:class="$style.title") {{ item.name }}
        div
          button options
          button(@click="$emit('close')") fermer
</template>

<script setup>
import { useWindowSize } from '@vueuse/core';
import { md } from 'assets/css/modules/breakpoints.module.sass';

defineProps(['item']);
defineEmits(['close']);

const { width } = useWindowSize();
</script>

<style lang="sass" module>
@import 'assets/css/_breakpoints'

.wrapper
  box-sizing: border-box
  background-color: rgba(0, 0, 0, 0.5)
  padding: 10px
  top: 0
  left: 0
  position: absolute
  width: 100%
  height: 100%
  z-index: 100

.recipe
  background-color: var(--color-background)
  box-sizing: border-box
  color: var(--color-background-text)
  border-radius: 10px
  display: flex
  flex-direction: column
  justify-content: space-between
  padding: 20px
  transition: 0.2s
  width: 100%
  height: 100%

  .title
    font-size: 1em
    font-weight: bolder
    text-decoration: underline
    text-decoration-thickness: 2px

.emptyRecipe
  $color: var(--color-primary-text)

  align-items: center
  background-color: transparent
  border: 6px dashed $color
  border-radius: 10px
  color: $color
  display: none
  justify-content: center
  font-weight: bold
  font-size: 1.2em
  opacity: 0.6
  text-align: center

@include md-min
  .wrapper
    background-color: unset
    position: static

    .title
      font-size: 1em

  .emptyRecipe
    display: flex

</style>
