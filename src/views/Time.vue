<template>
  <div id="Time">
    <div class="Topcont">
      <div class="datecaps">
        <div class="MnW">
          <h3 style="margin: 0px">Vecka {{ this.week - 1 }}</h3>
          <h3 style="margin: 0px">Månad {{ this.month + 1 }}</h3>
        </div>
        <div class="daycont">
          <div class="nextWC">
            <div class="nextW" @click="previousWeek()">Back</div>
          </div>
          <div class="daybtn" @click="selectday(Mon)">
            <a href="/#/Time/#Mon" class="daypick">M</a>
            <div class="singDate">{{ this.MonDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Tue)">
            <a href="/#/Time/#Tue" class="daypick">T</a>
            <div class="singDate">{{ this.TueDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Wed)">
            <a href="/#/Time/#Wed" class="daypick">O</a>
            <div class="singDate">{{ this.WedDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Thu)">
            <a href="/#/Time/#Thu" class="daypick">T</a>
            <div class="singDate">{{ this.ThuDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Fri)">
            <a href="/#/Time/#Fri" class="daypick">F</a>
            <div class="singDate">{{ this.FriDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Sat)">
            <a href="/#/Time/#Sat" class="daypick">L</a>
            <div class="singDate">{{ this.SatDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Sun)">
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
            <div class="LSVS">
              <div class="db">
                <label class="container"
                  ><label
                    @click="(chosenproject = 'Ledig'), (chosenid = 0)"
                    v-if="chosenproject !== 'Ledig'"
                    for="Ledig"
                    class="checkmark"
                    ><div>Ledig</div></label
                  ></label
                ><label class="container"
                  ><label
                    @click="(chosenproject = 'Semester'), (chosenid = 0)"
                    v-if="chosenproject !== 'Semester'"
                    for="Semester"
                    class="checkmark"
                    ><div>Semester</div></label
                  ></label
                >
                <label class="container"
                  ><label
                    @click="(chosenproject = 'VAB'), (chosenid = 0)"
                    v-if="chosenproject !== 'VAB'"
                    for="VAB"
                    class="checkmark"
                    ><div>VAB</div></label
                  ></label
                >
                <label class="container"
                  ><label
                    @click="(chosenproject = 'Sjuk'), (chosenid = 0)"
                    v-if="chosenproject !== 'Sjuk'"
                    for="Sjuk"
                    class="checkmark"
                    ><div>Sjuk</div></label
                  ></label
                >
              </div>
            </div>
            <div class="projectcaps">
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
                <div class="dropper" slot="body">
                  <input
                    class="searchbar"
                    type="text"
                    v-model="search"
                    placeholder="Search"
                  />
                  <div class="dropper" slot="body" dropdown-closer>
                    <div
                      dropdown-closer
                      class="drop-item"
                      v-for="projects in filterFunction"
                      :key="projects.id"
                      @click="dataPrimer(projects.id, projects.Title)"
                    >
                      {{ projects.Title }}
                    </div>
                  </div>
                </div>
              </dropdown-menu>
            </div>

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
            :startColor="'rgb(57, 124, 226)'"
            :stopColor="'#397ce2'"
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
        <div class="bfcaps">
          <div class="bf" @click="previousDay()">back</div>
          <div class="urndate">{{ picked }}</div>
          <div class="bf" @click="nextDay()">next</div>
        </div>

        <div class="dayinfo">
          <div class="spacer">
            <div
              class="urntimecaps"
              v-for="biden in datetime"
              :key="biden.index"
            >
              <div class="urntimetitle">
                {{ biden.Title }}
                <span class="debinf" v-if="biden.debit == 1">(debit)</span>
                <span class="debinf" v-if="biden.debit == 0">(Ejdebit)</span>
              </div>

              <div class="urntimetime">
                {{ biden.Hours + parseFloat((biden.Minutes / 60).toFixed(1)) }}h
              </div>
              <span
                @click="
                  deleteTime(
                    biden.id,
                    biden.Minutes,
                    biden.Hours,
                    biden.fatherid
                  )
                "
                class="deletetime"
                >Delete</span
              >
            </div>
          </div>
        </div>

        <p></p>
      </div>
    </div>
  </div>
</template>
<style scoped>
.dropper {
  height: 250px !important;
  overflow-y: scroll;
}
.LSVS {
  margin: 20px;
}
.debinf {
  font-size: 8px;
}
.deletetime {
  flex: 0;
  color: #c93319;
  font-size: 10px;
  cursor: pointer;
  align-self: center;
  margin: 2px;
}
.deletetime:hover {
  transition: 0.2s;
  color: #ff3916;
  font-size: 10px;
  transform: scale(1.2);
}
.projectcaps {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
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
.spacer {
  margin-top: 20px;
}
.urntimecaps {
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: left;
  text-align: left;
}
.urntimecaps:nth-child(odd) {
  background: #d8d8d8;
}
.urntimecaps:nth-child(even) {
  background: #f0f0f0;
  border-top: solid 1px rgba(0, 0, 0, 0.247);
}
.urntimetitle {
  display: flex;
  align-items: right;
  text-align: right;
  font-size: 12px;
}
.urntimetime {
  flex: 1;
  display: flex;
  justify-content: flex-end;
  align-items: right;
  text-align: right;
}
.bfcaps {
  width: 100%;

  display: flex !important;
  justify-content: space-around !important;
  align-items: center;
}
.urndate {
  background: #397ce2;
  padding: 5px;
  color: white;

  border-radius: 5px;
}
.bf {
  padding: 5px;
  cursor: pointer;
  background: rgb(60, 126, 167);
  color: white;
  border-radius: 5px;
}
.mh {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
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
  padding: 30px;

  background: rgb(238, 249, 255);
}
.innerOnShown {
  opacity: 1;
}
.formCont {
  width: 100%;

  background: rgb(255, 255, 255);
  display: flex;
  justify-content: center;
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
  align-items: top;
  height: 100%;
}
.daycont {
}
.nextW {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: 6vw;
  height: 50px;
  background-color: #397ce2;
  color: white;
  cursor: pointer;
}
.nextW:hover {
  background: #4d8be9;
}
.daypick {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;

  height: 50px;
  background-color: #397ce2;
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
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left: 20px;
  padding-right: 20px;
}
.daycont {
  display: flex;
  background-color: rgb(255, 255, 255);
  align-items: center;
  width: 100%;
  justify-content: center;
}
.daybtn {
  width: 100%;
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
@media only screen and (max-width: 800px) {
  .MnW {
    width: 100%;
    justify-content: space-around;
  }
  .Topcont {
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
  }
  .datecaps {
    flex: 0;

    padding-left: 0px;
    padding-right: 0px;
    width: 95%;
  }
  .UrnCaps {
    width: 90%;
    padding: 0px;
  }
  .Topcont {
    font-size: 15px;
  }
  .nextW {
    padding-left: 5px;
    padding-right: 5px;
  }
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
import $ from "jquery";

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
      search: "",
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
      debit: 1,
      toltip: false,
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
    test() {},
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
        debit: this.debit,
        nanoid: this.loggedin.nanoid,
      };
      console.log(addtimedata);

      this.socketInstance.emit("time", addtimedata);
      // window.location.reload();
    },
    ledig() {
      if (this.Ledig == true) {
        this.chosenproject = "Ledig";
      }
      if (this.Semester == true) {
        this.chosenproject = "Semester";
      }
      if (this.VAB == true) {
        this.chosenproject = "VAB";
      }
    },
    deleteTime(id, minuter, hours, fatherid) {
      let dtimedata = {
        id: id,
        minuter: minuter,
        hours: hours,
        fatherid: fatherid,
        user: this.loggedin.Username,
      };

      this.socketInstance.emit("delet:time", dtimedata);
      //window.location.reload();
    },
  },
  mounted() {
    $("input:checkbox").on("click", function () {
      var $box = $(this);
      if ($box.is(":checked")) {
        var group = "input:checkbox[name='" + $box.attr("name") + "']";
        $(group).prop("checked", false);
        $box.prop("checked", true);
      } else {
        $box.prop("checked", false);
      }
    });
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
