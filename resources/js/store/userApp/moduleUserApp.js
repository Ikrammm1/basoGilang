import { list } from "postcss";
import axios from "../../http/axios/index.js"
import { ref } from "vue"

const state = {
  datas : [],
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
//   ADD_ITEM(state, item){
//     state.datas.unshift(item)
//   },
//   UPDATE_ITEM(state, data) {
//     // console.log(data)
//     const Index = state.datas.findIndex((p) => p.id == data.id);
//     Object.assign(state.datas[Index], data);
//   },
//   DELETE_ITEM(state, data) {
//     data.forEach(id => {
//       const Index = state.datas.findIndex((p) => p.id == id);
//       state.datas.splice(Index, 1);
//     });
//   },
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
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};