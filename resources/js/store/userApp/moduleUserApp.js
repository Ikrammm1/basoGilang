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
    // console.log(data.from)
    return new Promise((resolve, reject) => {
      axios.post("/api/userApp/" + transactionType, data.formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
        .then(response => {         
          if (data.id) {
            if(data.from != 'User'){
              commit("UPDATE_ITEM", response.data.datas); 
            }else{
              let userData = JSON.parse(localStorage.getItem('userData'));
              userData.name = response.data.datas.name
              userData.email = response.data.datas.email
              userData.phone = response.data.datas.phone
              userData.photo = response.data.datas.photo

              localStorage.setItem('userData', JSON.stringify(userData));
            }
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
  },

  newPass({commit}, data){
    console.log(data.formData)
    return new Promise((resolve,reject)=>{
      axios.post("/api/userApp/newPass/" , data.formData, {
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
        axios.post("/api/userApp/upload/" , data.formData, {
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
