import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  provinces : [],
  provs : [],
  kabs : [],
  kecs : [],
  kels : [],
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
  SET_PROVS(state, item){
    state.provs = item
  },
  SET_KABS(state, item){
    state.kabs = item
  },
  SET_KECS(state, item){
    state.kecs = item
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
};

const actions = {
  async list({ commit }) {
    try{
      const response = await axios.post('/api/customer/list', {
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

  async getProv({ commit }) {
    try{
      const response = await axios.post('/api/customer/getProv')
      commit('SET_PROVS', response.data.data)
      return response
    }catch(error){
      throw error
    }
  },
  async getKab({ commit },data) {
    try{
      const response = await axios.post(`/api/customer/getKab/${data.codeProv}`)
      commit('SET_KABS', response.data.data)
      return response
    }catch(error){
      throw error
    }
  },
  async getKec({ commit },data) {
    try{
      const response = await axios.post(`/api/customer/getKec/${data.codeKab}`)
      // console.log(response.data.data)
      commit('SET_KECS', response.data.data)

      return response
    }catch(error){
      throw error
    }
  },

  async process({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/customer/" + transactionType, data.formData, {
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
      axios.delete(`/api/customer/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_ITEM', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  },

  newPass({commit}, data){
    return new Promise((resolve,reject)=>{
      axios.post("/api/customer/newPass/" , data.formData, {
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
        axios.post("/api/customer/upload/" , data.formData, {
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
  }
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
