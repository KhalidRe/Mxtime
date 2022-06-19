<template>
  <div id="Timer">
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
              </dropdown-menu>
            </div>

            <div class="buttons">
             <a id="start">Start</a>
    <a id="stop">Stop</a>
    <a id="reset">Reset</a>
              <!--

 <div
                v-show="this.$store.state.playdata == false"
                @click="setvalue()"
                id="pauseTimer"
              >
                <img src="@/assets/pause.png" alt="" />
              </div>
              <div
                v-show="this.$store.state.playdata == true"
                @click="setvalue()"
                id="startTimer"
              >
                <img src="@/assets/play.png" alt="" />
              </div>
              <div @click="play = false" id="resetTimer">
                <img src="@/assets/reset.png" alt="" />
              </div>
              <div @click="checker()" id="report">console</div>
            </div>
            <div class="timecont">
              <span class="Hours" ref="Hours" timeset="0" value="0">00</span> :
              <span class="Minutes" ref="Minutes" timeset="0" value="0"
                >00</span
              >
              :
              <span class="Seconds" ref="Seconds" timeset="0" value="0"
                >00</span
              >
              :
              <span class="Miliseconds" ref="Miliseconds" timeset="0" value="0"
                >000</span
              >
            </div>
              -->
             
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
    <transition name="slide-in">
      <div v-show="openoverlay" class="overlay">
        <div @click="openoverlay = !openoverlay" class="close">
          <img width="50px" src="@/assets/timercloser.png" alt="" />
        </div>
        <div class="container">
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
            </dropdown-menu>
          </div>
          <div class="timecontMobile">
            <span class="Hours" ref="Hours" timeset="0" value="0">00</span> :
            <span class="Minutes" ref="Minutes" timeset="0" value="0">00</span>
            :
            <span class="Seconds" ref="Seconds" timeset="0" value="0">00</span>
            :
            <span class="Miliseconds" ref="Miliseconds" timeset="0" value="0"
              >000</span
            >
          </div>

          <div class="buttons">
            <!--
<button id="pauseTimerMobile">Pause</button>
           -->

            <button id="startTimerMobile">Start</button>
            <button @click="checker()">logger</button>
            <!--
