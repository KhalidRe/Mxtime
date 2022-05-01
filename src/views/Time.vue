<template>
  <div id="Time">
    <div class="Topcont">
      <div class="datecaps">
        <div class="MnW">
          <h3 style="margin: 0px">Vecka {{ this.week }}</h3>
          <h3 style="margin: 0px">Månad {{ this.month + 1 }}</h3>
        </div>
        <div class="daycont">
          <div class="nextWC">
            <div class="nextW" @click="previousWeek()">Back</div>
          </div>
          <div @click="selectday(Mon)">
            <a href="/#/Time/#Mon" class="daypick">M</a>
            <div class="singDate">{{ this.MonDate }}</div>
          </div>
          <div @click="selectday(Tue)">
            <a href="/#/Time/#Tue" class="daypick">T</a>
            <div class="singDate">{{ this.TueDate }}</div>
          </div>
          <div @click="selectday(Wed)">
            <a href="/#/Time/#Wed" class="daypick">W</a>
            <div class="singDate">{{ this.WedDate }}</div>
          </div>
          <div @click="selectday(Thu)">
            <a href="/#/Time/#Thu" class="daypick">T</a>
            <div class="singDate">{{ this.ThuDate }}</div>
          </div>
          <div @click="selectday(Fri)">
            <a href="/#/Time/#Fri" class="daypick">F</a>
            <div class="singDate">{{ this.FriDate }}</div>
          </div>
          <div @click="selectday(Sat)">
            <a href="/#/Time/#Sat" class="daypick">L</a>
            <div class="singDate">{{ this.SatDate }}</div>
          </div>
          <div @click="selectday(Sun)">
            <a href="/#/Time/#Sun" class="daypick">S</a>
            <div class="singDate">{{ this.SunDate }}</div>
          </div>
          <div class="nextWC">
            <div class="nextW" @click="nextWeek()">Next</div>
          </div>
        </div>
        <div class="formCont" v-bind:class="{ onForm: picked !== undefined }">
          <div
            class="Forminnershown"
            v-bind:class="{ innerOnShown: picked !== undefined }"
          >
            <h3>{{ picked }}</h3>
            <dropdown-menu
              :overlay="false"
              :withDropdownCloser="true"
              :closeOnClickOutside="true"
              class="dropfag"
            >
              <div
                v-if="chosenproject.length == 0"
                dropdown-closer
                class="chooseproject"
                slot="trigger"
              >
                Välj project
              </div>
              <div
                v-if="chosenproject.length > 0"
                dropdown-closer
                class="chooseproject"
                slot="trigger"
              >
                {{ chosenproject }}
              </div>
              <div class="dropper" slot="body" dropdown-closer>
                <div
                  dropdown-closer
                  class="drop-item"
                  v-for="projects in project"
                  :key="projects.id"
                  @click="dataPrimer(projects.id, projects.Title)"
                >
                  {{ projects.Title }}
                </div>
              </div>
            </dropdown-menu>
            <br />
            <div class="mh">
              <div>
                <div>Timmar</div>
                <input v-model="Hours" type="number" min="0" max="15" />
              </div>
              <div>
                <div>Minuter</div>
                <input v-model="Minutes" type="number" min="0" max="60" />
              </div>
            </div>

            <br />
            <div class="e">
              <div>Notes</div>
              <textarea
                v-model="Notes"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
            <br />
            <div class="submittime" @click="addTime()">Lägg till</div>
            <br />
          </div>
        </div>
      </div>
      <div class="UrnCaps">
        <div class="s">
          <radial-progress-bar
            :diameter="140"
            :completed-steps="
              parseInt(this.amountonhours + this.amountonminutes)
            "
            :total-steps="8"
            :innerStrokeColor="'#C7C8C9'"
            :startColor="'#969897'"
            :stopColor="'#969897'"
            :strokeLinecap="'flat'"
            :strokeWidth="10"
            :innerStrokeWidth="10"
          >
            <div>
              <span class="datatime">{{
                this.amountonhours + this.amountonminutes
              }}</span
              ><span class="slash">/</span><span class="worktime">8h</span>
            </div>
          </radial-progress-bar>
        </div>
        <div>
          <span @click="previousDay()">back</span>
          <span>{{ picked }}</span>
          <span @click="nextDay()">next</span>
        </div>

        <div class="dayinfo">
          <p v-for="biden in datetime" :key="biden.index">
            {{ biden.Title }} ->
            {{ biden.Hours + Math.floor(biden.Minutes / 60) }}h
          </p>
        </div>

        <p></p>
      </div>
    </div>
  </div>
