
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
                            <label for="code">Kode Produk</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="code"
                                v-model="code"
                                placeholder="Kode Produk"
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
                            <label for="name">Nama produk</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="name"
                                v-model="name"
                                placeholder="Name produk"
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
                          <label for="category">Kategori</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                      <VSelect
                            v-model="selectedCat"
                            :items="categoryList"
                            placeholder="Select Item"
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
                            <label for="price">Harga Satuan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="price"
                                v-model="price"
                                type="number"
                                placeholder="Harga Satuan"
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
                            <label for="desc">Deskripsi</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextarea
                                id="desc"
                                v-model="desc"
                                placeholder="Deskripsi"
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
                            <label for="desc">Upload File</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VFileInput
                            label="Upload Gambar"
                            v-model="file"
                            accept="image/*"
                            prepend-icon="mdi-image"
                            >

                        </VFileInput>
                        <VImg
                            v-if="previewImage"
                            :src="previewImage"
                            max-height="150"
                            class="my-3"
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
            selectedCat:null,
            name: '',
            desc: '',
            code: '',
            price: null,
            satuan: null,
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
                    desc,
                    category_id,
                    code,
                    price,
                    satuan,
                   
                } = JSON.parse(JSON.stringify(this.data));
                console.log(this.categoryList)
                this.id = id;
                this.name = name;
                this.desc = desc;
                this.price = price;
                this.satuan = satuan;
                this.selectedCat = Number(category_id);
                // this.selectedCat = this.categoryList.find(item=>item.id==category_id)
                this.code = code;
            }
            
        },
        
    },
    computed:{
        categoryList(){
            return this.$store.state.category.datas
        },
        isFormValid(){
            return (
                this.code != '' &&
                this.name != '' &&
                this.price != 0 &&
                this.price != null &&
                this.satuan != null &&
                this.selectedCat != null 

            )
        },
        previewImage() {
            const file = this.id? this.file ? '/images/product/'+this.file : '/images/avatars/profilephoto.png': this.file ? URL.createObjectURL(this.file) : null;
            
            return this.file ? URL.createObjectURL(this.file) : null;
        },
        satuanList(){
            return ([{'name':'pcs'},{'name':'kg'},{'name':'box'},{'name':'dus'},{'name':'liter'},])
        },
    },
    methods:{
        resetForm(){
            this.id = null,
            this.name = '',
            this.desc = '',
            this.code = '',
            this.price = null,
            this.satuan = null,
            this.selectedCat = null,
            this.file = null,
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
            formData.append('desc', this.desc);
            formData.append('code', this.code);
            formData.append('price', this.price);
            formData.append('satuan', this.satuan);
            formData.append('category_id', this.selectedCat);

            // Tambahkan file jika ada
            if (this.file) {
                formData.append('file', this.file);
            }

            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("product/process", { formData, id })
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
    
    