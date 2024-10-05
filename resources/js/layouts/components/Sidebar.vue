
        <template>
  <VDialog
    v-model="isDialogVisible"
    max-width="600"
  >
    <!-- Dialog Activator -->
    <template #activator="{ props }">
      <VBtn v-bind="props">
        Open Dialog
      </VBtn>
    </template>

    <!-- Dialog close btn -->
    <DialogCloseBtn @click="isDialogVisible = !isDialogVisible" />

    <!-- Dialog Content -->
    <VCard title="User Profile">    
        <VForm @submit.prevent="() => {}">
            <VCardText>
                <VRow>
                <!-- 👉 First Name -->
                <VCol cols="12">
                    <VRow no-gutters>
                    <VCol
                        cols="12"
                        md="3"
                    >
                        <label for="firstNameHorizontalIcons">First Name</label>
                    </VCol>

                    <VCol
                        cols="12"
                        md="9"
                    >
                        <VTextField
                        id="firstNameHorizontalIcons"
                        v-model="firstName"
                        prepend-inner-icon="bx-user"
                        placeholder="John"
                        persistent-placeholder
                        />
                    </VCol>
                    </VRow>
                </VCol>

                <!-- 👉 Email -->
                <VCol cols="12">
                    <VRow no-gutters>
                    <VCol
                        cols="12"
                        md="3"
                    >
                        <label for="emailHorizontalIcons">Email</label>
                    </VCol>

                    <VCol
                        cols="12"
                        md="9"
                    >
                        <VTextField
                        id="emailHorizontalIcons"
                        v-model="email"
                        prepend-inner-icon="bx-envelope"
                        placeholder="johndoe@email.com"
                        persistent-placeholder
                        />
                    </VCol>
                    </VRow>
                </VCol>

                <!-- 👉 Mobile -->
                <VCol cols="12">
                    <VRow no-gutters>
                    <VCol
                        cols="12"
                        md="3"
                    >
                        <label for="mobileHorizontalIcons">Mobile</label>
                    </VCol>

                    <VCol
                        cols="12"
                        md="9"
                    >
                        <VTextField
                        id="mobileHorizontalIcons"
                        v-model="mobile"
                        type="number"
                        prepend-inner-icon="bx-mobile"
                        placeholder="+1 123 456 7890"
                        persistent-placeholder
                        />
                    </VCol>
                    </VRow>
                </VCol>

                <!-- 👉 Password -->
                <VCol cols="12">
                    <VRow no-gutters>
                        <VCol
                            cols="12"
                            md="3"
                        >
                            <label for="passwordHorizontalIcons">Password</label>
                        </VCol>

                        <VCol
                            cols="12"
                            md="9"
                        >
                            <VTextField
                            id="passwordHorizontalIcons"
                            v-model="password"
                            prepend-inner-icon="bx-lock"
                            autocomplete="on"
                            type="password"
                            placeholder="············"
                            persistent-placeholder
                            />
                        </VCol>
                        </VRow>
                    </VCol>

                </VRow>
        
            </VCardText>

            <VCardText class="d-flex justify-end flex-wrap gap-3">
                <VBtn
                    color="secondary"
                    variant="tonal"
                    type="reset"
                    >
                    Reset
                </VBtn>
                <VBtn
                variant="tonal"
                color="secondary"
                @click="isDialogVisible = false"
                >
                Close
                </VBtn>
                <VBtn @click="isDialogVisible = false">
                Save
                </VBtn>
            </VCardText>
        </VForm>
    </VCard>
  </VDialog>
</template>
 
<script setup>
const isDialogVisible = ref(false)
const firstName = ref('')
const email = ref('')
const password = ref('')
</script>
  
  