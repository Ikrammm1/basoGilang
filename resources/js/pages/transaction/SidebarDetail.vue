
<template>
    <VDialog
        v-model= "isDialogVisible"
        max-width="1000"
    >
    
        <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
    
        <!-- Dialog Content -->
        <VCard>  
            <h1 class="ml-6 mt-6">
                Detail Transaksi
            </h1>  
            <VForm @submit.prevent="() => {}">
                <VCardText>
                    <VRow>
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="3"
                                >
                                    <h4 >Nama Customer</h4>
                                </VCol>
                                <VCol
                                cols="1">
                                    <h4>:</h4>
                                </VCol>
                                <VCol
                                    cols="8"
                                >
                                    <label for="name" >{{ selectedCustomer }}</label>
                                </VCol>
                            </VRow>
                        </VCol> 

                    </VRow>
                    <VRow>
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="3"
                                >
                                    <h4 >Alamat</h4>
                                </VCol>
                                <VCol
                                cols="1">
                                    <h4>:</h4>
                                </VCol>
                                <VCol
                                    cols="8"
                                >
                                    <label for="name" >{{ address }}</label>
                                </VCol>
                            </VRow>
                        </VCol> 

                    </VRow>
                   
                   <VRow>
                        <VCol>
                            <VRow no-gutters align="center">
                            <VCol cols="3">
                                <h4>Status Pembayaran</h4>
                            </VCol>
                            <VCol cols="1">
                                <h4>:</h4>
                            </VCol>
                            <VCol cols="8">
                                <label
                                :style="{
                                    backgroundColor: statusPayment === 'Paid' ? '#16a34a' : '#dc2626',
                                    color: 'white',
                                    padding: '4px 8px',
                                    borderRadius: '4px',
                                    display: 'inline-block',
                                    minWidth: '100px',
                                    textAlign: 'center'
                                }"
                                >
                                {{ statusPayment }}
                                </label>
                            </VCol>
                            </VRow>
                        </VCol>
                        </VRow>

                        <VRow>
                            <VCol>
                                <VRow no-gutters align="center">
                                    <VCol cols="3">
                                        <h4>Status Pengemasan</h4>
                                    </VCol>
                                    <VCol cols="1">
                                        <h4>:</h4>
                                    </VCol>
                                    <VCol cols="8">
                                        <label
                                        :style="{
                                            backgroundColor: statusdDelivery === 'Unpack' ? '#f59e0b' : '#16a34a',
                                            color: 'white',
                                            padding: '4px 8px',
                                            borderRadius: '4px',
                                            display: 'inline-block',
                                            minWidth: '100px',
                                            textAlign: 'center'
                                        }"
                                        >
                                        {{ packStatus }}
                                        </label>
                                    </VCol>
                                </VRow>
                            </VCol>
                        </VRow>
                        <VRow>
                            <VCol>
                                <VRow no-gutters align="center">
                                    <VCol cols="3">
                                        <h4>Status Pengiriman</h4>
                                    </VCol>
                                    <VCol cols="1">
                                        <h4>:</h4>
                                    </VCol>
                                    <VCol cols="8">
                                        <label
                                        :style="{
                                            backgroundColor: statusdDelivery === 'Pending' ? '#f59e0b' : '#16a34a',
                                            color: 'white',
                                            padding: '4px 8px',
                                            borderRadius: '4px',
                                            display: 'inline-block',
                                            minWidth: '100px',
                                            textAlign: 'center'
                                        }"
                                        >
                                        {{ statusdDelivery }}
                                        </label>
                                    </VCol>
                                </VRow>
                            </VCol>
                        </VRow>

                    <VRow>
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="3"
                                >
                                    <h4 >Tanggal Pengiriman</h4>
                                </VCol>
                                <VCol
                                cols="1">
                                    <h4>:</h4>
                                </VCol>
                                <VCol
                                    cols="8"
                                >
                                    <label for="name" >{{ formatTanggal(deliveryDate) }}</label>
                                </VCol>
                            </VRow>
                        </VCol> 
                    </VRow>
                    <VRow>
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="3"
                                >
                                    <h4 >Jam Pengiriman</h4>
                                </VCol>
                                <VCol
                                cols="1">
                                    <h4>:</h4>
                                </VCol>
                                <VCol
                                    cols="8"
                                >
                                    <label for="name" >{{ deliveryTime }}</label>
                                </VCol>
                            </VRow>
                        </VCol> 
                    </VRow>
                    <VRow>
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="3"
                                >
                                    <h4 >Total Pesanan</h4>
                                </VCol>
                                <VCol
                                cols="1">
                                    <h4>:</h4>
                                </VCol>
                                <VCol
                                    cols="8"
                                >
                                    <label for="name" >{{ qty }}</label>
                                </VCol>
                            </VRow>
                        </VCol> 
                    </VRow>
                     
                    <div class="mt-3 mb-3">
                        <VRow justify="space-between" align="center">
                        <VCol cols="auto">
                            <h2>Detail Pesanan</h2>
                        </VCol>
                        </VRow>
                    </div>

                    <div v-for="(prod, index) in packages" :key="index">
                        <h3 class=" mt-2">Paket {{ index+1  +' - '+prod.kemasan.nama}}</h3>
                         <VTable>
                            <thead class="bg-gray-100">
                                <tr>
                                <th class="px-4 py-2 text-left">Gambar</th>
                                <th class="px-4 py-2 text-left">Produk</th>
                                <th class="px-4 py-2 text-left">Kategori</th>
                                <th class="px-4 py-2 text-center">Jumlah</th>
                                <th class="px-4 py-2 text-center">Jumlah Pack</th>
                                <!-- <th class="px-4 py-2 text-left">Packaging</th> -->
                                <th class="px-4 py-2 text-right">Total </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, prodIndex) in prod.products" :key="prodIndex" class="border-b">
                                <td class="px-4 py-2">
                                <VImg :src="item.product_image ? '/images/product/'+item.product_image : '/images/avatars/profilephoto.png'" :style="{  width:'50px',borderRadius: '10px', margin:'5px'}"/>
                                </td>
                                <td class="px-4 py-2">{{ item.product_name }}</td>
                                <td class="px-4 py-2">{{ item.category }}</td>
                                <td class="px-4 py-2 text-center">{{ item.jumlah +' '+item.satuan + ' per pack' }}</td>
                                <td class="px-4 py-2 text-center">{{ prod.jumlahPack }}</td>
                                <!-- <td class="px-4 py-2">{{ prod.kemasan.nama }} ({{ formatRupiah(prod.kemasan.harga) }})</td> -->
                                <td class="px-4 py-2 text-right">
                                    {{ formatRupiah(item.total_price) }}
                                </td>
                                </tr>
                            </tbody>
                        </VTable>
                        
                    </div>
                  
                    <VRow justify="end" class="mt-3"  v-for="(prod, index) in packages" :key="index">
                            <VCol cols="6">
                                <VRow no-gutters justify="end" align="center">
                                <VCol cols="4" class="text-right">
                                    <h4>Total Harga Paket {{ index+1 }}</h4>
                                </VCol>
                                <VCol cols="1" class="text-right">
                                    <h4>:</h4>
                                </VCol>
                                <VCol cols="7" class="text-right">
                                    <h4>{{ formatRupiah(prod.totalPrice) }}</h4>
                                </VCol>
                                </VRow>
                            </VCol>
                        </VRow>
                    <VRow justify="end" class="mt-3">
                        <VCol cols="6">
                            <VRow no-gutters justify="end" align="center">
                            <VCol cols="4" class="text-right">
                                <h4>Ongkir</h4>
                            </VCol>
                            <VCol cols="1" class="text-right">
                                <h4>:</h4>
                            </VCol>
                            <VCol cols="7" class="text-right">
                                <h4>{{ formatRupiah(ongkir) }}</h4>
                            </VCol>
                            </VRow>
                        </VCol>
                    </VRow>

                    <VRow justify="end" >
                        <VCol cols="6">
                            <VRow no-gutters justify="end" align="center">
                            <VCol cols="4" class="text-right">
                                <h4>Total Pembayaran</h4>
                            </VCol>
                            <VCol cols="1" class="text-right">
                                <h4>:</h4>
                            </VCol>
                            <VCol cols="7" class="text-right">
                                <h4>{{ formatRupiah(totalPrice) }}</h4>
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
            selectedProduct: [],
            selectedPackaging: [],
            jumlah: [],
            satuan: [],
            stock: [],
            unitPrice: [],
            totalPrice: [],
            isLoading : false,
            formData : new FormData(),
            errorMessages: [],
            notify : false,
            status: '',
            duration: 2000,
            title: '',
            text: '',
            icon:'',
            file: null,
            id:null,
            bahanList: [],
            nextId: 1, // untuk generate ID unik
            statusdDelivery:null,
            statusPayment:null,
            deliveryTime:null,
            deliveryDate:null,
            selectedCustomer:null,
            customerCategory:null,
            address:null,
            ongkir:null,
            telp:null,
            detail_transaction:[],
            selectedCategory:[],
            stocks:[],


            packStatus:null,
            packages : [],

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
            if (Object.entries(val).length === 0) {
                this.resetForm();
            } else {
                const {
                    id,
                    customer_id,
                    customer,
                    total_order,
                    payment_status,
                    total_price,
                    detail_transaction,
                    delivery_date,
                    delivery_time,
                    delivery_status,
                    packStatus,
                    packages,
                   
                } = JSON.parse(JSON.stringify(this.data));
                this.id = id;
                this.selectedCustomer = customer.name;
                // this.selectedCustomer = this.customerList.find(item => item.id == Number(customer_id));
                this.qty = total_order;
                this.statusdDelivery = delivery_status;
                this.statusPayment = payment_status;
                this.packStatus = packStatus;
                this.deliveryDate = delivery_date;
                this.deliveryTime = delivery_time;
                this.totalPrice = total_price;
                this.ongkir = customer.ongkir.price;
                this.address = (
                    customer.nama_prov+', '+customer.nama_kab +', '+ customer.nama_kec +', '+ customer.address +(customer.mark? ', '+  customer.mark: '')
                )
                // this.detail_transaction = detail_transaction
                this.packages = packages

                
                // console.log(satuan)
                // this.stock = this.$store.state.bahanBaku.stocks.find(item=>item.baku_id == Number(baku_id) && item.vendor_id == Number(vendor_id))?.total_stock ?? 0
            }
            
        },
    },
   
    methods:{
         formatTanggal(datetime) {
            if (!datetime) return '-';

            const options = {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            };

            return new Date(datetime).toLocaleDateString('id-ID', options);
        },
        formatRupiah(value) {
            if (typeof value !== "number") {
            value = Number(value);
            }
            return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR",
            minimumFractionDigits: 0
            }).format(value);
        },
        unformatRupiah(formatted) {
            if (!formatted) return 0;
            // Hapus "Rp", spasi, dan titik, ganti koma jadi titik desimal jika ada
            const numeric = formatted
            .toString()
            .replace(/[^0-9,-]+/g, '')  // Hapus semua kecuali angka, koma, dan minus
            .replace(',', '.');         // Ubah koma jadi titik untuk desimal

            return Number(numeric);
        },
        availableProduct(index) {
            // const selectedExceptCurrent = this.selectedProduct.filter((_, i) => i !== index);

            // // Filter bahan baku yang belum dipilih di index lain
            // return this.stocks.filter(item => !selectedExceptCurrent.includes(item.product_id));
            return this.stocks
        },
        addProduct() {
            this.selectedCategory.push(null)
            this.selectedProduct.push(null)
            this.selectedPackaging.push(null)
            this.jumlah.push('')
            this.satuan.push('')
            this.unitPrice.push(0)
            this.totalPrice.push(0)
            this.stock.push(0)
        },
        deleteProduct(index) {
            this.selectedCategory.splice(index, 1);
            this.selectedProduct.splice(index, 1);
            this.selectedPackaging.splice(index, 1);
            this.jumlah.splice(index, 1);
            this.satuan.splice(index, 1);
            this.unitPrice.splice(index, 1);
            this.totalPrice.splice(index, 1);
            this.stock.splice(index, 1);
        },

        resetForm(){
            this.id = null,
            this.selectedCustomer = null,
            this.deliveryDate = null,
            this.deliveryTime = null,
            this.selectedPayment = null,
            this.selectedDelivery = null,
            this.selectedCategory = [],
            this.selectedProduct = [],
            this.selectedPackaging = [],
            this.jumlah = [],
            this.satuan = [],
            this.unitPrice = [],
            this.totalPrice = [],
            this.formData = new FormData()

        },
        toggleDialog() {
            this.resetForm()
            this.isDialogVisible = !this.isDialogVisible
        },
        submitForm() {
            const formData = new FormData();

            formData.append('id', this.id);
            formData.append('customer_id', this.selectedCustomer);
            formData.append('delivery_date', this.deliveryDate);
            formData.append('delivery_time', this.deliveryTime);
            formData.append('delivery_status', this.selectedDelivery);
            formData.append('payment_status', this.selectedPayment);
            formData.append('categories', this.selectedCategory);
            formData.append('product_ids', this.selectedProduct);
            formData.append('packages', this.selectedPackaging);
            formData.append('jumlahs', this.jumlah);
            formData.append('unit_prices', this.unitPrice);
            formData.append('total_prices', this.totalPrice);
            formData.append('satuans', this.satuan);
            const id = this.id;

            this.isLoading = true;

            this.$store.dispatch("transaction/process", { formData, id })
                .then((response) => {
                this.notify = true
                this.status = 'success'
                this.title = 'Success!'
                this.text = "Data has been " + (!this.id ? "added" : "updated")
                // notify.value.icon = 'alert-cicle'
                this.isLoading = false
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
            // this.toggleDialog()

            });
        }
    },
  }
  </script>
    
    