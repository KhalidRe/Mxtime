<template>
  <div id="Timer">
    <div v-if="sureoverlay" class="sureoverlay">
      <div class="overcaps">
        <h2>Reset Time</h2>
        <div class="contentflex">
          <div class="suretext">
            Är du säker på att du vill återställa tiden?
          </div>
          <div class="janejbtn">
            <button class="nejbtn" @click="sureoverlay = !sureoverlay">
              NEJ
            </button>
            <Button
              class="jabtn"
              @click="reset(), (itson = false), (sureoverlay = !sureoverlay)"
            >
              JA
            </Button>
          </div>
        </div>
      </div>
    </div>
    <div v-if="sureoverlaytime" class="sureoverlay">
      <div class="overcaps overcapsm">
        <h2>Logga Tid</h2>
        <div v-if="suretext == 0" class="contentflex">
          Projekt: {{ chosenproject }} <br />
          <div class="suretext">
            Vill du Spara tiden? <br />
            <div class="wannasave">
              {{
                this.$refs.timer.time.h +
                ":" +
                this.$refs.timer.time.m +
                ":" +
                this.$refs.timer.time.s
              }}
            </div>
          </div>

          <div v-if="suretext == 0" class="janejbtn">
            <button
              class="nejbtn"
              @click="
                toggle(), (itson = true), (sureoverlaytime = !sureoverlaytime)
              "
            >
              NEJ
            </button>
            <Button class="jabtn" @click="(itson = false), (suretext = 1)">
              JA
            </Button>
          </div>
        </div>
        <div v-if="suretext == 1" class="contentflexa">
          Projekt: {{ chosenproject }} <br />
          <div v-if="suretext == 1" class="suretexta">
            Notis: <br />
            <div class="wannasavea">
              <textarea
                class="notisarea"
                v-model="Notes"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
          </div>

          <div v-if="suretext == 1" class="janejbtn">
            <button class="nejbtn" @click="suretext = 0">Avbryt</button>
            <Button class="jabtn" @click="(itson = false), (suretext = 2)">
              Nästa
            </Button>
          </div>
        </div>
        <div v-if="suretext == 2" class="contentflexa">
          Projekt: {{ chosenproject }} <br />
          <div v-if="suretext == 2" class="suretexta">
            Notis: <br />
            <div class="dbcaps">
              <div class="db">
                <label class="container">
                  <input
                    v-model="debit"
                    id="debitja"
                    class="deltagcheckbox"
                    type="radio"
                    value="1"
                  />
                  <label for="debitja" class="checkmark">
                    <div>DEBIT</div>
                  </label>
                </label>
                <label class="container">
                  <input
                    v-model="debit"
                    id="debitnej"
                    class="deltagcheckbox"
                    type="radio"
                    value="0"
                  />
                  <label for="debitnej" class="checkmark">
                    <div>EJ DEBIT</div>
                  </label>
                </label>
              </div>
            </div>
          </div>

          <div v-if="suretext == 2" class="janejbtn">
            <button class="nejbtn" @click="suretext = 1">Avbryt</button>
            <Button
              class="jabtn"
              @click="
                checker(),
                  reset(),
                  (itson = false),
                  (suretext = 0),
                  (sureoverlaytime = !sureoverlaytime)
              "
            >
              Skicka
            </Button>
          </div>
        </div>
      </div>
    </div>
    <div v-show="show" class="coolline"></div>
    <div class="strecher">
      <transition name="normal">
        <div v-show="show" class="Timewid">
          <div v-show="shows" class="timecaps">
            <div class="dropdown">
              <dropdown-menu
                :overlay="false"
                :withDropdownCloser="true"
                :closeOnClickOutside="true"
                class="dropfag"
              >
                <div
                  v-show="chosenproject.length == 0"
                  dropdown-closer
                  class="chooseproject"
                  slot="trigger"
                >
                  Välj project
                </div>

                <div
                  v-show="chosenproject.length > 0"
                  dropdown-closer
                  class="chooseproject"
                  slot="trigger"
                >
                  {{ chosenproject }}
                </div>

                <div class="dropper" slot="body">
                  <input
                    class="searchbar"
                    type="text"
                    v-model="search"
                    placeholder="Search"
                  />
                  <div dropdown-closer slot="body">
                    <div
                      class="drop-item"
                      v-for="project in filterFunction"
                      :key="project.id"
                      @click="dataPrimer(project.id, project.Title)"
                      dropdown-closer
                    >
                      {{ project.Title }}
                    </div>
                  </div>
                </div>
              </dropdown-menu>
            </div>

            <div class="buttons">
              <Button
                @click="toggle(), (itson = !itson)"
                v-show="!itson && primed"
                color="primary"
                class="mr-1"
              >
                <img src="@/assets/play.png" alt="" />
              </Button>
              <Button
                @click="toggle(), (itson = !itson)"
                v-show="itson && primed"
                color="primary"
                class="mr-1"
              >
                <img src="@/assets/pause.png" alt="" />
              </Button>
              <button @click="sureoverlay = !sureoverlay">
                <img src="@/assets/reset.png" alt="" />
              </button>
              <!--
          <Button @click="reset(), (itson = false)">
                <img src="@/assets/reset.png" alt=""
              /></Button>
         -->
              <button v-if="!itson">
                <img src="@/assets/sendstopwatch.png" alt="" />
              </button>
              <button
                v-if="itson"
                @click="
                  toggle(),
                    (itson = !itson),
                    (sureoverlaytime = !sureoverlaytime)
                "
              >
                <img src="@/assets/sendstopwatch.png" alt="" />
              </button>
            </div>
            <Timer
              ref="timer"
              class="numbers"
              :type="type"
              :allowOverflow="allowOverflow"
              :length="length"
              @done="onDone"
              @start="onStart"
              @stop="onStop"
              @reset="onReset"
              @pause="onPause"
              @resume="onResume"
              @overflow="onOverflow"
            />
          </div>
        </div>
      </transition>
      <div
        v-if="!show"
        class="Iconclosed"
        @click="(shows = !shows), (show = !show)"
      >
        <img src="@/assets/Timeicon.png" alt="" />
      </div>
      <div v-if="show" class="Icon" @click="(shows = !shows), (show = !show)">
        <img src="@/assets/Timeicon.png" alt="" />
      </div>
    </div>
    <div class="MobileIcon" @click="openoverlay = !openoverlay">
      <img src="@/assets/Timeicon.png" alt="" />
    </div>
  </div>
