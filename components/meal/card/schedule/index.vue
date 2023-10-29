<template lang="pug">
div(
  :class=`{
    [$style.cardSchedule]: true,
    [$style.cardScheduleAfterToday]: dayContent.isAfterToday,
    [$style.cardScheduleAfterNearToday]: dayContent.isAfterNearToday,
    [$style.cardScheduleBeforeToday]: dayContent.isBeforeToday,
  }`
)

  div(:class="$style.stepWrapper")
    h2(:class="$style.head")
      span(:class="$style.date") {{ $d(day, 'short') }}
      span(:class="$style.kcal")
        | {{ $n(dayContent.macro.kilocalorie, { maximumFractionDigits: 0 }) }} kcal

    div(v-for="(step, stepName) in dayContent.steps" :key="stepName" :class="$style.step")
      h3(:class="$style.stepTitle") {{ stepName }}
        span(:class="$style.stepKcal")
          | {{ $n(step.macro.kilocalorie, { maximumFractionDigits: 0 }) }} kcal

      button(
        v-for="{ ingredientOrMeal } in step.contents"
        :key="ingredientOrMeal.id"
        :class="$style.content"
        @click="$emit('click', ingredientOrMeal)"
      )
        | {{ ingredientOrMeal.name }}

        span(:class="$style.contentKcal")
          | {{ $n(ingredientOrMeal.macro.kilocalorie, { maximumFractionDigits: 0 }) }} kcal
</template>

<script setup>
defineEmits(['click']);
defineProps(['day', 'dayContent', 'index']);
</script>

<style lang="sass" module>
@import '@/assets/css/_colorScheme'

.cardSchedule
  padding: 20px 0
  padding-left: 1rem
  position: relative

  &:first-child
    border-top: 0

    &::after
      border-radius: 10px 10px 0 0

  &:last-child
    &::after
      border-radius: 0 0 10px 10px

  &::before
    $size: 15px

    background-color: hsl(0, 0%, 100%)
    border-radius: 50%
    content: ''
    height: $size
    left: 0
    position: absolute
    top: 42px
    transform: translateX(calc(-50%)) translateY(-50%)
    width: $size

  &:hover::before
    box-shadow: 0px 0 11px var(--color-primary)

  &::after
    background-color: hsl(0, 0%, 100%)
    content: ''
    height: 100%
    left: -2px
    position: absolute
    top: 0
    width: 5px

  &:after:not(.cardSchedule:first-child::after)
    border-radius: 10px

  .cardScheduleAfterNearToday
    &::after
      background: linear-gradient(180deg, var(--color-secondary) 0%, var(--color-primary) 100%)

  .kcal
    border-radius: 5px
    font-size: 0.8rem
    padding: 3px

  .head
    align-items: center
    display: flex
    justify-content: space-between
    margin-bottom: 10px

  .date
    color: var(--color-primary-text)
    font-size: 1rem
    font-weight: bolder

  .cardScheduleAfterToday
    &::before
      background-color: var(--color-secondary)

    &::after
      background-color: var(--color-secondary)

    .content
      background-color: color-mix(in srgb, var(--color-secondary) 20%, var(--color-primary))

      &:hover
        background-color: color-mix(in srgb, var(--color-secondary) 30%, var(--color-primary))

        &::before
          background-color: var(--color-secondary)
          box-shadow: 0px 0 11px var(--color-secondary)

  .cardScheduleBeforeToday
    opacity: 0.4
    transition: .2s
    &:hover
      opacity: 1

  .stepWrapper
    padding: 10px
    border-radius: 10px

  .step:not(.step:last-child)
    margin-bottom: 10px

  .stepTitle
    color: var(--color-primary-text)
    font-size: 0.8em

  .stepKcal
    font-size: 0.8rem
    margin-left: 5px
    &::before
      content: '('
    &::after
      content: ')'

  .content
    background-color: var(--color-background)
    border: initial
    border-radius: 30px
    color: var(--color-background-text)
    cursor: pointer
    display: flex
    justify-content: space-between
    font-size: 1em
    padding: 10px
    padding-left: 13px
    position: relative
    transition: .2s
    margin-top: 5px
    margin-bottom: 5px
    width: 100%

    &::before
      content: ''
      height: 100%
      left: 0
      position: absolute
      top: 0
      transition: .2s
      width: 5px

  .contentKcal
    font-size: 0.9rem
</style>
