<template>
  <div
    id="ViewtimeV2"
    v-if="userstatus !== 'Admin' && userstatus !== 'Finanse'"
  >
    <div class="noclickzone" v-if="!vieweditwindow">
      <div class="overlayzone">
        <div class="editcontent">
          <h2>Ändra tid</h2>
          <div class="pad">
            <input type="date" v-model="edate" />
            <div class="mh">
              <div>
                <div>Timmar</div>
                <input v-model="etime.Hours" type="number" min="0" max="15" />
              </div>
              <div>
                <div>Minuter</div>
                <input v-model="etime.Minutes" type="number" min="0" max="60" />
              </div>
            </div>
            <div class="dbcaps">
              <div class="db">
                <label class="container">
                  <input
                    v-model="etime.debit"
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
                    v-model="etime.debit"
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
            <div class="e">
              <div>Notes</div>
              <textarea
                v-model="etime.Description"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
            <br />
            <div
              class="submittimes"
              @click="editTime(), (vieweditwindow = !vieweditwindow)"
            >
              Lägg till
            </div>
            <div
              class="avbryt"
              @click="(vieweditwindow = !vieweditwindow), avbrytedit()"
            >
              Avbryt
            </div>
          </div>
        </div>
      </div>
    </div>
    <section>
      <div class="topcont">
        <h2>My Time</h2>
        <div class="inputsflex">
          <select
            name="project"
            id="debited"
            ref="project"
            v-model="projectfilter"
          >
            <option value="alla" selected>Alla projekt</option>
            <option
              v-for="projects in uniqueproject"
              :key="projects.index"
              :value="projects"
            >
              {{ projects }}
            </option>
          </select>
          <select
            name="debited"
            id="debited"
            ref="debited"
            v-model="debitfilter"
          >
            <option value="alla" selected>Debit/Ej</option>
            <option value="1">Debit</option>
            <option value="0">Ej Debit</option>
          </select>

          <span
            ><input
              type="date"
              name="Start"
              id="Start"
              v-model="start"
              ref="start"
              value=""
          /></span>
          <span><input type="date" name="End" id="End" v-model="end" /></span>

          <input
            class="filterbtnforfilter"
            type="submit"
            value="Filtrera"
            @click="filtertime()"
          />
        </div>
      </div>
      <table id="testTable">
        <div class="tbl-header">
          <table cellpadding="0" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>Projekt</th>
                <th>Datum</th>
                <th>Timmar</th>
                <th>Minuter</th>
                <th>Beskrivning</th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="tbl-content">
          <table cellpadding="0" cellspacing="0" border="0">
            <tbody>
              <tr class="row" v-for="times in time" :key="times.id">
                <td class="titleandedit">
                  <span class="editimg">
                    <img
                      @click="
                        Edit(times.id, times.Datum, times),
                          (vieweditwindow = !vieweditwindow)
                      "
                      src="@/assets/edit.png"
                      width="20px"
                      alt=""
                    />
                    <span>
                      {{ times.Title }}
                    </span>
                  </span>

                  <span class="debinf" v-if="times.debit == 1">(debit)</span>
                  <span class="debinf" v-if="times.debit == 0">(Ejdebit)</span>
                </td>
                <td>
                  {{ new Date(parseInt(times.Datum)).getFullYear() }}/{{
                    new Date(parseInt(times.Datum)).getMonth() + 1
                  }}/{{ new Date(parseInt(times.Datum)).getDate() }}
                </td>

                <td>
                  {{ times.Hours }}
                </td>
                <td>{{ times.Minutes }}</td>
                <td>{{ times.Description }}</td>
              </tr>
              <tr class="totalsum">
                <td>Totala Tid: {{ sum }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </table>
    </section>
    <input
      type="button"
      class="excbtn"
      @click="exportReportToExcel(this)"
      value="Exportera till Excel"
    />
    <transition name="slide-fade">
      <div v-if="!R" class="noclick">
        <div id="Deleteform">
          <iframe
            width="1px"
            height="1px"
            name="dummyframe"
            id="dummyframe"
            style="display: none"
          ></iframe>
          <form
            action="https://mxtime.se:3000/deletetime"
            target="dummyframe"
            method="POST"
          >
            <img class="danger" src="@/assets/Danger.png" alt="" />
            <h2 class="dangertext">Raderade Tider försvinner permanent!</h2>
            <h1 class="dsure">Säker att du vill radera detta projekt?</h1>
            <input
              type="text"
              name="id"
              id="id"
              :value="this.x"
              style="display: none"
            />
            <button class="dAvbryt" type="button" @click="R = !R">Nej</button>
            <input
              class="deletebtn"
              type="submit"
              value="JA"
              @click="reloadPage"
            />
          </form>
        </div>
      </div>
    </transition>
  </div>
</template>
<style scoped>
.titleandedit {
  display: flex;
  align-items: left;
  grid-gap: 5px;
  flex-direction: column;
  justify-content: flex-start;
}
.excbtn {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  border: none;
  padding: 10px;
  border-radius: 10px;
  background: #1988c9;
  color: white;
  font-size: 16px;
  font-weight: 700;
  margin-top: 10px;
  cursor: pointer;
}
.excbtn:hover {
  background: #367bca;
}
.totalsum > td {
  font-size: 18px;
  font-weight: 800;
}
#debited {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  width: 100px;
  font-weight: 700;
  font-size: 10px;
}
@media only screen and (max-width: 650px) {
  .topcont {
    width: 100%;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 0px;
    padding: 0px !important;
    padding-top: 10px !important;
    padding-bottom: 10px !important;
  }
  .inputsflex {
    width: 30%;
    margin: 0px;
    display: grid !important;
    grid-template-columns: auto auto;
    grid-template-rows: auto auto;
  }
  #debited {
    width: 100%;
    font-size: 10px;
    font-weight: 400;
  }
  th {
    padding: 0px 0px !important;
    text-align: left;
    font-weight: 600 !important;
    font-size: 10px !important;
    color: rgb(100, 100, 100);
    text-transform: uppercase;
  }
}
.debinf {
  font-size: 8px;
}
.inputsflex {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 50px;
  grid-gap: 10px;
}
.dflex {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 55%;
  align-items: center;
}
h2 {
  margin: 0;
}
.topcont {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  display: flex;
  justify-content: space-between;
  padding: 20px;
}
.section {
}
.noclick {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
}
.dwrite {
  color: rgb(0, 0, 0);
  font-size: 12px;
  text-align: left;
}
.dinputcapsule {
  display: flex;
  flex-direction: column;
}
.dinputcapsule input[type="text"] {
  background: rgb(255, 164, 164);
}
.sureinput {
}
.fakerdeletebtn {
  background: linear-gradient(180deg, #c2afaf 0%, #9b9b9b 50.06%, #b1afaf 100%);
  border: none;
  border-radius: 5px;
  width: 100px;
  height: 40px;
  font-size: 15px;
  font-weight: 600;
}
.deletebtn {
  background: linear-gradient(180deg, #dd7070 0%, #c24a4a 50.06%, #e47878 100%);
  border: none;
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  padding-left: 20px;
  padding-right: 20px;
  height: 20px;
}
.dAvbryt {
  background: linear-gradient(180deg, #4dacc1 0%, #5578ad 50.52%, #4dacc1 100%);
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  padding-left: 20px;
  padding-right: 20px;
  height: 20px;
}
.dsure {
  color: rgb(0, 0, 0);
}
.dangertext {
  color: rgb(3, 3, 3);
}
.danger {
  width: 100px;
}
.dcapsule {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.dcapsule h1 {
  margin-top: 0px;
}
#Deleteform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: linear-gradient(
    154.98deg,
    #000000 1.35%,
    #252525 22.93%,
    #515151 49.38%,
    #343434 74.82%,
    #000000 100%
  );
  padding: 20px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateY(-100%);
  opacity: 0;
}
.Openoverlay {
  background-color: #ececec;
  height: 55px;
  width: 55px;
  border-radius: 100%;
  border: none;
  font-size: 50px;
  align-items: center;
  color: rgb(0, 0, 0);
  text-align: center;
  line-height: 50px;
}
#ViewtimeV2 {
  width: 100%;
  margin-bottom: 50px;
  overflow-x: scroll;
}

h1 {
  font-size: 30px;
  color: rgb(0, 0, 0);
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
}

table {
  width: 100%;
  table-layout: fixed;
}
.tbl-header {
  background-color: rgba(255, 255, 255, 0.3);
}

.tbl-content {
  height: 75vh;
  overflow-x: auto;
  margin-top: 0px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.137);
  background-color: rgba(255, 255, 255, 0.068);
}
th {
  padding: 20px 15px;
  text-align: left;
  font-weight: 600;
  font-size: 12px;
  color: rgb(100, 100, 100);
  text-transform: uppercase;
}
input[type="date"] {
  padding: 5px;
  border-radius: 1px;
  border: solid 1px #51515173;

  width: 100px;
  height: 27px;
  background: #ececec;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 600;
  font-size: 12px;
  color: rgb(85, 85, 85);
  border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}

