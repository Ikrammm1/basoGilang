
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
                            <label for="name">Produk</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                    id="product"
                                    v-model="productName"
                                    type="text"
                                    placeholder="Produk"
                                    :disabled="true"
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
                            <label for="name">Stok Fresh</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                                    id="qty"
                                    v-model="qty"
                                    type="number"
                                    placeholder="qty"
                                    :disabled="true"
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
                            <label for="qtyFrozen">Stok Frozen</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                        <VTextField
                            id="qtyFrozen"
                            v-model="qtyFrozen"
                            type="number"
                            placeholder="Qty Frozen"
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
            productName:null,
            productId:null,
            qty: null,
            qtyFrozen: null,
            fixQty:null,
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
                    product,
                    qty,
                    qty_frozen,
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.qty = qty;
                this.qtyFrozen = qty_frozen;
                this.productName = product.name;
                this.productId = product.id;
                this.fixQty = qty+qty_frozen
             
            }
            
        },
        
        qtyFrozen(){
            this.qty = this.fixQty - this.qtyFrozen;
            if(this.qtyFrozen > this.fixQty){
                this.qtyFrozen = this.fixQty
            }
        }
        
    },
    computed:{
       
        isFormValid(){
            return (
                this.productId != null &&
                this.qty != null &&
                this.qtyFrozen != null 
            )
        },
    },
    methods:{
        resetForm(){
            this.qtyFrozen = null

        },
        toggleDialog() {
            this.resetForm()
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm() {
            const formData = new FormData();

            formData.append('id', this.id);
            formData.append('productId', this.productId);
            formData.append('qty', this.qty);
            formData.append('qtyFrozen', this.qtyFrozen);

            const id= this.id;

            this.isLoading = true;

            this.$store.dispatch("stock/updateStock", { formData, id })
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
    
    