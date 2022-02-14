<template>
  <div class="Users transform">
    <Usermetrics />
    <Addtime />
    <h1>Marinex</h1>
    <div class="Grid">
      <div class="s" v-for="users in user" :key="users.id">
        <div name="id" id="id" class="card" :value="users.id">
          <div class="profile">
            <img
              class="img"
              :src="require(`@/assets/${users.Profile}`)"
              alt=""
            />
          </div>
          <div>
            <h2 class="name">
              <div>{{ users.Name }}</div>
            </h2>
          </div>

          <div class="readmore">
            <button
              class="readmorebtn"
              @click="View(users.id), (showprofile = !showprofile)"
            >
              Show profile
            </button>
          </div>
        </div>
      </div>
    </div>
    <transition name="fade">
      <div
        style="transition-delay: 0.5s"
        class="profileview"
        v-if="showprofile"
      >
        <video autoplay muted loop>
          <source src="@/assets/energy.webm" type="video/mp4" />
        </video>

        <div class="metrics">
          <div class="close" @click="showprofile = !showprofile">
            <img width="40vw" src="@/assets/closebtn.png" alt="" />
          </div>
          <div class="infocapsule">
            <div class="gotit">
              <img
                class="img"
                :src="require(`@/assets/${this.eprofile}`)"
                alt=""
              />
              <h1>{{ this.ename }}</h1>
            </div>
            <div class="stats">
              <div class="fe">
                <div class="n">
                  <div>{{ this.eactive }}</div>
                </div>
                <div class="d">Active</div>
              </div>

              <div class="fe">
                <div class="n">
                  <div>{{ this.ecreated }}</div>
                </div>
                <div class="d">Created</div>
              </div>

              <div class="fe">
                <div class="n">
                  <div>{{ this.ecompleted }}</div>
                </div>
                <div class="d">Success</div>
              </div>
            </div>
            <div class="chart">
              <Linechart id="chart" :to-chart="filteredArray" />
            </div>
          </div>
        </div>
      </div>
    </transition>
    <Viewtime />
  </div>
</template>
<style scoped>
@keyframes FadeIn {
  0% {
    opacity: 0;
    transform: perspective(400px) translateZ(200px);
  }
  10% {
    opacity: 0;
  }

  85% {
    box-shadow: 0px 0px 0px rgba(242, 242, 242, 0.28);
  }
  100% {
    transform: perspective(400px) translateZ(0px);
    box-shadow: 0px 6px 9px rgba(242, 242, 242, 0.28);
  }
}

.fe {
  animation: FadeIn 1s linear;
  animation-fill-mode: both;
}

