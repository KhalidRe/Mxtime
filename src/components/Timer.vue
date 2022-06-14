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
                  <input type="text" v-model="search" placeholder="Search" />
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
              <button id="pauseTimer">Pause</button>
              <button id="startTimer">Start</button>
              <button id="resetTimer">Reset</button>
              <button @click="primedata()" id="report">console</button>
            </div>
            <div class="timecont">00 : 00 : 00 : 000</div>
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

      <div class="newfeature">
        <img class="newfetureimg" src="@/assets/Newfeture.png" alt="" />
      </div>
    </div>
  </div>
</template>
<style scoped>
.newfeature {
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
  justify-content: space-between;
}
.strecher {
  display: flex;
  width: 100%;
  margin-top: -1px;
}
.buttons button {
  background-color: #1988c9;
  box-shadow: 0px 0px 5px 3px #1a71a38e;
  color: #ffffff;
  border: none;
  font-family: "Poppins", sans-serif;
  font-size: 18px;
  border-radius: 5px;
  cursor: pointer;
  outline: none;
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
@keyframes newfeture {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.6);
  }
  60% {
    transform: scale(1.6);
    transform: rotate(170deg);
  }

  100% {
    transform: scale(1.6);
    transform: rotate(170deg);
    transform: skew(50deg);
  }
}
.newfetureimg {
  animation: newfeture;
  animation: newfeture 1s infinite;
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
      Hours: 0,
      Minutes: 0,
      Notes: "",
      debit: 1,
      toltip: false,
      shows: true,
      project: [],
    };
  },
  methods: {
    dataPrimer(id, title) {
      this.chosenproject = title;
      this.chosenid = id;
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
            console.log(this.project);
            if (this.loggedstatus == "Admin") {
              this.project = projectdata;
            } else {
              this.project = projectdata.filter(
                (result) => result.Authorstatus == this.loggedstatus
              );
            }
          });
          console.log(this.time);
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
    let [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
    let timerRef = document.querySelector(".timecont");
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
      timerRef.innerHTML = "00 : 00 : 00 : 000 ";
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

      timerRef.innerHTML = ` ${h} : ${m} : ${s} : ${ms}`;
    }
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.onResize);
  },
  computed: {
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
