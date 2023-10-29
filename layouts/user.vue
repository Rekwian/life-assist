<template lang="pug">
ui-container(:class="$style.layoutUser")
  header(:class="$style.header")
    nav(:class="$style.navigation")
      ul
        li
          nuxt-link(
            :to="{ name: 'index' }"
            :class="$style.link"
            :active-class="$style.linkActive"
          ) home
        li
          nuxt-link(
            :to="{ name: 'workspace-meal-schedules'}"
            :class="$style.link"
            :active-class="$style.linkActive"
          ) schedules
        li
          nuxt-link(
            :to="{ name: 'workspace-meal-meals'}"
            :class="$style.link"
            :active-class="$style.linkActive"
          ) dishs
        li
          nuxt-link(
            :to="{ name: 'workspace-meal-ingredients'}"
            :class="$style.link"
            :active-class="$style.linkActive"
          ) foods
  main(:class="$style.main")
    slot
</template>

<style lang="sass" module>
.layoutUser
  display: grid
  grid-template-areas: 'header' 'main'
  grid-template-columns: 1fr
  grid-template-rows: auto 1fr
  min-height: 100vh
  gap: 20px

  .header
    background-color: var(--color-background)
    color: var(--color-background-text)
    border-radius: 10px
    display: flex
    grid-area: header
    justify-content: flex-end

  .main
    grid-area: main
    justify-self: center
    max-width: 1440px
    width: 100%

  .navigation
    ul
      display: flex

  .link
    cursor: pointer
    display: block
    padding: 15px 25px
    position: relative
    text-decoration: none

  .link:hover
    background-color: color-mix(in srgb, var(--color-background) 90%, white 10%)

  .linkActive
    background-color: color-mix(in srgb, var(--color-background) 95%, white 5%)
</style>
