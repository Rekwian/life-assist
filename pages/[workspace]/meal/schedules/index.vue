<template lang="pug">
nuxt-layout(name="user")
  div(:class="$style.mealPage")
    div(:class="$style.scheduleList")
      ui-button(:to="{ name: 'workspace'}" :class="$style.actionAdd") add
      section(:class="$style.cards")
        meal-card-schedule(
          v-for="(dayContent, day, index) in days"
          :key="`${dayContent.id}`"
          :day="new Date(day)"
          :day-content="dayContent"
          :index="index"
          @click="handleSelectItem"
        )
    meal-card-schedule-recipe(:item="selectedItem" @close="selectedItem = null")
</template>

<script setup>
import { isToday, endOfToday, startOfToday, isSameDay } from 'date-fns/esm';
import Schedule from 'store/entity/meal/Schedule';
import Macro from 'store/entity/meal/Macro';
import { useScheduleStore } from 'store';

const scheduleStore = useScheduleStore();
const route = useRoute();

const selectedItem = ref(null);

const schedules = scheduleStore.list
  .filter(({ workspace }) => workspace.name === route.params.workspace)
  .map((schedule) => new Schedule(schedule))
  .sort((a, b) => new Date(b.date) - new Date(a.date));

const days = computed(() => schedules.reduce((acc, curr, _, array) => {
  const date = new Date(curr.date);

  const firstAfterToday = array
    .filter((item) => new Date(item.date) > endOfToday())
    .sort((a, b) => new Date(a.date) - new Date(b.date))
    .shift();

  if (!acc[curr.date]) {
    acc[curr.date] = {
      id: curr.id,
      isAfterNearToday: firstAfterToday ? isSameDay(date, new Date(firstAfterToday.date)) : false,
      isAfterToday: date > endOfToday(),
      isBeforeToday: date < startOfToday(),
      isToday: isToday(date),
      macro: new Macro(),
      steps: {},
    };
  }

  if (curr.step?.name && !acc[curr.date].steps[curr.step.name]) {
    acc[curr.date].steps[curr.step.name] = {
      contents: [],
      macro: new Macro(),
    };
    acc[curr.date].steps[curr.step.name].contents.push(curr);

    Object.entries(curr.macro).forEach(([key, value]) => {
      if (Number.isNaN(value)) { return; }

      const currentMacro = acc[curr.date].steps[curr.step.name].macro;

      currentMacro[key] += value;
      acc[curr.date].macro[key] += value;
    });
  }

  return acc;
}, {}));

function handleSelectItem(item) {
  selectedItem.value = item;
}
</script>

<style lang="sass" module>
@import 'assets/css/_breakpoints'

.mealPage
  display: grid
  grid-template-columns: 1fr
  gap: 1rem
  min-height: 100%

  .scheduleList
    display: flex
    flex-direction: column

    .actionAdd
      align-self: flex-end
      bottom: 60px
      color: var(--color-primary)
      position: sticky

@include md-min
  .mealPage
    grid-template-columns: repeat(2, 1fr)
</style>
