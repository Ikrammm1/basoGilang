<template>
    <!-- <transition name="fade"> -->
        <div class="notification-container">
            <VCard 
            v-if="visible"
            :color="statusClass"
            style="z-index: 9999;">
                <VCardItem>
                <template #prepend>
                    <FeatherIcon
                    size="1.9rem"
                    color="white"
                    :icon="iconClass"
                    class="mr-2"
                    />
                </template>
                <VCardTitle class="text-white">
                    {{ title }}
                </VCardTitle>
                <!-- <VCardText> -->
                <p class="clamp-text text-white mb-0">
                    {{ text }}
                </p>
                <!-- </VCardText> -->
                </VCardItem>

                

            </VCard>
        </div>
        
      <!-- </div> -->
    <!-- </transition> -->
  </template>
  
  <script>
  import FeatherIcon from './FeatherIcon.vue';
  export default {
    props: {
      status: {
        type: String,
        default: 'info', // 'success', 'error', 'warning', 'info'
      },
      duration: {
        type: Number,
        default: 2000, // Durasi tampil dalam milidetik
      },
      title: {
        type: String,
        default: '',
      },
      text: {
        type: String,
        default: '',
      },
      icon: {
        type: String,
        default: '', // Nama kelas ikon atau ikon dari library yang digunakan
      },
    },
    data() {
      return {
        visible: false,
      };
    },
    components: {
        FeatherIcon,
    },
    computed: {
      statusClass() {
        switch (this.status) {
          case 'success':
            return '#3cb371';
          case 'error':
            return '#ff4040';
          case 'warning':
            return '#ffa500';
          case 'info':
          default:
            return '#16B1FF';
        }
      },
      iconClass() {
        switch (this.status) {
          case 'success':
            return 'check-circle';
          case 'error':
            return 'alert-circle';
          case 'warning':
            return 'alert-circle';
          case 'info':
            return 'info'
          default:
            return '#16B1FF';
        }
        return this.icon;
      },
    },
    methods: {
      show() {
        this.visible = true;
        // setTimeout(() => {
        //   this.visible = false;
        // }, this.duration);
      },
    },
    mounted() {
      this.show();
    },
  };
  </script>
  
  <style scoped>
  .notification {
    max-width: 90%;
    min-width: 300px;
  }
  
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity 0.5s;
  }
  .fade-enter, 
  .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
    opacity: 0;
  }
  .notification-container {
  position: fixed;
  bottom: 20px; /* Jarak dari bawah */
  left: 50%;
  transform: translateX(-50%); /* Pusatkan horizontal */
  width: auto; /* Lebar otomatis sesuai konten */
}
  </style>
  
