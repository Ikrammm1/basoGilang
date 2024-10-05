<script>
export default {
   data(){
    return{
        isDialogVisible : ref(false),
    }
   },
   methods:{
    toggleLoading(bol){
        this.isDialogVisible = bol
        
        // this.isDialogVisible = bol
    }
   }
}
</script>


<template>
    
  <!-- Dialog -->
  <VDialog
    v-model="isDialogVisible"
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
