<script setup>
import illustrationJohnDark from '@images/cards/illustration-john-dark.png';
import illustrationJohnLight from '@images/cards/illustration-john-light.png';
import { ref } from "vue";
import { useTheme } from 'vuetify';

const { global } = useTheme()
const illustrationJohn = computed(() => global.name.value === 'dark' ? illustrationJohnDark : illustrationJohnLight)
let userName = ref('')


userName = (JSON.parse(localStorage.getItem('userData')).name)

</script>

<template>
  <VCard class="text-center text-sm-start">
    <VRow no-gutters>
      <VCol
        cols="12"
        sm="8"
        order="2"
        order-sm="1"
      >
        <VCardItem class="pb-3">
          <VCardTitle class="text-primary">
            Selamat Datang Kembali {{userName}} 🎉
          </VCardTitle>
        </VCardItem>

        <VCardText>
          Kinerja penjualanmu hari ini semakin baik!
          <br>
          Lihat performa mu di laporan penjualan.
          <br>
          <div class="mt-6" style="height: 38px;"></div>
         
        </VCardText>
      </VCol>

      <VCol
        cols="12"
        sm="4"
        order="1"
        order-sm="2"
        class="text-center"
      >
        <img
          :src="illustrationJohn"
          :height="$vuetify.display.xs ? '150' : '182'"
          :class="$vuetify.display.xs ? 'mt-6 mb-n2' : 'position-absolute'"
          class="john-illustration flip-in-rtl"
        >
      </VCol>
    </VRow>
  </VCard>
</template>

<style lang="scss" scoped>
.john-illustration {
  inset-block-end: -0.125rem;
  inset-inline-end: 3.5rem;
}
</style>
