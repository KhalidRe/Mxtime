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
            <input type="text" />
            <br />
            <input type="text" />
            <br />
            <input type="text" />
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
              ><span class="slash">/</span><span class="worktime">8</span>
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

        <p>total----------DAMN!</p>
      </div>
    </div>
  </div>
</template>
<style scoped>
.dayinfo {
  margin-left: 15px;
  color: rgb(105, 105, 105);
  text-align: left;
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
  opacity: 0;
  transition: 1s;
  transition-delay: 0.5s;
}
.innerOnShown {
  opacity: 1;
}
.formCont {
  width: 50vw;
  height: 0px;
  border-radius: 20px;
  background: rgb(243, 243, 243);
  transition: 1s;
}
.onForm {
  height: 300px;
}
.UrnCaps {
  background: rgb(223, 223, 223);
  padding: 20px;
  width: 250px;
  display: flex;
  justify-content: center;
  flex-direction: column;
  float: right;
  box-shadow: 0px -5px 5px 5px rgba(134, 134, 134, 0.514);
}
.MnW {
  width: 350px;
  display: flex;
  justify-content: space-between;
  align-items: center;
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
  width: 69%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  float: left;
}
.daycont {
  display: flex;

  align-items: center;
}
#Time {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  overflow-y: auto;
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none;
}

.Topcont {
  background: rgb(141, 141, 141);
  width: 100%;
  height: 100%;
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0px 10px 6px rgba(27, 247, 255, 0.993);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0px 6px rgb(0, 0, 0);
}
</style>

<script>
import AddtimeN from "../components/AddtimeN.vue";
import Usermetrics from "../components/Usermetrics.vue";
import moment from "moment";
import RadialProgressBar from "vue-radial-progress";
import io from "socket.io-client";

export default {
  components: { AddtimeN, Usermetrics, RadialProgressBar },
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
    fetch("https://flexn.se:3000/mytime", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.time = result;

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

    this.socketInstance = io("https://flexn.se:3000/");
    this.socketInstance.on("time:received", (timedata) => {
      this.time = timedata;
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
  },
};
</script>
