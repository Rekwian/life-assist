<template lang="pug">
div(:class="$style.placeholder")
  slot
</template>

<style lang="sass" module>
.placeholder
  background-color: #ababab
  color: white
  padding: 10px
  box-sizing: border-box
  border-radius: 10px
  width: 100%
</style>
