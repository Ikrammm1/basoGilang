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
    <div>
       <VRow class="ms-2 mt-2 me-2 mb-2">
        <VCol cols="8" md="8">
          <h2>Bahan Baku</h2>
        </VCol>

        <VCol cols="4" md="4" class="d-flex justify-end align-center">
          <RouterLink to="/items/bahan-baku/restock">
            <VBtn
              rounded="pill"
              color="primary"
            >
              <VIcon start icon="bx-plus-circle" /> 
              <span class="d-none d-sm-inline">Restock</span>
            </VBtn>
          </RouterLink>
        </VCol>
      </VRow>

        <!-- Menggunakan CustomTable -->
        <CustomTable
            :data="datas"
            :headers="headers"
            :search="search"
            :items="[3, 5, 10, 25]"
            :itemsPerPage="itemsPerPage"
            @update:itemsPerPage="val => itemsPerPage = val"
        >
            <template #item.no="{ index }">
                <span>{{ index + 1 }}</span>
            </template>
            <template #item.nama_bahan="{ item }">
                <span>{{ item.nama_bahan ? item.nama_bahan : '-' }}</span>
            </template>
            <!-- <template #item.vendor="{ item }">
                <span>{{ item.vendor ? item.vendor.name : '-' }}</span>
            </template> -->
            <template #item.harga_satuan="{ item }">
                <span>{{ formatRupiah(item.harga_satuan) }}</span>
            </template>
          

        </CustomTable>
    </div>

  <!-- <Loading ref="loading"/> -->
  <VDialog
    v-model="isLoading"
    width="300"
  >
    <VCard
      color="primary"
      width="300"
    >
      <VCardText class="pt-3 text-white">
        Please stand by
        <VProgressLinear
          indeterminate
          bg-color="rgba(var(--v-theme-surface), 0.1)"
          color="#fff"
          class="mb-0 mt-4"
        />
      </VCardText>
    </VCard>
  </VDialog>
  <CustomNotification 
  v-if="notify"
  :status="status" 
  :duration="duration" 
  :title="title" 
  :text="text" 
  :icon="icon"
  style="z-index: 99;"
  @click="hidden()"
/>
</template>

<script>
// const isLoading = ref(false)
// Import SweetAlert2
import CustomTable from '../../layouts/components/CustomTable.vue';



export default {
    components:{
        CustomTable
    },
    data(){
        return {
            page: 1,
            itemsPerPage: 3,
            sortBy: [''],
            sortDesc: [false],
            isLoading : false,
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            splash:false,
            from : '',
            headers : [
            {
                title: 'No',
                key: 'no',
            },
            {
                title: 'Nama Bahan',
                key: 'nama_bahan',
            },
            // {
            //     title: 'Merk / Vendor',
            //     key: 'vendor',
            // },
            {
                title: 'Satuan',
                key: 'satuan',
            },
            {
                title: 'Satuan',
                key: 'harga_satuan',
            },
            {
                title: 'Sisa Stock',
                key: 'total_qty',
            },
            ],
            search:'',
        }
    },
    watch : {
        
    },
    computed:{
        
        datas() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.bahanBaku.needRestocks;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
              return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },

       
       
    },
  
    methods:{
        formatTanggal(datetime) {
            if (!datetime) return '-';

            const options = {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            };

            return new Date(datetime).toLocaleDateString('id-ID', options);
        },
        formatRupiah(value) {
            if (typeof value !== "number") {
            value = Number(value);
            }
            return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR",
            minimumFractionDigits: 0
            }).format(value);
        },
      
        closeDialog() {
            this.$refs.SidebarForm.resetForm();  // Panggil reset form
            this.sidebarData = {};  // Reset sidebarData agar data kosong setelah ditutup
        },
        hidden(){
            this.notify = false
        }
        
    },
    // async created() {
    //     this.isLoading = true
    //     await this.$store.dispatch("bahanBaku/needRestock")
    //     // this.$refs.table
    //     this.isLoading = false
    // },
}
</script>


<style lang="scss" scoped>
.john-illustration {
  inset-block-end: -0.125rem;
  inset-inline-end: 3.5rem;
}
</style>


<style lang="scss" scoped>
.john-illustration {
  inset-block-end: -0.125rem;
  inset-inline-end: 3.5rem;
}
</style>
