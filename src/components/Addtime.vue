<template>
  <div id="Addtime">
    <section>
      <h1 class="hd">Lägg in tid</h1>
      <div class="tbl-header">
        <table cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th>Projekt</th>
              <th>Timmar</th>
              <th>Minuter</th>
              <th>Beskrivning</th>
              <Addtimeform class="o" />
            </tr>
          </thead>
        </table>
      </div>
      <div class="tbl-content">
        <table cellpadding="0" cellspacing="0" border="0">
          <tbody>
            <tr class="Card" v-for="(times, index) in time" :key="times.id">
              <td>{{ times.Title }}</td>
              <td>{{ times.Hours }}</td>
              <td>{{ times.Minutes }}</td>
              <td>{{ times.Description }}</td>
              <td
                style="color: red; cursor: pointer"
                v-bind:id="times.id"
                @click="Remove(index), (R = !R)"
              >
                DELETE
              </td>
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
          <form action="" target="dummyframe" method="POST">
            <img class="danger" src="@/assets/Danger.png" alt="" />
            <h2 class="dangertext">Raderade Tider försvinner permanent!</h2>
            <h1 class="dsure">Säker att du vill radera detta projekt?</h1>
            <input
              type="hidden"
              name="id"
              id="id"
              :value="this.x"
              style="display: none"
            />
            <input
              type="hidden"
              name="hours"
              id="hours"
              :value="parseInt(this.dhours)"
              style="display: none"
            />
            <input
              type="hidden"
              name="minutes"
              id="minutes"
              :value="parseInt(this.dminutes)"
              style="display: none"
            />
            <input
              type="hidden"
              name="title"
              id="title"
              :value="this.dtitle"
              style="display: none"
            />

            <button class="dAvbryt" type="button" @click="R = !R">Nej</button>
            <input
              class="deletebtn"
              type="submit"
              value="JA"
              @click="sendDelete(), reloadPage()"
            />
          </form>
        </div>
      </div>
    </transition>
  </div>
</template>
<style scoped>
.hd {
  background: #1988c9;
  padding: 10px;
  margin: 0px;
}
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&display=swap");
.dflex {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 55%;
  align-items: center;
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
  color: rgb(255, 164, 164);
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
.Card:nth-of-type(odd) {
  background-color: #0089d0;

  color: white;
}
.Card:nth-of-type(even) {
  background-color: #006aae;

  color: white;
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
  color: rgb(255, 255, 255);
}
.dangertext {
  color: rgb(252, 97, 97);
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
.o {
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
}
#Addtime {
  margin-top: 1px;
  width: 100%;
}

h1 {
  font-size: 30px;
  color: #fff;
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
  background-color: #006aae;
}

.tbl-content {
  height: 300px;
  overflow-x: auto;
  margin-top: 0px;
  box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.137);
  background-color: #006aae;
}
th {
  padding: 20px 15px;
  text-align: left;
  font-size: 14px;
  font-weight: 600;
  color: #fff;
  text-transform: uppercase;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 600;
  font-size: 14px;
  color: #fff;
  border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}

/* demo styles */

@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,300,700);
body {
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  font-family: "Roboto", sans-serif;
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
  font-family: arial;
  color: #fff;
}
.made-with-love i {
  font-style: normal;
  color: #f50057;
  font-size: 14px;
  position: relative;
  top: 2px;
}
.made-with-love a {
  color: #fff;
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
import io from "socket.io-client";
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
      dhours: 0,
      dminutes: 0,
      dtitle: "",
      dtimeused: "",
      z: 0,
      index: 0,
    };
  },
  methods: {
    sendDelete() {
      let dtimedata = {
        id: this.x,
        title: this.dtitle,
        timmar: this.dhours,
        minuter: this.dminutes,
      };
      this.socketInstance.emit("delet:time", dtimedata);
    },
    Remove(index) {
      this.z = id - 1;
      this.x = this.time[index].id;
      this.dhours = this.time[index].Hours;
      this.dminutes = this.time[index].Minutes;
      this.dtitle = this.time[index].Title;
      this.dtimeused = this.dhours + this.dminutes;
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
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
    fetch("https://mxtime.se:3000/mytime", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.time = result;
      });
    this.socketInstance = io("https://mxtime.se:3000/");
    this.socketInstance.on("time:received", (timedata) => {
      this.time = timedata;
    });
  },
};
</script>
