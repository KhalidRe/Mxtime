import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [createPersistedState()],
  listObjects: {},

  state: {
    someValue: "",
    playdata: true,
  },
  mutations: {
    setSomeValue(state, someValue) {
      state.someValue = someValue;
    },
    setplay(state) {
      state.playdata = !state.playdata;
    },
  },
  actions: {},
  modules: {},
});