select {
  border: solid 1px #5151517c;
  background: #ececec;
  width: 70px;
  height: 39px;
  border-radius: 1px;
  font-weight: bolder;
}
input[type="submit"] {
  background: #1988c9;
  border-radius: 5px;
  color: white;
  border: none;
  width: 70px;
  height: 37px;
  font-weight: 700;
  margin-left: 20px;
}
/* demo styles */

body {
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
}
section {
}
.submittimes {
  background: #1988c9;
  width: 80%;
  cursor: pointer;
  padding: 10px;
  color: white;
  border-radius: 20px;
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
  display: flex;
  flex-direction: column;

  align-items: center;
  width: 100%;
}
.urntimecaps {
  padding: 20px;
  display: flex;
  width: 90%;
  justify-content: space-between;
  align-items: center;
  text-align: center;
}

.urntimecaps:nth-child(odd) {
  background: #d8d8d8;
}
.urntimecaps:nth-child(even) {
  background: #f0f0f0;
  border-top: solid 1px rgba(0, 0, 0, 0.247);
}
.urntimecaps:hover {
  background: rgb(176, 189, 190);
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
  width: 25%;
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
  color: rgb(105, 105, 105);
  text-align: left;
  height: 100%;
  overflow-y: scroll;
  width: 100%;
  padding: 10px;
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
.avbryt {
  margin-top: 10px;
  background: rgb(218, 81, 81);
  border-radius: 20px;
  width: 100px;
  height: 20px;
  text-align: center;
  color: white;
  font-size: 15px;
  padding: 5px;
  cursor: pointer;
}
.editimg {
  margin-right: 5px;

  grid-gap: 10px;
}
.editimg > img {
  width: 20px;
  transition: 0.5s;
}
.editimg > img:hover {
  width: 25px;
  cursor: pointer;
}
.editimg > span {
  margin-left: 5px;
}
.editcontent > h2 {
  background: #1988c9;
  border-radius: 20px 20px 0px 0px;
  padding: 10px;
  color: white;
  margin-top: 0;
}
.pad {
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  grid-gap: 5px;
}
.noclickzone {
  position: absolute;
  width: 100vw;
  height: 100vh;
  top: 0%;
  left: 0%;
  background: #00000036;
  z-index: 10;
  display: flex;
  justify-content: center;

  align-items: center;
}
.overlayzone {
  width: 300px;
  height: 500px;
  background: white;
  border-radius: 20px;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.356);
}

