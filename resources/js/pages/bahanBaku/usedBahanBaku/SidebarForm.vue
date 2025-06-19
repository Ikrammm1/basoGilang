
<template>
    <VDialog
        v-model= "isDialogVisible"
        max-width="600"
    >
    
        <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
    
        <!-- Dialog Content -->
        <VCard :title="'Form ' + from">    
            <VForm @submit.prevent="() => {}">
                <VCardText>
                    <VRow>
    
                    <VCol cols="12">
                        <VRow no-gutters>
                        <VCol
                            cols="12"
                            md="3"
                        >
                            <label for="name">Bahan Baku</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VSelect
                                v-model="selectedbahanBaku"
                                :items="bahanBakuList"
                                placeholder="Pilih Satuan"
                                persistent-placeholder
                                item-title="name"
                                item-value="id"
                                
                            />
                        </VCol>
                        </VRow>
                    </VCol>

                    <VCol cols="12">
                        <VRow no-gutters>
                        <VCol
                            cols="12"
                            md="3"
                        >
                            <label for="name">Merk/Vendor</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VSelect
                                v-model="selectedVendor"
                                :items="vendorList"
                                placeholder="Pilih Satuan"
                                persistent-placeholder
                                item-title="name"
                                item-value="id"
                                
                            />
                        </VCol>
                        </VRow>
                    </VCol>

                    <VCol cols="12">
                        <VRow no-gutters>
                        <VCol
                            cols="12"
                            md="3"
                        >
                            <label for="jumlah">Jumlah</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                        <VTextField
                        id="jumlah"
                        v-model="jumlah"
                        type="number"
                        placeholder="Jumlah"
                        />
                        <small>Sisa Stok = {{ stock +' '+satuan }}</small>
                    </VCol>
                        </VRow>
                    </VCol>
                    <VCol cols="12">
                        <VRow no-gutters>
                        <VCol
                            cols="12"
                            md="3"
                        >
                            <label for="satuan">Satuan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                    id="satuan"
                                    v-model="satuan"
                                    type="text"
                                    placeholder="satuan"
                                    :disabled="true"
                            />
                        </VCol>
                        </VRow>
                    </VCol>
                    </VRow>
            
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
            selectedbahanBaku:null,
            selectedVendor:null,
            jumlah: null,
            oldJumlah: null,
            harga_satuan: null,
            satuan: '',
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
            stock:0,
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
                    baku_id,
                    vendor_id,
                    jumlah,
                    satuan,
                    harga_satuan,
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.selectedbahanBaku = Number(baku_id);
                this.selectedVendor = Number(vendor_id);
                this.jumlah = jumlah;
                this.oldJumlah = jumlah;
                this.satuan = satuan;
                this.harga_satuan = harga_satuan;
                this.stock = this.$store.state.bahanBaku.stocks.find(item=>item.baku_id == Number(baku_id) && item.vendor_id == Number(vendor_id))?.total_stock ?? 0
                // console.log(this.stock)
            }
            
        },

        selectedbahanBaku(){
            const listBahan = this.bahanBakuList
            const data = listBahan.find(item=>item.id == this.selectedbahanBaku)
            this.satuan = data? data.satuan : ''
            this.stock = this.$store.state.bahanBaku.stocks.find(item=>item.baku_id == this.selectedbahanBaku && item.vendor_id == this.selectedVendor)?.total_stock ?? 0
            // console.log(this.stock)
            
        },
        selectedVendor(){
            this.stock = this.$store.state.bahanBaku.stocks.find(item=>item.baku_id == this.selectedbahanBaku && item.vendor_id == this.selectedVendor)?.total_stock ?? 0
            // console.log(this.stock)
            
        },
        jumlah(){
            if(!this.id){
                this.jumlah = this.jumlah > this.stock ? this.stock : this.jumlah

            }else{
                 this.jumlah = this.jumlah > (this.oldJumlah+this.stock) ? (this.oldJumlah+this.stock) : this.jumlah
            }
        }
        
    },
    computed:{
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
                this.selectedbahanBaku != null &&
                this.selectedVendor != null &&
                this.jumlah != null &&
                this.jumlah != 0 &&
                this.satuan != ''

            )
        },
    },
    methods:{
        resetForm(){
            this.id = null,
            this.selectedbahanBaku = null,
            this.selectedVendor = null,
            this.jumlah = null,
            this.satuan = '',
            this.harga_satuan = null,
            this.formData = new FormData()

        },
        toggleDialog() {
            this.resetForm()
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm() {
            const formData = new FormData();

            formData.append('id', this.id);
            formData.append('baku_id', this.selectedbahanBaku);
            formData.append('vendor_id', this.selectedVendor);
            formData.append('jumlah', this.jumlah);
            formData.append('satuan', this.satuan);
            formData.append('harga_satuan', 0);
            formData.append('total_harga', 0);
            formData.append('category', "Used");
            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("bahanBaku/processLog", { formData, id })
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
            this.toggleDialog()

            });
        }
    },
  }
  </script>
    
    