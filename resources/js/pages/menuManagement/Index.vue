
<template>
    <SidebarForm ref="SidebarForm" :data="sidebarData"/>
    <div class="mb-3">
        <!-- <VCard> -->
            
            <VRow class="ms-2 mt-2 me-2 mb-2">
                <VCol cols="12" md="8">
                    <VBtn
                    rounded="pill" 
                    @click="addNewData()">
                        <VIcon
                    start
                    icon="bx-plus-circle"
                />Add New</VBtn>
                </VCol>
                <VCol cols="12"
                md="4">
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
        <!-- </VCard> -->
    </div>
    <div>
    
    <VDataTable
        :headers="headers"
        :items="datas"
        :search="search"
        :items-per-page="itemsPerPage"
        :page="page"
        class="text-no-wrap rounded-0 text-sm"
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
        <template #bottom>
        <VCardText class="pt-2">
            <div class="d-flex flex-wrap justify-center justify-sm-space-between gap-y-2 mt-2">
            <VSelect
                v-model="itemsPerPage"
                :items="[10, 25, 50, 100]"
                label="Rows per page:"
                variant="underlined"
                style="max-inline-size: 8rem;min-inline-size: 5rem;"
            />

            <VPagination
                v-model="page"
                :total-visible="$vuetify.display.smAndDown ? 2 : 5"
                :length="Math.ceil(userList.length / itemsPerPage)"
            />
            </div>
        </VCardText>
        </template>
    </VDataTable>
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
</template>

<script>
import SidebarForm from './SidebarForm.vue';
// const isLoading = ref(false)



export default {
    components:{
        SidebarForm
    },
    data(){
        return {
            page: 1,
            itemsPerPage: 10,
            sortBy: [''],
            sortDesc: [false],
            isLoading : false,
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
        userList(){
            return [
            {
                fullName:'name',
                email:'email',
                startDate:'startDate',
                salary:'salary',
                age:'age',
                status:'status',
            },
            {
                fullName:'name2',
                email:'email2',
                startDate:'startDate2',
                salary:'salary2',
                age:'age2',
                status:'status2',
            }
            ]
        },
        datas() {
            // console.log(this.$store.state.menuManagement.datas);

            const data = ref([])
            data.value = this.$store.state.menuManagement.datas; 

            // Menghapus reaktivitas menggunakan toRaw
            if (data.value.length > 0) {

                const rawData = ref([])
                rawData.value = toRaw(data.value);
                // console.log(rawData.value);
                this.$refs.table
                return rawData.value;
            }
        },
    },
  
    methods:{
        addNewData() {
            this.sidebarData = {};
            this.$refs.SidebarForm.toggleDialog();
        },
        editData(data){
            this.sidebarData = data;
            this.$refs.SidebarForm.toggleDialog();
        },
        deleteItem(id){
            console.log(id)
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
