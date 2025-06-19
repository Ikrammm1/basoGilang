
<template>
    <VDialog
    v-model= "isDialogVisible"
      max-width="800"
    >
  
      <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
  
      <!-- Dialog Content -->
        <VCard :title="this.from + ' Group'">    
            <VForm @submit.prevent="() => {}">
                <VCardText>
                    <VRow>
                        <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                    md="3"
                                >
                                    <label for="name">Group Name</label>
                                </VCol>
        
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                    <VTextField
                                        id="name"
                                        v-model="name"
                                        placeholder="Group Name"
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
                                    <label for="desc">Description</label>
                                </VCol>
            
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                <VTextarea
                                    id="desc"
                                    v-model="desc"
                                    placeholder="Description"
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
                                    <label for="menus">Assign Menu</label>
                                </VCol>
                                
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                <VRow class="ms-2 me-2 mb-2">
                                  
                                    <VCol cols="12">
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
                                <CustomTable
                                    :data="menus"
                                    :headers="headerMenus"
                                    :search="search"
                                >
                                    <template #item.assign="{ item }">
                                        <VCheckbox id="menus" :value=item.id v-model="assign"/>
                                    </template>
                                </CustomTable>
                                </VCol>
                            </VRow>
                        </VCol>    
                        <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                    md="3"
                                >
                                    <label for="menus">Assign User</label>
                                </VCol>
                                
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                <VRow class="ms-2 me-2 mb-2">
                                  
                                    <VCol cols="12">
                                        <VCard>
                                            <VTextField
                                            id="search"
                                            v-model="searchUser"
                                            placeholder="Search"
                                            persistent-placeholder
                                            prepend-inner-icon="bx-search"
                                            />
                                        </VCard>
                                    </VCol>
                                </VRow>
                                <CustomTable
                                    :data="users"
                                    :headers="columnUsers"
                                    :search="searchUser"
                                >
                                    <template #item.assignUsers="{ item }">
                                        <VCheckbox id="assignUsers" :value=item.id v-model="assignUsers"/>
                                    </template>
                                </CustomTable>
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
import CustomTable from '../../layouts/components/CustomTable.vue';

const { notify }  = useNotification()

  export default {
        components: {
            CustomTable,
        },

    data(){
        return {
            search: '', // Query pencarian
            searchUser: '', // Query pencarian
            isDialogVisible : ref(false),
            id:"",
            name:"",
            isSidebarActive : true,
            splash:false,
            assign:[],
            assignUsers:[],
            desc: "",
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            isLoading:false,
            headerMenus: [
                {
                    title: 'Assign',
                    key: 'assign',
                },
                {
                    title: 'Name',
                    key: 'name',
                },
                {
                    title: 'URL',
                    key: 'url',
                },
              
                
            ],
          columnUsers: [
                {
                    title: 'Assign',
                    key: 'assignUsers',
                },
                {
                    title: 'Name',
                    key: 'name',
                },
                {
                    title: 'Position',
                    key: 'mp_name',
                },
              
                
            ],

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
            if (Object.entries(val).length == 0) {
                // this.resetField();
            } else {
                const {
                    id,
                    name,
                    description,
                    menus,
                    users
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.name = name;
                this.desc = description;
                menus.forEach(item => {
                    this.assign.push(item.id)
                });
                users.forEach(item=>{
                    this.assignUsers.push(item.id)
                })
            }
        },
  },
  computed:{
    isFormValid(){
      return (
        this.name != ""
      );
    },
    menus() {
      const data = ref([])
      data.value = this.$store.state.menuManagement.datas; 
      if (data.value.length > 0) {
          const rawData = ref([])
          rawData.value = toRaw(data.value);
          this.$refs.table
          return rawData.value;
      }
    },
    users() {
      const data = ref([])
      data.value = this.$store.state.userApp.datas; 
      if (data.value.length > 0) {
          const rawData = ref([])
          rawData.value = toRaw(data.value);
          this.$refs.table
          return rawData.value;
      }
    },
  },
  methods: {
        resetForm(){
            this.id = "",
            this.name = "",
            this.assign = [],
            this.assignUsers = [],
            this.desc = ""
            
            // this.formData = new FormData();
        },
    
        async submitForm() {
            // // console.log(this.parent)
            const formData = new FormData()
            const user = JSON.parse(localStorage.getItem('userData'));
            // console.log(user.id)
            

            formData.append('id', this.id)
            formData.append('menus', this.assign)
            formData.append('users', this.assignUsers)
            formData.append('name', this.name)
            formData.append('desc', this.desc)
            formData.append('userId', user.id)
            const id = this.id
            
            try{
                const result =await this.$store.dispatch("authorizations/process", {formData,id})
                if(result.data){
                this.closeSidebar()
                notify(
                {
                    title: "Success",
                    text: "Data has been " + (!this.id ? "added" : "updated"),
                    type: 'success',
                    duration: 2000
                });
                }
                
            }catch(error){
                console.error('Error saving item:', error);
                notify({
                    title: "Error!",
                    text: error,
                    type: 'error',
                });
            }
        },
        toggleDialog() {
            this.resetForm()            
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm(){
            // // console.log(this.parent)
            const formData = new FormData()
            const user = JSON.parse(localStorage.getItem('userData'));
            // console.log(user.id)
            

            formData.append('id', this.id)
            formData.append('menus', this.assign)
            formData.append('users', this.assignUsers)
            formData.append('name', this.name)
            formData.append('desc', this.desc)
            formData.append('userId', user.id)
            const id = this.id
            this.isLoading = true
            this.$store.dispatch("authorizations/process", {formData,id}).then((response)=>{
                this.isLoading = false
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
    
    