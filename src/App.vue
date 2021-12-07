<template>
  <div id="app">
    <Navbar v-if="!isLogin" />

    <router-view />
  </div>
</template>

<script>
import Navbar from "@/components/Navbar.vue";
import Workernav from "@/components/Workernav.vue";

export default {
  name: "Home",
  components: {
    Navbar,
    Workernav,
  },
  data() {
    return {
      show: false,
      fromChild: false,
    };
  },
  methods: {
    onClickChild(value) {
      console.log(value);
    },
  },
  computed: {
    isLogin() {
      return this.$route.name === "Login";
    },
  },
};
</script>

<style>
body {
  background: rgb(245, 245, 245);

  margin: 0;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: flex;
  height: 100%;
  width: 100%;
  margin: 0px;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
