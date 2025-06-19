
<template>
    <h1>
        Data Transaksi
    </h1>
    
    <SidebarForm ref="SidebarForm" :data="sidebarData" :from="from"/>
    <SidebarDetail ref="SidebarDetail" :data="sidebarData" :from="from"/>
    <div>
        <VRow class="ms-2 mt-2 me-2 mb-2">
            <VCol cols="12" md="8">
            <VBtn
                rounded="pill" 
                @click="addNewData()"
                color="primary"
            >
                <VIcon start icon="bx-plus-circle" /> Tambah
            </VBtn>
            </VCol>
    
            <VCol cols="12" md="4">
            <VCard>
                <VTextField
                id="search"
                v-model="search"
                placeholder="Search"
                persistent-placeholder
                prepend-inner-icon="bx-search"
                />
            </VCard>
            </VCol>
        </VRow>

        <!-- Menggunakan CustomTable -->
        <CustomTable
            :data="datas"
            :headers="headers"
            :search="search"
        >
            <template #item.no="{ index }">
                <span>{{ index + 1 }}</span>
            </template>
            <template #item.created_at="{ item }">
                <span>{{ item.created_at ? formatTanggal(item.created_at) : '-' }}</span>
            </template>
            <template #item.delivery_date="{ item }">
                <span>{{ item.delivery_date ? formatTanggal(item.delivery_date) : '-' }}</span>
            </template>
            <template #item.customer="{ item }">
                <span>{{ item.customer ? item.customer.name : '-' }}</span>
            </template>
            <template #item.delivery="{ item }" width="5%">
                <span>{{ item.customer ? item.customer.nama_kab + ', kec. ' + item.customer.nama_kec + ', ' + item.customer.address + (item.customer.mark? ', '+item.customer.mark:'') : '-' }}</span>
            </template>
            <template #item.product="{ item }">
                <ul>
                    <li v-for="(pkg, pkgIndex) in item.packages" :key="pkgIndex" class="mb-2">
                    <strong>{{ pkg.kemasan?.nama || '-' }}</strong>
                    <ul class="ms-4 mt-1">
                        <li v-for="(prod, prodIdx) in pkg.products" :key="prodIdx">
                        {{ prod.product_name }} - {{ prod.category }}
                        </li>
                    </ul>
                    </li>
                </ul>
            </template>

            <template #item.qty="{ item }">
                <ul>
                    <li v-for="(pkg, pkgIndex) in item.packages" :key="pkgIndex" class="mb-2">
                    <strong>{{ pkg.kemasan?.nama || '-' }}</strong>
                    <ul class="ms-4 mt-1">
                        <li v-for="(prod, prodIdx) in pkg.products" :key="prodIdx">
                        {{ prod.jumlah }}
                        </li>
                    </ul>
                    </li>
                </ul>
            </template>
          
            <template #item.payment_status="{ item }">
                <div
                    :style="{
                    backgroundColor: item.payment_status === 'Paid' ? '#16a34a' : '#dc2626', // hijau/merah
                    color: 'white',
                    padding: '4px 8px',
                    borderRadius: '4px',
                    fontSize: '13px',
                    display: 'inline-block',
                    minWidth: '60px',
                    textAlign: 'center',
                    }"
                >
                    {{ item.payment_status ?? '-' }}
                </div>
            </template>
            <template #item.packStatus="{ item }">
                <div
                    :style="{
                    backgroundColor: item.packStatus === 'Pack' ? '#16a34a' : '#f59e0b', // hijau/merah
                    color: 'white',
                    padding: '4px 8px',
                    borderRadius: '4px',
                    fontSize: '13px',
                    display: 'inline-block',
                    minWidth: '60px',
                    textAlign: 'center',
                    }"
                >
                    {{ item.packStatus ?? '-' }}
                </div>
            </template>
            <template #item.delivery_status="{ item }">
                <div
                    :style="{
                    backgroundColor: item.delivery_status === 'Pending' ? '#f59e0b' : '#16a34a', // hijau/merah
                    color: 'white',
                    padding: '4px 8px',
                    borderRadius: '4px',
                    fontSize: '13px',
                    display: 'inline-block',
                    minWidth: '60px',
                    textAlign: 'center',
                    }"
                >
                    {{ item.delivery_status ?? '-' }}
                </div>
            </template>

              <template #item.total_price="{ item }">
                <span>{{ formatRupiah(item.total_price) }}</span>
            </template>
            <!-- Actions -->
            <template #item.actions="{ item }">
                <div class="d-flex gap-1">
                <IconBtn @click="detailData(item)">
                    <VIcon icon="bx-file" />
                </IconBtn>
                <IconBtn @click="editData(item)">
                    <VIcon icon="bx-edit" />
                </IconBtn>
                <IconBtn @click="deleteItem(item.id)" 
                v-if="item.status !='Paid' && item.delivery_status!='Deliver'"
                >
                    <VIcon icon="bx-trash"/>
                </IconBtn>
                </div>
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
import SidebarDetail from './SidebarDetail.vue';
import SidebarForm from './SidebarForm.vue';
// const isLoading = ref(false)
// Import SweetAlert2
import Swal from 'sweetalert2';
import CustomTable from '../../layouts/components/CustomTable.vue';



