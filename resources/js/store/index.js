import { createStore } from 'vuex';
import moduleAuth from './auth/moduleAuth';
import moduleAuthorizations from './authorizations/moduleAuthorizations';
import moduleBahanBaku from './bahanBaku/moduleBahanBaku';
import moduleBahanKemasan from './bahanKemasan/moduleBahanKemasan';
import moduleCategory from './category/moduleCategory';
import moduleCustomer from './customer/moduleCustomer';
import moduleMenuManagement from './menuManagement/moduleMenuManagement';
import moduleOngkir from './ongkir/moduleOngkir';
import modulePackaging from './packaging/modulePackaging';
import modulePosition from './positionUser/modulePosition';
import moduleProduct from './product/moduleProduct';
import moduleReport from './report/moduleReport';
import moduleStock from './stock/moduleStock';
import moduleTransaction from './transaction/moduleTransaction';
import moduleUserApp from './userApp/moduleUserApp';
import moduleVendor from './vendorManagement/moduleVendor';


const store = createStore({
  modules: {
    auth: moduleAuth,
    menuManagement: moduleMenuManagement,
    authorizations: moduleAuthorizations,
    userApp: moduleUserApp,
    position: modulePosition,
    category: moduleCategory,
    product: moduleProduct,
    vendor: moduleVendor,
    bahanBaku: moduleBahanBaku,
    bahanKemasan: moduleBahanKemasan,
    stock: moduleStock,
    packaging: modulePackaging,
    ongkir: moduleOngkir,
    customer: moduleCustomer,
    transaction:moduleTransaction,
    report:moduleReport,
  },
  // Optionally, you can add global state, getters, mutations, and actions here
});

export default store;
