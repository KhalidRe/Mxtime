<template>
  <div id="father">
    <transition name="normal">
      <div v-if="show" id="Navbar">
        <router-link class="links" to="/Home"
          ><img class="icons" src="@/assets/projecticon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Time">
          <img class="icons" src="@/assets/Addtimeicon.png" alt="" />
        </router-link>
        <router-link class="links" to="/Mytime"
          ><img class="icons" src="@/assets/historyicon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Charts"
          ><img class="icons" src="@/assets/charticon2.png" alt=""
        /></router-link>

        <router-link class="links" to="/UsersV2"
          ><img class="icons" src="@/assets/usericon2.png" alt=""
        /></router-link>
        <router-link class="links" to="/Histor"
          ><img class="icons" src="@/assets/Arkiv.png" alt=""
        /></router-link>
        <router-link class="links planner" to="/Planner"
          ><img class="icons" src="@/assets/dateicon.png" alt=""
        /></router-link>

        <!--
<router-link class="links" to="/Chat"
          ><img  src="@/assets/Chat2.png" alt=""
        /></router-link>
        -->
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
@media only screen and (max-width: 786px) {
  .planner {
    display: none !important;
  }
}
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
  cursor: pointer;
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
}
* {
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
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
  height: 25px;
  padding: 10px;
  padding-top: 15px;
  padding-bottom: 15px;

  border-radius: 5px;

  background: #1988c9;

  border-radius: 3px;
  background: #1988c9;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
  -webkit-tap-highlight-color: transparent;
  box-shadow: -7px -7px 20px 0px #1d9be4, -4px -4px 5px 0px #1988c9,
    7px 7px 20px 0px #0002, 4px 4px 5px 0px #0001;
  font-size: 26px;
  color: #666;
  text-decoration: none;
  transition: 1s;
}
.links:active {
  box-shadow: 4px 4px 6px 0 #1d91d4, -4px -4px 6px 0 #126291,
    inset -4px -4px 6px 0 #1c95db, inset 4px 4px 6px 0 #126291;
  transition: 1s;
}
.icons {
  width: 25px;
}
.links:active .icons {
  width: 24px;
}
.links.router-link-active {
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
