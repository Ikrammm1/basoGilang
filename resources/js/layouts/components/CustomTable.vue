<template>
    <VTable class="text-no-wrap">
      <thead>
        <tr>
          <!-- Render Header Kolom -->
          <th
            v-for="header in headers"
            :key="header.key"
            @click="sort(header.key)"
            style="cursor: pointer; font-size: 10px"
          >
            {{ header.title }}
            
            <!-- Tampilkan Ikon Panah Jika Kolom Sedang Diurutkan -->
            <VIcon
              v-if="sortBy === header.key"
              :icon="sortDesc ? 'bx-chevron-down' : 'bx-chevron-up'"
              class="ms-1"
            />
          </th>
        </tr>
      </thead>
  
      <tbody class="text-sm">
        <tr v-for="(item, index) in paginatedData" :key="item.id">
          <td v-for="header in headers" :key="header.key" class="text-sm">
            <slot :name="'item.' + header.key" :item="item" :index="index">
              {{ item[header.key] }}
            </slot>
          </td>
        </tr>
      </tbody>
  
      <!-- Template Pagination di Bawah Tabel -->
      <template #bottom>
        <VCardText class="pt-2">
          <div class="d-flex flex-wrap justify-center justify-sm-space-between gap-y-2 mt-2">
            <VSelect
              v-model="localItemsPerPage"
              :items="items.length ? items : [10, 25, 50, 100]"
              label="Rows per page:"
              variant="underlined"
              style="max-inline-size: 8rem; min-inline-size: 5rem;"
              @change="updateItemsPerPage"
            />
            <VPagination
              v-model="page"
              :total-visible="$vuetify.display.smAndDown ? 2 : 5"
              :length="Math.ceil(filteredData.length / itemsPerPage)"
            />
          </div>
        </VCardText>
      </template>
    </VTable>
  </template>
  
  <script>
  export default {
    props: {
      data: {
        type: Array,
        required: true,
      },
      headers: {
        type: Array,
        required: true,
      },
      search: {
        type: String,
        default: '',
      },
      itemsPerPage: {
        type: Number,
        default: 10,
      },
      items: {
        type: Array,
        default: () => [10, 25, 50, 100],
      },
    },
    emits: ['update:itemsPerPage'],
    data() {
      return {
        page: 1,
        // itemsPerPage: 10,
        sortBy: '',
        sortDesc: false,
        clickCount: {},  // Untuk melacak jumlah klik per kolom
        localItemsPerPage: this.itemsPerPage,
      };
    },
    watch: {
    localItemsPerPage(newVal) {
      this.$emit('update:itemsPerPage', newVal)
    },
    itemsPerPage(newVal) {
      this.localItemsPerPage = newVal
    }
  },
    computed: {
      filteredData() {
        if (!this.search) return this.data;
        const searchLower = this.search.toLowerCase();

        const extractAllValues = (obj) => {
          let values = [];
          for (const key in obj) {
            if (!Object.prototype.hasOwnProperty.call(obj, key)) continue;
            const value = obj[key];
            if (value && typeof value === 'object') {
              values = values.concat(extractAllValues(value)); // Rekursif
            } else {
              values.push(String(value)); // Ambil nilai primitif (termasuk number, boolean, dll)
            }
          }
          return values;
        };

        return this.data.filter(item => {
          const allValues = extractAllValues(item);
          return allValues.some(val => val.toLowerCase().includes(searchLower));
        });
      },
      sortedData() {
        if (!this.sortBy) return this.filteredData;
        return [...this.filteredData].sort((a, b) => {
          const valueA = a[this.sortBy];
          const valueB = b[this.sortBy];
          if (this.sortDesc) {
            return valueA < valueB ? 1 : -1;
          } else {
            return valueA > valueB ? 1 : -1;
          }
        });
      },
      paginatedData() {
        const start = (this.page - 1) * this.itemsPerPage;
        const end = start + this.itemsPerPage;
        return this.sortedData.slice(start, end);
      },
    },
    methods: {
      updateItemsPerPage(val) {
    this.$emit('update:itemsPerPage', val)
  },
      sort(column) {
        // Inisialisasi jika belum ada clickCount untuk kolom ini
        if (this.clickCount[column] === undefined) {
          this.clickCount[column] = 0;
        }
  
        // Logika urutan klik
        if (this.clickCount[column] === 2) {
          // Klik ketiga, reset urutan
          this.sortBy = '';
          this.sortDesc = false;
          this.clickCount[column] = 0;
        } else {
          // Klik pertama atau kedua, urutkan
          if (this.sortBy === column) {
            this.sortDesc = !this.sortDesc; // Toggle direction
          } else {
            this.sortBy = column;
            this.sortDesc = false; // Default to ascending
          }
          this.clickCount[column] += 1;
        }
      },
    },
  };
  </script>
  