<template>
  <div id="Workernav">
    <div>Aktiv: {{ loggedin.Active }}</div>
    <div>
      <span>Skapat: {{ loggedin.Created }}</span>
    </div>
    <div>
      <span>Klara project: {{ loggedin.Completion }}</span>
    </div>
    <div class="profname">
      <span>{{ loggedin.Name }}</span>
      <img
        class="profile"
        :src="require(`@/assets/${loggedin.Profile}`)"
        alt=""
      />
    </div>
  </div>
</template>
<style scoped>
#Workernav {
  width: 100%;
  background: -webkit-linear-gradient(120deg, #4484b8, #47b4b4);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  grid-gap: 10vh;
  height: 60px;

  box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
  font-size: 16px;
  font-weight: 900;
}
.profile {
  width: 50px;
  border-radius: 25px;
}
.profname {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 10px;
}
@media only screen and (max-width: 1000px) {
  #Workernav {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around;
    grid-gap: 0vh;
    height: 60px;
    width: normal;
    box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
    font-size: 16px;
    font-weight: 900;
  }
}
</style>
<script>
import io from "socket.io-client";
export default {
  data() {
    return {
      users: {},
      loggedin: "",
      logged: this.$store.state.someValue,
    };
  },
  created() {
    const user = {
      username: this.logged,
    };

    this.socketInstance = io("http://192.168.1.129:3000");
    this.socketInstance.emit("info", user);
    this.socketInstance.on("info:received", (userinfo) => {
      this.loggedin = userinfo[0];
      console.log(userinfo);
    });
  },
};
</script>