<button id="resetTimerMobile">Reset</button>
            -->
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>
<style scoped>
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
  padding: 10px;
  border-radius: 5px;
  background: rgb(238, 244, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.185);
}
.chooseproject:hover {
  background: rgb(225, 238, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.32);
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
    #1988c9 30.49%,
    #1988c9 80.41%
  );
  background-size: 1000px;

  animation: gradient 1.5s infinite linear;
  width: 51%;
  height: 1px;
  float: left;
  z-index: 0;
}
.buttons {
  display: flex;
  width: 30%;

  margin: 5px;
}
.strecher {
  display: flex;
  width: 100%;
  margin-top: -1px;
}
.buttons div {
  cursor: pointer;
  padding: 10px;
  border-radius: 5px;
  background: rgb(238, 244, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.185);
  margin: 5px;
}
.buttons div:hover {
  background: rgb(225, 238, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.32);
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

.show {
  display: block;
}
@media only screen and (max-width: 1433px) {
  .overlay {
    display: block;
    position: absolute;
    z-index: 99;
    top: 0%;
    left: 0%;
    width: 100vw;
    height: 100vh;
    background: #448aff;
  }
  .strecher {
    display: none !important;
  }
  .coolline {
    display: none;
  }
  .MobileIcon {
    display: block !important;
    width: 51px;
    height: 51px;
    border-radius: 0px 0px 50px 0px;
    box-shadow: 0px 2px 3px 1px rgba(0, 0, 0, 0.233);
    background: linear-gradient(-45deg, #206dc5, #437ea0, #5574ca, #3297be);
    background-size: 20px 20px;

    animation: gradients 7s infinite linear;
    cursor: pointer;
  }
  .MobileIcon > img {
    margin-top: 5px;
    margin-right: 5px;
  }
  .container {
    background-color: #ffffff;
    width: 50%;
    min-width: 300px;
    position: absolute;
    transform: translate(-50%, -50%);
    top: 50%;
    left: 50%;
    padding: 20px 0;
    padding-bottom: 50px;
    border-radius: 10px;
  }
  .timecontMobile {
    position: relative !important;
    width: 92% !important;
    background: #ffffff !important;
    left: 4% !important;
    padding: 40px 0 !important;
    font-family: "Roboto mono", monospace !important;
    color: #0381bb !important;
    font-size: 40px !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-around !important;
    border-radius: 5px !important;
    box-shadow: 0 0 20px rgba(0, 139, 253, 0.25) !important;
  }
  .buttons {
    margin: 60px auto 0 auto !important;
    display: flex;
    justify-content: space-around !important;
  }
  .buttons button {
    width: 120px !important;
    height: 45px !important;
    background-color: #205e94 !important;
    color: #ffffff !important;
    border: none !important;
    font-family: "Poppins", sans-serif !important;
    font-size: 18px !important;
    border-radius: 5px !important;
    cursor: pointer !important;
    outline: none !important;
  }
  .buttons button:nth-last-child(2) {
    background-color: #d23332 !important;
  }
  .buttons button:nth-last-child(1) {
    background-color: #20b380 !important;
  }
  .dropdown {
    margin-top: -5px;
    margin-bottom: 10px;
  }
}
@media only screen and (max-width: 933px) {
  .container {
    background-color: #ffffff;
    width: 90%;
    min-width: 200px;
    position: absolute;
    transform: translate(-50%, -50%);
    top: 50%;
    left: 50%;
    padding: 20px 0;
    padding-bottom: 50px;
    border-radius: 10px;
  }
  .timecontMobile {
    position: relative !important;
    width: 92% !important;
    background: #ffffff !important;
    left: 4% !important;
    padding: 40px 0 !important;
    font-family: "Roboto mono", monospace !important;
    color: #0381bb !important;
    font-size: 7vw !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-around !important;
    border-radius: 5px !important;
    box-shadow: 0 0 20px rgba(0, 139, 253, 0.25) !important;
  }
}
</style>
<script>
import { ref } from "vue";
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
import moment from "moment";
import io from "socket.io-client";
export default {
  components: { DropdownMenu },
  data() {
    return {
      message: "Menu Test",
      navVisible: true,
      show: true,
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
      toltip: false,
      shows: true,
      project: [],
      openoverlay: true,
      play: this.$store.state.playdata,
      ok: true,
      playdata: this.$store.state.playdata,
    };
  },
  methods: {
    dataPrimer(id, title) {
      this.chosenproject = title;
      this.chosenid = id;
    },
    setvalue() {
      this.$store.commit("setplay");
      console.log(this.$store.state.playdata);
    },
    checker() {
      this.Hours = this.$refs.Hours.attributes[1].value;
      this.Minutes = this.$refs.Minutes.attributes[1].value;
      this.Seconds = this.$refs.Seconds.attributes[1].value;
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
    fetch("https://flexn.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        this.loggedstatus = this.loggedin.Status;

        this.socketInstance = io("https://flexn.se:3000/");
        this.socketInstance.emit("loggedinfo", this.loggedin.nanoid);
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
  mounted() {
    var timeBegan = null
, timeStopped = null
, stoppedDuration = 0
, started = null
, running = false;

document.getElementById("start").addEventListener("click", start);
document.getElementById("stop").addEventListener("click", stop);
document.getElementById("reset").addEventListener("click", reset);

function start() {
  if(running) return;
  
  if (timeBegan === null) {
    reset();
    timeBegan = new Date();
  }

  if (timeStopped !== null) {
    stoppedDuration += (new Date() - timeStopped);
  }

  started = setInterval(clockRunning, 10);	
  running = true;
}

function stop() {
  running = false;
  timeStopped = new Date();
  clearInterval(started);
}

function reset() {
  running = false;
  clearInterval(started);
  stoppedDuration = 0;
  timeBegan = null;
  timeStopped = null;
  clock.time = "00:00:00.000";
}

function clockRunning(){
  var currentTime = new Date()
  , timeElapsed = new Date(currentTime - timeBegan - stoppedDuration)
  , hour = timeElapsed.getUTCHours()
  , min = timeElapsed.getUTCMinutes()
  , sec = timeElapsed.getUTCSeconds()
  , ms = timeElapsed.getUTCMilliseconds();

  clock.time = 
    zeroPrefix(hour, 2) + ":" + 
    zeroPrefix(min, 2) + ":" + 
    zeroPrefix(sec, 2) + "." + 
    zeroPrefix(ms, 3);
};

function zeroPrefix(num, digit) {
  var zero = '';
  for(var i = 0; i < digit; i++) {
    zero += '0';
  }
  return (zero + num).slice(-digit);
}
   /*
   let [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
    let timerRef = document.querySelector(".timecont");
    let timerRefMobile = document.querySelector(".timecontMobile");
    let int = null;

    document.getElementById("startTimer").addEventListener("click", () => {
      if (int !== null) {
        clearInterval(int);
      }
      int = setInterval(displayTimer, 10);
    });

    document.getElementById("pauseTimer").addEventListener("click", () => {
      clearInterval(int);
    });

    document.getElementById("resetTimer").addEventListener("click", () => {
      clearInterval(int);
      [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
      //  timerRef.innerHTML = "00 : 00 : 00 : 000 ";
      document.getElementsByClassName("Hours")[0].textContent = "00";
      document.getElementsByClassName("Minutes")[0].textContent = "00";
      document.getElementsByClassName("Seconds")[0].textContent = "00";
      document.getElementsByClassName("Miliseconds")[0].textContent = "000";
      document.getElementsByClassName("Hours")[1].textContent = "00";
      document.getElementsByClassName("Minutes")[1].textContent = "00";
      document.getElementsByClassName("Seconds")[1].textContent = "00";
      document.getElementsByClassName("Miliseconds")[1].textContent = "000";
    });
    document
      .getElementById("startTimerMobile")
      .addEventListener("click", () => {
        if (int !== null) {
          clearInterval(int);
        }
        int = setInterval(displayTimer, 10);
      });

    document
      .getElementById("pauseTimerMobile")
      .addEventListener("click", () => {
        clearInterval(int);
      });

    document
      .getElementById("resetTimerMobile")
      .addEventListener("click", () => {
        clearInterval(int);
        [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
        // timerRef.textContent = "00 : 00 : 00 : 000 ";
        // timerRefMobile.textContent = "00 : 00 : 00 : 000 ";
        document.getElementsByClassName("Hours")[0].textContent = "00";
        document.getElementsByClassName("Minutes")[0].textContent = "00";
        document.getElementsByClassName("Seconds")[0].textContent = "00";
        document.getElementsByClassName("Miliseconds")[0].textContent = "000";
        document.getElementsByClassName("Hours")[1].textContent = "00";
        document.getElementsByClassName("Minutes")[1].textContent = "00";
        document.getElementsByClassName("Seconds")[1].textContent = "00";
        document.getElementsByClassName("Miliseconds")[1].textContent = "000";
        document.getElementsByClassName(
          "Hours"
        )[0].attributes[1].value = `${hours}`;

        document.getElementsByClassName(
          "Minutes"
        )[0].attributes[1].value = `${minutes}`;

        document.getElementsByClassName(
          "Seconds"
        )[0].attributes[1].value = `${seconds}`;

        //---------------------------------------------
        document.getElementsByClassName(
          "Hours"
        )[1].attributes[1].value = `${hours}`;

        document.getElementsByClassName(
          "Minutes"
        )[1].attributes[1].value = `${minutes}`;

        document.getElementsByClassName(
          "Seconds"
        )[1].attributes[1].value = `${seconds}`;
      });

    function displayTimer() {
      milliseconds += 10;
      if (milliseconds == 1000) {
        milliseconds = 0;
        seconds++;
        if (seconds == 60) {
          seconds = 0;
          minutes++;
          if (minutes == 60) {
            minutes = 0;
            hours++;
          }
        }
      }

      let h = hours < 10 ? "0" + hours : hours;
      let m = minutes < 10 ? "0" + minutes : minutes;
      let s = seconds < 10 ? "0" + seconds : seconds;
      let ms =
        milliseconds < 10
          ? "00" + milliseconds
          : milliseconds < 100
          ? "0" + milliseconds
          : milliseconds;
      
      document.getElementsByClassName(
        "Hours"
      )[0].attributes[1].value = `${hours}`;

      document.getElementsByClassName(
        "Minutes"
      )[0].attributes[1].value = `${minutes}`;

      document.getElementsByClassName(
        "Seconds"
      )[0].attributes[1].value = `${seconds}`;

      //---------------------------------------------
      document.getElementsByClassName(
        "Hours"
      )[1].attributes[1].value = `${hours}`;

      document.getElementsByClassName(
        "Minutes"
      )[1].attributes[1].value = `${minutes}`;

      document.getElementsByClassName(
        "Seconds"
      )[1].attributes[1].value = `${seconds}`;

      //  timerRef.innerHTML = ` ${h} : ${m} : ${s} : ${ms}`;
      // timerRefMobile.innerHTML = ` ${h} : ${m} : ${s} : ${ms}`;
      document.getElementsByClassName("Hours")[0].innerHTML = `${h}`;
      document.getElementsByClassName("Minutes")[0].innerHTML = `${m}`;
      document.getElementsByClassName("Seconds")[0].innerHTML = `${s}`;
      document.getElementsByClassName("Miliseconds")[0].innerHTML = `${ms}`;
      document.getElementsByClassName("Hours")[1].innerHTML = `${h}`;
      document.getElementsByClassName("Minutes")[1].innerHTML = `${m}`;
      document.getElementsByClassName("Seconds")[1].innerHTML = `${s}`;
      document.getElementsByClassName("Miliseconds")[1].innerHTML = `${ms}`;
    }
   
   */ 
  
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.onResize);
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