export default {
    components:{
        SidebarForm,
        SidebarDetail,
        CustomTable
    },
    data(){
        return {
            page: 1,
            itemsPerPage: 10,
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
                title: 'Tanggal',
                key: 'created_at',
            },
            {
                title: 'Customer',
                key: 'customer',
            },
            {
                title: 'Paket',
                key: 'product',
            },
            {
                title: 'Jumlah',
                key: 'qty',
            },
            {
                title: 'Total Harga',
                key: 'total_price',
            },
            {
                title: 'Status Pembayaran',
                key: 'payment_status',
            },
            {
                title: 'Status Pengemasan',
                key: 'packStatus',
            },
            {
                title: 'Status Pengiriman',
                key: 'delivery_status',
            },
         
            {
                title: 'Aksi',
                key: 'actions',
            },
            ],
            search:'',
            isSidebarOpen: false,
            sidebarData: {},
        }
    },
    watch : {
        '$route.query.search'(val) {
            this.search = val;
        }
    },
    computed:{
        
        datas() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.transaction.datas;

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
        async addNewData() {
            this.isLoading = true
            this.sidebarData = {};
            this.from = 'Tambah';

            this.$refs.SidebarForm.toggleDialog();
            this.isLoading = false
        },

        async detailData(data){
            // this.sidebarData = data;
            this.isLoading = true
            this.from = 'Detail';
            this.sidebarData = { ...data };
            
            this.$refs.SidebarDetail.toggleDialog();
            this.isLoading = false
        },

        async editData(data){
            // this.sidebarData = data;
            this.isLoading = true
            this.from = 'Update';
            this.sidebarData = { ...data };
            
            this.$refs.SidebarForm.toggleDialog();
            this.isLoading = false
        },
        closeDialog() {
            this.$refs.SidebarForm.resetForm();  // Panggil reset form
            this.sidebarData = {};  // Reset sidebarData agar data kosong setelah ditutup
        },
        deleteItem(id){
            const formData = new FormData();
            formData.append('id', id);
            // console.log(id)

                Swal.fire({
                    title: 'Delete Data?',
                    text: "Are you sure you want to delete this item!",
                    icon: 'warning',
                    color: 'black',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // console.log("success")
                        this.$store.dispatch("transaction/delete", {id})
                        .then((response) =>{
                            this.notify = true
                            this.status = 'success'
                            this.title = 'Success!'
                            this.text = 'Success delete data'
                            // notify.value.icon = 'alert-cicle'
                            setTimeout(() => {
                                this.notify = false;
                                }, 2000);

                        }) .catch((error) => {
                            console.error('Error saving item:', error);
                            formData.splash = false
                            this.notify = true
                            this.status = 'error'
                            this.title = 'Error!'
                            this.text = error.response.data.message
                            setTimeout(() => {
                                this.notify = false;
                                }, 2000);
                            });
                    }
                })
                
        },
        hidden(){
            this.notify = false
        }
        
    },
    async created() {
        this.isLoading = true
        await this.$store.dispatch("transaction/list")
        await this.$store.dispatch("customer/list")
        await this.$store.dispatch("product/list")
        // await this.$store.dispatch("packaging/list")
        await this.$store.dispatch("bahanKemasan/stock")
        // Set awal dari query saat halaman dibuka
            if (this.$route.query.search) {
            this.search = this.$route.query.search;
            }
        this.isLoading = false
    },
}
</script>
