<template>
     <div class="mb-4">
        <VBtn 
            :color="activeTab == 'account'? 'primary' : 'secondary'"
            variant="tonal"
            class="mr-2"
            @click="setActiveTab('account')"
            >
            <VIcon icon="bx-user" class="mr-1" />
            <span>Account</span>
        </VBtn>

            <!-- Tombol Security -->
        <VBtn 
        :color="activeTab == 'security' ? 'primary' : 'secondary'"
        variant="tonal"
        @click="setActiveTab('security')"
        >
            <VIcon icon="bx-lock" class="mr-1" />
            <span>Security</span>
        </VBtn>
    </div>

    <div v-if="activeTab == 'account'">
        <VForm @submit.prevent="() => {}">
            <VCard class="text-center text-sm-start">
                <VRow no-gutters>
                    <VCol
                    cols="2"
                    >

                        <VImg :src="photo ? '/images/avatars/'+photo : '/images/avatars/profilephoto.png'" :style="{ borderRadius: '20px', margin:'15px'}"/>
                    </VCol>
                    <VCol
                    cols="10"
                    >
                        <VRow class="mb-3 mt-5">
                            <VBtn type="button" class="mr-3 ml-3" @click="selectFile">
                                Upload new photo
                            </VBtn>
                            <input 
                                ref="fileInput" 
                                type="file" 
                                style="display:none" 
                                @change="handleFileChange" 
                                accept="image/*"
                            />
                        </VRow>
                        <VRow class="ml-2 mb-5">
                            <span v-if="selectedFile">
                                File Change : {{selectedFile.name}}
                            </span>
                            <span>
                                Hanya diperbolehkan gambar berformat JPG, GIF, atau PNG. Ukuran maksimum 800KB.
                            </span>
                        </VRow>
                    </VCol>
                </VRow>
            </VCard>

            <VCard class="mt-2">
                <VRow>
                    
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
                                    :rules="[rules.required]"
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
                                    :rules="[rules.required, rules.email]"
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
                                    :disabled="true"
                                />
                            </VCol>
                            </VRow>
                        </VCol>
            
            
                            </VRow>
                    
                        </VCardText>
                        <!-- </VForm> -->
                </VRow>
                <VCardText class="d-flex justify-end flex-wrap gap-3">
                        <VBtn
                            color="secondary"
                            variant="tonal"
                            type="reset"
                            @click="resetForm"
                        >
                            Reset
                        </VBtn>
                    <VBtn type="submit" @click="submitForm">
                    Save
                    </VBtn>
                </VCardText>
            </VCard>
        </VForm>
    </div>

    <div v-if="activeTab =='security'">
        <VCard>
            <VForm @submit.prevent="() => {}">
                <VCard class="mt-2">
                    <h3 class="mt-3 ml-3">Ubah Password</h3>

                <VRow class="mb-4 mt-3">
                        <VCardText>
                            <VRow>
                            <VCol cols="12">
                                <VRow no-gutters>
                                <VCol
                                    cols="12"
                                    md="3"
                                >
                                    <label for="curPass">Password Sekarang</label>
                                </VCol>
            
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                    <VTextField
                                    id="curPass"
                                    v-model="curPass"
                                    placeholder="············"
                                    :type="isCPVisible ? 'text' : 'password'"
                                    :append-inner-icon="isCPVisible ? 'bx-hide' : 'bx-show'"
                                    @click:append-inner="isCPVisible = !isCPVisible"
                                    :rules="[rules.required, rules.minLength]"
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
                                    <label for="newPass">Password Baru</label>
                                </VCol>
            
                                <VCol
                                    cols="12"
                                    md="9"
                                >
                                    <VTextField
                                    id="newPass"
                                    v-model="newPass"
                                    placeholder="············"
                                    :type="isNPVisible ? 'text' : 'password'"
                                    :append-inner-icon="isNPVisible ? 'bx-hide' : 'bx-show'"
                                    @click:append-inner="isNPVisible = !isNPVisible"
                                    :rules="[rules.required, rules.minLength]"
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
                                        <label for="cnewPass">Konfirmasi Password</label>
                                    </VCol>
                
                                    <VCol
                                        cols="12"
                                        md="9"
                                    >
                                        <VTextField
                                        id="cnewPass"
                                        v-model="cnewPass"
                                        placeholder="············"
                                        :type="isCNPVisible ? 'text' : 'password'"
                                        :append-inner-icon="isCNPVisible ? 'bx-hide' : 'bx-show'"
                                        @click:append-inner="isCNPVisible = !isCNPVisible"
                                        :rules="[rules.required, rules.matchPassword]"
                                        />
                                    </VCol>
                                </VRow>
                            </VCol>
                            </VRow>
                        </VCardText>
                        <!-- </VForm> -->
                </VRow>
                   <span class="ml-3">Persyaratan Password:</span>
                    <VRow class="ml-10 mt-4 mb-4">
                    <ul>
                        <li>Minimal 8 karakter — lebih banyak lebih baik</li>
                        <li>Setidaknya satu huruf kecil</li>
                        <li>Setidaknya satu angka, simbol, atau spasi</li>
                    </ul>
                    </VRow>
                    
                <VCardText class="d-flex justify-end flex-wrap gap-3">
                        <VBtn
                            color="secondary"
                            variant="tonal"
                            type="reset"
                            @click="resetFormPass"
                        >
                            Reset
                        </VBtn>
                    <VBtn type="submit" @click="newPassword" :disabled="!isFormNewPass">
                    Save
                    </VBtn>
                </VCardText>
            </VCard>
            </VForm>
        </VCard>
    </div>

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

