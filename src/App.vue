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
#app:after {
  content: "";
  display: block;
  position: absolute;
  z-index: 2;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  background-image: url("https://library.elementor.com/resources/christmas-snow-effect/s1.png"),
    url("https://library.elementor.com/resources/christmas-snow-effect/s2.png"),
    url("https://library.elementor.com/resources/christmas-snow-effect/s3.png");
  animation: snow 20s linear infinite;
}
@keyframes snow {
  0% {
    background-position: 0px 0px, 0px 0px, 0px 0px;
  }
  50% {
    background-position: 500px 500px, 100px 200px, -100px 150px;
  }
  100% {
    background-position: 500px 1000px, 200px 400px, -100px 300px;
  }
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
