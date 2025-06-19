
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
                            <label for="name">Nama Bahan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="name"
                                v-model="name"
                                placeholder="Nama Bahan"
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
                        <VSelect
                            v-model="satuan"
                            :items="satuanList"
                            placeholder="Pilih Satuan"
                            persistent-placeholder
                            item-title="name"
                            item-value="name"
                            
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
                            <label for="harga_satuan">Harga Satuan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="harga_satuan"
                                type="number"
                                v-model="harga_satuan"
                                placeholder="Harga Satuan"
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
            selectedbahanBaku:'',
            name: '',
            jumlah: null,
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
                    name,
                    jumlah,
                    satuan,
                    harga_satuan,
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.name = name;
                this.jumlah = jumlah;
                this.satuan = satuan;
                this.harga_satuan = harga_satuan;
            }
            
        },
        
    },
    computed:{
        satuanList(){
            return ([{'name':'pcs'},{'name':'kg'},{'name':'box'},{'name':'dus'},{'name':'liter'},])
        },

        isFormValid(){
            return (
                this.name != '' &&
                this.jumlah != null &&
                this.satuan != '' &&
                this.harga_satuan != null 

            )
        },
    },
    methods:{
        resetForm(){
            this.id = null,
            this.name = '',
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
            formData.append('name', this.name);
            formData.append('jumlah', this.jumlah);
            formData.append('satuan', this.satuan);
            formData.append('harga_satuan', this.harga_satuan);

            // Tambahkan file jika ada
            if (this.file) {
                formData.append('file', this.file);
            }

            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("bahanBaku/process", { formData, id })
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
    
    