
<template>
    <VDialog
        v-model= "isDialogVisible"
        max-width="1000"
    >
    
        <!-- <DialogCloseBtn @click="toggleDialog()" /> -->
    
        <!-- Dialog Content -->
        <VCard :title="'Form ' + from">    
            <VForm @submit.prevent="() => {}">
                <VCardText>
                    <VRow class="mb-2">
                         <VCol>
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="name" >Customer</label>
                                    <VSelect
                                        v-model="selectedCustomer"
                                        :items="customerList"
                                        placeholder="Pilih Customer"
                                        persistent-placeholder
                                        item-title="name"
                                        item-value="id"
                                        class="mt-2"
                                        
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                        
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="deliveryDate" >Tanggal Pengiriman</label>

                                     <VTextField
                                        id="deliveryDate"
                                        v-model="deliveryDate"
                                        type="date"
                                        placeholder="tanggal pengiriman"
                                        class="mt-2"
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="deliveryTime" >Jam Pengiriman</label>

                                     <VTextField
                                        id="deliveryTime"
                                        v-model="deliveryTime"
                                        placeholder="Satuan"
                                        class="mt-2"
                                        type="time"
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="status" >Status Pembayaran</label>

                                    <VSelect
                                        v-model="selectedPayment"
                                        :items="paidList"
                                        placeholder="Pilih status"
                                        persistent-placeholder
                                        item-title="name"
                                        item-value="name"
                                        class="mt-2"
                                        
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="packStatus" >Status Packing</label>

                                     <VSelect
                                        v-model="packStatus"
                                        :items="packList"
                                        placeholder="Pilih status"
                                        persistent-placeholder
                                        item-title="name"
                                        item-value="name"
                                        class="mt-2"
                                        
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                         <VCol cols="12">
                            <VRow no-gutters>
                                <VCol
                                    cols="12"
                                >
                                    <label for="deliveryStatus" >Status Pengiriman</label>

                                     <VSelect
                                        v-model="selectedDelivery"
                                        :items="deliveryList"
                                        placeholder="Pilih status"
                                        persistent-placeholder
                                        item-title="name"
                                        item-value="name"
                                        class="mt-2"
                                        
                                    />
                                </VCol>
                            </VRow>
                        </VCol> 
                    </VRow>
                    <div class="mt-3 mb-2">
                        <VRow justify="space-between" align="center">
                        <VCol cols="auto">
                            <h3>Detail pesanan</h3>
                        </VCol>
                        <VCol cols="auto" class="d-flex justify-end">
                            <VBtn icon color="success" @click="addPaket">
                            <VIcon icon="bx-plus" />
                            </VBtn>
                        </VCol>
                        </VRow>
                    </div>

                    <div v-for="(pkg, pkgIndex) in packages" :key="pkgIndex" >
                        <VRow class="mt-2">
                            <VCol>
                                <h3 >Paket  {{ pkgIndex+1 }}</h3>
                            </VCol>
                            <VCol cols="auto" class="d-flex justify-end">
                            <VBtn icon color="error" @click="deletePaket(pkgIndex)">
                                <VIcon icon="bx-trash" />
                            </VBtn>
                            </VCol>
                        </VRow>
                        <VRow class="mt-3">
                            <VCol cols="12">
                                <VRow no-gutters class="justify-center">
                                    <VCol cols="5">
                                        <h3>Daftar item</h3>

                                    </VCol>
                                    <VCol cols="5" class="d-flex justify-end">

                                        <VBtn icon color="success" @click="addProduct(pkgIndex)">
                                            <VIcon icon="bx-plus" />
                                        </VBtn>

                                    </VCol>
                                </VRow>
                            </VCol>
                        </VRow>
                        
                        <VRow>
                            <VCol cols="12" v-for="(prod, prodIndex) in pkg.products" :key="prodIndex">
                                <VRow class="justify-center mt-2">
                                    <VCol cols="10">
                                        <VRow no-gutters class="justify-center">
                                            <VCol>
                                                <h3 >Item  {{ prodIndex+1 }}</h3>
                                            </VCol>
                                            <VCol cols="auto" class="d-flex justify-end">
                                            <VBtn icon color="error" @click="deleteProductFromPackage(pkgIndex,prodIndex)">
                                                <VIcon icon="bx-trash" />
                                            </VBtn>
                                            </VCol>
                                        </VRow>
                                    </VCol>
                                </VRow>
                                <VRow>
                                    <VCol cols="12">
                                        <VRow no-gutters class="justify-center">
                                            <VCol cols="10 mr-3 ml-4" md="5">
                                                <label for="status" >Kategori</label>

                                                <VSelect
                                                    v-model="prod.category"
                                                    :items="categoryList"
                                                    placeholder="Pilih kategori"
                                                    persistent-placeholder
                                                    item-title="name"
                                                    item-value="name"
                                                    class="mt-2"
                                                    
                                                />
                                            </VCol>
                                             <VCol cols="10" md="5  mt-3">
                                                <label>Produk</label>
                                                <VSelect
                                                    v-model="prod.product"
                                                    :items="getAvailableProducts(pkgIndex, prod.category)"
                                                    placeholder="Pilih Product"
                                                    item-title="name"
                                                    item-value="id"
                                                    @update:model-value="onProductSelect(pkgIndex, prodIndex)"
                                                    />
                                            </VCol>
                                        </VRow>
                                    </VCol>
                                </VRow>
                                <VRow no-gutters class="justify-center ml-3">
                                    <VCol cols="10" md="5 mr-3 mt-3">
                                        <label>Satuan</label>
                                        <VTextField
                                            v-model="prod.satuan"
                                            type="text"
                                            placeholder="Satuan"
                                            :disabled="true"
                                        />
                                    </VCol>
                                    <VCol cols="10" md="5 mt-3">
                                    <label>Jumlah per pack</label>
                                    <VTextField
                                        v-model="prod.jumlah"
                                        type="number"
                                        placeholder="Jumlah"
                                    />
                                    <small v-if="prod.category=='Frozen'">Stok produk = {{ prod.remaining  }}</small>
                                    </VCol>
                                  
                                    
                                </VRow>
                                <!-- <VRow no-gutters class="justify-center mt-3">
                                    <VCol cols="10">
                                    <label>Satuan</label>
                                    <VTextField
                                        v-model="prod.satuan"
                                        type="text"
                                        placeholder="Satuan"
                                    />
                                    </VCol>
                                </VRow> -->
                            </VCol>

                            <VCol cols="12" >
                                <VRow no-gutters class="justify-center mt-2">
                                    
                                    <VCol cols="10">
                                        <label>Packaging</label>
                                        <VSelect
                                        v-model="pkg.packaging"
                                        :items="getAvailablePackaging(pkgIndex)"
                                        placeholder="Pilih Packaging"
                                        item-title="bahan_kemasan"
                                        item-value="kemasan_id"
                                        />
                                    </VCol>
                                </VRow>
                                <VRow no-gutters class="justify-center mt-3">
                                    <VCol cols="10">
                                    <label>Jumlah Pack</label>
                                    <VTextField
                                        v-model="pkg.jumlahPack"
                                        type="number"
                                        placeholder="Jumlah Pack"
                                    />
                                    </VCol>
                                </VRow>
                                <VRow no-gutters class="justify-center mt-2">

                                <VCol cols="10 mt-2">
                                <label>Total Harga + Packaging</label>
                                <VTextField
                                    v-model="pkg.totalPrice"
                                    type="number"
                                    placeholder="Total"
                                    :disabled=true
                                />
                                </VCol>
                            </VRow>
                            </VCol>

                            
                        </VRow>
                    </div>
                   
            
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
            selectedProduct: [],
            selectedPackaging: [],
            jumlah: [],
            oldJumlah: [],
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
            selectedDelivery:null,
            selectedPayment:null,
            deliveryTime:null,
            deliveryDate:null,
            selectedCustomer:null,
            packStatus:null,
            selectedCategory:[],
            stocks:[],

            //new revisi
            packages : [],
            usedPackagingCount: {},
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
                this.selectedCustomer = Number(customer_id);
                this.deliveryDate = delivery_date
                this.deliveryTime = delivery_time
                this.selectedPayment = payment_status
                this.selectedDelivery = delivery_status
                this.packStatus = packStatus
                this.packages = packages


             
               
            }
            
        },

        packages: {
            deep: true,
            handler(newPackages, oldPackages) {
                const usageCounter = {};
                const frozenCounter = {};
                let allTotalPrice = 0;

                newPackages.forEach((pkg, pkgIndex) => {
                    let totalPricePerPackage = 0;
                    const availableProducts = this.getAvailableProducts(pkgIndex, 'Frozen');

                    pkg.products.forEach((prod, prodIndex) => {
                        const jumlah = Number(prod.jumlah) || 0;
                        const jumlahPack = Number(pkg.jumlahPack) || 0;

                        // Hitung penggunaan produk Frozen
                        if (prod.category === 'Frozen' && prod.product) {
                            frozenCounter[prod.product] = (frozenCounter[prod.product] || 0) + jumlah;
                        }

                        const selected = this.productList.find(item => item.id == prod.product);
                        const selectedCategory = this.categoryList.find(item => item.name == prod.category);

                        // Set satuan dan harga
                        prod.unit_price = selected?.price ?? 0;
                        prod.total_price = prod.unit_price * jumlah;
                        prod.satuan = selected?.satuan || '';
                        totalPricePerPackage += prod.total_price;

                        // Ambil stok & remaining
                        let remaining = 0;
                        if (prod.category === 'Frozen') {
                            const found = availableProducts.find(p => p.id === prod.product);
                            remaining = found?.remaining ?? 0;
                            prod.stock = remaining;
                        } else if (prod.category === 'Fresh' && this.statusPack === 'Pack') {
                            if (selected?.stock?.length) {
                                remaining = selected.stock[0].total_qty;
                                prod.stock = remaining;
                            } else {
                                remaining = 0;
                                prod.stock = 0;
                            }
                        } else {
                            // Fresh dan Unpack → tidak pakai validasi stok
                            prod.stock = null;
                            remaining = Infinity;
                        }

                        // VALIDASI: batasi jika jumlah * jumlahPack melebihi remaining
                        if (jumlah && jumlahPack && jumlah * jumlahPack > remaining) {
                            const maxJumlah = Math.floor(remaining / jumlahPack) || 1;
                            prod.jumlah = maxJumlah;
                        }
                    });

                    // Hitung penggunaan kemasan
                    if (pkg.packaging) {
                        usageCounter[pkg.packaging] = (usageCounter[pkg.packaging] || 0) + 1;
                    }

                    // Hitung total harga per paket
                    if (pkg.jumlahPack) {
                        const selectedPackaging = this.packagingList.find(item => item.kemasan_id == pkg.packaging);
                        const packagingPrice = selectedPackaging ? Number(selectedPackaging.price) : 0;
                        pkg.totalPrice = (pkg.jumlahPack * packagingPrice) + (pkg.jumlahPack * totalPricePerPackage);
                    }
                });

                // Simpan ke state
                this.usedPackagingCount = usageCounter;
                this.usedFrozenProductCount = frozenCounter;
            }




        },
        
    },
    computed:{
        productList(){
            // Mengakses data dari Vuex store
            const data = this.$store.state.product.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0 ) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`

                return data.filter(product => Array.isArray(product.stock));
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        packagingList(){
            // Mengakses data dari Vuex store
            const data = this.$store.state.bahanKemasan.listStock;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
                
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data.filter(item => item.category ==1);
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        availablePackaging() {
            // Buat daftar packaging berdasarkan sisa stock
            return this.packagingList.map(pkg => {
            const used = this.usedPackagingCount[pkg.kemasan_id] || 0;
            const remaining = pkg.sisa_stock - used;
            console.log(remaining)
            return {
                ...pkg,
                remaining
            }
            }).filter(pkg => pkg.remaining > 0);
        },
        customerList(){
             // Mengakses data dari Vuex store
            const data = this.$store.state.customer.datas;

            // Memastikan data ada dan berupa array
            if (Array.isArray(data) && data.length > 0) {
            // Jika data ada, kembalikan data tersebut tanpa perlu menggunakan `ref` dan `toRaw`
            return data;
            }

            // Jika tidak ada data, kembalikan array kosong
            return [];
        },
        

        categoryList(){
            return ([{'name':'Fresh'},{'name':'Frozen'}])
        },
        paidList(){
            return ([{'name':'Paid'},{'name':'Unpaid'}])
        },
        deliveryList(){
            return ([{'name':'Deliver'},{'name':'Pending'}])
        },
        packList(){
            return ([{'name':'Pack'},{'name':'Unpack'}])
        },

        isFormValid(){
            return (
                this.selectedCustomer != null 
                &&
                this.selectedPayment != null &&
                this.selectedDelivery != null &&
                this.packStatus != null &&
                this.packages .length != 0
                // (this.selectedCategory.length != 0 &&
                // this.selectedCategory.every(val => val != null && val !== '')) &&


            )
        },
    },
    methods:{
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

       getAvailableProducts(pkgIndex, category) {
    if (category === 'Fresh') {
        return this.productList;
    }

    return this.productList
        .map(product => {
            const stockItem = product.stock && product.stock[0];
            const frozenStock = stockItem ? stockItem.total_qty_frozen : 0;

            // Hitung total pemakaian produk ini di semua paket (jumlah * jumlahPack)
            let totalUsed = 0;

            this.packages.forEach((pkg, index) => {
                pkg.products.forEach(p => {
                    if (p.product === product.id && p.category === 'Frozen') {
                        const jumlah = Number(p.jumlah) || 0;
                        const jumlahPack = Number(pkg.jumlahPack) || 0;
                        totalUsed += jumlah * jumlahPack;
                    }
                });
            });

            // Hitung pemakaian di current package
            const currentPkg = this.packages[pkgIndex];
            let usedInCurrentPkg = 0;
            const currentJumlahPack = Number(currentPkg.jumlahPack) || 0;

            currentPkg.products.forEach(p => {
                if (p.product === product.id && p.category === 'Frozen') {
                    usedInCurrentPkg += (Number(p.jumlah) || 0) * currentJumlahPack;
                }
            });

            // Hitung remaining: stok - total dipakai + yang sedang dipakai di paket ini (biar nggak double count saat edit)
            const remaining = frozenStock - totalUsed + usedInCurrentPkg;

            return {
                ...product,
                remaining
            };
        })
        .filter(product => product.remaining > 0);
},

       onProductSelect(pkgIndex, prodIndex) {
    const prod = this.packages[pkgIndex].products[prodIndex];
    const products = this.getAvailableProducts(pkgIndex, prod.category);
    const selected = products.find(p => p.id === prod.product);

    prod.satuan = selected?.satuan || '';
    prod.remaining = selected?.remaining || 0;
    prod.stock = selected?.remaining || 0; // jangan dikurangi 1
},

        getAvailablePackaging(pkgIndex) {
            return this.packagingList.map(pkg => {
            const used = this.usedPackagingCount[pkg.kemasan_id] || 0;
            const currentPkg = this.packages[pkgIndex];
            const isUsedHere = currentPkg.packaging == pkg.kemasan_id ? 1 : 0;
            const remaining = pkg.sisa_stock - used + isUsedHere;

            return {
                ...pkg,
                remaining
            };
            }).filter(pkg => pkg.remaining > 0);
        },
        addPaket() {
            // this.selectedCategory.push(null)
            // this.selectedProduct.push(null)
            // this.selectedPackaging.push(null)
            // this.jumlah.push('')
            // this.satuan.push('')
            // this.unitPrice.push(0)
            // this.totalPrice.push(0)
            // this.stock.push(0)


            this.packages.push({
                packaging: null,
                jumlahPack: 0,
                totalPrice: 0,
                products: [
                    {
                    category: null,
                    product: null,
                    jumlah: '',
                    satuan: '',
                    unit_price: 0,
                    total_price: 0,
                    stock: 0
                    }
                ]
            });
        },
        deletePaket(index) {
            this.selectedCategory.splice(index, 1);
            this.selectedProduct.splice(index, 1);
            this.selectedPackaging.splice(index, 1);
            this.jumlah.splice(index, 1);
            this.satuan.splice(index, 1);
            this.unitPrice.splice(index, 1);
            this.totalPrice.splice(index, 1);
            this.stock.splice(index, 1);

            this.packages.splice(index, 1);
        },
        addProduct(index){
            this.packages[index].products.push({
                category: null,
                product: null,
                jumlah: '',
                satuan: '',
                unit_price: 0,
                total_price: 0,
                stock: 0
            });
        },
        deleteProductFromPackage(packageIndex, productIndex) {
            this.packages[packageIndex].products.splice(productIndex, 1);
        },

        resetForm(){
            this.id = null,
            this.selectedCustomer = null,
            this.deliveryDate = null,
            this.deliveryTime = null,
            this.selectedPayment = null,
            this.selectedDelivery = null,
            this.packStatus = null,
            this.packages = [],
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
            this.deliveryDate ? formData.append('delivery_date', this.deliveryDate) : null;
            this.deliveryTime ? formData.append('delivery_time', this.deliveryTime) : null;

            formData.append('delivery_status', this.selectedDelivery);
            formData.append('payment_status', this.selectedPayment);
            formData.append('packStatus', this.packStatus);
            this.packages.forEach((pkg, pkgIndex) => {
                formData.append(`packages[${pkgIndex}][packaging]`, pkg.packaging);
                formData.append(`packages[${pkgIndex}][jumlahPack]`, pkg.jumlahPack);
                formData.append(`packages[${pkgIndex}][totalPrice]`, pkg.totalPrice);

                pkg.products.forEach((prod, prodIndex) => {
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][category]`, prod.category);
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][product_id]`, prod.product);
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][jumlah]`, prod.jumlah);
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][satuan]`, prod.satuan);
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][unit_price]`, prod.unit_price);
                formData.append(`packages[${pkgIndex}][products][${prodIndex}][total_price]`, prod.total_price);
                });
            });
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
    
    