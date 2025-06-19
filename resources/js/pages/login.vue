<script setup>
import logoutama from '@images/logoutama.png';
import authV1BottomShape from '@images/svg/auth-v1-bottom-shape.svg?url';
import authV1TopShape from '@images/svg/auth-v1-top-shape.svg?url';
import { ref } from "vue";
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';
// Inject global function
// const showNotification = inject('showNotification');



const store = useStore();
const router = useRouter();



const form = ref({
  email: '',
  password: '',
  remember: false,
  
})
const notify = ref({
  notify: false,
  status: '',
  duration: 2000,
  title: '',
  text: '',
  icon:'',
  splash:false,
})


const isPasswordVisible = ref(false)

function LoginFunc() {
  // formData.splash = true;
  notify.value.splash =true
  store.dispatch('auth/store', form.value)
    .then((response) => {
      // console.log(response.data)
      const token = response.data.token;
      localStorage.setItem('authToken', token);
      // router.push({ name: 'Dashboard' });
      router.push('/dashboard')
      // formData.splash = false
      notify.value.splash =false

      notify.value.notify = true
      notify.value.status = 'success'
      notify.value.title = 'Success!'
      notify.value.text = 'Login Success'
      // notify.value.icon = 'alert-cicle'
      setTimeout(() => {
        notify.value.notify = false;
        }, 2000);
      })
      // console.log(notify.value.notify)
    .catch((error) => {
      console.error('Error saving item:', error);
      // formData.splash = false
      notify.value.splash =false

      notify.value.notify = true
      notify.value.status = 'error'
      notify.value.title = 'Error!'
      notify.value.text = error.response.data.message
      setTimeout(() => {
        notify.value.notify = false;
        }, 2000);
      // console.log(notify.notify)

      })
}

function hidden(){
  notify.value.notify = false
}
</script>

<template>
  <Splash v-if="notify.splash" style="z-index: 100;"/>
  <div class="auth-wrapper d-flex align-center justify-center pa-4">
    <div class="position-relative my-sm-16">
     
      <VImg
        :src="authV1TopShape"
        class="text-primary auth-v1-top-shape d-none d-sm-block"
      />

      
      <VImg
        :src="authV1BottomShape"
        class="text-primary auth-v1-bottom-shape d-none d-sm-block"
      />

      
      <VCard
        class="auth-card"
        max-width="460"
        :class="$vuetify.display.smAndUp ? 'pa-6' : 'pa-0'"
      >
        <VCardItem class="justify-center">
          <RouterLink
            to="/"
            class="app-logo"
          >
          <div class="illustrator-img">
            <VImg
              :src="logoutama"
              :width="180"
            />
          </div>
          <!-- <VAvatar
            class="cursor-pointer"
            color="primary"
            variant="tonal" 
            size="80"
          >
            <VImg :src="logoutama" />
          </VAvatar> -->
            <!-- <h1 class="app-logo-title">
              CMS
            </h1> -->
          </RouterLink>
        </VCardItem>

        <VCardText>
          <h4 class="text-h4 mb-1">
            Selamat Datang di Baso Gilang Apps 👋🏻
          </h4>
          <p class="mb-0">
            Silahkan Login untuk masuk ke aplikasi
          </p>
        </VCardText>

        <VCardText>
          <VForm  @submit.prevent="LoginFunc()">
            <VRow>
              
              <VCol cols="12">
                <VTextField
                  v-model="form.email"
                  autofocus
                  label="Email atau Username"
                  type="text"
                  placeholder="Email atau Username"
                />
              </VCol>

              
              <VCol cols="12">
                <VTextField
                  v-model="form.password"
                  label="Password"
                  placeholder="············"
                  :type="isPasswordVisible ? 'text' : 'password'"
                  :append-inner-icon="isPasswordVisible ? 'bx-hide' : 'bx-show'"
                  @click:append-inner="isPasswordVisible = !isPasswordVisible"
                />

                
                <div class="d-flex align-center justify-space-between flex-wrap my-6">
                  <VCheckbox
                    v-model="form.remember"
                    label="Ingat saya"
                  />

                  <a
                    class="text-primary"
                    href="javascript:void(0)"
                  >
                    Lupa Password?
                  </a>
                </div>

                
                <VBtn
                  block
                  type="submit"
                >
                  Login
                </VBtn>
              </VCol>

              
              <!-- <VCol
                cols="12"
                class="text-body-1 text-center"
              >
                <span class="d-inline-block">
                  New on our platform?
                </span>
                <RouterLink
                  class="text-primary ms-1 d-inline-block text-body-1"
                  to="/register"
                >
                  Create an account
                </RouterLink>
              </VCol> -->

              <!-- <VCol
                cols="12"
                class="d-flex align-center"
              >
                <VDivider />
                <span class="mx-4 text-high-emphasis">or</span>
                <VDivider />
              </VCol>

              
              <VCol
                cols="12"
                class="text-center"
              >
                <AuthProvider />
              </VCol> -->
            </VRow>
          </VForm>
        </VCardText>
      </VCard>
    </div>
  </div>
  <CustomNotification 
  v-if="notify.notify"
  :status="notify.status" 
  :duration="notify.duration" 
  :title="notify.title" 
  :text="notify.text" 
  :icon="notify.icon"
  style="z-index: 99;"
  @click="hidden()"
/>


</template>



<style lang="scss">
@use "@core-scss/template/pages/page-auth.scss";
</style>
