<template>
  <Splash v-if="notify.splash" style="z-index: 100;"/>
  <div>
    <VBadge
      dot
      location="bottom right"
      offset-x="3"
      offset-y="3"
      color="success"
      bordered
    >
      <VAvatar
        class="cursor-pointer"
        color="primary"
        variant="tonal"
      >
        <VImg :src="photo ? '/images/avatars/'+photo : avatar" />

        <!-- SECTION Menu -->
        <VMenu
          activator="parent"
          width="230"
          location="bottom end"
          offset="14px"
        >
          <VList>
            <!-- 👉 User Avatar & Name -->
            <VListItem>
              <template #prepend>
                <VListItemAction start>
                  <VBadge
                    dot
                    location="bottom right"
                    offset-x="3"
                    offset-y="3"
                    color="success"
                  >
                    <VAvatar
                      color="primary"
                      variant="tonal"
                    >
                    <VImg :src="photo ? '/images/avatars/'+photo : avatar" />
                    </VAvatar>
                  </VBadge>
                </VListItemAction>
              </template>

              <VListItemTitle class="font-weight-semibold">
                <span>
                  {{ userName }}
                </span>
              </VListItemTitle>
              <VListItemSubtitle>{{ position }}</VListItemSubtitle>
            </VListItem>
            <VDivider class="my-2" />

            <!-- 👉 Profile -->
            <VListItem link>
              <template #prepend>
                <VIcon
                  class="me-2"
                  icon="bx-user"
                  size="22"
                />
              </template>

              <VListItemTitle @click.stop="profile">Profile</VListItemTitle>
            </VListItem>

            <!-- 👉 Settings -->
            <VListItem link>
              <template #prepend>
                <VIcon
                  class="me-2"
                  icon="bx-cog"
                  size="22"
                />
              </template>

              <VListItemTitle>Settings</VListItemTitle>
            </VListItem>

            <!-- 👉 FAQ -->
            <VListItem link>
              <template #prepend>
                <VIcon
                  class="me-2"
                  icon="bx-help-circle"
                  size="22"
                />
              </template>

              <VListItemTitle>FAQ</VListItemTitle>
            </VListItem>

            <!-- Divider -->
            <VDivider class="my-2" />

            <!-- 👉 Logout -->
            <VListItem link>
              <template #prepend>
                <VIcon
                  class="me-2"
                  icon="bx-log-out"
                  size="22"
                />
              </template>
              <div @click.stop="logout">
                <VListItemTitle>Logout</VListItemTitle>
              </div>
            </VListItem>
          </VList>
        </VMenu>
        <!-- !SECTION -->
      </VAvatar>
    </VBadge>
  </div>

</template>

<script setup>
import avatar from '@images/avatars/defaultAvatar.png';
import Swal from 'sweetalert2';
import { ref } from "vue";
import { useRouter } from 'vue-router';


const router = useRouter();
const notify = ref({
  splash:false,
})
let userName = ref('')
let position = ref('')
let photo = ref('')

userName = (JSON.parse(localStorage.getItem('userData')).name)
photo = (JSON.parse(localStorage.getItem('userData')).photo)
position = (JSON.parse(localStorage.getItem('userData')).user_position[0].mp_name)

function logout() {
  try {
        Swal.fire({
        title: 'Logout?',
        text: "Are you sure you want to logout!",
        icon: 'warning',
        color: 'black',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Logout!',
      
    }).then((result) => {
        if (result.isConfirmed) {
          // Hapus token autentikasi dari localStorage
          notify.value.splash =true
          ToLogin()
        }
      }).catch((error) => {
            console.error('Error saving item:', error);
            formData.splash = false
            });
   
  } catch (error) {
    console.error('Error during logout:', error);
  }
  notify.value.splash =false
}

function ToLogin(){
  localStorage.removeItem('authToken');

  // Hapus daftar menu pengguna dari localStorage
  localStorage.removeItem('userData');
  localStorage.removeItem('userMenus');

  // Redirect ke halaman login
  router.push('/login');
}

let idleTimer;

function resetIdleTimer() {
    // Jika ada timer berjalan, reset
    if (idleTimer) clearTimeout(idleTimer);

    // Set timer untuk logout setelah 30 menit (1800000 ms)
    idleTimer = setTimeout(() => {
      ToLogin(); // Panggil fungsi logout
    }, 30 * 60 * 1000); // 30 menits
}

// Deteksi aktivitas pengguna
['mousemove', 'keydown', 'click', 'scroll', 'touchstart'].forEach(event => {
    window.addEventListener(event, resetIdleTimer);
});

// Mulai timer ketika halaman dimuat
resetIdleTimer();


function profile(){
  router.push('/profile');
}

</script>

<style scoped>
.cursor-pointer {
  cursor: pointer;
}

.swal2-confirm {
    color: white !important; /* Pastikan teks tombol confirm putih */
}

.swal2-cancel {
    color: white !important; /* Pastikan teks tombol cancel putih */
}
</style>
