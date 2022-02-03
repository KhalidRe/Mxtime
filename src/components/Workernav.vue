<template>
  <div id="Workernav">
    <div class="e aktiv">
      <span>Aktiv</span>
      <span>{{ loggedin.Active }}</span>
    </div>
    <div class="e waiting">
      <span>Väntande</span>
      <span>{{ loggedin.Created }}</span>
    </div>
    <div class="e paused">
      <span>Pausade</span>
      <span>{{ loggedin.Completion }}</span>
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
.e {
  display: flex;
  flex-direction: column;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 20px;
}
/*

.aktiv {
  color: rgb(193, 255, 193);
}
.waiting {
  color: rgb(244, 252, 142);
}
.paused {
  color: rgb(255, 102, 102);
}
*/
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&family=Ubuntu:ital@0;1&display=swap");
#Workernav {
  width: 100%;
  background: #1988c9;
  color: white;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  grid-gap: 10vh;
  height: 60px;
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
  font-size: 17px;
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
  font-weight: bolder;
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
    const requestOptions = {
      method: "POST",
      mode: "cors",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
      body: JSON.stringify({ user: this.logged }),
    };

    fetch("https://mxserver-simdf.ondigitalocean.app/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
      });

    fetch(
      "https://mxserver-simdf.ondigitalocean.app/viewprojects",
      requestOptions
    )
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
      });
  },
};
</script>
