<template>
  <div id="Postit">
    <iframe
      width="1px"
      height="1px"
      name="dummyframe"
      id="dummyframe"
      style="display: none"
    ></iframe>
    <transition name="slide-fade">
      <div v-if="show" class="noclick">
        <div id="Formen">
          <h1 class="title">Lägg till Projekt</h1>
          <form id="inputsStyle" action="" method="POST" target="dummyframe">
            <span class="e">
              <span>Projekt namn</span
              ><input
                type="text"
                name="title"
                id="title"
                mode="no-cors"
                required
                v-model="title"
                maxlength="18"
              />
            </span>
            <span class="e">
              <input
                type="hidden"
                :value="this.loggedin.Name"
                name="author"
                id="author"
                ref="author"
              />
              <input
                type="hidden"
                id="userid"
                name="userid"
                :value="this.loggedin.id"
                ref="userid"
              />
            </span>
            <span class="e w">
              <span>Deltagare</span>
              <div class="workerscaps">
                <div
                  id="tblFruits"
                  v-for="deltag in deltagare"
                  :key="deltag.id"
                  class="workcheck"
                >
                  <label class="container">
                    <input
                      :id="deltag.Name + deltag.id"
                      class="deltagcheckbox"
                      type="checkbox"
                      :value="deltag"
                    />

                    <label :for="deltag.Name + deltag.id" class="checkmark"
                      ><img
                        class="icons"
                        :src="require(`@/assets/${deltag.Profile}`)"
                      />
                      <div>{{ deltag.Name }}</div>
                    </label>
                  </label>
                </div>
              </div>
            </span>
            <div class="dateanddead">
              <span class="e">
                <span>Datum</span>
                <input
                  type="date"
                  name="date"
                  id="date"
                  v-model="date"
                  required
                  onkeydown="return false"
                />
              </span>
              <span class="e">
                <span>Deadline</span
                ><input
                  type="date"
                  name="deadline"
                  id="deadline"
                  v-model="deadline"
                  required
                  onkeydown="return false"
                />
              </span>
            </div>
            <span class="e avk">
              <input
                type="hidden"
                name="precentage"
                id="precentage"
                value="0"
                v-model="precentage"
              />
            </span>
            <span class="e">
              <span>Tidsbudget</span>
              <input type="number" value="1" min="1" v-model="timebudget" />
            </span>
            <input
              type="submit"
              class="skapaknapp"
              v-if="
                this.title.replace(/\s/g, '').length > 0 &&
                this.date.length > 0 &&
                this.deadline.length > 0 &&
                this.timebudget > 0
              "
              @click="createProject(), (show = !show)"
            />
            <input
              v-else
              type="submit"
              class="fakerskapaknapp"
              title="Fyll i alla fält"
              disabled
            />
            <button class="avbryt" type="button" @click="show = !show">
              Avbryt
            </button>
          </form>
        </div>
      </div>
    </transition>

    <div @click="show = !show" id="Addbtn">+</div>
  </div>
</template>
<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&display=swap");
#tblFruits {
  height: 50px;
  width: 50px;
  margin-top: 10px;
  margin: 10px;
  box-shadow: 0px 5px 10px rgb(0, 0, 0);
  border-radius: 100%;
}
.icons {
  width: 50px;
  border-radius: 100%;
}
.container {
  display: block;
  position: relative;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  height: 32px;
  width: 45px;
  border-radius: 100%;
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(81, 182, 250, 0.3);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 0px 5px rgb(84, 161, 224);
}
.Texten {
  font-size: 14px;
}
/* Hide the browser's default checkbox */
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;

  border-radius: 100%;
}
/* Create a custom checkbox */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  width: 50px;
  height: 50px;
  background-color: #e0eeff;

  border: solid white 2px;
  border-radius: 100%;
}
.container:hover input ~ .checkmark {
  background-color: #e0eeff;
}
.container input:checked ~ .checkmark {
  background-color: #44f321;
  border: 2px rgb(103, 218, 103) solid;
  border-radius: 100%;
}
/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}
/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
  display: block;
}
/* Style the checkmark/indicator */
.container .checkmark:after {
  display: none;
}
.e {
  width: 80%;
}
.workerscaps {
  justify-content: center;
  overflow-y: scroll;
  background: rgb(255, 255, 255);
  width: 100%;
  height: 150px;
  display: grid;
  grid-gap: 20px;
  grid-template-columns: auto auto;
}
.deltagcheckbox {
  appearance: none;
}
.dateanddead {
  display: flex;
}
.noclick {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
}
.title {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 30px;
  line-height: 45px;
  background: #1988c9;
  color: white;
  margin-top: 0px;
  padding: 10px;
  padding-left: 35px;
  padding-right: 35px;
  border-radius: 10px 10px 0px 0px;
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
  cursor: pointer;
}
.fakerskapaknapp {
  border: none;
  background: linear-gradient(180deg, #aab1ab 0%, #c3cec5 46.88%, #bdc9bf 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 150px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
  color: #666666;
}
.skapaknapp {
  border: none;
  background: linear-gradient(180deg, #6df983 0%, #3db951 46.88%, #82ed93 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 150px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
  color: #01537c;
  cursor: pointer;
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
  cursor: pointer;
  z-index: 0;
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
  color: white;
}
input[type="text"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
  background: #1988c9;
  color: white;
}
input[type="number"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  width: 50%;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
  background: #1988c9;
  color: white;
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
  color: white;
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
.avk {
  background: rgba(0, 0, 0, 0.336);
  width: 100%;
}
</style>
<script>
import io from "socket.io-client";
import ding from "../assets/soundeffect/ding.mp3";
export default {
  data() {
    return {
      hej: "",
      show: false,
      loggedin: "",
      precentage: 0,
      logged: this.$store.state.someValue,
      delay: 1000,
      title: "",
      workers: "",
      date: "",
      deadline: "",
      timebudget: 0,
      deltagare: "",
      authorstatus: "",
      dingsound: "",
    };
  },
  created() {
    const requestOptions = {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("https://flexn.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        const searchnano = {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },

          body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
        };
        fetch("https://flexn.se:3000/getusers", searchnano)
          .then((response) => response.json())
          .then((result) => {
            this.user = result;
            this.deltagare = this.user.filter(
              (e) => !e.Name.includes(this.loggedin.Name)
            );
          });
        this.socketInstance = io("https://flexn.se:3000/");

        this.socketInstance.emit("loggedinfo", this.loggedin.nanoid);
        if (this.loggedin.nanoid == undefined) {
          window.location.reload();
        }
      });
  },
  methods: {
    GetSelected() {},
    createProject() {
      var selected = new Array();

      var chks = document.getElementsByClassName("deltagcheckbox");

      for (var i = 0; i < chks.length; i++) {
        if (chks[i].checked) {
          selected.push(chks[i]._value);
        }
      }

      const postdata = {
        title: this.title.replace(/'/g, ``),
        author: this.$refs.author.value,
        date: this.date,
        deadline: this.deadline,
        precentage: 0,
        userid: this.$refs.userid.value,
        timebudget: this.timebudget,
        timeused: 0,
        status: "A",
        Authorstatus: this.loggedin.Status,
        deltag: selected,
        Authorid: this.loggedin.id,
        authornanoid: this.loggedin.nanoid,
        authorprofile: this.loggedin.Profile,
      };

      this.socketInstance.emit("post", postdata);
      this.dingsound.play();
      swal({
        title: "Projekt Skapat!",
        text: "Du har skapat ett projekt!",
        icon: "success",
      });
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
  },
  mounted() {
    this.dingsound = new Audio(ding);
  },
};
</script>
