
<template>
    <SidebarForm ref="SidebarForm" :data="sidebarData"/>
    <div>
        <VRow class="ms-2 mt-2 me-2 mb-2">
            <VCol cols="12" md="8">
            <VBtn
                rounded="pill"
                @click="addNewData()"
                color="primary"
            >
                <VIcon start icon="bx-plus-circle" /> Add New
            </VBtn>
            </VCol>
    
            <VCol cols="12" md="4">
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

        <!-- Menggunakan CustomTable -->
        <CustomTable
            :data="datas"
            :headers="headers"
            :search="search"
        >
            <template #item.icon="{ item }">
                <VAvatar
                size="32"
                :color="item.icon ? '' : 'primary'"
                :class="item.icon ? '' : 'v-avatar-light-bg primary--text'"
                :variant="!item.icon ? 'tonal' : undefined"
                >
                <VIcon v-if="item.icon" :icon="item.icon" />
                <span v-else>{{ avatarText(item.icon) }}</span>
                </VAvatar>
                
            </template>
            <template #item.parent="{ item }">
                <span>{{ item.parent ? item.parent.name : '-' }}</span>
            </template>
            <template #item.url="{ item }">
                <span>{{ item.url ? item.url : '-' }}</span>
            </template>
            <!-- Actions -->
            <template #item.actions="{ item }">
                <div class="d-flex gap-1">
                <IconBtn @click="editData(item)">
                    <VIcon icon="bx-edit" />
                </IconBtn>
                <IconBtn @click="deleteItem(item.id)">
                    <VIcon icon="bx-trash"/>
                </IconBtn>
                </div>
            </template>

        </CustomTable>
    </div>

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
import SidebarForm from './SidebarForm.vue';
// const isLoading = ref(false)
// Import SweetAlert2
import Swal from 'sweetalert2';
import CustomTable from '../../layouts/components/CustomTable.vue';



export default {
    components:{
        SidebarForm,
        CustomTable
    },
    data(){
        return {
            page: 1,
            itemsPerPage: 10,
            sortBy: [''],
            sortDesc: [false],
            isLoading : false,
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            splash:false,
            headers : [
            {
                title: 'Icon',
                key: 'icon',
            },
            {
                title: 'Name',
                key: 'name',
            },
            {
                title: 'Parent',
                key: 'parent',
            },
            {
                title: 'Url',
                key: 'url',
            },
            {
                title: 'Action',
                key: 'actions',
            },
            ],
            search:'',
            isSidebarOpen: false,
            sidebarData: {},
        }
    },
    watch : {
        
    },
    computed:{
        
        datas() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.menuManagement.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
       
    },
  
    methods:{
        addNewData() {
            this.sidebarData = {};
            this.$refs.SidebarForm.toggleDialog();
        },
        editData(data){
            console.log(data)
            // this.sidebarData = data;
            this.sidebarData = { ...data };
            this.$refs.SidebarForm.toggleDialog();
        },
        closeDialog() {
            this.$refs.SidebarForm.resetForm();  // Panggil reset form
            this.sidebarData = {};  // Reset sidebarData agar data kosong setelah ditutup
        },
        deleteItem(id){
            console.log(id)
            const formData = new FormData();
            formData.append('id', id);
            // console.log(id)

                Swal.fire({
                    title: 'Delete Data?',
                    text: "Are you sure you want to delete this item!",
                    icon: 'warning',
                    color: 'black',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // console.log("success")
                        this.$store.dispatch("menuManagement/delete", {formData, id})
                        .then((response) =>{
                            this.notify = true
                            this.status = 'success'
                            this.title = 'Success!'
                            this.text = 'Success delete data'
                            // notify.value.icon = 'alert-cicle'
                            setTimeout(() => {
                                this.notify = false;
                                }, 2000);

                        }) .catch((error) => {
                            console.error('Error saving item:', error);
                            formData.splash = false
                            this.notify = true
                            this.status = 'error'
                            this.title = 'Error!'
                            this.text = error.response.data.message
                            setTimeout(() => {
                                this.notify = false;
                                }, 2000);
                            });
                    }
                })
                
        },
        hidden(){
            this.notify = false
        }
        
    },
    async created() {
        this.isLoading = true
        await this.$store.dispatch("menuManagement/list")
        // this.$refs.table
        this.isLoading = false
    },
}
</script>
