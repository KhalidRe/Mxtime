import Vue from "vue";
import Vuex from "vuex";
import VuexPersist from "vuex-persist";
Vue.use(Vuex);

const vuexLocalStorage = new VuexPersist({
  key: "vuex",
  storage: window.localStorage,
});
export default new Vuex.Store({
  listObjects: {},
  state: {
    count: 12,
  },
  mutations: {
    increment(state) {
      state.count++;
    },
  },
  actions: {},
  modules: {},
});
