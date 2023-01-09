<template>
  <div id="app">
    <Navbar v-if="!isLogin" />

    <router-view />
  </div>
</template>

<script>
import Navbar from "@/components/Navbar.vue";

export default {
  name: "Home",
  components: {
    Navbar,
  },
  data() {
    return {
      show: false,
      fromChild: false,
    };
  },
  created() {
    //SocketioService.setupSocketConnection();
  },
  methods: {
    onClickChild(value) {},
  },
  computed: {
    isLogin() {
      console.log(this.$route.name);
      if (
        this.$route.name === "Login" ||
        this.$route.name === "Forgotpass" ||
        this.$route.name === "Resetpass"
      ) {
        return true;
      }
    },
  },
};
</script>

<style>
#app {
  position: relative;
}

@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&family=Ubuntu:ital@0;1&display=swap");
body {
  background: rgb(245, 245, 245);

  margin: 0;
}
#app {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
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
