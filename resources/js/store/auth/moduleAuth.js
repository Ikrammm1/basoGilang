import axios from "../../http/axios/index.js";

const state = {
  token: localStorage.getItem('authToken') || '',
  userData: null,
  userMenus: null,
  menus:[]
};

const mutations = {
  SET_USERS(state, user) {
    state.userData = user;
    localStorage.setItem('userData', JSON.stringify(user));

  },
  SET_MENUS(state, menu) {
    state.userMenus = menu;
    state.menus = menu;
    // console.log(menu)
    localStorage.setItem('userMenus', JSON.stringify(menu));

  },
  SET_TOKEN(state, token) {
    state.token = token;
    localStorage.setItem('authToken', token);

    // Set token to Axios headers
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  },

  
};

const actions = {
  store({ commit }, data) {
    console.log(data)
    return new Promise((resolve, reject) => {
      axios.post('/api/login', data, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
        .then(response => {
          commit('SET_USERS', response.data.datas)          
          commit('SET_MENUS', response.data.menus)          
          commit('SET_TOKEN', response.data.token)          
          resolve(response);
        })
        .catch(error => {
          reject(error);
        });
    });
  }
};

// const getters = {
//   user: state => state.userData,
//   menus: state => state.userMenus
// };

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  // getters
};
