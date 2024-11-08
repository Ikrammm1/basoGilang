import axios from "../../http/axios/index.js";

const state = {
  menus: null,
  datas : [],
  parent: []
};

const mutations = {
  SET_MENUS(state, menu) {
    state.userMenus =menu;
  },
  SET_ITEMS(state, item){
    // console.log(item)
    state.datas = item
    // console.log(state.datas)
  },
  SET_PARENTS(state, item){
    state.parent = item
  },
  ADD_ITEM(state, item){
    state.datas.unshift(item)
  },
  UPDATE_ITEM(state, data) {
    console.log(state)
    console.log(data.id)
    const Index = state.datas.findIndex((p) => p.id == data.id);
    // console.log(Index)
    // console.log(state.datas)
    Object.assign(state.datas[Index], data);
  },
  DELETE_ITEM(state, data) {
    data.forEach(id => {
      const Index = state.datas.findIndex((p) => p.id == id);
      state.datas.splice(Index, 1);
    });
      
  },
  
};

const actions = {
  authlist({ commit }, data) {
    // console.log(data)
    return new Promise((resolve, reject) => {
      axios.post('/api/menu-management/list', data, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
        .then(response => {       
          commit('SET_MENUS', response.data.menus)           
          resolve(response.data.menus);
        })
        .catch(error => {
          reject(error);
        });
    });
  },
  async list({ commit }) {
    try{
      const response = await axios.post('/api/menu-management/menuList', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_ITEMS', response.data)
      return response
    }catch(error){
      throw error
    }
   
    // // console.log(data)
    // return new Promise((resolve, reject) => {
    //   axios.post('/api/menu-management/menuList', {
    //     headers: {
    //         'Content-Type': 'multipart/form-data'
    //     }
    //   })
    //     .then(response => {       
    //       commit('SET_ITEMS', response.data)           
    //       resolve(response.data);
    //     })
    //     .catch(error => {
    //       reject(error);
    //     });
    // });
  },
  getParent({ commit }, item) {
    // console.log(data)
    return new Promise((resolve, reject) => {
      axios.post(`/api/menu-management/getParent/${item.category}`, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
        .then(response => {       
          commit('SET_PARENTS', response.data)           
          resolve(response.data);
        })
        .catch(error => {
          reject(error);
        });
    });
  },
  async process({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
    // console.log(transactionType)

    return new Promise((resolve, reject) => {
      axios.post("/api/menu-management/" + transactionType, data.formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
        .then(response => {       
          // commit('SET_PARENTS', response.data)        
          if (data.id) {
            commit("UPDATE_ITEM", response.data.datas); 
            // console.log(response.data.datas)// Pastikan struktur data benar
          } else {
            commit("ADD_ITEM", response.data.datas); // Pastikan struktur data benar
          }   
          resolve(response.data.datas);
        })
        .catch(error => {
          reject(error);
        });
    });
    
    // try {
    //   // Tentukan tipe transaksi berdasarkan apakah ID ada atau tidak
    //   const transactionType = data.id ? "update" : "add";
      
    //   // Gunakan axios untuk mengirimkan request POST dan tunggu responsenya
    //   const response = await axios.post("/api/menu-management/" + transactionType, data.formData);
  
    //   // Jika ID ada, lakukan update, jika tidak, lakukan add
    //   if (data.id) {
    //     commit("UPDATE_ITEM", response.data.datas); 
    //     // console.log(response.data.datas)// Pastikan struktur data benar
    //   } else {
    //     commit("ADD_ITEM", response.data.datas); // Pastikan struktur data benar
    //   }
  
    //   // Mengembalikan respons jika berhasil
    //   // console.log(response)
    //   return response;
  
    // } catch (error) {
    //   // Jika terjadi error, lemparkan ke catch
    //   throw error;
    // }
  
  
  },
  delete({commit}, data){
    // console.log(data.id)
    return new Promise((resolve, reject)=>{
      axios.post("/api/menu-management/delete", data.formData)
      .then((response)=>{
        commit('DELETE_ITEM', response.data.id)
        resolve(response)
      })
    })
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
