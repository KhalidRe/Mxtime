<template>
  <div id="Addtimeform">
    <iframe
      width="1px"
      height="1px"
      name="dummyframe"
      id="dummyframe"
      style="display: none"
    ></iframe>
    <transition name="slide-fade">
      <div v-if="!show" class="noclick">
        <div id="Formen">
          <h1 class="title" style="margin: 0">Lägg till tid</h1>
          <form id="inputsStyle" action="" method="POST" target="dummyframe">
            <span class="e">
              <input
                type="hidden"
                :value="this.loggedin.Name"
                name="name"
                id="name"
                ref="name"
              />
              <input
                type="hidden"
                id="username"
                name="username"
                :value="this.loggedin.Username"
                ref="username"
              />
            </span>
            <span class="e">
              <span>Projekt: </span
              ><select name="title" id="title" ref="title">
                <option value="Egen tid">Egen tid</option>
                <option
                  v-for="projects in project"
                  :key="projects.id"
                  :value="projects.Title"
                >
                  {{ projects.Title }}
                </option>
              </select>
            </span>
            <span class="e">
              <span>Timmar: </span>
              <input
                type="number"
                min="0"
                max="10"
                value="0"
                name="hours"
                id="hours"
                ref="timmar"
              />
            </span>
            <span class="e">
              <span>Minuter: </span
              ><input
                type="number"
                min="0"
                max="60"
                value="0"
                name="minutes"
                id="minutes"
                ref="minuter"
              />
            </span>
            <span class="e">
              <span>Beskrivning: </span>
              <input
                type="text"
                name="description"
                id="description"
                value=".."
                maxlength="60"
                ref="description"
              />
            </span>
            <input
              type="submit"
              class="skapaknapp"
              @click="createTime(), reloadPage()"
              name="ok"
            />
            <button @click="show = !show" class="avbryt">Avbryt</button>
          </form>
        </div>
      </div>
    </transition>
    <button class="Openoverlay" @click="show = !show">+</button>
  </div>
</template>
<style scoped>
#Addtimeform {
}
#Formen {
  position: absolute;
  z-index: 1;
  top: 20%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;

  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
.Openoverlay {
  background-color: rgb(79, 165, 79);
  height: 55px;
  width: 55px;
  border-radius: 100%;
  border: none;
  font-size: 50px;
  align-items: center;
  color: white;
  text-align: center;
  line-height: 50px;
  cursor: pointer;
}
@media only screen and (max-width: 1000px) {
  #Formen {
    left: 20%;
  }
}
#inputsStyle {
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  align-items: center;

  grid-gap: 10px;
  text-align: center;
}
input[type="text"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
}
select {
  border: none;
  background-color: rgb(27, 162, 185);
  padding: 10px;
  border-radius: 10px 10px 0px 0px;
  font-weight: bolder;
}
input[type="date"] {
  padding: 5px;
  border-radius: 5px;
  border: none;
  box-shadow: 0px 0px 5px 1px black;
}
.e {
  width: 100%;
  color: black;
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8  :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"*/ {
  transform: translateY(-100%);
  opacity: 0;
}
.dateanddead {
  display: flex;
}
.title {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;
  background: #1988c9;
  border-radius: 10px 10px 0px 0px;
  padding: 20px;
  color: white;
}
.avbryt {
  font-style: normal;
  font-weight: normal;
  background: linear-gradient(180deg, #f96d6d 0%, #cf4040 46.88%, #ed8282 100%);
  width: 104px;
  height: 24px;
  box-shadow: 0px 4px 4px rgba(186, 186, 186, 0.25);
  border-radius: 24px;
  font-size: 15px;
  line-height: 17px;
  border: none;
  font-weight: 600;
  color: #01537c;
}
.fakerskapaknapp {
  border: none;
  background: linear-gradient(180deg, #aab1ab 0%, #c3cec5 46.88%, #bdc9bf 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 260px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
  color: #01537c;
}
.skapaknapp {
  border: none;
  background: linear-gradient(180deg, #6df983 0%, #3db951 46.88%, #82ed93 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 260px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
  color: #01537c;
}
#Addbtn {
  overflow: hidden;
  position: fixed;
  font-size: 40px;
  font-weight: bolder;
  background-color: chartreuse;
  padding: 25px;
  padding-top: 15px;
  padding-bottom: 15px;
  margin: 0;
  border-radius: 100px;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.39);
  right: 5vw;
  top: 80vh;
  z-index: 3;
  cursor: pointer;
}
#Addbtn:active {
  background-color: rgb(6, 143, 36);
  box-shadow: 0px 0px 25px 10px rgba(2, 217, 255, 0.979);
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8  :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"*/ {
  transform: translateY(-100%);
  opacity: 0;
}
#Postit {
}
#Formen {
  position: absolute;
  z-index: 1;
  top: 10%;
  left: 40%;
  background: white;
  width: 300px;
  min-height: 50vh;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
  padding-bottom: 10px;
}
@media only screen and (max-width: 1000px) {
  #Formen {
    left: 20%;
  }
}
#inputsStyle {
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  align-items: center;

  grid-gap: 10px;
  text-align: center;
}
input[type="text"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
  background: linear-gradient(180deg, #129426 0%, #40cf57 46.88%, #129628 100%);
}
select {
  border: none;
  background: #1988c9;
  padding: 10px;
  border-radius: 10px 10px 0px 0px;
  font-weight: bolder;
}
::-webkit-datetime-edit-year-field:not([aria-valuenow]),
::-webkit-datetime-edit-month-field:not([aria-valuenow]),
::-webkit-datetime-edit-day-field:not([aria-valuenow]) {
  color: transparent;
}
input[type="date"] {
  padding: 5px;
  border-radius: 5px;
  border: none;
  box-shadow: 0px 0px 5px 1px black;
  width: 50%;
  background: #1988c9;
}

input[type="range"] {
}
.e {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  display: flex;
  flex-direction: column;

  align-items: center;

  font-size: 20px;
  line-height: 25px;

  color: black;
}
.noclick {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
}
</style>
<script>
import io from "socket.io-client";
export default {
  data() {
    return {
      hej: "",
      show: true,
      loggedin: "",
      precentage: 0,
      logged: this.$store.state.someValue,
      project: "",
      loggedstatus: "",
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

    fetch("https://mxtime.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        this.loggedstatus = this.loggedin.Status;
        console.log(this.loggedstatus == "Admin");
        fetch("https://mxtime.se:3000/viewprojects")
          .then((response) => response.json())
          .then((result) => {
            if (this.loggedstatus == "Admin") {
              this.project = result;
            } else {
              this.project = result.filter(
                (result) => result.Authorstatus == this.loggedstatus
              );
            }
          });
      });

    this.socketInstance = io("https://mxtime.se:3000/");
  },

  methods: {
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
    createTime() {
      const timedata = {
        title: this.$refs.title.value,
        name: this.$refs.name.value,
        user: this.$refs.username.value,
        description: this.$refs.description.value,
        timmar: this.$refs.timmar.value,
        minuter: this.$refs.minuter.value,
      };

      this.socketInstance.emit("time", timedata);
    },
  },
};
</script>
