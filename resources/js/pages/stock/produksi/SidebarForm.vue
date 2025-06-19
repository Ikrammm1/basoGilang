
<template>
    <VDialog
        v-model= "isDialogVisible"
        max-width="700"
    >
    
        <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
    
        <!-- Dialog Content -->
        <VCard :title="'Form ' + from">    
            <VForm @submit.prevent="() => {}">
                <VCardText>
                    <VRow class="mb-2">
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="name" >Produk</label>
                                    <VSelect
                                        v-model="selectedProduk"
                                        :items="productList"
                                        placeholder="Pilih Satuan"
                                        persistent-placeholder
                                        item-title="name"
                                        item-value="id"
                                        class="mt-2"
                                        
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="qty" >Qty</label>

                                     <VTextField
                                        id="qty"
                                        v-model="qty"
                                        type="number"
                                        placeholder="qty"
                                        class="mt-2"
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="satuanProduk" >Satuan</label>

                                     <VTextField
                                        id="satuanProduk"
                                        v-model="satuanProduk"
                                        placeholder="Satuan"
                                        class="mt-2"
                                        :disabled=true
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="totalHarga" >Total Harga</label>

                                     <VTextField
                                        id="totalHarga"
                                        v-model="totalHarga"
                                        placeholder="Total Harga"
                                        class="mt-2"
                                        :disabled=true
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                    </VRow>
                    <div class="mt-3 mb-3">
                        <VRow justify="space-between" align="center">
                        <VCol cols="auto">
                            <h3>Bahan Baku</h3>
                        </VCol>
                        <VCol cols="auto" class="d-flex justify-end">
                            <VBtn icon color="success" @click="addBahan">
                            <VIcon icon="bx-plus" />
                            </VBtn>
                        </VCol>
                        </VRow>
                    </div>

                    <div v-for="(item, index) in selectedbahanBaku" :key="index">
                        <VRow class="mt-4 mb-4">
                            <VCol>
                                <h3 >Bahan  {{ index+1 }}</h3>
                            </VCol>
                            <VCol cols="auto" class="d-flex justify-end">
                            <VBtn icon color="error" @click="deleteBahan(index)">
                                <VIcon icon="bx-trash" />
                            </VBtn>
                            </VCol>
                        </VRow>
                        <VRow>
                            <VCol cols="12">
                            <VRow no-gutters class="justify-center">
                                <VCol cols="12 mr-3" md="5">
                                <label>Bahan Baku</label>
                                <VSelect
                                    v-model="selectedbahanBaku[index]"
                                    :items="availableBahanBaku(index)"
                                    placeholder="Pilih Bahan"
                                    item-title="name"
                                    item-value="id"
                                    />

                                </VCol>

                                <VCol cols="12 mr-3" md="5">
                                <label>Merk/Vendor</label>
                                <VSelect
                                    v-model="selectedVendor[index]"
                                    :items="vendorList"
                                    placeholder="Pilih Vendor"
                                    item-title="name"
                                    item-value="id"
                                />
                                </VCol>
                            </VRow>
                            </VCol>

                            <VCol cols="12">
                            <VRow no-gutters class="justify-center">
                                <VCol cols="12 mr-3" md="5">
                                <label>Jumlah</label>
                                <VTextField
                                    v-model="jumlah[index]"
                                    type="number"
                                    placeholder="Jumlah"
                                />
                                <small>Stok Bahan = {{ stock[index] + ' ' + satuan[index] }}</small>
                                </VCol>

                                <VCol cols="12 mr-3" md="5">
                                <label>Satuan</label>
                                <VTextField
                                    v-model="satuan[index]"
                                    type="text"
                                    placeholder="Satuan"
                                    :disabled=true
                                />
                                </VCol>
                            </VRow>
                            </VCol>

                            
                        </VRow>
                    </div>
                   
            
                </VCardText>
  
                <VCardText class="d-flex justify-end flex-wrap gap-3">
                
                    <VBtn
                        variant="tonal"
                        color="secondary"
                        @click="toggleDialog"
                    >
                        Close
                    </VBtn>
                    <VBtn
                        color="secondary"
                        variant="tonal"
                        type="reset"
                        @click="resetForm"
                      >
                      Reset
                  </VBtn>
                  <VBtn type="submit" @click="submitForm" :disabled="!isFormValid">
                  Save
                  </VBtn>
              </VCardText>
          </VForm>
      </VCard>
    </VDialog>
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
import { useNotification } from "@kyvg/vue3-notification";
import { ref } from 'vue';