const { notify }  = useNotification()

export default {
    data(){
        return {
            photo: ref(''),
            id : null,
            selectedFile: ref(null),
            selectedPosition:'',
            nameUser:"",
            email:'',
            phone: '',
            activeTab : 'account',
            isLoading : false,
            isCPVisible: ref(false),
            isNPVisible: ref(false),
            isCNPVisible: ref(false),
            curPass: '',
            newPass : '',
            cnewPass : '',
            formData : new FormData(),
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            rules: {
                required: (value) => !!value || "This field is required.",
                email: (value) =>
                /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value) || "Enter a valid email address.",
                minLength: (value) =>
                (value && value.length >= 8) ||
                "Password must be at least 8 characters long.",
                matchPassword: (value) =>
                value === this.newPass || "Passwords do not match.",
            },
        }
    },
    async created(){
        this.isLoading = true
        await this.$store.dispatch("userApp/getPositions").then(()=>{
            this.setData(true)
            this.isLoading = false
        })
        this.isLoading = false
      
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
        },
        isFormNewPass(){
            return(
                this.curPass != '' &&
                this.newPass != '' &&
                this.newPass == this.cnewPass
            )
        }
    },
    methods:{
        setActiveTab(tab) {
            this.activeTab = tab;
        },
        setData(con){
            if(con){
                const userData = JSON.parse(localStorage.getItem('userData'))
                this.id = userData.id
            this.nameUser = userData.name   
            this.email = userData.email
            this.phone = userData.phone
            this.photo = userData.photo? userData.photo : this.photo
            const pos = this.Position.find(item => item.mp_code == userData.user_position[0].mp_code)
            this.selectedPosition = (pos ? pos.mp_code : '')
            }
           
        },
        resetForm(){
            this.nameUser = '',
            this.email = ''
            this.phone = '',
            this.formData = new FormData()

        },
        resetFormPass(){
            this.curPass = '',
            this.newPass = '',
            this.cnewPass = '',
            this.formData = new FormData()

        },
        submitForm(){
            const formData = new FormData()
            

            formData.append('id', this.id)
            formData.append('name', this.nameUser)
            formData.append('email', this.email)
            formData.append('phone', this.phone)
            formData.append('position', this.selectedPosition)
            const id = this.id
            const from = 'User'
            
            if(this.photo != this.selectedFile.name){
                formData.append('imageOld', this.photo)
                formData.append('image', this.selectedFile.name)

                this.uploadImage()
            }
    
            this.$store.dispatch("userApp/process", {formData,id, from}).then((response)=>{
                this.notify = true
                this.status = 'success'
                this.title = 'Success!'
                this.text = "Data has been updated"

                
                // notify.value.icon = 'alert-cicle'
                setTimeout(() => {
                    this.notify = false;
                }, 2000);
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

            });



        },

        newPassword(){
            const formData = new FormData()
            formData.append('id', this.id)
            formData.append('current_password', this.curPass)
            formData.append('new_password', this.newPass)
            

            this.$store.dispatch("userApp/newPass",{formData}).then((response)=>{
                this.notify = true
                this.status = 'success'
                this.title = 'Success!'
                this.text = "Data has been updated"

                
                // notify.value.icon = 'alert-cicle'
                setTimeout(() => {
                    this.notify = false;
                }, 2000);
            }).catch((error)=>{
                this.isLoading = false
                this.notify = true
                this.status = 'error'
                this.title = 'Error!'
                setTimeout(() => {
                    this.notify = false;
                }, 2000);
            })
        },
        selectFile() {
            this.$refs.fileInput.click();
        },

        // Handle file change when the user selects a file
        handleFileChange(event) {
            const file = event.target.files[0];  // Get the selected file
            if (file) {
                this.selectedFile = file;
                this.previewImage = URL.createObjectURL(file); // Show preview image
                // this.filechange = this.selectFile.name
            }
        },

        // Function to upload the image to the server
        async uploadImage() {
            if (!this.selectedFile) {
                return; // If no file is selected, do nothing
            }


            const formData = new FormData();
            formData.append('image', this.selectedFile);
            formData.append('imageOld', this.photo);
            this.$store.dispatch("userApp/upload",{formData}).then((response)=>{
                // console.log(response.data.imageUrl)
                return response.data.imageUrl
            })
        },
    },
}

</script>
<style>

</style>
