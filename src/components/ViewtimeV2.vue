<template>
  <div
    id="ViewtimeV2"
    v-if="userstatus === 'Admin' || userstatus === 'Finanse'"
  >
    <section>
      <div class="topcont">
        <h2>Admin view</h2>
        <div class="inputsflex">
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
              Välj projekt
            </div>
            <div
              v-if="chosenproject.length > 0"
              dropdown-closer
              class="chooseproject"
              slot="trigger"
            >
              {{ chosenproject }}
            </div>
            <div class="droppers" slot="body">
              <div
                dropdown-closer
                class="drop-item allap"
                @click="dataPrimer('Alla projekt')"
              >
                Alla projekt
              </div>
              <div
                dropdown-closer
                class="drop-item franvaro"
                @click="dataPrimer('Frånvaro')"
              >
                Frånvaro
              </div>
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
                  :key="projects.index"
                  @click="dataPrimer(projects)"
                >
                  {{ projects }}
                </div>
              </div>
            </div>
          </dropdown-menu>

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
          /></span>
          <span><input type="date" name="End" id="End" v-model="end" /></span>
          <select
            name="arbetare"
            id="arbetare"
            ref="arbetare"
            v-model="selectedfilter"
          >
            <option value="alla" selected>Alla</option>
            <option
              v-for="usersindex in users"
              :key="usersindex.id"
              :value="usersindex.Name"
            >
              {{ usersindex.Name }}
            </option>
          </select>
          <input type="submit" value="Filtrera" @click="filtertime()" />
        </div>
      </div>
      <table id="testTable">
        <div class="tbl-header">
          <table cellpadding="0" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>Projekt</th>
                <th>Skapare</th>
                <th>Timmar</th>
                <th>Minuter</th>
                <th>Beskrivning</th>
                <th>Datum</th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="tbl-content">
          <table cellpadding="0" cellspacing="0" border="0">
            <tbody>
              <tr class="row" v-for="times in time" :key="times.id">
                <td>
                  {{ times.Title }}
                  <span class="debinf" v-if="times.debit == 1">(debit)</span>
                  <span class="debinf" v-if="times.debit == 0">(Ejdebit)</span>
                </td>
                <td align="center">{{ times.Name }}</td>
                <td>{{ times.Hours }}</td>
                <td>{{ parseInt(times.Minutes) }}</td>
                <td>{{ times.Description }}</td>

                <td>{{ parseInt(times.Datum) | moment }}</td>
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
    <!--
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
  
-->
  </div>
