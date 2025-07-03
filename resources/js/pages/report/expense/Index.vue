
<template>
    <h1>
        Laporan Pengeluaran
    </h1>
    
    <div id="filter" class="mt-3" >
        <VCard title="Filter Laporan">
            <VRow class=" ml-3 mr-3 mb-2">
                <VCol cols="12" md="6">
                    <label>Filter Berdasarkan</label>
                    <VSelect
                        v-model="jenisFilter"
                        :items="filterList"
                        placeholder="Pilih Filter"
                        persistent-placeholder
                        item-title="name"
                        item-value="id"
                        class="mt-2"
                    />
                </VCol>
                <VCol cols="12" md="6">
                <VRow class="ml-3 mr-3 mb-5" v-if="jenisFilter == '1'">
                <VCol cols="12">
                    <label>Tahun</label>
                     <VSelect
                        v-model="tahun"
                        :items="listTahun"
                        placeholder="Pilih Tahun"
                        persistent-placeholder
                        item-title="label"
                        item-value="value"
                        class="mt-2"
                    />
                </VCol>
            </VRow>
            <VRow class="ml-3 mr-3 mb-5s" v-if="jenisFilter == '2'">
                <VCol cols="12">
                    <label>Bulan</label>
                     <VSelect
                        v-model="bulan"
                        :items="listBulan"
                        placeholder="Pilih Bulan"
                        persistent-placeholder
                        item-title="label"
                        item-value="value"
                        class="mt-2"
                    />
                </VCol>
            </VRow>
            <VRow class="ml-3 mr-3 mb-5s" v-if="jenisFilter == '3'">
                <VCol cols="12" md="6">
                    <label>Tanggal Awal</label>
                    <VTextField
                        v-model="startDate"
                        placeholder="Pilih Tanggal"
                        persistent-placeholder
                        type="date"
                        class="mt-2"
                    />
                </VCol>
                <VCol cols="12" md="6">
                    <label>Tanggal Akhir</label>
                    <VTextField
                        v-model="endDate"
                        placeholder="Pilih Tanggal"
                        persistent-placeholder
                        type="date"
                        class="mt-2"
                    />
                </VCol>
            </VRow>
                </VCol>
                
            </VRow>

            <VRow class="ml-5 mb-6">
                <VBtn
                class="mr-3"
                    color="secondary"
                    variant="tonal"
                    type="reset"
                    @click="resetForm"
                    >
                    Reset
                </VBtn>
                <VBtn type="submit" @click="submitForm">
                    Submit
                </VBtn>
            </VRow>
        </VCard>
        
    </div>

    <div v-if="expenses.length!=0">
        <VRow class="mt-5 mb-3 ml-3">
            <h2>
                Total Pengeluaran : {{ totalExpensePrice }}
            </h2>
        </VRow>
        <VRow class="ms-2 mt-2 me-2 mb-2">
             <VCol cols="12" md="8">
            <VBtn
                rounded="pill" 
                @click="exportExpensesToExcel()"
                color="primary"
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
            :data="expenses"
            :headers="headerSales"
            :search="search"
        >
            <template #item.no="{ index }">
                <span>{{ index + 1 }}</span>
            </template>
              <template #item.inDate="{ item }">
                <span>{{ formatTanggal(item.inDate) }}</span>
            </template>
              <template #item.total_harga="{ item }">
                <span>{{ formatRupiah(item.total_harga) }}</span>
            </template>
            <!-- Actions -->
           

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
import * as XLSX from 'xlsx';
import CustomTable from '../../../layouts/components/CustomTable.vue';