/* follow me template */
.made-with-love {
  margin-top: 40px;
  padding: 10px;
  clear: left;
  text-align: center;
  font-size: 10px;

  font-weight: 600;
  color: rgb(0, 0, 0);
}
.made-with-love i {
  color: #f50057;
  font-size: 14px;
  position: relative;
  top: 2px;
}
.made-with-love a {
  color: rgb(0, 0, 0);
  text-decoration: none;
}
.made-with-love a:hover {
  text-decoration: underline;
}
.filterbtnforfilter {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
}

/* for custom scrollbar for webkit browser*/

::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
</style>
<script>
import Addtimeform from "@/components/Addtimeform.vue";
import moment from "moment";
import io from "socket.io-client";
export default {
  components: {
    Addtimeform,
  },
  data() {
    return {
      R: true,
      vieweditwindow: true,
      show: false,
      time: "",
      logged: this.$store.state.someValue,
      x: 0,
      userstatus: "",
      users: "",
      selectedfilter: "alla",
      start: "",
      end: "",
      startholder: "",
      endholder: "getTime(this.end),",
      debitfilter: "alla",
      projectfilter: "alla",
      sum: 0,
      i: 0,
      subar: [],
      uniqueproject: [],
      From: "F",
      To: "T",
      z: 0,
      x: 0,
      etime: "",
      oldhours: "",
      oldminutes: "",
      edate: "",
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

        const searchnano = {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },

          body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
        };

        fetch("https://mxtime.se:3000/loggedin", requestOptions)
          .then((response) => response.json())
          .then((result) => {
            this.userstatus = result[0].Status;
            this.socketInstance = io("https://mxtime.se:3000/", {
              transports: ["websocket"],
              pingInterval: 1000 * 60 * 10,
              pingTimeout: 1000 * 60 * 5,
              reconnection: true,
              reconnectionDelay: 1000,
              reconnectionDelayMax: 5000,
              reconnectionAttempts: Infinity,
            });
            var socketInstance = this.socketInstance;
            var loggedin = this.loggedin;
            this.socketInstance.emit("loggedinfo", this.loggedin);
            socketInstance.on("connect", function () {
              console.log("Connected to server");
              socketInstance.emit("loggedinfo", loggedin);
            });

            this.socketInstance.on("disconnect", function () {
              console.log("Disconnected from server");
            });

            this.socketInstance.on("ping", function () {});

            this.socketInstance.on("pong", function () {
              console.log("Received pong from server");
            });

            this.socketInstance.emit("mytime", this.loggedin.Username);

            this.socketInstance.on("mytimedata", (mytimedata) => {
              this.time = mytimedata;

              if (this.loggedin.nanoid == undefined) {
                window.location.reload();
              }

              this.time.sort((a, b) => parseInt(b.Datum) - parseInt(a.Datum));

              this.uniqueproject = [
                ...new Set(this.time.map((item) => item.Title)),
              ];

              this.subar = [];
              let sum = this.time.reduce((accumulator, object) => {
                return accumulator + object.Hours;
              }, 0);
              let sums = this.time.reduce((accumulator, object) => {
                return accumulator + object.Minutes / 60;
              }, 0);
              sums = parseFloat(sums).toFixed(1);
              console.log("SUM", sum);
              console.log("SUMS", sums);
              this.sum = parseInt(sum) + parseFloat(sums);
              console.log(this.sum);
            });
            fetch("https://mxtime.se:3000/getusers", searchnano)
              .then((response) => response.json())
              .then((result) => {
                this.users = result;
              });
          });
      });
  },
  methods: {
    editTime() {
      const sender = {
        etime: this.etime,
        oldhours: this.oldhours,
        oldminutes: this.oldminutes,
      };
      this.etime.Datum = new Date(this.edate).getTime();
      this.socketInstance.emit("edittime", sender);
      console.log(sender);
    },
    Edit(id, datum, cont) {
      this.z = id;
      this.x = id - 1;
      this.etime = cont;
      this.oldhours = this.etime.Hours;
      this.oldminutes = this.etime.Minutes;
      this.edate = moment(parseInt(datum)).format("YYYY-MM-DD");
      console.log(this.edate);
      console.log(this.etime);
    },
    Remove(id) {
      this.z = id - 1;
      this.x = id;
    },
    exportReportToExcel() {
      if (this.start.length > 1 || this.end.length > 1) {
        this.From = this.start;
        this.To = this.end;
      }
      let table = document.getElementsByTagName("table");
      TableToExcel.convert(table[0], {
        name: `${
          "MX-TIDRAPPORT - " +
          this.projectfilter +
          `-` +
          this.From +
          this.To +
          `-` +
          this.debitfilter
        }.xlsx`,
        sheet: {
          name: "Sheet 1",
        },
      });

      console.log(this.end);
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
    avbrytedit() {
      console.log(this.edate);
      console.log(this.etime);
      this.socketInstance.emit("mytime", this.loggedin.Username);
    },
    filtertime() {
      this.startholder = new Date(this.start).getTime();
      this.endholder = new Date(this.end).getTime();
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
      fetch("https://mxtime.se:3000/mytime", requestOptions)
        .then((response) => response.json())
        .then((result) => {
          this.time = result;
          this.time.sort((a, b) => parseInt(b.Datum) - parseInt(a.Datum));
          if (this.startholder > 0 && this.endholder > 0) {
            this.time = this.time.filter((results) => {
              return (
                parseInt(results.Datum) >= this.startholder &&
                parseInt(results.Datum) <= this.endholder
              );
            });
          }

          if (this.debitfilter !== "alla") {
            this.time = this.time.filter((results) => {
              return results.debit == this.debitfilter;
            });
          }
          if (this.projectfilter !== "alla") {
            this.time = this.time.filter((results) => {
              return results.Title == this.projectfilter;
            });
          }
          this.subar = [];
          let sum = this.time.reduce((accumulator, object) => {
            return accumulator + object.Hours;
          }, 0);
          let sums = this.time.reduce((accumulator, object) => {
            return accumulator + object.Minutes / 60;
          }, 0);
          sums = parseFloat(sums).toFixed(1);
          console.log("SUM", sum);
          console.log("SUMS", sums);
          this.sum = parseInt(sum) + parseFloat(sums);
          console.log(this.sum);
          if (this.time.length == 0) {
            this.sum = 0;
          }
        });
    },
  },
};
</script>
