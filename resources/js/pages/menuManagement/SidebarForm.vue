
<template>
    <VDialog
    v-model= "isDialogVisible"
      max-width="600"
    >
  
      <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
  
      <!-- Dialog Content -->
      <VCard title="Form">    
          <VForm @submit.prevent="() => {}">
              <VCardText>
                  <VRow>
                  <VCol cols="12">
                      <VRow no-gutters>
                      <VCol
                          cols="12"
                          md="3"
                      >
                          <label for="category">Category</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                      <VSelect
                            v-model="selectedCat"
                            :items="catList"
                            placeholder="Select Item"
                        />
                      </VCol>
                      </VRow>
                  </VCol>
                  <VCol cols="12" v-if="selectedCat != 'Header'">
                      <VRow no-gutters>
                      <VCol
                          cols="12"
                          md="3"
                      >
                          <label for="parent">Parent</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                      <VSelect
                            v-model="selectedParent"
                            :items="mapParent"
                            placeholder="Select Item"
                            persistent-placeholder
                            item-title="name"
                            item-value="id"
                            :disabled="selectedCat == ''"
                            
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
                          <label for="menuName">Menu Name</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                          <VTextField
                          id="menuName"
                          v-model="menuName"
                          placeholder="Menu name"
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
                          <label for="formIcon">formIcon</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                          <VTextField
                          id="formIcon"
                          v-model="formIcon"
                          type="text"
                          placeholder="bx-..."
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
                          <label for="url">Url</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                          <VTextField
                          id="url"
                          v-model="url"
                          type="text"
                          placeholder="url"
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
                          <label for="sort">Sort Order</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                          <VTextField
                          id="sort"
                          v-model="sort"
                          type="number"
                          placeholder="sort order"
                          persistent-placeholder
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
            catList: (['Header','Parent','Submenu']),
            selectedCat:'',
            menuName:"",
            formIcon:'',
            url:'',
            sort:'',
            isLoading : false,
            selectedParent:'',
            formData : new FormData(),
            nameRules: [
                v => !!v || 'Menu name is required',
            ],
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            mapParent : []
        }
    },
    props: {
        data: {
            type: Object,
            default: () => {},
        },
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
                    url,
                    icon,
                    sort_order,
                    category,
                    parent
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.menuName = name;
                this.url = url;
                this.formIcon = icon;
                this.sort = sort_order;
                this.selectedCat = this.catList.filter(
                    (item) => item == category
                )[0];

                console.log(this.mapParent)
                // this.selectedParent =  this.selectedCat != "Header" ? this.mapParent.find(
                //     (item) => item.id == parent.id
                //   ).id
                //   : ""
                console.log( this.selectedParent)
            }
            
        },
        selectedCat(){
            // this.parent
            if(this.selectedCat != ''){
                if( this.selectedCat == 'Header'){
                    this.selectedParent = ''

                }else if(this.selectedCat == 'Parent'){
                    this.selectedParent = ''
                    this.mapParent = this.parent.filter(item => item.category == 'Header')
                }else if(this.selectedCat =='Submenu'){
                    this.selectedParent = ''
                    this.mapParent = this.parent.filter(item => item.category == 'Parent')
                }
            }else{
                this.mapParent = this.parent
            }
        },
        // selectedParent(){
        //     console.log(this.selectedParent)
        // }
        
    },
    computed:{
        parent(){
            return this.$store.state.menuManagement.datas.map(item =>{
                return ({'id':item.id, 'name':item.name, 'category':item.category})
            })
        },
        isFormValid(){
            return (
                this.menuName != '' &&
                this.selectedCat != '' &&
                (this.selectedCat == 'Header' ? true : this.selectedParent!= '') && 
                this.formIcon

            )
        }
    },
    methods:{
        resetForm(){
            this.selectedCat = '',
            this.menuName = '',
            this.selectedParent ='',
            this.formIcon = '',
            this.sort ='',
            this.url = ''
            this.formData = new FormData()

           
        },
        toggleDialog() {
            this.resetForm()
            // console.log(this.isDialogVisible)
            
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm(){
            // console.log(this.parent)
            const formData = new FormData()
            const user = JSON.parse(localStorage.getItem('userData'));
            // console.log(user.id)
            

            formData.append('id', this.id)
            formData.append('category', this.selectedCat)
            formData.append('parent_id', this.selectedParent)
            formData.append('name', this.menuName)
            formData.append('icon', this.formIcon)
            formData.append('url', this.url)
            formData.append('sort_order', this.sort)
            formData.append('user_id', user.id)
            const id = this.id
            // this.isLoading = true
            // try{
            //     const result = this.$store.dispatch("menuManagement/process", {formData,id})
            //     this.isLoading = false
            //     console.log(result.data)
            //     if(result.data){
                    
            //         this.notify = true
            //         this.status = 'success'
            //         this.title = 'Success!'
            //         this.text = "Data has been " + (!this.id ? "added" : "updated")
            //         // notify.value.icon = 'alert-cicle'
            //         setTimeout(() => {
            //             this.notify = false;
            //             }, 2000);
            //     }
                
            // }catch(error){
            //     console.error('Error saving item:', error);
            //     this.isLoading = false
            //     this.notify = true
            //     this.status = 'error'
            //     this.title = 'Error!'
            //     this.text = error.response.data.message
            //     setTimeout(() => {
            //         this.notify = false;
            //         }, 2000);
            // }
            this.$store.dispatch("menuManagement/process", {formData,id}).then((response)=>{
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
    
    