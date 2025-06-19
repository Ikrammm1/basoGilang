import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  logs : [],
  stocks :[],
  liststock :[],
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
  SET_LOGS(state, item){
    state.logs = item
  },
  SET_STOCK(state, item){
    state.stocks = item
  },
  SET_LISTSTOCK(state, item){
    state.listStock = item
  },
  ADD_ITEM(state, item){
    state.datas.unshift(item)
  },
  UPDATE_ITEM(state, data) {
    // const Index = state.datas.findIndex((p) => p.id == data.id);
    // Object.assign(state.datas[Index], data);

    const Index = state.datas.findIndex((p) => p.id == data.id);
    state.datas.splice(Index, 1);

    state.datas.unshift(data)
  },
   UPDATE_STOCK(state, data) {
    // console.log(data)
    const Index = state.listStock.findIndex((p) => p.id == data.id);
    Object.assign(state.listStock[Index], data);
  },
  DELETE_ITEM(state, id) {
      const Index = state.datas.findIndex((p) => p.id == id);
      state.datas.splice(Index, 1);
  },
 
};

const actions = {
  async list({ commit }) {
    try{
      const response = await axios.post('/api/produksi/list', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_ITEMS', response.data)
      return response
    }catch(error){
      throw error
    }
  },

  async process({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/bahanBaku/" + transactionType, data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {         
        if (data.id) {
          commit("UPDATE_ITEM", response.data.datas); 
        } else {
          commit("ADD_ITEM", response.data.datas); 
        }   
  
        resolve(response.data.datas);
      })
      .catch(error => {
        reject(error);
      });
    });
  },

  delete({commit}, data){
    return new Promise((resolve, reject)=>{
      axios.delete(`/api/produksi/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_ITEM', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  },

  async processProduksi({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/produksi/" + transactionType, data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {         
        if (data.id) {
          commit("UPDATE_ITEM", response.data.datas); 
        } else {
          commit("ADD_ITEM", response.data.datas); 
        }   
  
        resolve(response.data.datas);
      })
      .catch(error => {
        reject(error);
      });
    });
  },


  async listStock({ commit }) {
    try{
      const response = await axios.post('/api/bahanBaku/stock/list', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_STOCK', response.data)
      return response
    }catch(error){
      throw error
    }
  },
  async stocks({ commit }) {
    try{
      const response = await axios.post('/api/stock/list', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_LISTSTOCK', response.data)
      return response
    }catch(error){
      throw error
    }
  },

  async updateStock({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/stock/" + transactionType, data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {         
        if (data.id) {
          commit("UPDATE_STOCK", response.data.datas); 
        } else {
          commit("ADD_STOCK", response.data.datas); 
        }   
  
        resolve(response.data.datas);
      })
      .catch(error => {
        reject(error);
      });
    });
  },
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