</template>
<style scoped>
.mh {
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.submittime {
  background: #1988c9;
  cursor: pointer;
  padding: 10px;
  color: white;
  border-radius: 20px;
}
.e {
  display: flex;
  flex-direction: column;
  align-items: left;
  text-align: left;
  justify-content: flex-start;
}
textarea {
  resize: none;
  height: 100px;
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
.dayinfo {
  margin-left: 15px;
  color: rgb(105, 105, 105);
  text-align: left;
  height: 100%;
  overflow-y: scroll;
  width: 100%;
}
.s {
  align-self: center;
}
.slash {
  font-size: 30px;
}
.worktime {
  font-size: 30px;
}
.datatime {
  font-size: 30px;
}
.Forminnershown {
  display: flex;
  flex-direction: column;
  width: 50%;
  margin-bottom: 20px;
  padding: 20px;
  height: 100%;
  background: white;
}
.innerOnShown {
  opacity: 1;
}
.formCont {
  min-width: 50vw;

  height: 0px;
  border-radius: 20px;
  background: rgb(255, 255, 255);
  display: flex;
  justify-content: center;
  box-shadow: 0px 4px 5px 1px rgba(55, 55, 55, 0.267);
  margin-top: 20px;
  height: 300px;
  overflow-x: auto;
}
.onForm {
}
.UrnCaps {
  background: rgb(246, 246, 246);
  padding: 20px;
  width: 250px;
  display: flex;
  align-items: center;
  flex-direction: column;
  float: right;
  border-left: 1px solid rgba(128, 128, 128, 0.228);
}
.MnW {
  width: 350px;
  display: flex;
  justify-content: space-between;

  margin-top: 50px;
}
.singDate {
  font-size: 12px;
}

.nextWC {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 5px;
}
.nextW {
  height: 40px;
  width: 40px;
  background-color: rgb(28, 136, 168);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  color: white;
}
.daypick {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: 6vw;
  height: 50px;
  background-color: rgb(57, 124, 226);
  color: white;
  cursor: pointer;
}
a:focus {
  background-color: rgb(29, 57, 100);
}
.daypick:hover {
  background-color: rgb(29, 57, 100);
}
.datecaps {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left: 20px;
}
.daycont {
  display: flex;

  align-items: center;
}
#Time {
  width: 100%;
  height: 100%;
  display: flex;

  overflow-y: auto;
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none;
}

.Topcont {
  width: 100%;
  display: flex;
  justify-content: space-between;
  background: rgb(241, 241, 241);
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0px 10px 6px rgba(221, 221, 221, 0.993);
  border-radius: 20px;
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0px 10px rgb(139, 139, 139);
  border-radius: 20px;
}
</style>

<script>
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
import AddtimeN from "../components/AddtimeN.vue";
import Usermetrics from "../components/Usermetrics.vue";
import moment from "moment";
import RadialProgressBar from "vue-radial-progress";
import io from "socket.io-client";

export default {
  components: { AddtimeN, Usermetrics, DropdownMenu, RadialProgressBar },
  data() {
    return {
      Sun: 7,
      Mon: 1,
      Tue: 2,
      Wed: 3,
      logged: this.$store.state.someValue,
      time: "",
      datetime: "s",
      amountonhours: [],
      amountonminutes: [],
      Thu: 4,
      Fri: 5,
      Sat: 6,
      week: moment(moment().day(this.Mon)._d).week(),
      month: moment(moment().day(this.Mon)._d).month(),
      SunDate: moment(moment().day(this.Sun)._d).format("DD/MM"),
      MonDate: moment(moment().day(this.Mon)._d).format("DD/MM"),
      TueDate: moment(moment().day(this.Tue)._d).format("DD/MM"),
      WedDate: moment(moment().day(this.Wed)._d).format("DD/MM"),
      ThuDate: moment(moment().day(this.Thu)._d).format("DD/MM"),
      FriDate: moment(moment().day(this.Fri)._d).format("DD/MM"),
      SatDate: moment(moment().day(this.Sat)._d).format("DD/MM"),
      picked: moment(moment().add(0, "d")._d).format("YYYY-MM-DD"),
      incrementday: 0,
      loggedin: "",
      project: [],
      chosenproject: "",
      chosenid: 0,
      Hours: 0,
      Minutes: 0,
      Notes: "",
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
    fetch("https://flexn.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        this.loggedstatus = this.loggedin.Status;

        fetch("https://flexn.se:3000/mytime", requestOptions)
          .then((response) => response.json())
          .then((result) => {
            this.time = result;

            this.amountonhours = [];
            this.amountonminutes = [];

            this.picked = moment(
              moment().add(this.incrementday, "d")._d
            ).format("YYYY-MM-DD");
            this.SunDate = moment(moment().day(this.Sun)._d).format("DD/MM");
            this.MonDate = moment(moment().day(this.Mon)._d).format("DD/MM");
            this.TueDate = moment(moment().day(this.Tue)._d).format("DD/MM");
            this.WedDate = moment(moment().day(this.Wed)._d).format("DD/MM");
            this.ThuDate = moment(moment().day(this.Thu)._d).format("DD/MM");
            this.FriDate = moment(moment().day(this.Fri)._d).format("DD/MM");
            this.SatDate = moment(moment().day(this.Sat)._d).format("DD/MM");
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

        this.socketInstance = io("https://flexn.se:3000/");

        this.socketInstance.on("time:received", (timedata) => {
          this.time = timedata;
        });

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
      });
  },
  methods: {
    nextWeek() {
      this.Sun += 7;
      this.Mon += 7;
      this.Tue += 7;
      this.Wed += 7;
      this.Thu += 7;
      this.Fri += 7;
      this.Sat += 7;
      this.week = moment(moment().day(this.Mon)._d).week();
      this.month = moment(moment().day(this.Mon)._d).month();
      this.SunDate = moment(moment().day(this.Sun)._d).format("DD/MM");
      this.MonDate = moment(moment().day(this.Mon)._d).format("DD/MM");
      this.TueDate = moment(moment().day(this.Tue)._d).format("DD/MM");
      this.WedDate = moment(moment().day(this.Wed)._d).format("DD/MM");
      this.ThuDate = moment(moment().day(this.Thu)._d).format("DD/MM");
      this.FriDate = moment(moment().day(this.Fri)._d).format("DD/MM");
      this.SatDate = moment(moment().day(this.Sat)._d).format("DD/MM");
    },
    previousWeek() {
      this.Sun -= 7;
      this.Mon -= 7;
      this.Tue -= 7;
      this.Wed -= 7;
      this.Thu -= 7;
      this.Fri -= 7;
      this.Sat -= 7;
      this.week = moment(moment().day(this.Mon)._d).week();
      this.month = moment(moment().day(this.Mon)._d).month();
      this.SunDate = moment(moment().day(this.Sun)._d).format("MM/DD");
      this.MonDate = moment(moment().day(this.Mon)._d).format("MM/DD");
      this.TueDate = moment(moment().day(this.Tue)._d).format("MM/DD");
      this.WedDate = moment(moment().day(this.Wed)._d).format("MM/DD");
      this.ThuDate = moment(moment().day(this.Thu)._d).format("MM/DD");
      this.FriDate = moment(moment().day(this.Fri)._d).format("MM/DD");
      this.SatDate = moment(moment().day(this.Sat)._d).format("MM/DD");
    },
    selectday(day) {
      this.picked = moment(moment().day(day)._d).format("YYYY-MM-DD");

      this.amountonhours = [];
      this.amountonminutes = [];
      this.incrementday = day - 3;
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
    },
    previousDay() {
      this.amountonhours = [];
      this.amountonminutes = [];
      this.incrementday--;
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
    },
    nextDay() {
      this.amountonhours = [];
      this.amountonminutes = [];
      this.incrementday++;
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
    },
    dataPrimer(id, title) {
      this.chosenproject = title;
      this.chosenid = id;
    },
    addTime() {
      let addtimedata = {
        projectid: this.chosenid,
        title: this.chosenproject,
        name: this.loggedin.Name,
        user: this.loggedin.Username,
        description: this.Notes,
        timmar: this.Hours,
        minuter: this.Minutes,
        datepicked: new Date(this.picked).getTime(),
        fatherid: this.chosenid,
      };
      this.socketInstance.emit("time", addtimedata);
      this.minuter = 0;
      this.timmar = 0;
      location.reload();
    },
    deleteTime(id, minuter, hours, fatherid) {
      let dtimedata = {
        id: id,
        minuter: minuter,
        hours: hours,
        fatherid: fatherid,
      };
      this.socketInstance.emit("delete:time", dtimedata);
    },
  },
};
</script>
