<!-- components/FeatherIcon.vue -->
<template>
  <span v-html="svgIcon" :class="customClass"></span>
</template>

<script>
import feather from 'feather-icons';

export default {
  props: {
    icon: {
      type: String, 
      required: true
    },
    customClass: {
      type: String,
      default: ''
    }
  },
  computed: {
    svgIcon() {
      // Menggunakan Feather Icons untuk mendapatkan SVG dari nama ikon
      const icon = feather.icons[this.icon];
      if (icon) {
        return icon.toSvg();
      } else {
        console.warn(`Icon "${this.icon}" tidak ditemukan di Feather Icons.`);
        return '';
      }
    }
  }
};
</script>

<style scoped>
/* Tambahkan styling global jika diperlukan */
</style>
