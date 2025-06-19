<script setup>
import { globalTheme } from '@/themeState'; // ✅ satu-satunya sumber state global
import logodark from '@images/logoDark.png';
import logoutama from '@images/logoutama.png';
import { useCycleList } from '@vueuse/core';
import { watch } from 'vue';
import { useTheme } from 'vuetify';

const props = defineProps({
  themes: {
    type: Array,
    required: true,
  },
})

const { name: themeName, global: vuetifyTheme } = useTheme()

const savedTheme = globalTheme.name.value
vuetifyTheme.name.value = savedTheme

// Set logo awal
globalTheme.logo.value = savedTheme === 'dark' ? logodark : logoutama
localStorage.setItem('logo', globalTheme.logo.value)

const {
  state: currentThemeName,
  next: getNextThemeName,
  index: currentThemeIndex, // ✅ Tambahkan baris ini
} = useCycleList(
  props.themes.map((t) => t.name),
  { initialValue: savedTheme }
)


const changeTheme = () => {
  const nextTheme = getNextThemeName()
  globalTheme.name.value = nextTheme
  vuetifyTheme.name.value = nextTheme
  localStorage.setItem('theme', nextTheme)

  const logo = nextTheme === 'dark' ? logodark : logoutama
  globalTheme.logo.value = logo
  localStorage.setItem('logo', logo)
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