</template>
<style scoped>
.wannasave {
  color: rgb(102, 102, 102);
  font-size: 18px;
}
.janejbtn > button {
  border: none;
  border-radius: 10px;
  height: 30px;
  width: 70px;
  font-size: 15px;
  font-weight: 600;
  text-align: center;
  align-content: center;
  justify-content: center;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.226);
}
.jabtn {
  background: #5ed4ab;
}
.nejbtn {
  background: #f37f7f;
}
.janejbtn {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  grid-gap: 20px;
}
.contentflex {
  display: flex;
  justify-content: center;
  align-items: center;
  align-content: center;
  grid-gap: 60px;
  flex-direction: column;
  height: 100%;
  width: 80%;
  text-align: center;
}
.sureoverlay {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  z-index: 98;
  display: flex;
  background: rgba(44, 44, 44, 0.322);
}
.overcaps > h2 {
  background: #0381bb;
  color: white;
  padding-top: 10px;
  padding-bottom: 10px;
  width: 100%;
  margin: 0px;
  border-radius: 20px 20px 0px 0px;
}
.overcaps {
  position: absolute;
  background: white;
  width: 250px;
  height: 300px;
  z-index: 99;

  top: 20%;
  left: 45%;
  display: flex;
  justify-content: center;
  align-items: center;
  align-content: center;
  border-radius: 20px;
  box-shadow: 0px 2px 3px 1px rgba(0, 0, 0, 0.233);

  flex-direction: column;
}
.numbers {
  color: white;
  font-weight: 900 !important;
}
.dropper {
  height: 250px !important;
  overflow-y: scroll;
}
.slide-in-enter-active {
  transition: all 0.5s;
}
.slide-in-leave-active {
  transition: all 0.5s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-in-enter, .slide-in-leave-to
/* .slide-fade-leave-active below version 2.1.8  :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"*/ {
  transform: translateX(-100%);
}

.close {
  float: right;
  padding: 20px;
}
.close > img {
  filter: drop-shadow(0px 0px 4px #7c7c7c);
}
.chooseproject {
  cursor: pointer;
  background: #1988c9;
  padding: 3px;
  padding-left: 7px;
  padding-right: 7px;
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
  color: white;
  text-decoration: none;

  transition: 1s;
  margin: 5px;
  border: none;
}
.chooseproject:active {
  box-shadow: 4px 4px 6px 0 #1d91d4, -4px -4px 6px 0 #126291,
    inset -4px -4px 6px 0 #1c95db, inset 4px 4px 6px 0 #126291;
  transition: 1s;
}
.searchbar {
  margin: 5px;
  width: 80%;
}
.overlay {
  display: none;
}

.drop-item {
  width: 100%;
  padding-top: 10px;
  padding-bottom: 10px;
  background: white;
  cursor: pointer;
}
.drop-item:hover {
  background: rgb(226, 226, 226);
}
.MobileIcon {
  display: none;
}
.coolline {
  background: linear-gradient(
    270.01deg,
    #e5fd7b 1.25%,
    #1988c900 30.49%,
    #1988c900 80.41%
  );
  background-size: 1000px;

  animation: gradient 1.5s infinite linear;
  width: 49%;
  margin-bottom: -3px;
  position: fixed;
  height: 1px;

  float: left;
  z-index: 90;
}
.buttons {
  display: flex;
  width: 30%;

  margin: 5px;
}
* {
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
}
.strecher {
  display: flex;
  width: 100%;
  margin-top: -1px;
}
.buttons > * {
  cursor: pointer;
  background: #1988c9;
  padding: 3px;
  padding-left: 7px;
  padding-right: 7px;
  border-radius: 3px;
  background: #1988c9;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
  -webkit-tap-highlight-color: transparent;
  box-shadow: -5px -5px 20px 0px #1d9be4, -4px -4px 5px 0px #1988c9,
    7px 7px 20px 0px #0002, 4px 4px 5px 0px #0001;
  color: white;
  text-decoration: none;
  transition: 1s;
  margin: 5px;
  border: none;
}
.buttons > *:active {
  box-shadow: 4px 4px 6px 0 #1d91d4, -4px -4px 6px 0 #126291,
    inset -4px -4px 6px 0 #1c95db, inset 4px 4px 6px 0 #126291;
  transition: 1s;
}
.timecont {
  color: #ffffff;
}
.Timewid {
  width: 50%;
  height: 50px;
  margin-top: -1px;

  background-color: #1988c9;

  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-right: 20px;
  box-shadow: inset 0px 2px 3px 1px rgba(0, 0, 0, 0.233);
}
#Timer {
  display: flex;
  flex-direction: column;
}
@keyframes gradient {
  0% {
    background-position: 0%;
  }

  100% {
    background-position: 1000px;
  }
}
@keyframes gradients {
  0% {
    background-position: 0%;
  }

  100% {
    background-position: 1000%;
  }
}

.timecaps {
  display: flex;
  width: 100%;

  justify-content: space-around;
  align-items: center;
}
.Icon {
  width: 50px;
  height: 50px;
  border-radius: 0px 0px 50px 0px;
  box-shadow: 0px 2px 3px 1px rgba(0, 0, 0, 0.233);
  cursor: pointer;
  margin-top: -1px;
  background: linear-gradient(
    270.01deg,
    #e5fd7b 1.25%,
    #1988c9 30.49%,
    #1988c9 80.41%
  );
  background-size: 1000px;
}

.Iconclosed {
  width: 51px;
  height: 51px;
  border-radius: 0px 0px 50px 0px;
  box-shadow: 0px 2px 3px 1px rgba(0, 0, 0, 0.233);
  background: linear-gradient(-45deg, #206dc5, #437ea0, #5574ca, #3297be);
  background-size: 20px 20px;

  animation: gradients 7s infinite linear;
  cursor: pointer;
}
.Iconclosed > img {
  margin-top: 5px;
  margin-right: 5px;
}
.Icon > img {
  margin-top: 5px;
  margin-right: 5px;
}
.normal-enter-active {
  animation: normal-in 0.5s;
}
.normal-leave-active {
  animation: normal-in 0.5s reverse;
}
.notnormalffs-enter-active {
  animation: notnormalffs-in 0.2s;
}
.notnormalffs-leave-active {
  animation: notnormalffs-in 0.2s reverse;
}
@keyframes normal-in {
  0% {
    width: 0%;
    opacity: 0;
  }

  100% {
    width: 50%;
  }
}
@keyframes notnormalffs-in {
  0% {
    opacity: 1;
  }

  100% {
    opacity: 0;
  }
}
.dropbtn {
  background-color: #d0ddec;
  border-radius: 5px;
  color: rgb(92, 92, 92);
  padding: 5px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropbtn:hover,
.dropbtn:focus {
  background-color: #84e9f0;
}

#myInput {
  box-sizing: border-box;

  background-position: 14px 12px;
  background-repeat: no-repeat;
  font-size: 16px;
  padding: 14px 20px 12px 45px;
  border: none;
  border-bottom: 1px solid #ddd;
}

#myInput:focus {
  outline: 3px solid #ddd;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f6f6f6;
  min-width: 230px;
  overflow: auto;
  border: 1px solid #ddd;
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown a:hover {
  background-color: #ddd;
}
.deltagcheckbox {
  appearance: none;
}
.debitstuff {
  height: 100%;
  width: 100%;
  padding: 10px;
  border-radius: 20px;
  color: white;
  background: #1988c9;
}
.debitcheck {
  appearance: none;
}
.dbcaps {
  margin-top: 15px;
}
.db {
  display: flex;
  justify-content: center;
  grid-gap: 20px;
  height: 50px;
}
.checkmark {
  position: absolute;
  width: 50px;
  padding: 10px;
  background-color: #e0eeff;

  border: solid white 2px;
}
.container:hover input ~ .checkmark {
  background-color: #e0eeff;
}
.container input:checked ~ .checkmark {
  background-color: #1988c9;
  color: white;
  border: 2px rgb(32, 102, 151) solid;
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
.container {
  display: block;
  position: relative;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  margin-right: 70px;
  font-size: 12px;
}
.show {
  display: block;
}
textarea {
  resize: none;
  height: 100px;
}
.contentflexa {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  height: 100%;
}
.contentflexa > .janejbtn {
  grid-gap: 0px;
  justify-content: space-around;
}
@media only screen and (max-width: 786px) {
  #Timer {
    width: 100% !important;
  }
  .strecher {
    width: 100% !important;
  }
  .Iconclosed {
    border-radius: 0px 50px 0px 0px;
  }
  .Iconclosed > img {
    margin-top: 13px;
  }
  .Icon {
    border-radius: 0px 50px 0px 0px;
    height: 300px;
  }
  .Icon > img {
    margin-top: 13px;
  }
  .Timewid {
    width: 65vw;
    flex: 2;
    height: 300px;
    margin-top: 0px;
    background-color: #1988c9;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    padding-right: 20px;
    box-shadow: inset 0px 2px 3px 1px rgba(0, 0, 0, 0.233);
  }
  .timecaps {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-content: center;
    grid-gap: 50px;
    margin: 5px;
  }
  .sureoverlay {
    position: absolute;
    z-index: 2;
    border-radius: 0px 50px 0px 0px;
  }
  .buttons {
    margin-left: -90px;
  }

  .buttons > * {
    padding: 15px;
  }
  .numbers {
    font-size: 25px;
  }
  .overcaps {
    top: 5%;
    left: 10%;
    height: 240px;
  }

  .timecaps :nth-last-child(2) {
    order: 1;
  }

  @keyframes normal-in {
    0% {
      width: 0vw;
      opacity: 0;
    }
    100% {
      width: 65vw;
    }
  }
}

@media only screen and (max-width: 786px) {
  .container {
  }
  .timecontMobile {
  }
}
</style>
<script>
import { ref } from "vue";
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
import moment from "moment";
import io from "socket.io-client";
import { TimerVue as Timer } from "@josephuspaye/timer";
import Button from "./Button.vue";
export default {
  components: { DropdownMenu, Timer, Button },

  data() {
    return {
      message: "Menu Test",
      navVisible: true,
      show: false,
      products: [
        { id: 1, name: "Foo" },
        { id: 2, name: "Bar" },
        { id: 3, name: "Baz" },
        { id: 4, name: "Foobar" },
      ],
      search: "",
      Sun: 7,
      Mon: 1,
      Tue: 2,
      Wed: 3,
      logged: this.$store.state.someValue,
      time: "",
      datetime: "s",
      amountonhours: [],
      amountonminutes: [],
      Ledig: false,
      Sjuk: false,
      VAB: false,
      Semester: false,
      Thu: 4,
      Fri: 5,
      running: true,
      Sat: 6,
      picked: moment(moment().add(0, "d")._d).format("YYYY-MM-DD"),
      incrementday: 0,
      loggedin: "",
      project: [],
      chosenproject: "",
      chosenid: 0,
      Hours: "",
      Minutes: 0,
      Seconds: 0,
      Notes: "",
      debit: 1,
      toltip: true,
      shows: false,
      project: [],
      openoverlay: true,
      play: this.$store.state.playdata,
      ok: true,
      elapsedTime: 0,
      times: 0,
      timer: null,
      type: "stopwatch",
      allowOverflow: true,
      length: 5 * 1000,
      itson: false,
      primed: false,
      sureoverlay: false,
      sureoverlaytime: false,
      suretext: 0,
      picked: moment(moment().add(0, "d")._d).format("YYYY-MM-DD"),
    };
  },
  methods: {
    dataPrimer(id, title) {
      this.chosenproject = title;
      this.chosenid = id;
      if (this.chosenproject.length > 0) {
        this.primed = true;
      }
    },
    setvalue() {
      this.$store.commit("setplay");
      console.log(this.$store.state.playdata);
    },
    checker() {
      const addtimedata = {
        projectid: this.chosenid,
        title: this.chosenproject,
        name: this.loggedin.Name,
        user: this.loggedin.Username,
        description: this.Notes,
        timmar: parseInt(this.$refs.timer.time.h),
        minuter: parseInt(this.$refs.timer.time.m),
        datepicked: new Date(this.picked).getTime(),
        fatherid: this.chosenid,
        debit: this.debit,
        nanoid: this.loggedin.nanoid,
      };

      this.socketInstance.emit("time", addtimedata);
      this.chosenproject = "";
      this.chosenid = 0;
      this.Notes = "";
    },
    toggle: function () {
      this.$refs.timer.toggle();
    },
    reset: function () {
      this.$refs.timer.reset();
    },
    onStart: function () {
      console.log("event: start");
    },
    onStop: function () {
      console.log("event: stop");
    },
    onReset: function (t) {
      console.log("event: reset", t);
    },
    onPause: function () {
      console.log("event: pause");
    },
    onResume: function () {
      console.log("event: resume");
    },
    onDone: function () {
      console.log("event: done");
    },
    onOverflow: function () {
      console.log("event: overflow");
    },
  },
  filters: {
    secondsInMinutes: function (seconds) {
      return moment("2015-01-01")
        .startOf("day")
        .seconds(seconds)
        .format("HH:mm:ss");
    },
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

        this.socketInstance = io("https://mxtime.se:3000/");
        this.socketInstance.emit("loggedinfo", this.loggedin);
        if (this.loggedin.nanoid == undefined) {
          window.location.reload();
        }
        this.socketInstance.emit("mytime", this.loggedin.Username);

        this.socketInstance.on("mytimedata", (mytimedata) => {
          this.time = mytimedata;

          this.socketInstance.on("data:received", (projectdata) => {
            this.project = projectdata;

            if (this.loggedstatus == "Admin") {
              this.project = projectdata;
            } else {
              this.project = projectdata.filter(
                (result) => result.Authorstatus == this.loggedstatus
              );
            }
          });

          this.amountonhours = [];
          this.amountonminutes = [];

          this.picked = moment(moment().add(this.incrementday, "d")._d).format(
            "YYYY-MM-DD"
          );

          this.datetime = this.time.filter(
            (result) =>
              new Date(parseInt(result.Datum)).getFullYear() +
                "" +
                new Date(parseInt(result.Datum)).getMonth() +
                "" +
                new Date(parseInt(result.Datum)).getDate() ==
              new Date(this.picked).getFullYear() +
                "" +
                new Date(this.picked).getMonth() +
                "" +
                new Date(this.picked).getDate()
          );
          for (this.i = 0; this.datetime.length > this.i; this.i++) {
            this.amountonhours.push(this.datetime[this.i].Hours);

            this.amountonminutes.push(this.datetime[this.i].Minutes);
          }
          this.amountonhours = this.amountonhours.reduce((a, b) => a + b, 0);
          this.amountonminutes = Math.floor(
            this.amountonminutes.reduce((a, b) => a + b, 0) / 60
          );
        });
      });
  },
  mounted() {},
  beforeDestroy() {
    window.removeEventListener("resize", this.onResize);
  },
  watch: {
    running: function (newVal, oldVal) {
      if (newVal) this.startT();
      else this.stopT();
    },
  },
  computed: {
    playdata: {
      get() {
        return this.$store.state.playdata;
      },
      set(play) {
        this.$store.commit("setplay", playdata);
      },
    },
    filterFunction() {
      return this.project.filter((p) => {
        // return true if the product should be visible

        // in this example we just check if the search string
        // is a substring of the product name (case insensitive)
        return p.Title.toLowerCase().indexOf(this.search.toLowerCase()) != -1;
      });
    },
  },
};
</script>
