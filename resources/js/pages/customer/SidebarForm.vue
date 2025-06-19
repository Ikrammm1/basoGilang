
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
                            <label for="name">Nama</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="name"
                                v-model="name"
                                placeholder="name"
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
                                v-model="category"
                                :items="categoryList"
                                placeholder="Pilih kategori"
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
                            <label for="telp">No. Telp</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="telp"
                                v-model="telp"
                                placeholder="telp"
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
                            <label for="prov">Provinsi</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VSelect
                                v-model="prov"
                                :items="provList"
                                placeholder="Pilih Provinsi"
                                persistent-placeholder
                                item-title="name"
                                item-value="code"
                                
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
                            <label for="kab">Kota/Kab</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VSelect
                                v-model="kab"
                                :items="kabList"
                                placeholder="Pilih kota/kab"
                                persistent-placeholder
                                item-title="name"
                                item-value="code"
                                :disabled="!prov"
                                
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
                            <label for="kec">Kecamatan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VSelect
                                v-model="kec"
                                :items="kecList"
                                placeholder="Pilih kecamatan"
                                persistent-placeholder
                                item-title="name"
                                item-value="code"
                                :disabled="!kab"
                                
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
                            <label for="address">Alamat Lengkap</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextarea
                                id="address"
                                v-model="address"
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
                            <label for="mark">Patokan</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                id="mark"
                                v-model="mark"
                                placeholder="Patokan"
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
                            <label for="radius">Radius</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                           <VSelect
                                v-model="radius"
                                :items="radiusList"
                                placeholder="Pilih radius"
                                persistent-placeholder
                                item-title="radius"
                                item-value="id"
                                
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
            name: '',
            address: null,
            isLoading : false,
            formData : new FormData(),
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            id:null,
            category:null,
            kab:null,
            kec:null,
            address:null,
            mark:null,
            telp:null,
            radius:null,
            prov:null,
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
            
            if (Object.entries(val).length === 0) {
                this.resetForm();
            } else {
                const {
                    id,
                    name,
                    address,
                    prov,
                    kab,
                    kec,
                    telp,
                    category,
                    radius_id,
                    mark,
                   
                } = JSON.parse(JSON.stringify(this.data));
                // console.log(radius)
                this.id = id;
                this.name = name;
                this.address = address;
                this.prov = prov;
                this.kab = kab;
                this.kec = kec;
                this.mark = mark;
                this.category = category;
                this.telp = telp;
                this.radius = Number(radius_id);
            }
            
        },

        prov(){
            const codeProv = this.prov
            if(this.prov){
                // this.kec = null
                this.getKab(codeProv)
            }


        },
        kab(){
            const codeKab = this.kab
            if(this.kab){
                // this.kec = null
                this.getKecamatan(codeKab)
            }


        }
        
    },
    computed:{
        isFormValid(){
            return (
                this.name != '' &&
                this.prov != null &&
                this.kab != null &&
                this.kec != null &&
                this.address != null &&
                this.category != null &&
                this.radius != null 

            )
        },
        categoryList(){
            return ['Konsumen', 'Distributor']
        },

        radiusList(){
            return this.$store.state.ongkir.datas;
        },
        provList(){
            return this.$store.state.customer.provs;
        },
        kabList(){
            return this.$store.state.customer.kabs;
        },
        kecList(){
            return this.$store.state.customer.kecs??[];
        }
    },
    methods:{
        getKab(codeProv){
            return this.$store.dispatch("customer/getKab", {codeProv})

        },
        getKecamatan(codeKab){
            return this.$store.dispatch("customer/getKec", {codeKab})

        },
        resetForm(){
            this.id = null,
            this.name = '',
            this.prov = null,
            this.kab = null,
            this.category = null,
            this.kec = null,
            this.address = null,
            this.radius = null,
            this.telp = null,
            this.mark = null,
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
            formData.append('address', this.address);
            formData.append('prov', this.prov);
            formData.append('kab', this.kab);
            formData.append('kec', this.kec);
            if (this.mark != null && this.mark !== '') {
                formData.append('mark', this.mark);
            }
            formData.append('radius', this.radius);
            formData.append('category', this.category);
            formData.append('telp', this.telp);

            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("customer/process", { formData, id })
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
    
    