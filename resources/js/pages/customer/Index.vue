
<template>
    <h1>
        Management Customer
    </h1>
    <SidebarForm ref="SidebarForm" :data="sidebarData" :from="from"/>
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
             <VBtn
                rounded="pill"
                @click="exportReportToExcel()"
                color="primary"
                variant="outlined"
                class="ml-3"
            >
                <VIcon start icon="bx-arrow-to-bottom" /> Export
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
            <template #item.radius="{ item }">
                <span>{{ item.ongkir? item.ongkir.radius:'-' }}</span>
            </template>
            <template #item.address="{ item }">
                <span>{{ item.address ? item.address : '-' }}</span>
            </template>
            <template #item.mark="{ item }">
                <span>{{ item.mark ? item.mark : '-' }}</span>
            </template>
           
            <!-- Actions -->
            <template #item.actions="{ item }">
                <div class="d-flex gap-1">
                <IconBtn @click="editData(item)">
                    <VIcon icon="bx-edit" />
                </IconBtn>
                <IconBtn @click="deleteItem(item.id)">
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
import SidebarForm from './SidebarForm.vue';
// const isLoading = ref(false)
// Import SweetAlert2
import Swal from 'sweetalert2';
import * as XLSX from 'xlsx';
import CustomTable from '../../layouts/components/CustomTable.vue';




export default {
    components:{
        SidebarForm,
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
                title: 'Nama Customer',
                key: 'name',
            },
            {
                title: 'Kategori',
                key: 'category',
            },
            {
                title: 'No. Telp',
                key: 'telp',
            },
            {
                title: 'Provinsi',
                key: 'prov_name',
            },
            {
                title: 'Kabupaten',
                key: 'kab_name',
            },
            {
                title: 'Kecamatan',
                key: 'kec_name',
            },
            {
                title: 'Alamat Lengkap',
                key: 'address',
            },
            {
                title: 'Patokan',
                key: 'mark',
            },
            {
                title: 'Radius',
                key: 'radius',
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
        
    },
    computed:{
        
        datas() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.customer.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        
       
    },
  
    methods:{
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
            this.sidebarData = {};
            this.from = 'Tambah';
            this.$refs.SidebarForm.toggleDialog();
            await this.$store.dispatch("ongkir/list")
        },
        async editData(data){
            // this.sidebarData = data;
            // console.log(data)
            this.from = 'Update';
            this.sidebarData = { ...data };
            this.$refs.SidebarForm.toggleDialog();
            await this.$store.dispatch("ongkir/list")
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
                        this.$store.dispatch("customer/delete", {id})
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
        },

        exportReportToExcel() {
            const rawData = this.datas;

            if (!Array.isArray(rawData) || rawData.length === 0) {
                alert('Tidak ada data untuk diexport!');
                return;
            }

            let data = [];
                // Customer Terbanyak Order
                data = rawData.map(item => ({
                'Nama Customer': item.name,
                'Kategori': item.category,
                'Telp': item.telp,
                'Provinsi': item.prov_name,
                'Kabupaten': item.kab_name,
                'Kecamatan': item.kec_name,
                'Alamat': item.address,
                'Patokan': item.mark,
                'Radius': item.ongkir.radius,
                'Ongkir': this.formatRupiah(item.ongkir.price),
                }));

            if (data.length === 0) {
                alert('Data tidak valid untuk diexport!');
                return;
            }

            // 1. Buat worksheet dan workbook
            const worksheet = XLSX.utils.json_to_sheet(data);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Customer');

            // 2. Lebar kolom otomatis
            worksheet['!cols'] = Object.keys(data[0]).map((key, i) => {
                const max = Math.max(
                key.length,
                ...data.map(item => String(item[key] ?? '').length)
                );
                return { wch: max + 4 };
            });

            // 3. Simpan file
            const fileName = `Data-Customer-${new Date().toISOString().slice(0, 10)}.xlsx`
            XLSX.writeFile(workbook, fileName);
        }
        
    },
    async created() {
        this.isLoading = true
        await this.$store.dispatch("customer/list")
        await this.$store.dispatch("customer/getProv")
        // await this.$store.dispatch("customer/getKab")
        // this.$refs.table
        this.isLoading = false
    },
}
</script>
