<script setup>
import statsVerticalWallet from '@images/cards/wallet-primary.png'
import { hexToRgb } from '@layouts/utils'
import { computed, onMounted } from 'vue'
import { useTheme } from 'vuetify'
import { useStore } from 'vuex'

const vuetifyTheme = useTheme()
const store = useStore()

onMounted(() => {
  store.dispatch('transaction/fetchWeeklyIncomeStats')
})
const formatRupiah = value => {
  if (typeof value !== "number") value = Number(value)
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0
  }).format(value)
}
const chartSeries = computed(() => store.state.transaction.weeklyIncomeSeries)
const stats = computed(() => store.state.transaction.weeklyIncomeStats)

const chartOptions = computed(() => {
  const theme = vuetifyTheme.current.value.colors
  const variables = vuetifyTheme.current.value.variables

  return {
    chart: { parentHeightOffset: 0, toolbar: { show: false }},
    dataLabels: { enabled: false },
    stroke: { width: 3, curve: 'smooth' },
    grid: {
      strokeDashArray: 4.5,
      borderColor: `rgba(${ hexToRgb(variables['border-color']) },${ variables['border-opacity'] })`,
      padding: { left: 0, top: -20, right: 11, bottom: 7 },
    },
    fill: {
      type: 'gradient',
      gradient: {
        opacityTo: 0.25,
        opacityFrom: 0.5,
        stops: [0, 95, 100],
        shadeIntensity: 0.6,
        colorStops: [[
          { offset: 0, opacity: 0.4, color: theme.primary },
          { offset: 100, opacity: 0.2, color: theme.surface },
        ]],
      },
    },
    xaxis: {
      categories: chartSeries.value[0]?.data.map((_, i) => `Week ${i + 1}`),
      offsetY: 20,
      offsetX: -24,
      axisTicks: { show: false },
      axisBorder: { show: false },
      labels: {
        style: {
          fontSize: '14px',
          colors: `rgba(${ hexToRgb(theme['on-surface']) },${ variables['disabled-opacity'] })`,
          fontFamily: 'Public Sans',
        },
      },
    },
    yaxis: { show: false, min: 0 },
    markers: {
      size: 8,
      strokeWidth: 6,
      strokeOpacity: 1,
      offsetX: -10,
      hover: { size: 8 },
      colors: ['transparent'],
      strokeColors: 'transparent',
      discrete: [{
        size: 8,
        seriesIndex: 0,
        fillColor: '#fff',
        strokeColor: theme.primary,
        dataPointIndex: chartSeries.value[0]?.data.length - 1 ?? 0,
      }],
    },
  }
})
</script>

<template>
  <VCard>
    <VCardText class="d-flex align-center gap-3">
      <VAvatar size="48" rounded :image="statsVerticalWallet" />

      <div>
        <p class="mb-0">Total Pemasukan Minggu Ini</p>
        <div class="d-flex align-center gap-2">
          <h6 class="text-h6">{{ formatRupiah(stats.total) }}</h6>
          <span
            class="text-sm"
            :class="stats.percent >= 0 ? 'text-success' : 'text-error'"
          >
            <VIcon :icon="stats.percent >= 0 ? 'bx-chevron-up' : 'bx-chevron-down'" />
            {{ stats.percent }}%
          </span>
        </div>
      </div>
    </VCardText>

    <VCardText>
      <VueApexCharts
        type="area"
        :height="230"
        :options="chartOptions"
        :series="chartSeries"
      />
    </VCardText>

    <VCardText class="d-flex align-center justify-center pt-2 gap-4">
      <!-- <VProgressCircular size="45" color="primary" :model-value="Math.abs(stats.percent)">
        <span class="text-overline text-medium-emphasis">${{ stats.amount }}</span>
      </VProgressCircular> -->

      <div>
        <h6 class="text-base font-weight-regular text-center">
          Minggu ini
        </h6>
        <span class="text-sm d-inline-block">
          {{ formatRupiah(stats.amount) }} {{ stats.percent >= 0 ? 'lebih' : 'kurang' }} dari minggu lalu ({{ formatRupiah(stats.lastWeek) }})
        </span>
      </div>
    </VCardText>
  </VCard>
</template>
