<script setup>
import { useTheme } from 'vuetify';

const props = defineProps({
  themes: {
    type: Array,
    required: true,
  },
})

const {
  name: themeName,
  global: globalTheme,
} = useTheme()

const savedTheme = localStorage.getItem('theme')? localStorage.getItem('theme'): globalTheme.name.value
globalTheme.name.value = savedTheme

const {
  state: currentThemeName,
  next: getNextThemeName,
  index: currentThemeIndex,
} = useCycleList(
  props.themes.map((t) => t.name),
  { initialValue: savedTheme }
);


const changeTheme = () => {
  globalTheme.name.value = getNextThemeName()
  localStorage.setItem('theme', globalTheme.name.value)

}

watch(() => globalTheme.name.value, val => {
  currentThemeName.value = val
})
</script>

<template>
  <IconBtn @click="changeTheme">
    <VIcon :icon="props.themes[currentThemeIndex].icon" />
    <VTooltip
      activator="parent"
      open-delay="1000"
      scroll-strategy="close"
    >
      <span class="text-capitalize">{{ currentThemeName }}</span>
    </VTooltip>
  </IconBtn>
</template>