</template>
<style scoped>
.excbtn {
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
.row:nth-of-type(even) {
  background: rgb(224, 224, 224);
}
.excbtn:hover {
  background: #4dacc1;
}
.totalsum > td {
  font-size: 18px;
  font-weight: 800;
}
#debited {
  width: 100px;
  font-size: 10px;
}
.drop-item {
  width: 100%;
  padding-top: 10px !important;
  padding-bottom: 10px !important;
  background: white;
  cursor: pointer;
}
.chooseproject {
  cursor: pointer;
  padding: 10px;
  border-radius: 5px;
  background: rgb(238, 244, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.185);
  min-width: 80px;
}
.allap {
  background: #dafff0;
  margin-bottom: 2px;
  margin-top: 5px;
}
.franvaro {
  background: rgb(255, 218, 218);
  margin-bottom: 2px;
}
.chooseproject:hover {
  background: rgb(225, 238, 249) !important;
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.32) !important;
}
.drop-item:hover {
  background: rgb(226, 226, 226);
}
.v-dropdown-menu__container .v-dropdown-menu__header .v-dropdown-menu__body {
  margin-left: -50px !important;
}
.dropper {
  height: 250px !important;
  overflow-y: scroll;
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
<script src="https://unpkg.com/primevue@^3/core/core.min.js"></script>
<script>
import Addtimeform from "@/components/Addtimeform.vue";
import * as XLSX from "xlsx";
import TableToExcel from "@linways/table-to-excel";
import moment from "moment";
import DropdownMenu from "v-dropdown-menu";

export default {
  components: {
    Addtimeform,
    DropdownMenu,
  },
  data() {
    return {
      R: true,
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
      projectfilter: "Alla projekt",
      sum: 0,
      i: 0,
      subar: [],
      uniqueproject: [],
      chosenproject: "Alla projekt",
      chosenid: "",
      search: "",
      exporten: "",
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

            if (this.userstatus === "Admin") {
              fetch("https://mxtime.se:3000/alltime", searchnano)
                .then((response) => response.json())
                .then((result) => {
                  this.time = result;
                  this.time.sort(
                    (a, b) => parseInt(b.Datum) - parseInt(a.Datum)
                  );
                  this.subar = [];
                  this.uniqueproject = [
                    ...new Set(this.time.map((item) => item.Title)),
                  ];
                  for (this.i = 0; this.time.length > 0; this.i++) {
                    this.subar.push(
                      this.time[this.i].Hours +
                        parseFloat((this.time[this.i].Minutes / 60).toFixed(1))
                    );
                    this.sum = parseFloat(
                      this.subar.reduce((a, b) => a + b, 0)
                    ).toFixed(1);
                  }
                });
              fetch("https://mxtime.se:3000/getusers", searchnano)
                .then((response) => response.json())
                .then((result) => {
                  this.users = result;
                });
            }
          });
      });
  },
  filters: {
    moment: function (date) {
      return moment(date).format("L");
    },
  },
  methods: {
    moment: function () {
      return moment();
    },
    exportReportToExcel() {
      /*
      let table = document.getElementsByTagName("table");
      TableToExcel.convert(table[0], {
        name: `${
          "MX-TIDRAPPORT - " +
          this.projectfilter +
          `-` +
          this.selectedfilter +
          `-` +
          this.debitfilter
        }.xlsx`,
        sheet: {
          name: "Sheet 1",
        },
      });
      */
      this.exporten = this.time;
      for (let i = 0; i < this.exporten.length; i++) {
        delete this.exporten[i]["id"];
        delete this.exporten[i]["nanoid"];
        delete this.exporten[i]["fatherid"];
        delete this.exporten[i]["Username"];
        this.exporten[i]["Datum"] = moment(
          parseInt(this.exporten[i]["Datum"])
        ).format("YYYY-MM-DD");
        if (this.exporten[i]["debit"] == "1") {
          this.exporten[i]["debit"] = "Ja";
        } else {
          this.exporten[i]["debit"] = "Nej";
        }
      }
      const columns = [
        { header: "Datum", key: "Datum" },

        { header: "Title", key: "Title" },
        { header: "Name", key: "Name" },
        { header: "Hours", key: "Hours" },
        { header: "Minutes", key: "Minutes" },
        { header: "Description", key: "Description" },
        { header: "debit", key: "debit" },
      ];
      const data = this.exporten;
      const ws = XLSX.utils.json_to_sheet(data);

      var wscols = [
        { wch: 15 },
        { wch: 15 },
        { wch: 50 },
        { wch: 15 },
        { wch: 15 },
        { wch: 15 },
      ];

      ws["!cols"] = wscols;

      const wb = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(wb, ws, `${"MX-TIDRAPPORT - "}`);
      XLSX.writeFile(
        wb,
        `${
          "MX-TIDRAPPORT - " + this.projectfilter + `-` + this.selectedfilter
        }.xlsx`
      );
    },
    dataPrimer(title) {
      this.chosenproject = title;
      this.projectfilter = title;
    },
    Remove(id) {
      this.z = id - 1;
      this.x = id;
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },

    filtertime() {
      this.startholder = new Date(this.start).getTime();
      this.endholder = new Date(this.end).getTime();
      const searchnano = {
        method: "POST",

        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },

        body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
      };
      fetch("https://mxtime.se:3000/alltime", searchnano)
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
          if (this.projectfilter === "Frånvaro") {
            this.time = this.time.filter((results) => {
              return (
                results.Title == "VAB" ||
                results.Title == "Semester" ||
                results.Title == "Sjuk" ||
                results.Title == "Ledig"
              );
            });
            console.log(this.time);
            this.projectschosen = this.projectfilter;
          }
          if (
            this.projectfilter !== "Alla projekt" &&
            this.projectfilter !== "Frånvaro"
          ) {
            console.log("whut");
            this.time = this.time.filter((results) => {
              return results.Title == this.projectfilter;
            });
            this.projectschosen = this.projectfilter;
          }

          if (this.selectedfilter !== "alla") {
            this.time = this.time.filter((results) => {
              return results.Name.includes(this.selectedfilter);
            });
          }
          if (this.debitfilter !== "alla") {
            this.time = this.time.filter((results) => {
              return results.debit == this.debitfilter;
            });
          }

          this.subar = [];
          for (this.i = 0; this.time.length > 0; this.i++) {
            this.subar.push(
              this.time[this.i].Hours +
                parseFloat((this.time[this.i].Minutes / 60).toFixed(1))
            );
            this.sum = parseFloat(
              this.subar.reduce((a, b) => a + b, 0)
            ).toFixed(1);
          }
          if (this.time.length == 0) {
            this.sum = 0;
          }
        });
    },
  },
  computed: {
    filterFunction() {
      return this.uniqueproject.filter((p) => {
        // return true if the product should be visible

        // in this example we just check if the search string
        // is a substring of the product name (case insensitive)
        return p.toLowerCase().indexOf(this.search.toLowerCase()) != -1;
      });
    },
  },
};
</script>
