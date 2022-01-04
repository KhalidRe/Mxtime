<template>
  <div id="Home">
    <Workernav />
    <div class="Grid">
      <div class="Card" v-for="projects in project" :key="projects.id">
        <div class="tabletop">
          <span
            style="color: blue; float: left"
            v-bind:id="projects.id"
            class="edit"
            @click="Edit(projects.id), (T = !T)"
          >
            <img width="20px" src="@/assets/edit.png" alt="" />
          </span>
          <span class="title">{{ projects.Title }}</span>
          <span
            v-bind:id="projects.id"
            @click="Remove(projects.id), (R = !R)"
            style="float: right; color: red"
            ><img width="15px" src="@/assets/kryss.png" alt=""
          /></span>
        </div>
        <div class="inscription">
          <div class="utförtS">
            <span class="greendot"></span><span>Utfört</span>
          </div>
          <div class="deadlineS">
            <span class="reddot"></span><span>Deadline</span>
          </div>
        </div>
        <div class="radialprogress">
          <radial-progress-bar
            :diameter="150"
            :completed-steps="100"
            :total-steps="100"
            :innerStrokeColor="'none'"
            :startColor="'#D4F7FFB0'"
            :stopColor="'#D4F7FFB0'"
            :strokeLinecap="'flat'"
            :strokeWidth="18"
          >
            <radial-progress-bar
              class="progresscont"
              :diameter="147"
              :total-steps="0"
              :completed-steps="100"
              :innerStrokeColor="'none'"
              :startColor="'#D4F7FF'"
              :stopColor="'#D4F7FF'"
              :strokeLinecap="'flat'"
              :strokeWidth="18"
            >
              <radial-progress-bar
                :diameter="150"
                :completed-steps="projects.Precentage"
                :total-steps="100"
                :innerStrokeColor="'none'"
                :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"
                :strokeLinecap="'flat'"
                :strokeWidth="18"
              >
                <radial-progress-bar
                  :diameter="139"
                  :completed-steps="array[projects.id - 1]"
                  :total-steps="100"
                  :innerStrokeColor="'none'"
                  :startColor="'#FF0606'"
                  :stopColor="'#700505'"
                  :strokeLinecap="'flat'"
                  :strokeWidth="9"
                >
                  <radial-progress-bar
                    class="deadlinecont"
                    :diameter="129"
                    :total-steps="100"
                    :completed-steps="0"
                    :innerStrokeColor="'none'"
                    :startColor="'none'"
                    :stopColor="''"
                    :strokeLinecap="'flat'"
                    :strokeWidth="9"
                  >
                    <div class="koko">
                      <span class="precst">{{ projects.Precentage }}%</span>
                      <span class="optim">{{ array[projects.id - 1] }}%</span>
                    </div>
                  </radial-progress-bar>
                </radial-progress-bar>
              </radial-progress-bar>
            </radial-progress-bar>
          </radial-progress-bar>
        </div>
        <div class="desc">
          <div class="inf">
            <span class="fontgradient">Börjar:</span>
            <span class="fontgradient">Deadline:</span>
          </div>
          <div class="val">
            <span class="fontgradient">{{ projects.Date }}</span>
            <span class="fontgradient">{{ projects.Deadline }}</span>
          </div>
        </div>
        <div class="deltagareC">
          <span class="fontgradient">Deltagare: </span>
          <img
            class="deltagare"
            :src="require(`@/assets/${projects.Author}.jpg`)"
            alt=""
          />
          <img
            class="deltagare va"
            v-if="projects.Workers !== 'Ensam'"
            :src="require(`@/assets/${projects.Workers}.jpg`)"
            alt=""
          />
        </div>
        <div class="faktureratC">
          <button
            title="Du måste först nå 100% avklarat"
            class="notnow"
            v-if="projects.Precentage < 100"
          >
            Complete
          </button>
          <button
            class="now"
            v-if="projects.Precentage > 99"
            @click="Edit(projects.id), (arkiveraoverlay = !arkiveraoverlay)"
          >
            Complete
          </button>
        </div>
      </div>
      <transition name="slide-fade">
        <div id="Deleteform" v-if="!R">
          <iframe
            width="1px"
            height="1px"
            name="dummyframe"
            id="dummyframe"
            style="display: none"
          ></iframe>
          <form
            action="http://192.168.1.65:3000/deleteproject"
            target="dummyframe"
            method="POST"
          >
            <p>Är du säker att du vill radera detta project?</p>
            <input type="hidden" name="id" id="id" :value="this.x" />
            <input
              type="hidden"
              name="author"
              id="author"
              :value="this.rauthor"
            />
            <input
              type="hidden"
              name="workers"
              id="workers"
              :value="this.rworker"
            />
            <input
              type="hidden"
              name="username"
              id="username"
              :value="this.$store.state.someValue"
            />
            <button type="button" @click="R = !R">Nej</button>
            <input type="submit" value="JA" @click="reloadPage" />
          </form>
        </div>
      </transition>
      <transition name="slide-fade">
        <div v-if="!T" id="Editform">
          <iframe
            width="1px"
            height="1px"
            name="dummyframe"
            id="dummyframe"
            style="display: none"
          ></iframe>
          <h2>Redigera projekt</h2>
          <form
            id="inputsStyle"
            action="http://192.168.1.65:3000/editproject"
            method="POST"
            target="dummyframe"
          >
            <input type="hidden" name="title" id="title" :value="this.etitle" />
            <input type="hidden" name="date" id="date" :value="this.edate" />
            <input
              type="hidden"
              name="author"
              id="author"
              :value="this.eauthor"
            />
            <span>
              <span>Deadline: </span
              ><input
                type="date"
                name="deadline"
                :value="this.edeadline"
                id="deadline"
              />
            </span>

            <input type="hidden" name="id" id="id" :value="this.z" />
            <span class="e">
              <input
                type="range"
                name="precentage"
                id="precentage"
                v-model="precentage"
              />
              <span>{{ this.precentage }}</span>
            </span>

            <input type="submit" @click="reloadPage" />
          </form>
        </div>
      </transition>
      <transition name="slide-fade">
        <div id="ArkivForm" v-if="arkiveraoverlay">
          <iframe
            width="1px"
            height="1px"
            name="dummyframe"
            id="dummyframe"
            style="display: none"
          ></iframe>
          <form
            method="POST"
            action="http://192.168.1.65:3000/completeproject"
            target="dummyframe"
          >
            <h1>{{ this.etitle }}</h1>
            <input type="hidden" name="id" id="id" :value="this.z" />
            <input type="hidden" name="title" id="title" :value="this.etitle" />
            <input
              type="hidden"
              name="author"
              id="author"
              :value="this.eauthor"
            />
            <input
              type="hidden"
              name="workers"
              id="workers"
              :value="this.eworker"
            />
            <div>
              <span>Budget</span>
              <input type="number" id="budget" name="budget" />
            </div>
            <div>
              <span>Belopp</span>
              <input type="Number" id="belopp" name="belopp" />
            </div>
            <div>
              <p>Fakturerat</p>
              <div>
                <input
                  type="radio"
                  name="completed"
                  id="completed"
                  value="Nej"
                  checked
                />
                <label for="completed">Nej</label>
              </div>
              <div>
                <input
                  type="radio"
                  name="completed"
                  id="completed"
                  value="Ja"
                />
                <label for="completed">Ja</label>
              </div>
            </div>
            <input type="Submit" value="Arkivera" @click="reloadPage" />
          </form>
        </div>
      </transition>
    </div>
    <Postit />
  </div>
