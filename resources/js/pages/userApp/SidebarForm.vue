
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
                            <label for="nameUser">Name</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                            id="nameUser"
                            v-model="nameUser"
                            placeholder="Name"
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
                            <label for="email">Email</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                            id="email"
                            v-model="email"
                            type="email"
                            placeholder="email"
                            persistent-placeholder
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
                            <label for="phone">Phone</label>
                        </VCol>
    
                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                            id="phone"
                            v-model="phone"
                            type="text"
                            placeholder="phone"
                            persistent-placeholder
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
                          <label for="position">Position</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                      <VSelect
                            v-model="selectedPosition"
                            :items="Position"
                            placeholder="Select Item"
                            persistent-placeholder
                            item-title="mp_name"
                            item-value="mp_code"
                            
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
            selectedPosition:'',
            nameUser:"",
            email:'',
            phone: '',
            isLoading : false,
            formData : new FormData(),
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
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
                    email,
                    phone,
                    mp_code
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.nameUser = name;
                this.email = email;
                this.phone = phone;
                const pos = this.Position.find(item => item.mp_code == mp_code)
                this.selectedPosition = (pos ? pos.mp_code : '')
                

             
            }
            
        },
        // selectedParent(){
        //     console.log(this.selectedParent)
        // }
        
    },
    computed:{
        Position(){
            return this.$store.state.userApp.positions.map(item =>{
                return ({'mp_code':item.mp_code, 'mp_name':item.mp_name})
            })
        },
        isFormValid(){
            return (
                this.nameUser != '' &&
                this.email != '' &&
                this.selectedPosition != ''

            )
        }
    },
    methods:{
        resetForm(){
            this.nameUser = '',
            this.email = ''
            this.phone = '',
            this.selectedPosition = '',
            this.formData = new FormData()

        },
        toggleDialog() {
            this.resetForm()
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm(){
            const formData = new FormData()
            

            formData.append('id', this.id)
            formData.append('name', this.nameUser)
            formData.append('email', this.email)
            formData.append('phone', this.phone)
            formData.append('position', this.selectedPosition)
            const id = this.id
    
            this.$store.dispatch("userApp/process", {formData,id}).then((response)=>{
                this.notify = true
                this.status = 'success'
                this.title = 'Success!'
                this.text = "Data has been " + (!this.id ? "added" : "updated")
                // notify.value.icon = 'alert-cicle'
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
    
    