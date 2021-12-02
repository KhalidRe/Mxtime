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
  background: rgb(164, 243, 168);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  grid-gap: 10vh;
  height: 60px;
  width: 93.9vw;
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
</style>
<script>
export default {
  data() {
    return {
      users: {},
      loggedin: "",
    };
  },
  created() {
    fetch("http://localhost:3000/getusers")
      .then((response) => response.json())
      .then((result) => {
        this.users = result;
        console.log(this.users);
        switch (this.$store.state.someValue) {
          case "MXkhalid":
            this.loggedin = this.users[4];
            break;
          case "MXboss":
            this.loggedin = this.users[0];
            break;
          case "MXkvist":
            this.loggedin = this.users[1];
            break;
          case "MXanders":
            this.loggedin = this.users[2];
            break;
          case "MXphilip":
            this.loggedin = this.users[3];
            break;
          default:
            console.log("Inte inloggad");
        }
        console.log(this.loggedin);
      });
  },
};
</script>
