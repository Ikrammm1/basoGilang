import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  positions : [],
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
  SET_POSITIONS(state, item){
    state.positions = item
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
  async listUser({ commit }) {
    try{
      const response = await axios.post('/api/userApp/listUser', {
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
  async getPositions({ commit }) {
    try{
      const response = await axios.post('/api/userApp/getPositions', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_POSITIONS', response.data)
      return response
    }catch(error){
      throw error
    }
  },

  async process({ commit }, data) {
    const transactionType = data.id ? "update" : "add";

    return new Promise((resolve, reject) => {
      axios.post("/api/userApp/" + transactionType, data.formData, {
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
      axios.delete(`/api/userApp/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_ITEM', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  }
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
