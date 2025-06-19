import axios from "../../http/axios/index.js";

const state = {
  datas : [],
  stocks :[],
  today :{},
  pending :[],
  weeklySeries: [],
  weeklyCategories: [],
  weeklyIncomeSeries: [],
  weeklyIncomeStats: {
    percent: 0,
    amount: 0,
    total: 0,
  },
};

const mutations = {
  SET_ITEMS(state, item){
    state.datas = item
  },
 
  SET_STOCK(state, item){
    state.stocks = item
  },
  SET_TODAY(state, payload) {
    state.today = payload
  },
  SET_PENDING(state, payload) {
    state.pending = payload
  },
  SET_WEEKLY_DATA(state, { series, categories }) {
      state.weeklySeries = series
      state.weeklyCategories = categories
    },

    SET_WEEKLY_INCOME(state, { series, stats }) {
    state.weeklyIncomeSeries = series
    state.weeklyIncomeStats = stats
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
   
  DELETE_ITEM(state, id) {
      const Index = state.datas.findIndex((p) => p.id == id);
      state.datas.splice(Index, 1);
  },
 
};

const actions = {
  async list({ commit }) {
    try{
      const response = await axios.post('/api/transaction/list', {
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
  async listToday({ commit }) {
   try{
      const response = await axios.post('/api/transaction/todayList', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      // console.log(response.data.summary)
      commit('SET_TODAY', response.data.summary)
      return response
    }catch(error){
      throw error
    }
  },
  async pendingList({ commit }) {
   try{
      const response = await axios.post('/api/transaction/pendingList', {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
      })
      commit('SET_PENDING', response.data)
      return response
    }catch(error){
      throw error
    }
  },
  async fetchWeeklyTransaction({ commit }) {
      try {
        const { data } = await axios.post('/api/transaction/weeklySummary')

        const transformedSeries = data.series.map((s, i) => {
          return {
            ...s,
            data: i === 1 ? s.data.map(v => -v) : s.data, // indeks ke-1 = bulan sebelumnya → dibalik (negatif)
          }
        })

        commit('SET_WEEKLY_DATA', {
          series: transformedSeries,
          categories: data.categories,
        })
      } catch (error) {
        console.error('Failed to fetch weekly transactions:', error)
      }
    },

    async fetchWeeklyIncomeStats({ commit }) {
    try {
      const { data } = await axios.post('/api/transaction/weeklyIncomeStats')

      commit('SET_WEEKLY_INCOME', {
        series: data.series,
        stats: {
          percent: data.percentage,
          amount: data.amount,
          total: data.total,
          lastWeek: data.lastWeek,
        },
      })
    } catch (err) {
      console.error('Gagal mengambil statistik income mingguan:', err)
    }
  },
  async availabelStock({ commit },data) {
    try{
      const response = await axios.post(`/api/stock/available/${data.category}`)
      commit('SET_STOCK', response.data)
      return response
    }catch(error){
      throw error
    }
  },

  async process({ commit }, data) {
    const transactionType = data.id ? "update" : "add";
  
    return new Promise((resolve, reject) => {
      axios.post("/api/transaction/" + transactionType, data.formData, {
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
      axios.post(`/api/transaction/delete/${data.id}`)
      .then((response)=>{
        commit('DELETE_ITEM', data.id)
        resolve(response)
      }).catch((error) => {
          reject(error)
      })
    })
  },
    

};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
