<template lang="pug">
nuxt-layout(name="user" :class="$style.workspacePage")
  nuxt-link(
    v-for="(page, key) in software"
    :key="key"
    :class="$style.page"
    :to="page.to"
  )
    div {{ page.name }}
</template>

<script setup>
const software = {
  budget: {
    name: 'Gestion du budget',
    to: { name: 'workspace-budget' },
  },
  meal: {
    name: 'Gestion des repas',
    to: { name: 'workspace-meal-schedules' },
  },
};
</script>

<style lang="sass" module>
.workspacePage
  align-items: center
  display: flex
  justify-content: center
  gap: 30px
.page
  display: block
  border: 1px solid black
  border-radius: 10px
  padding: 10px
  color: initial
  text-decoration: initial
</style>