.stats .fe:nth-child(1) {
  animation-delay: 0.5s;
}
.stats .fe:nth-child(2) {
  animation-delay: 1s;
}
.stats .fe:nth-child(3) {
  animation-delay: 1.5s;
}
.stats .fe:nth-child(4) {
  animation-delay: 2s;
}
.digitalstats {
  display: grid;
  grid-template-columns: auto auto auto;
  justify-content: center;
  grid-gap: 10px;
}
#chart {
  width: 100%;
}
.chart {
  width: 100%;
  background-color: #000000cc;

  float: right;
  color: white;
}
.gotit {
}
.infocapsule {
  width: 100%;
  height: 90%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
}
.close {
  float: right;
  padding: 20px;
}
#line-chart {
  width: 100vw;
}
.metrics {
  width: 100%;
  height: 100%;
  position: absolute;
}
video {
  width: 100%;
  height: 100%;
  position: fixed;
  object-fit: cover;
  z-index: 0;
  left: 0;
}
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
.profileview {
  width: 100vw;
  height: 100vh;
  position: absolute;
  z-index: 1;

  left: 0%;
}
.readmore {
  width: 100%;
  margin-top: 15%;
  padding-bottom: 10px;
  display: flex;
  justify-content: center;
}
.readmorebtn {
  width: 70%;
  padding: 15px;
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  border-radius: 20px;
  font-size: 20px;
  border: solid 1px#30a2b1;
  font-weight: bold;
}
.readmorebtn:hover {
  background: -webkit-linear-gradient(left, #3bf0a4, #38c6d3);
}
.readmorebtn:active {
  background: -webkit-linear-gradient(left, #113526, #113a3d);
  border: none;
}
#Your {
  width: 100%;
}
.Users {
  background-color: #006aae;
  color: white;
  width: 100%;
  height: 100vh;
  overflow-y: scroll;
  overflow-x: hidden;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.s {
}
.Grid {
  width: 80vw;
  margin-top: 50px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  grid-gap: 50px;
  padding-bottom: 50px;
}
.img {
  width: 100px;
  border-radius: 50px;
  border: solid #38abe0;
  box-shadow: 0px 5px 10px 2px rgba(114, 114, 114, 0.507);
  margin-top: 5px;
}
.card {
  width: 300px;

  background: linear-gradient(180deg, #5f94a5 0%, #000000 100%);
  box-shadow: 0px 5px 5px 1px rgba(0, 253, 42, 0.322);
  border-radius: 40% 20px 20px 20px;
}
.name {
  margin-top: 5px;
  color: #6dff91;
}
.stats {
  display: grid;
  grid-template-columns: auto auto auto;
  justify-content: center;
  grid-gap: 10px;
}
.fe {
  width: 85px;
  height: 120px;
  background: linear-gradient(156.98deg, #585858 3.66%, #000000 97.3%);

  border-radius: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.n > div {
  background: -webkit-linear-gradient(
    148.95deg,
    #63ab37 14.93%,
    rgba(43, 108, 117, 0.93) 89.41%
  );
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.n {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;

  background: linear-gradient(
    131.77deg,
    #000000 12.15%,
    rgba(55, 55, 55, 0.65) 56.17%,
    #3382df 87.64%
  );
  border-radius: 100px;
  width: 70px;
  height: 70px;

  font-size: 50px;
  font-weight: bolder;
  color: rgb(130, 255, 130);
  margin-top: 5px;
}
.d {
  font-size: 18px;
  font-weight: bold;
  color: #b7ff8a;
  margin-top: 10px;
}
.detail {
  margin-top: 50px;
  padding: 10px;
  background-color: green;
  box-shadow: 0px 3px 5px 1px rgba(255, 255, 255, 0.432);
}
.transform {
  -webkit-transition: all 2s ease;
  -moz-transition: all 2s ease;
  -o-transition: all 2s ease;
  -ms-transition: all 2s ease;
  transition: all 2s ease;
}

.transform-active {
  background-color: #45cee0;
  height: 200px;
  width: 200px;
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
import Linechart from "../components/Linechart.vue";
import $ from "jquery";
import Usermetrics from "../components/Usermetrics.vue";
import Addtime from "../components/Addtime.vue";
import Viewtime from "../components/Viewtime.vue";
export default {
  components: {
    Addtime,
    Usermetrics,
    Linechart,
    Viewtime,
  },
  data() {
    return {
      showprofile: false,
      user: "",
      projects: "",
      logged: this.$store.state.someValue,
      arkivs: "",
      success: true,
      arr2: "",
      index: "",
      value2: "",
      datumchart: [],
      count: {},
      second: {},
      filteredArray: [],
      datacollection: null,
    };
  },
  created() {
    const requestOptions = {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    const auth = {
      method: "POST",
      mode: "cors",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("188.166.114.141:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length == 0) {
          location.replace("https://flexnet.se/#/");
        }
        if (result.length > 0) {
          fetch("188.166.114.141:3000/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.user = result;
            });

          fetch("188.166.114.141:3000/myprojects", requestOptions)
            .then((response) => response.json())
            .then((result) => {
              this.myprojects = result;
            });

          fetch("188.166.114.141:3000/getarkiv")
            .then((response) => response.json())
            .then((result) => {
              this.arkivs = result;
            });
        }
      });
  },
  methods: {
    View(id) {
      this.z = id;
      this.x = id - 1;

      this.ename = this.user[this.x].Name;
      this.eprofile = this.user[this.x].Profile;
      this.eactive = this.user[this.x].Active;
      this.ecreated = this.user[this.x].Created;
      this.ecompleted = this.user[this.x].Completion;

      this.chartdata = this.arkivs.filter(
        (arkiv) => arkiv.Author == this.ename || arkiv.Workers == this.ename
      );

      this.count = this.chartdata.map((item) => item.Datum);

      this.second = {};
      for (let i = 0; i < this.count.length; i++) {
        this.second[this.count[i]] = this.second[this.count[i]] + 1 || 1;
      }
      this.filteredArray = Object.keys(this.second).reduce((acc, cur) => {
        acc.push({ Datum: cur, result: this.second[cur] });
        return [...acc];
      }, []);

      this.index = this.chartdata
        .map((e) => e["Datum"])
        .map((e, i, final) => final.indexOf(e) === i && i)
        .filter((obj) => this.chartdata[obj])
        .map((e) => this.chartdata[e]);
    },
  },
};
</script>
