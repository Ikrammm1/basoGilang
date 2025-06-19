<script setup>
import NeedRestock from '@/views/dashboard/NeedRestock.vue'
import NeedRestockKemasan from '@/views/dashboard/NeedRestockKemasan.vue'
import NeedRestockProduct from '@/views/dashboard/NeedRestockProduct.vue'
import transactionToday from '@/views/dashboard/transactionToday.vue'

import AnalyticsFinanceTabs from '@/views/dashboard/AnalyticsFinanceTab.vue'

// 👉 Images
import AnalyticsTotalRevenue from '@/views/dashboard/AnalyticsTotalRevenue.vue'
import chart from '@images/cards/chart-success.png'
import card from '@images/cards/credit-card-primary.png'
import paypal from '@images/cards/paypal-error.png'
import wallet from '@images/cards/wallet-info.png'


const formatRupiah = value => {
  if (typeof value !== "number") value = Number(value)
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0
  }).format(value)
}
</script>

<template>
  <VCol cols="12" md="12" class="mb-4" v-if="position_code=='OWN'">
    <VRow>
      <!-- Profit -->
      <VCol cols="3" md="3" sm="6">
        <CardStatisticsVertical
          :title="'Transaksi Hari Ini'"
          :image="chart"
          :stats="String(qty_today)"
          :change="(qty_change_percent)"
          :to="String('/transaction/data')"
        />
      </VCol>

      <!-- Sales -->
      <VCol cols="3" md="3" sm="6">
        <CardStatisticsVertical
        :title="'Pendapatan Hari Ini'"
          :image="wallet"
          :stats="String(formatRupiah(price_today))"
          :change="price_change_percent"
          :to="String('')"

         
        />
      </VCol>

      <!-- Payments -->
      <VCol cols="3" md="3" sm="6">
        <CardStatisticsVertical
        :title="'Sudah Dibayar'"
          :image="paypal"
          :stats="String(formatRupiah(paid_price_today))"
          :change="paid_price_change_percent"
          :to="String('/transaction/data')"        
         
        />
      </VCol>

      <!-- Transactions -->
      <VCol cols="3" md="3" sm="6">
        <CardStatisticsVertical
         :title="'Belum Dibayar'"
          :image="card"
          :stats="String(formatRupiah(unpaid_price_today))"
          :change="unpaid_price_change_percent"
          :to="{ path: String('/transaction/data'), query: { search: 'Unpaid' } }"
         
        />
      </VCol>

      <!-- Profit Report -->
      <!-- <VCol cols="12">
        <AnalyticsProfitReport />
      </VCol> -->
    </VRow>
    <VRow>
        <VCol
          cols="12"
          md="6"
          style="height: 100%;"
        >
          <AnalyticsTotalRevenue />
        </VCol>

        <!-- 👉 Tabs chart -->
        <VCol
          cols="12"
          md="6"
          style="height: 100%;"
        >
          <AnalyticsFinanceTabs />
        </VCol>
    </VRow>
  </VCol>

<VRow>
  <!-- 👉 Kolom Kiri: Semua NeedRestock* -->
  <VCol cols="12" md="12">
    <VRow>
      <!-- transaksitoday -->
      <VCol cols="12" v-if="transaksi.length">
        <VCard >
          <transactionToday />
        </VCard>
      </VCol>
      <!-- NeedRestockProduct -->
      <VCol cols="12" v-if="product.length && (position_code=='OWN' || position_code=='SA')" >
        <VCard >
          <NeedRestockProduct />
        </VCard>
      </VCol>
      

      <!-- NeedRestock (jika ada data) -->
      <VCol cols="12" v-if="bahanBaku.length && (position_code=='OWN' || position_code=='SA')">
        <VCard >
          <NeedRestock />
        </VCard>
      </VCol>

      <!-- NeedRestockKemasan -->
      <VCol cols="12" v-if="bahanKemasan.length && (position_code=='OWN' || position_code=='SA')">
        <VCard>
          <NeedRestockKemasan />
        </VCard>
      </VCol>


          <!-- 👉 Order Statistics -->
      

    <!-- 👉 Transactions -->
    <!-- <VCol
      cols="12"
      md="4"
      sm="6"
      order="3"
    >
      <AnalyticsTransactions />
    </VCol> -->
    </VRow>
  </VCol>

  <!-- 👉 Kolom Kanan: Statistik -->
  
</VRow>

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



export default {
    data(){
        return {
            isLoading : false,
            notify : false,
            position_code:null,
            // qty_change_percent: 0,
            // price_today: 0,
            // price_change_percent: 0,
            // paid_price_today: 0,
            // paid_price_change_percent: 0,
            // unpaid_price_today: 0,
            // unpaid_price_change_percent: 0,
        }
    },
    

     computed:{
        
        product() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.stock.listStock;

            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        bahanBaku() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.bahanBaku.needRestocks;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
              return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        bahanKemasan() {
            // Mengakses data dari Vuex store
            const data = this.$store.state.bahanKemasan.needRestocks;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
              return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        transaksi() {
          const data = this.$store.state.transaction.pending;

           if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
              return data;
            }
            return [];

        },

        summary() {
          const data= this.$store.state.transaction.today || {};
          // console.log(data)
          return data; 
        },
        qty_today() {
          return this.summary.qty_today??0
        },
        qty_change_percent() {
          return this.summary.qty_change_percent??0
        },
        price_today() {
          return this.summary.price_today??0
        },
        price_change_percent() {
          return this.summary.price_change_percent??0
        },
        paid_price_today() {
          return this.summary.paid_price_today??0
        },
        paid_price_change_percent() {
          return this.summary.paid_price_change_percent??0
        },
        unpaid_price_today() {
          return this.summary.unpaid_price_today??0
        },
        unpaid_price_change_percent() {
          return this.summary.unpaid_price_change_percent??0
        },

       
       
    },
  
    methods:{
        hidden(){
            this.notify = false
        }
        
    },
    async created() {
        this.isLoading = true
        await this.$store.dispatch("bahanBaku/needRestock")
        await this.$store.dispatch("bahanKemasan/needRestock")
        await this.$store.dispatch("stock/stocks")
        await this.$store.dispatch("transaction/pendingList")
        await this.$store.dispatch("transaction/listToday")

      this.position_code = (JSON.parse(localStorage.getItem('userData')).position_code)
        // this.$refs.table
        this.isLoading = false
    },
}
</script>
