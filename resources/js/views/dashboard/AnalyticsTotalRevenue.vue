<script setup>
import { hexToRgb } from '@core/utils/colorConverter'
import { computed, onMounted } from 'vue'
import { useDisplay, useTheme } from 'vuetify'
import { useStore } from 'vuex'

const store = useStore()
const vuetifyTheme = useTheme()
const display = useDisplay()

onMounted(() => {
  store.dispatch('transaction/fetchWeeklyTransaction')
})

const series = computed(() => store.state.transaction.weeklySeries)
const categories = computed(() => store.state.transaction.weeklyCategories)

const chartOptions = computed(() => {
  const currentTheme = vuetifyTheme.current.value.colors
  const variableTheme = vuetifyTheme.current.value.variables

  const disabledTextColor = `rgba(${hexToRgb(String(currentTheme['on-surface']))},${variableTheme['disabled-opacity']})`
  const borderColor = `rgba(${hexToRgb(String(variableTheme['border-color']))},${variableTheme['border-opacity']})`

  return {
    chart: {
      stacked: true,
      toolbar: { show: false },
      offsetX: -12,
      parentHeightOffset: 6,
    },
    dataLabels: { enabled: false },
    stroke: {
      width: 6,
      lineCap: 'round',
      colors: [currentTheme.surface],
    },
    colors: [
      `rgba(${hexToRgb(String(currentTheme.primary))}, 1)`,
      `rgba(${hexToRgb(String(currentTheme.info))}, 1)`,
    ],
    legend: {
      offsetX: -22,
      offsetY: -1,
      position: 'top',
      fontSize: '13px',
      horizontalAlign: 'left',
      fontFamily: 'Public Sans',
      labels: { colors: currentTheme.secondary },
      itemMargin: {
        vertical: 4,
        horizontal: 10,
      },
      markers: {
        width: 11,
        height: 11,
        radius: 10,
        offsetX: -2,
      },
    },
    states: {
      hover: { filter: { type: 'none' } },
      active: { filter: { type: 'none' } },
    },
    grid: {
      strokeDashArray: 6,
      borderColor,
      padding: { bottom: 5 },
    },
    plotOptions: {
      bar: {
        borderRadius: 9,
        columnWidth: '30%',
        borderRadiusApplication: 'around',
        borderRadiusWhenStacked: 'all',
      },
    },
    xaxis: {
      categories: categories.value,
      axisTicks: { show: false },
      crosshairs: { opacity: 0 },
      axisBorder: { show: false },
      labels: {
        style: {
          fontSize: '13px',
          colors: disabledTextColor,
          fontFamily: 'Public Sans',
        },
      },
    },
    yaxis: {
      min: undefined,
      max: undefined,
      forceNiceScale: true,
      labels: {
        formatter: val => Math.abs(val),
        style: {
          fontSize: '13px',
          colors: disabledTextColor,
          fontFamily: 'Public Sans',
        },
      },
      axisBorder: {
        show: true,
        color: borderColor,
      },
      axisTicks: {
        show: true,
        color: borderColor,
      },
    },
    responsive: [
      {
        breakpoint: display.thresholds.value.xl,
        options: {
          plotOptions: { bar: { columnWidth: '43%', borderRadius: 8 } },
        },
      },
      {
        breakpoint: display.thresholds.value.md,
        options: {
          plotOptions: { bar: { columnWidth: '48%', borderRadius: 8 } },
        },
      },
      {
        breakpoint: 420,
        options: {
          plotOptions: { bar: { columnWidth: '55%', borderRadius: 6 } },
        },
      },
    ],
  }
})
</script>

<template>
  <VCard>
    <VCardItem class="pb-0">
      <VCardTitle>Jumlah Penjualan Mingguan</VCardTitle>
    </VCardItem>

    <VCardText class="pb-0">
      <VueApexCharts
        type="bar"
        :height="360"
        :options="chartOptions"
        :series="series"
      />
    </VCardText>
  </VCard>
</template>

<style lang="scss">
@use "@core-scss/template/libs/apex-chart.scss";
</style>