</template>
<style scoped>
.now {
  background: linear-gradient(#8bf39c 0%, #49ca38 100%);
  border: solid rgb(30, 212, 182) 1px;
  box-shadow: inset 0px 0px 5px 1px black;
  padding: 7px;
  border-radius: 20px;
  color: rgb(46, 48, 53);
  padding-left: 10px;
  padding-right: 10px;
  transition: 1s;
  animation: glow 10s infinite;
  font-weight: bold;

  font-size: 20px;
}
.now:after {
  content: "";
  top: 20%;

  width: 35px;
  height: 30px;
  position: absolute;
  z-index: 1;
  animation: slide 1s infinite;
  border-radius: 25px;

  /*
  CSS Gradient - complete browser support from http://www.colorzilla.com/gradient-editor/
  */
  background: -moz-linear-gradient(
    left,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(128, 186, 232, 0) 99%,
    rgba(125, 185, 232, 0) 100%
  ); /* FF3.6+ */
  background: -webkit-gradient(
    linear,
    left top,
    right top,
    color-stop(0%, rgba(255, 255, 255, 0)),
    color-stop(50%, rgba(255, 255, 255, 0.8)),
    color-stop(99%, rgba(128, 186, 232, 0)),
    color-stop(100%, rgba(125, 185, 232, 0))
  ); /* Chrome,Safari4+ */
  background: -webkit-linear-gradient(
    left,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(128, 186, 232, 0) 99%,
    rgba(125, 185, 232, 0) 100%
  ); /* Chrome10+,Safari5.1+ */
  background: -o-linear-gradient(
    left,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(128, 186, 232, 0) 99%,
    rgba(125, 185, 232, 0) 100%
  ); /* Opera 11.10+ */
  background: -ms-linear-gradient(
    left,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(128, 186, 232, 0) 99%,
    rgba(125, 185, 232, 0) 100%
  ); /* IE10+ */
  background: linear-gradient(
    to right,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(128, 186, 232, 0) 99%,
    rgba(125, 185, 232, 0) 100%
  ); /* W3C */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00ffffff', endColorstr='#007db9e8',GradientType=1 ); /* IE6-9 */
}

@keyframes slide {
  0% {
    opacity: 0;
    transform: translateX(-300%);
  }
  50% {
    opacity: 1;
  }
  100% {
    transform: translateX(-67%);
    opacity: 0;
  }
}
.notnow {
  background-color: #5e685c;
  padding: 7px;
  border-radius: 20px;
  color: rgb(135, 140, 151);
  border: none;
}
.progresscont {
  box-shadow: inset 0px 0px 5px 1px rgb(119, 229, 248);
  border-radius: 100%;
}
.deadlinecont {
  box-shadow: inset 0px 0px 5px 1px black;
  border-radius: 100%;
}
.tabletop {
  padding: 10px;
  align-items: center;
  display: flex;
  justify-content: space-between;
  border-radius: 15px 15px 0px 0px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  background: linear-gradient(90deg, #004e95 0%, #6994bd 100%);
}
.optim {
  color: #b40303;
  font-weight: bolder;
}
.inscription {
  display: flex;
  flex-direction: column;
  margin-bottom: -15px;
  font-size: 10px;
  text-align: left;
  margin-left: 5px;
  justify-content: flex-start;
  padding-top: 5px;
}
.koko {
  display: flex;
  flex-direction: column;
  grid-gap: 6px;
}
.fontgradient {
  background: -webkit-linear-gradient(#eee, rgb(126, 126, 126));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;

  font-size: 20px;
  line-height: 16px;
  padding-bottom: 5px;
}
.utförtS {
  display: flex;
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
  color: #24ff00;
  grid-gap: 5px;
}
.deadlineS {
  display: flex;
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
  color: red;
  grid-gap: 5px;
}
.reddot {
  width: 10px;
  height: 10px;
  border-radius: 25px;
  background-color: red;
  border: solid 1px black;
}
.greendot {
  width: 10px;
  height: 10px;
  border-radius: 25px;
  background-color: #24ff00;
  border: solid 1px black;
}
.precst {
  font-size: 25px;
  font-weight: bolder;
  color: rgb(84, 235, 134);
}
.radialprogress {
  display: flex;
  justify-content: center;
  align-items: center;
}
.inspcript {
  display: flex;
  flex-direction: column;
  position: absolute;
}
.title {
  font-size: 18px;
  font-weight: bold;
  color: rgb(212, 255, 251);
}
.desc {
  display: flex;
  justify-content: space-between;
  padding: 5px;
}
.inf {
  display: flex;
  flex-direction: column;
  text-align: left;
}
.val {
  display: flex;
  flex-direction: column;
  text-align: right;
}
#ArkivForm {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
#Deleteform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
#Home {
  margin: 0;
  max-width: 100%;
  width: 100%;
  overflow-y: scroll;
  overflow-x: hidden;
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
}
.Grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  width: 80vw;
  margin: 30px;
  grid-gap: 20px;
}
.Card {
  background: linear-gradient(
    180deg,
    #0d0d0e 30%,
    rgb(59, 92, 107) 50%,
    rgb(89, 107, 116) 57%,
    rgb(59, 92, 107) 65%,
    #000000 90%
  );
  border-radius: 15px;

  width: 250px;
  font-weight: bolder;
  font-size: 18px;
  line-height: 16px;
  color: #b1abab;
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
#Editform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;
  height: 50vh;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
@media only screen and (max-width: 1000px) {
  #ArkivForm {
    left: 20%;
  }
  #Editform {
    left: 20%;
  }
  #Deleteform {
    left: 20%;
  }
}
.deltagareC {
  display: flex;
  align-items: center;
  margin-left: 5px;
}
.deltagareC > span {
  margin-right: 4px;
}
.deltagare {
  width: 40px;
  border-radius: 25px;
  box-shadow: 0px 0px 5px 1px black;
}
.va {
  margin-left: -10px;
}
.faktureratC {
  padding: 15px;
  margin-top: 8px;
  padding-bottom: 15px;
  height: 20px;
  display: flex;
  justify-content: center;
  align-items: center;

  border-radius: 0px 0px 15px 15px;
  background: linear-gradient(180deg, #0089d0 0%, #024d72 100%);
  filter: drop-shadow(0px -1px 5px rgba(0, 0, 0, 0.25));
}
#inputsStyle {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  height: 100%;
  grid-gap: 4%;
  text-align: center;
}
input[type="text"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
}
select {
  border: none;
  background-color: rgb(27, 162, 185);
  padding: 10px;
  border-radius: 10px 10px 0px 0px;
  font-weight: bolder;
}
input[type="date"] {
  padding: 5px;
  border-radius: 5px;
  border: none;
  box-shadow: 0px 0px 5px 1px black;
}
.e {
  width: 100%;
}
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
import $ from "jquery";
import RadialProgressBar from "vue-radial-progress";
import Postit from "../components/Postit.vue";
import Workernav from "@/components/Workernav.vue";
export default {
  components: { Postit, Workernav, RadialProgressBar },
  data() {
    return {
      arkiveraoverlay: false,
      completedSteps: 0,
      totalSteps: 10,
      T: true,
      R: true,
      x: "",
      etitle: "",
      eauthor: "",
      edate: "",
      edeadline: "",
      eworkers: "",
      ecompleted: "",
      eprecentage: 0,
      precentage: 0,
      projects: "",
      project: "",
      obj: {},
      start: 0,
      end: 0,
      today: "",
      array: [],
      i: 0,
      q: 0,
      d: 0,
      optimal: 0,
    };
  },

  created() {
    fetch("http://192.168.1.65:3000/viewprojects")
      .then((response) => response.json())
      .then((result) => {
        this.project = result;
        console.log(this.project);
        for (this.i = 0; this.i < this.project.length; this.i++) {
          this.start = new Date(this.project[this.i].Date);
          this.end = new Date(this.project[this.i].Deadline);
          this.today = new Date();
          this.q = Math.abs(this.today - this.start);
          this.d = Math.abs(this.end - this.start);
          this.optimal = Math.round((this.q / this.d) * 100);
          if (this.optimal > 100) {
            this.optimal = 100;
          }
          this.array.push(this.optimal);
        }
      });
  },
  methods: {
    Edit(id) {
      this.z = id;
      this.x = id - 1;
      console.log(this.x);
      this.etitle = this.project[this.x].Title;
      this.edeadline = this.project[this.x].Deadline;
      this.ecompleted = this.project[this.x].Completed;
      this.eauthor = this.project[this.x].Author;
      this.eprecentage = this.project[this.x].precentage;
      this.edate = this.project[this.x].Date;
      this.eworker = this.project[this.x].Workers;
    },
    Remove(id) {
      this.z = id - 1;
      this.x = id;
      this.rauthor = this.project[this.z].Author;
      this.rworker = this.project[this.z].Workers;
    },
    reloadPage() {
      window.location.reload();
    },
  },
};
</script>