const { notify }  = useNotification()

  export default {

    data(){
        return {
            isDialogVisible : ref(false),
            selectedProduk:null,
            selectedbahanBaku: [],
            selectedVendor: [],
            jumlah: [],
            satuan: [],
            stock: [],
            isLoading : false,
            formData : new FormData(),
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            file: null,
            id:null,
            bahanList: [],
            nextId: 1, // untuk generate ID unik
            totalHarga:null,
            satuanProduk:null,
            qty:null,
        }
    },
    props: {
        data: {
            type: Object,
            default: () => {},
        },
        from:{
            type: String
        }
    },
    watch:{
        data(val) {
            // console.log(val)
            if (Object.entries(val).length === 0) {
                this.resetForm();
            } else {
                const {
                    id,
                    product_id,
                    qty,
                    satuan,
                    total_harga,
                    product,
                    bahan_baku_log,
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.selectedProduk = Number(product_id);
                this.qty = qty;
                this.satuanProduk = satuan;
                this.totalHarga = total_harga;
                console.log(bahan_baku_log)
                if(bahan_baku_log){
                    bahan_baku_log.forEach(item => {
                        this.selectedbahanBaku.push(Number(item.baku_id))
                        this.selectedVendor.push(Number(item.vendor_id))
                        this.jumlah.push(item.jumlah)
                        this.satuan.push(item.satuan)
                    });
                }
                // console.log(satuan)
                // this.stock = this.$store.state.bahanBaku.stocks.find(item=>item.baku_id == Number(baku_id) && item.vendor_id == Number(vendor_id))?.total_stock ?? 0
            }
            
        },
        selectedProduk(){
            this.satuanProduk = this.productList.find(item=>item.id == this.selectedProduk)?.satuan
            
        },
        qty(){
            this.totalHarga = this.formatRupiah(Number(this.productList.find(item=>item.id == this.selectedProduk)?.price ?? 0) * Number(this.qty))
        },
        selectedbahanBaku: {
            handler(newVal) {
            newVal.forEach((baku_id, index) => {
                const selected = this.bahanBakuList.find(item => item.id === baku_id);
                this.satuan[index] = selected ? selected.satuan : '';

                const vendor_id = this.selectedVendor[index];
                const foundStock = this.$store.state.bahanBaku.stocks.find(
                item => item.baku_id == baku_id && item.vendor_id == vendor_id
                );

                this.stock[index] = foundStock ? foundStock.total_stock : 0;
            });
            },
            deep: true,
            immediate: true
        },

        selectedVendor: {
            handler(newVal) {
            newVal.forEach((vendor_id, index) => {
                const baku_id = this.selectedbahanBaku[index];
                const foundStock = this.$store.state.bahanBaku.stocks.find(
                item => item.baku_id == baku_id && item.vendor_id == vendor_id
                );

                this.stock[index] = foundStock ? foundStock.total_stock : 0;
            });
            },
            deep: true,
            immediate: true
        },
        jumlah: {
            handler(newVal) {
            newVal.forEach((val, index) => {
                if (!this.id) {
                const stok = this.stock[index] ?? 0;
                if (val > stok) {
                    this.jumlah[index] = stok;
                }
                }
            });
            },
            deep: true
        }
        
    },
    computed:{
        productList(){
            // Mengakses data dari Vuex store
            const data = this.$store.state.product.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        bahanBakuList(){
            // Mengakses data dari Vuex store
            const data = this.$store.state.bahanBaku.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        vendorList(){
            // Mengakses data dari Vuex store
            const data = this.$store.state.vendor.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },

        satuanList(){
            return ([{'name':'pcs'},{'name':'kg'},{'name':'box'},{'name':'dus'},{'name':'liter'},])
        },

        isFormValid(){
            return (
                this.selectedProduk != null &&
                this.totalHarga != null &&
                this.qty != null &&
                this.qty != 0 &&
                this.satuanProduk != ''

            )
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
        unformatRupiah(formatted) {
            if (!formatted) return 0;
            // Hapus "Rp", spasi, dan titik, ganti koma jadi titik desimal jika ada
            const numeric = formatted
            .toString()
            .replace(/[^0-9,-]+/g, '')  // Hapus semua kecuali angka, koma, dan minus
            .replace(',', '.');         // Ubah koma jadi titik untuk desimal

            return Number(numeric);
        },
        availableBahanBaku(index) {
            // Ambil semua yang sudah dipilih, kecuali untuk index ini sendiri
            const selectedExceptCurrent = this.selectedbahanBaku.filter((_, i) => i !== index);

            // Filter bahan baku yang belum dipilih di index lain
            return this.bahanBakuList.filter(item => !selectedExceptCurrent.includes(item.id));
        },
        addBahan() {
            this.selectedbahanBaku.push(null)
            this.selectedVendor.push(null)
            this.jumlah.push(0)
            this.satuan.push('')
            this.harga.push(0)
            this.stock.push(0)
        },
        deleteBahan(index) {
            this.selectedbahanBaku.splice(index, 1);
            this.selectedVendor.splice(index, 1);
            this.jumlah.splice(index, 1);
            this.satuan.splice(index, 1);
            this.stock.splice(index, 1);
        },

        resetForm(){
            this.id = null,
            this.selectedProduk = null,
            this.qty = null,
            this.totalHarga = null,
            this.satuanProduk = null,
            this.selectedbahanBaku = [],
            this.selectedVendor = [],
            this.jumlah = [],
            this.satuan = [],
            this.harga = [],
            this.formData = new FormData()

        },
        toggleDialog() {
            this.resetForm()
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm() {
            const formData = new FormData();

            formData.append('id', this.id);
            formData.append('product_id', this.selectedProduk);
            formData.append('qty', this.qty);
            formData.append('satuanProduk', this.satuanProduk);
            formData.append('totalHarga', this.unformatRupiah(this.totalHarga));
            formData.append('baku_ids', this.selectedbahanBaku);
            formData.append('vendor_ids', this.selectedVendor);
            formData.append('jumlahs', this.jumlah);
            formData.append('satuans', this.satuan);
            formData.append('hargas', 0);
            formData.append('bahanBaku', this.selectedbahanBaku.length);
            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("stock/processProduksi", { formData, id })
                .then((response) => {
                this.notify = true
                this.status = 'success'
                this.title = 'Success!'
                this.text = "Data has been " + (!this.id ? "added" : "updated")
                // notify.value.icon = 'alert-cicle'
                this.isLoading = false
                setTimeout(() => {
                    this.notify = false;
                }, 2000);
            this.toggleDialog()

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
            // this.toggleDialog()

            });
        }
    },
  }
  </script>
    
    