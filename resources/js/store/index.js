import { createStore } from 'vuex';
import moduleAuth from './auth/moduleAuth';
import moduleAuthorizations from './authorizations/moduleAuthorizations';
import moduleMenuManagement from './menuManagement/moduleMenuManagement';
import moduleUserApp from './userApp/moduleUserApp';

const store = createStore({
  modules: {
    auth: moduleAuth,
    menuManagement: moduleMenuManagement,
    authorizations: moduleAuthorizations,
    userApp: moduleUserApp
  },
  // Optionally, you can add global state, getters, mutations, and actions here
});

export default store;
