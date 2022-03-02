<template>
  <div id="father">
    <transition name="normal">
      <div v-if="show" id="Navbar">
        <router-link class="links" to="/Home"
          ><img width="25vw" src="@/assets/projecticon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Time">
          <img width="25vw" src="@/assets/Timeicon.png" alt="" />
        </router-link>
        <router-link class="links" to="/Charts"
          ><img width="25vw" src="@/assets/charticon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Users"
          ><img width="25vw" src="@/assets/usericon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Histor"
          ><img width="25vw" src="@/assets/historyicon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Chat"
          ><img width="25vw" src="@/assets/Chat2.png" alt=""
        /></router-link>
      </div>
    </transition>
    <div id="openclose">
      <span class="text" @click="show = !show" v-if="show">close</span>
      <span @click="show = !show" v-if="!show" class="text">open</span>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      show: true,
    };
  },

  methods: {
    handleClick() {
      this.$emit("update:parent", this.childMessage);
    },
  },
};
</script>

<style scoped>
.text {
  transform: rotate(90deg);
  font-size: 16px;
  font-weight: 700;
  margin-left: 0%;
  padding-left: 100%;
  padding-right: 100%;
  color: white;
}
#openclose {
  display: flex;
  justify-content: center;
  align-items: center;
  align-self: center;
  width: 15px;
  margin-right: -15px;
  height: 100px;
  z-index: 1;
  border-radius: 0% 25px 25px 0px;
  background: #6aec87;
}

#father {
  display: flex;
  height: 100vh;
}
#Navbar {
  background: #1988c9;
  display: flex;
  flex-direction: column;
  align-items: center;
  grid-gap: 5vh;
  padding-top: 65px;
  overflow-x: hidden;
  width: 70px;
}
#Navbar::-webkit-scrollbar {
  width: 6px;
}
#Navbar::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
#Navbar::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.164);
}
.links {
  width: 30px;
  padding: 10px;
  padding-top: 15px;
  padding-bottom: 15px;
  box-shadow: 0px 0px 10px 3px rgba(2, 6, 46, 0.226);

  border-radius: 5px;
  transition: 1s;
  background: #1988c9;
}
.links:active {
  transition: 1s;
  box-shadow: inset 0px 2px 5px 1px rgba(0, 0, 0, 0.603);
}
.links.router-link-active {
  transition: 1s;
}
.normal-enter-active {
  animation: normal-in 0.5s;
}
.normal-leave-active {
  animation: normal-in 0.5s reverse;
}
@keyframes normal-in {
  0% {
    width: 0vw;
  }

  50% {
    width: 90px;
  }
  100% {
    width: 70px;
  }
}
@media only screen and (max-width: 1000px) {
  #Navbar {
  }
  .links {
    width: 50%;
  }
}
</style>
