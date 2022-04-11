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
          <h3>{{ picked }}</h3>
        </div>
      </div>
      <div class="UrnCaps">KLockFan</div>
    </div>
    <div class="Tablecont">
      <div>Table show date</div>
    </div>
  </div>
</template>
<style scoped>
.formCont {
  width: 500px;
  height: 0px;
  border-radius: 20px;
  background: black;
  transition: 1s;
}
.onForm {
  height: 300px;
}
.UrnCaps {
  width: 300px;
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
.hej {
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
  width: 50px;
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
  width: 70%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
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
  width: 100%;
  display: flex;
  justify-content: space-between;
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

export default {
  components: { AddtimeN, Usermetrics },
  data() {
    return {
      Sun: 7,
      Mon: 1,
      Tue: 2,
      Wed: 3,
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
      picked: undefined,
    };
  },
  created() {},
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
      console.log(this.picked);
    },
    formPush() {},
  },
};
</script>
