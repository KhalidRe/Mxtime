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
  state: {},
  mutations: {
    addList(state, payload) {
      Vue.set(state.listObjects, {
        Loggedin: payload.auth,
      });
    },
  },
  actions: {},
  modules: {},
});
