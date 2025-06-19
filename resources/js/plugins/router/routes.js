export const routes = [
  { path: '/', redirect: '/login' },
  {
    path: '/',
    component: () => import('@/layouts/default.vue'),
    children: [
      {
        path: 'dashboard',
        name: 'dashboard',
        component: () => import('@/pages/dashboard/Index.vue'),
      },
      // {
      //   path: 'account-settings',
      //   component: () => import('@/pages/account-settings.vue'),
      // },
      // {
      //   path: 'typography',
      //   component: () => import('@/pages/typography.vue'),
      // },
      // {
      //   path: 'icons',
      //   component: () => import('@/pages/icons.vue'),
      // },
      // {
      //   path: 'cards',
      //   component: () => import('@/pages/cards.vue'),
      // },
      // {
      //   path: 'tables',
      //   component: () => import('@/pages/tables.vue'),
      // },
      // {
      //   path: 'form-layouts',
      //   component: () => import('@/pages/form-layouts.vue'),
      // },

      //page Route
      { path: 'menuManagement', 
        name: 'Menu', 
        component: () => import('@/pages/menuManagement/Index.vue'),
        // component: () => import("./Pages/menuManagement/Index.vue")
       },

       //===============AUTHORIZATION GROUP=============== 

      { path: 'authorizationGroup', 
        name: 'Authorization', 
        // component: () => import("./Pages/authorizationGroup/Index.vue")
        component: () => import('@/pages/authorizationGroup/Index.vue'),
       },
       //===============REPORRT=============== 

      { path: 'report', 
        name: 'Report', 
        component: () => import("@/pages/report/Index.vue")
        // component: () => import('@/pages/form-layouts.vue'),
       },
      { path: 'report/expenses', 
        name: 'Report Expense', 
        component: () => import("@/pages/report/expense/Index.vue")
        // component: () => import('@/pages/form-layouts.vue'),
       },

       //===============USER MANAGEMENT=============== 

      { path: 'user-management', 
        name: 'UserManagement', 
        // component: () => import("./Pages/report/Index.vue")
        component: () => import('@/pages/userApp/Index.vue'),

       },
       //===============POSITION MANAGEMENT=============== 

      { path: 'position-management', 
        name: 'positionManagement', 
        component: () => import('@/pages/positionUser/Index.vue'),

       },

       //===============CATEGORY MANAGEMENT=============== 

      { path: 'category-management', 
        name: 'categoryManagement', 
        component: () => import('@/pages/category/Index.vue'),

       },

      //===============PRODUCT MANAGEMENT=============== 

      { path: 'items/produk', 
        name: 'productManagement', 
        title:'Produk Management',
        component: () => import('@/pages/product/Index.vue'),

      },

      //===============VENDOR MANAGEMENT=============== 

      { path: 'items/vendor', 
        name: 'vendor', 
        title:'Vendor Management',
        component: () => import('@/pages/vendorManagement/Index.vue'),

      },

      //===============BAHAN BAKU MANAGEMENT=============== 

      { path: 'items/bahan-baku/list', 
        name: 'bahanBaku', 
        title:'Bahan Baku',
        component: () => import('@/pages/bahanBaku/Index.vue'),

      },
      //===============BAHAN BAKU RESTOCK=============== 

      { path: 'items/bahan-baku/restock', 
        name: 'restockBahanBaku', 
        title:'Restock Bahan Baku',
        component: () => import('@/pages/bahanBaku/restock/Index.vue'),

      },

      //===============BAHAN BAKU USED=============== 

      { path: 'items/bahan-baku/used', 
        name: 'usedBahanBaku', 
        title:'Penggunaan Bahan Baku',
        component: () => import('@/pages/bahanBaku/usedBahanBaku/Index.vue'),

      },

      //===============BAHAN BAKU STOCK=============== 

      { path: 'items/bahan-baku/stock', 
        name: 'stockBahanBaku', 
        title:'Stock Bahan Baku',
        component: () => import('@/pages/bahanBaku/stockBahanBaku/Index.vue'),

      },
      //===============BAHAN KEMASAN MANAGEMENT=============== 

      { path: 'items/bahan-kemasan/list', 
        name: 'bahan-kemasan', 
        title:'Bahan Kemasan',
        component: () => import('@/pages/bahanKemasan/Index.vue'),

      },
      //===============BAHAN KEMASAN RESTOCK=============== 

      { path: 'items/bahan-kemasan/restock', 
        name: 'restockBahanKemasan', 
        title:'Restock Bahan kemasan',
        component: () => import('@/pages/bahanKemasan/restock/Index.vue'),

      },

      //===============BAHAN KEMASAN USED=============== 

      { path: 'items/bahan-kemasan/used', 
        name: 'usedBahanKemasan', 
        title:'Penggunaan Bahan kemasan',
        component: () => import('@/pages/bahanKemasan/usedBahanKemasan/Index.vue'),

      },

      //===============BAHAN KEMASAN STOCK=============== 

      { path: 'items/bahan-kemasan/stock', 
        name: 'stockBahanKemasan', 
        title:'Stock Bahan kemasan',
        component: () => import('@/pages/bahanKemasan/stockBahanKemasan/Index.vue'),

      },

      //===============PRODUKSI=============== 

      { path: 'produksi', 
        name: 'produksi', 
        title:'Produksi',
        component: () => import('@/pages/stock/produksi/Index.vue'),

      },

      //===============Packaging=============== 

      { path: 'packaging', 
        name: 'packaging', 
        title:'Packaging',
        component: () => import('@/pages/packaging/Index.vue'),

      },
      //===============ONGKIR=============== 

      { path: 'items/ongkir', 
        name: 'ongkir', 
        title:'Ongkir',
        component: () => import('@/pages/ongkir/Index.vue'),
      },

      //===============DATA CUSTOMER=============== 

      { path: 'data-customer', 
        name: 'customer', 
        title:'Data Customer',
        component: () => import('@/pages/customer/Index.vue'),
      },
      //===============STOCK MANAGEMENT=============== 

      { path: 'stock-product', 
        name: 'stock-product', 
        title:'Stock Product',
        component: () => import('@/pages/stock/Index.vue'),
      },
      //===============TRANSACTIONS MANAGEMENT=============== 

      { path: 'transaction/data', 
        name: 'transactions', 
        title:'Transaksi',
        component: () => import('@/pages/transaction/Index.vue'),
      },


       //===============PROFILE=============== 

      { path: 'profile', 
        name: 'profile', 
        component: () => import('@/pages/profile/Index.vue'),

       },


       //END
    ],
  },
  {
    path: '/',
    component: () => import('@/layouts/blank.vue'),
    children: [
      {
        path: 'login',
        name: 'Login',
        component: () => import('@/pages/login.vue'),
      },
      {
        path: 'register',
        component: () => import('@/pages/register.vue'),
      },
      {
        path: '/:pathMatch(.*)*',
        component: () => import('@/pages/[...error].vue'),
      },
    ],
  },
]
