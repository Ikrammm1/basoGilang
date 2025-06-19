<script setup>
import Footer from '@/layouts/components/Footer.vue';
import NavbarThemeSwitcher from '@/layouts/components/NavbarThemeSwitcher.vue';
import NavItems from '@/layouts/components/NavItems.vue';
import UserProfile from '@/layouts/components/UserProfile.vue';
import { globalTheme } from '@/themeState';
import VerticalNavLayout from '@layouts/components/VerticalNavLayout.vue';
import { computed, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useTheme } from 'vuetify'; // ✅ tambahkan

const { global: theme } = useTheme() // ✅ ini yang sebelumnya error
const logo = globalTheme.logo
const router = useRouter()

const search = ref('')

const suggestionBgColor = computed(() => {
  return theme.name.value === 'dark' ? '#1e1e1e' : '#ffffff'
})
// Daftar semua item yang bisa dicari
// const items = ref([
//   'Apple',
//   'Banana',
//   'Cherry',
//   'Date',
//   'Elderberry',
//   'Fig',
//   'Grape',
//   'Honeydew',
// ]);
const rawMenus = JSON.parse(localStorage.getItem('userMenus') || '{}')
const userMenus = ref(Array.isArray(rawMenus) ? rawMenus : Object.values(rawMenus))
// console.log(userMenus.value)

const items = ref([])

userMenus.value.forEach(data => {
    
  data.items.forEach(menu => {
      if(menu.submenu.length == 0){
        items.value.push(menu)
        // items.value.push('if')

      }else{
        // items.value.push('else')
        menu.submenu.forEach(sub => {
          items.value.push(sub)
        });
      }
    });
});


// Daftar hasil suggestion berdasarkan input
const suggestions = computed(() => {
  if (!search.value) return []; // Tidak ada hasil jika input kosong
  const men = items.value.filter((item) =>
    item.name.toLowerCase().includes(search.value.toLowerCase())
  ).map((item) => item.name);
  return items.value.filter((item) =>
    item.name.toLowerCase().includes(search.value.toLowerCase())
  ).map((item) => item.name);
});

// Indeks aktif untuk navigasi keyboard
const activeIndex = ref(-1);

// Fungsi untuk menangani navigasi dengan panah atas dan bawah
const navigateSuggestions = (direction) => {
  if (!suggestions.value.length) return;

  if (direction === 'down') {
    activeIndex.value =
      activeIndex.value < suggestions.value.length - 1 ? activeIndex.value + 1 : 0;
  } else if (direction === 'up') {
    activeIndex.value =
      activeIndex.value > 0 ? activeIndex.value - 1 : suggestions.value.length - 1;
  }
};

// Fungsi untuk memilih suggestion yang sedang aktif
const selectActiveSuggestion = () => {
  if (activeIndex.value >= 0 && activeIndex.value < suggestions.value.length) {
    selectSuggestion(suggestions.value[activeIndex.value]);
  }
};

// Fungsi untuk memilih item suggestion
const selectSuggestion = (item) => {
  search.value = ''
  let to = (items.value.find(menu => menu.name == item).url)
  router.push(to)
};

function gotoMenu(menu){
  const to = items.value.find(item => item.name == menu)
  // console.log(to)
}


</script>

<template>
  <VerticalNavLayout>
    <!-- 👉 navbar -->
    <template #navbar="{ toggleVerticalOverlayNavActive }">
      <div class="d-flex h-100 align-center">
        <!-- 👉 Vertical nav toggle in overlay mode -->
        <IconBtn
          class="ms-n3 d-lg-none"
          @click="toggleVerticalOverlayNavActive(true)"
        >
          <VIcon icon="bx-menu" />
        </IconBtn>

       

        <!-- 👉 Search -->
        <div
          class="align-center cursor-pointer"
          style="user-select: none; position: inherit; width: 100%;"
        >
          <div class="row" style="position: relative; width: 100%;">
            <!-- Input Search -->
            <VTextField
              id="search"
              v-model="search"
              placeholder="Search"
              persistent-placeholder
              prepend-inner-icon="bx-search"
              full-width
              @keydown.down="navigateSuggestions('down')"
              @keydown.up="navigateSuggestions('up')"
              @keydown.enter="selectActiveSuggestion"
            />
            <!-- Daftar Suggestion -->
          <VList
              v-if="suggestions.length"
              class="suggestion-list"
               :style="{
                  background: suggestionBgColor,
                  color: theme.name.value === 'dark' ? '#fff' : '#000'
                }"
            >
              <VListItem
                v-for="(item, index) in suggestions"
                :key="index"
                :class="{ 'active-suggestion': activeIndex === index }"
                @click="selectSuggestion(item)"
              >
                {{ item }}
              </VListItem>
            </VList>
          </div>
        </div>
          <!-- 👉 Search Trigger button -->
          <!-- <IconBtn>
            <VIcon icon="bx-search" />
          </IconBtn>

          <span class="d-none d-md-flex align-center text-disabled ms-2">
            <span class="me-2">Search</span>
            <span class="meta-key">&#8984;K</span>
          </span>
        </div>-->

        <VSpacer /> 

        <!-- <IconBtn
          href="https://github.com/Ikrammm1/CMS-Template"
          target="_blank"
          rel="noopener noreferrer"
        >
          <VIcon icon="bxl-github" />
        </IconBtn> -->

        <!-- <IconBtn>
          <VIcon icon="bx-bell" />
        </IconBtn> -->

        <NavbarThemeSwitcher class="me-1" />

        <UserProfile />
      </div>
    </template>

    <template #vertical-nav-header="{ toggleIsOverlayNavActive }">
      <RouterLink
        to="/"
        class="app-logo app-title-wrapper"
      >
        <!-- eslint-enable -->
        <div class="illustrator-img">
            <VImg
              :src="logo"
              :width="180"
              :style="{  borderRadius: '20px'}"
            />
        </div>
        <!-- <h1 class="app-logo-title">
          Baso Gilang
        </h1> -->
      </RouterLink>

      <IconBtn
        class="d-block d-lg-none"
        @click="toggleIsOverlayNavActive(false)"
      >
        <VIcon icon="bx-x" />
      </IconBtn>
    </template>

    <template #vertical-nav-content>
      <NavItems />
    </template>

    <!-- 👉 Pages -->
    <slot />

    <!-- 👉 Footer -->
    <template #footer>
      <Footer />
    </template>
  </VerticalNavLayout>
</template>

<style lang="scss" scoped>
.meta-key {
  border: thin solid rgba(var(--v-border-color), var(--v-border-opacity));
  border-radius: 6px;
  block-size: 1.5625rem;
  line-height: 1.3125rem;
  padding-block: 0.125rem;
  padding-inline: 0.25rem;
}

.app-logo {
  display: flex;
  align-items: center;
  column-gap: 0.75rem;

  .app-logo-title {
    font-size: 1.25rem;
    font-weight: 500;
    line-height: 1.75rem;
    text-transform: uppercase;
  }
}

.suggestion-list {
  max-height: 200px;
  overflow-y: auto;
  border: 1px solid var(--suggestion-border);
  border-radius: 4px;
  box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
  background-color: var(--suggestion-bg);
  color: var(--suggestion-color);
}

.active-suggestion {
  background-color: var(--suggestion-active);
}
:root {
  --suggestion-bg: #ffffff;
  --suggestion-color: #000000;
  --suggestion-border: #ccc;
  --suggestion-active: #e0e0e0;
}

[data-theme="dark"] {
  --suggestion-bg: #1e1e1e;
  --suggestion-color: #ffffff;
  --suggestion-border: #555;
  --suggestion-active: #333;
}

</style>
