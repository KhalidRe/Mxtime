<template>
  <div
    id="ViewtimeV2"
    v-if="userstatus === 'Admin' || userstatus === 'Finanse'"
  >
    <section>
      <div class="topcont">
        <h2>Admin view</h2>
        <div class="inputsflex">
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
              @
            >
              {{ usersindex.Name }}
            </option>
          </select>
          <input type="submit" value="Filtrera" @click="filterthatshit()" />
        </div>
      </div>

      <div class="tbl-header">
        <table cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th>Projekt</th>
              <th>Skapare</th>
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
              <td>
                {{ times.Title }}
                <span class="debinf" v-if="times.debit == 1">(debit)</span>
                <span class="debinf" v-if="times.debit == 0">(Ejdebit)</span>
              </td>
              <td>{{ times.Name }}</td>
              <td>{{ times.Hours }}</td>
              <td>{{ times.Minutes }}</td>
              <td>{{ times.Description }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
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
            action="https://flexn.se:3000/deletetime"
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
  height: 300px;
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
<script>
import Addtimeform from "@/components/Addtimeform.vue";
export default {
  components: {
    Addtimeform,
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
    fetch("https://flexn.se:3000/loggedin", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.userstatus = result[0].Status;

        if (this.userstatus === "Admin") {
          fetch("https://flexn.se:3000/alltime", requestOptions)
            .then((response) => response.json())
            .then((result) => {
              this.time = result;
            });
          fetch("https://flexn.se:3000/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.users = result;
            });
        }
      });
  },
  methods: {
    Remove(id) {
      this.z = id - 1;
      this.x = id;
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
    filterthatshit() {
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
      fetch("https://flexn.se:3000/alltime", requestOptions)
        .then((response) => response.json())
        .then((result) => {
          this.time = result;
          if (this.startholder > 0 && this.endholder > 0) {
            this.time = this.time.filter((results) => {
              return (
                parseInt(results.Datum) >= this.startholder &&
                parseInt(results.Datum) <= this.endholder
              );
            });
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
        });
    },
  },
};
</script>