export default {
    components:{
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

            jenisReport:null,
            startDate:null,
            endDate:null,
            jenisFilter:null,
            tahun:null,
            bulan:null,
            formData : new FormData(),


            headerSales : [
                    {
                        title: 'No',
                        key: 'no',
                    },
                    {
                        title: 'Tanggal',
                        key: 'inDate',
                    },
                    {
                        title: 'Jenis',
                        key: 'jenis',
                    },
                    {
                        title: 'Nama Pengeluaran',
                        key: 'bahan_name',
                    },
                    {
                        title: 'Kategori Pengeluaran',
                        key: 'category',
                    },
                    {
                        title: 'Jumlah',
                        key: 'jumlah',
                    },
                    {
                        title: 'Total Harga',
                        key: 'total_harga',
                    },
                ],
            search:'',
        }
    },
    watch : {
        '$route.query.search'(val) {
            this.search = val;
        }

    },
    computed:{
        
        expenses() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.report.expenses;

            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },

        totalExpensePrice() {
            const result = this.expenses.reduce((sum, item) => {
            const value = parseFloat(item.total_harga);
            return sum + (isNaN(value) ? 0 : value);
            }, 0);
            return this.formatRupiah(result) 
        },
        jenisList(){
            return ([{'id' :1,'name':'Penjualan Produk'},{'id' :2,'name':'Penjualan Customer'}])
        },
        filterList(){
            return ([{'id' :1,'name':'Per Tahun'},{'id' :2,'name':'Per Bulan'},{'id' :3,'name':'Per Tanggal'},{'id' :4,'name':'Hari Ini'}])
        },
        listTahun() {
            const currentYear = new Date().getFullYear()
            const years = []
            for (let year = 2020; year <= currentYear; year++) {
            years.unshift({ value: year, label: `${year}` })
            }
            return years
        },
        listBulan() {
            const bulanIndo = [
            'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
            'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
            ];
            return bulanIndo.map((nama, index) => ({
            value: index + 1, // 1 = Januari, dst
            label: nama
            }));
        }

       
       
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

        resetForm(){
            this.jenisReport = null,
            this.startDate =null,
            this.endDate= null,
            this.tahun=null,
            this.bulan=null

             const data = ''
            this.$store.dispatch("report/getExpenses", { data })
            this.totalExpensePrice = 0
        },
        
        submitForm(){
           
            const formData = new FormData();

            formData.append('jenisFilter', this.jenisFilter);
            // formData.append('name', this.name);

            if(this.jenisFilter =='1'){
                formData.append('tahun', this.tahun);
            }else if(this.jenisFilter =='2'){
                formData.append('bulan', this.bulan);
            }else if(this.jenisFilter =='3'){
                formData.append('startDate', this.startDate);
                formData.append('endDate', this.endDate);
            }else{
                formData.append('date',  new Date());
                
            }
            this.isLoading = true
             this.$store.dispatch("report/getExpenses", { formData })
                .then((response) => {
                    console.log(response.length)
                    if(response.length == 0){
                        this.isLoading = false
                        this.notify = true
                        this.status = 'warning'
                        this.title = 'Data kosong'
                        this.text = 'Data tidak ditemukan/kosong'
                        setTimeout(() => {
                            this.notify = false;
                        }, 2000);
                    }else{
                            this.notify = true
                            this.status = 'success'
                            this.title = 'Success!'
                            this.text = "Success"
                            // notify.value.icon = 'alert-cicle'
                            this.isLoading = false
                            setTimeout(() => {
                                this.notify = false;
                            }, 2000);
                    }
               

            }).catch((err) => {
                console.error('Error saving item:', err);
                this.isLoading = false
                this.notify = true
                this.status = 'error'
                this.title = 'Error!'
                this.text = err.response.data.message
                setTimeout(() => {
                    this.notify = false;
                }, 2000);

            });
        },

        exportExpensesToExcel() {
            const rawData = this.expenses;

            if (!Array.isArray(rawData) || rawData.length === 0) {
                alert('Tidak ada data untuk diexport!');
                return;
            }

            // 1. Format dan map data biar rapi
            const data = rawData.map(item => ({
                'Tanggal': item.inDate,
                'Jenis': item.jenis,
                'Nama Bahan': item.bahan_name,
                'Jumlah': item.jumlah,
                'Satuan': item.satuan,
                'Total Harga (Rp)': this.formatRupiah(item.total_harga),
                'Vendor': item.vendor_name || '-'  // fallback jika null
            }));
            data.push({
                 'Tanggal': '',
                'Jenis': '',
                'Nama Bahan': '',
                'Jumlah': '',
                'Satuan': 'TOTAL',
                'Total Harga (Rp)': this.totalExpensePrice,
                'Vendor': ''  // fallback jika null
            });

            // 2. Buat worksheet dan workbook
            const worksheet = XLSX.utils.json_to_sheet(data);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Laporan');

            // 3. Lebar kolom otomatis
            const maxWidths = Object.keys(data[0]).map((key) => {
                const max = Math.max(
                key.length,
                ...data.map((item) => String(item[key] ?? '').length)
                );
                return { wch: max + 4 };
            });
            worksheet['!cols'] = maxWidths;

            // 4. Simpan file
            const filename = `Laporan-pengeluaran-${new Date().toISOString().slice(0, 10)}.xlsx`;
            XLSX.writeFile(workbook, filename);
        },

      
        hidden(){
            this.notify = false
        }
        
    },
    async created() {
        this.isLoading = true
        // await this.$store.dispatch("transaction/list")
        // await this.$store.dispatch("customer/list")
        // await this.$store.dispatch("product/list")
        // await this.$store.dispatch("packaging/list")
        // await this.$store.dispatch("bahanKemasan/stock")
        // Set awal dari query saat halaman dibuka
            if (this.$route.query.search) {
            this.search = this.$route.query.search;
            }
            const data = ''
            this.$store.dispatch("report/getExpenses", { data })
        this.isLoading = false
    },
}
</script>
