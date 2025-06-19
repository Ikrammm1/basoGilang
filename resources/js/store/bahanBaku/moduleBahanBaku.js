import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  logs : [],
  stocks :[],
  listStock:[],
  needRestocks:[],
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
  SET_NEED(state, item){
    state.needRestocks = item
  },
  SET_LISTSTOCK(state, item){
    state.listStock = item
  },
  ADD_ITEM(state, item){
    state.datas.unshift(item)
  },
  UPDATE_ITEM(state, data) {
    // console.log(data)
    const Index = state.datas.findIndex((p) => p.id == data.id);
    Object.assign(state.datas[Index], data);
  },
  DELETE_ITEM(state, id) {
      const Index = state.datas.findIndex((p) => p.id == id);
      state.datas.splice(Index, 1);
  },
  ADD_LOGS(state, item){
    state.logs.unshift(item)
  },
  UPDATE_LOGS(state, data) {
    // console.log(data)
    const Index = state.logs.findIndex((p) => p.id == data.id);
    Object.assign(state.logs[Index], data);
  },
  DELETE_LOGS(state, id) {
      const Index = state.logs.findIndex((p) => p.id == id);
      state.logs.splice(Index, 1);
  },
};

const actions = {
  async list({ commit }) {
    try{
      const response = await axios.post('/api/bahanBaku/list', {
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
  async needRestock({ commit }) {
    try{
      const response = await axios.post('/api/bahanBaku/stock/needRestock', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_NEED', response.data)
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
      axios.delete(`/api/bahanBaku/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_ITEM', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  },

  newPass({commit}, data){
    console.log(data.formData)
    return new Promise((resolve,reject)=>{
      axios.post("/api/bahanBaku/newPass/" , data.formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      }).then((response)=>{
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  },

  upload({commit}, data){
     // try {
      return new Promise((resolve,reject)=>{
        axios.post("/api/bahanBaku/upload/" , data.formData, {
          headers: {
              'Content-Type': 'multipart/form-data'
          }
        }).then((response)=>{
          resolve(response)
        }).catch((error) => {
            reject(error)
        })
      })
       
    // } catch (error) {
    //     this.$toast.error('An error occurred while uploading the image!');
    // }
  },

  async listLog({ commit }) {
    try{
      const response = await axios.post('/api/bahanBaku/restock/list', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_LOGS', response.data)
      return response
    }catch(error){
      throw error
    }
  },

  async processLog({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/bahanBaku/restock/" + transactionType, data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {         
        if (data.id) {
          commit("UPDATE_LOGS", response.data.datas); 
        } else {
          commit("ADD_LOGS", response.data.datas); 
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
      axios.delete(`/api/bahanBaku/restock/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_LOGS', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
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
  async stock({ commit }) {
    try{
      const response = await axios.post('/api/bahanBaku/stock/getStock', {
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
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
