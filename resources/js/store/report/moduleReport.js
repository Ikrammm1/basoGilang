import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  sales : [],
  expenses:[],
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
  SET_SALES(state, item){
    state.sales = item
  },
  SET_EXPENSES(state, item){
    state.expenses = item
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
      const response = await axios.post('/api/ongkir/list', {
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

  
  async getExpenses({ commit }, data) {
  
    return new Promise((resolve, reject) => {
      axios.post("/api/report/getExpenses", data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {     
        commit("SET_EXPENSES", response.data); 
         
        resolve(response.data);
      })
      .catch(error => {
        reject(error);
      });
    });
  },
  async getReport({ commit }, data) {
  
    return new Promise((resolve, reject) => {
      axios.post("/api/report/getReport", data.formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {     
        commit("SET_SALES", response.data); 
         
        resolve(response.data);
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
