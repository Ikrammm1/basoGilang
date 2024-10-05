
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
                            :items="parent"
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
                          <label for="icon">Icon</label>
                      </VCol>
  
                      <VCol
                          cols="12"
                          md="9"
                      >
                          <VTextField
                          id="icon"
                          v-model="icon"
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
  </template>
   
  <script>
import { ref } from 'vue';

  export default {

    data(){
        return {
            isDialogVisible : ref(false),
            catList: (['Header','Parent','Submenu']),
            selectedCat:'',
            menuName:"",
            icon:'',
            url:'',
            sort:'',
            selectedParent:'',
            nameRules: [
                v => !!v || 'Menu name is required',
            ],
            errorMessages: [],
        }
    },
    // watch:{
        
    // },
    computed:{
        parent(){
            return this.$store.state.menuManagement.datas.map(item =>{
                return ({'id':item.id, 'name':item.name})
            })
        },
        isFormValid(){
            if(this.menuName != "" &&
                this.selectedCat !=""
            ){
               
                    return this.selectedCat !='Header' ? this.selectedParent!=""? true : false : false
                }else{
                    return false
                }
        }
    },
    methods:{
        validateForm(){
           
        },
        toggleDialog() {
            // console.log(this.isDialogVisible)
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm(){
            console.log(this.menuName)
            console.log(this.isFormValid)
            console.log(this.selectedCat)

        }
    },
  }
  </script>
    
    