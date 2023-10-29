<template lang="pug">
div(:class="$style.container")
  slot
</template>

<style lang="sass" module>
.container
  box-sizing: border-box
  max-width: 1440px
  margin: auto
  padding: 10px
  width: 100%
</style>