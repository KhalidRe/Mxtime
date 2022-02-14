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
            <img width="20px" height="25px" src="@/assets/edit.png" alt="" />
            <div class="satuscont">
              <input
                type="radio"
                v-if="projects.Statu === 'A'"
                checked
                class="A shown"
              />
              <input
                type="radio"
                v-if="projects.Statu === 'B'"
                checked
                class="B shown"
              />
              <input
                type="radio"
                v-if="projects.Statu === 'C'"
                checked
                class="C shown"
              />
            </div>
          </span>
          <span class="title">{{ projects.Title }}</span>
          <span
            v-bind:id="projects.id"
            @click="Remove(projects.id), (R = !R)"
            style="float: right; color: red"
            ><img width="16px" src="@/assets/Kryss2.png" alt=""
          /></span>
        </div>
        <div class="canit">
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
              v-if="
                Math.round(
                  (Math.abs(new Date() - new Date(projects.Date)) /
                    Math.abs(
                      new Date(projects.Deadline) - new Date(projects.Date)
                    )) *
                    100
                ) < 100
              "
              :diameter="150"
              :completed-steps="0"
              :total-steps="0"
              :innerStrokeColor="'none'"
              :startColor="'none'"
              :stopColor="'none'"
              :strokeLinecap="'flat'"
              :strokeWidth="1"
              :innerStrokeWidth="1"
            >
              <radial-progress-bar
                class="progresscont"
                :diameter="160"
                :total-steps="0"
                :completed-steps="0"
                :innerStrokeColor="'none'"
                :startColor="'none'"
                :stopColor="'none'"
                :strokeLinecap="'flat'"
                :strokeWidth="2"
              >
                <radial-progress-bar
                  :diameter="160"
                  :completed-steps="
                    Math.round((projects.Timeused / projects.Timebudget) * 100)
                  "
                  :total-steps="100"
                  :innerStrokeColor="'#DDDEDF'"
                  :startColor="'#1988c9'"
                  :stopColor="'#1988c9'"
                  :strokeLinecap="'flat'"
                  :strokeWidth="8"
                  :innerStrokeWidth="8"
                >
                  <radial-progress-bar
                    :diameter="140"
                    :completed-steps="
                      Math.round(
                        (Math.abs(new Date() - new Date(projects.Date)) /
                          Math.abs(
                            new Date(projects.Deadline) -
                              new Date(projects.Date)
                          )) *
                          100
                      )
                    "
                    :total-steps="100"
                    :innerStrokeColor="'#C7C8C9'"
                    :startColor="'#969897'"
                    :stopColor="'#969897'"
                    :strokeLinecap="'flat'"
                    :strokeWidth="8"
                    :innerStrokeWidth="8"
                  >
                    <radial-progress-bar
                      class="deadlinecont"
                      :diameter="139"
                      :total-steps="100"
                      :completed-steps="0"
                      :innerStrokeColor="'none'"
                      :startColor="'none'"
                      :stopColor="''"
                      :strokeLinecap="'flat'"
                      :strokeWidth="2"
                    >
                      <div class="koko">
                        <span class="precst"
                          >{{
                            Math.round(
                              (projects.Timeused / projects.Timebudget) * 100
                            )
                          }}%</span
                        >
                        <span class="optim"
                          >{{
                            Math.round(
                              (Math.abs(new Date() - new Date(projects.Date)) /
                                Math.abs(
                                  new Date(projects.Deadline) -
                                    new Date(projects.Date)
                                )) *
                                100
                            )
                          }}%</span
                        >
                        <button
                          class="now"
                          @click="
                            Edit(projects.id),
                              (arkiveraoverlay = !arkiveraoverlay)
                          "
                        >
                          Klart
                        </button>
                      </div>
                    </radial-progress-bar>
                  </radial-progress-bar>
                </radial-progress-bar>
              </radial-progress-bar>
            </radial-progress-bar>
            <radial-progress-bar
              v-if="
                Math.round(
                  (Math.abs(new Date() - new Date(projects.Date)) /
                    Math.abs(
                      new Date(projects.Deadline) - new Date(projects.Date)
                    )) *
                    100
                ) > 100
              "
              :diameter="150"
              :completed-steps="0"
              :total-steps="0"
              :innerStrokeColor="'none'"
              :startColor="'none'"
              :stopColor="'none'"
              :strokeLinecap="'flat'"
              :strokeWidth="1"
              :innerStrokeWidth="1"
            >
              <radial-progress-bar
                class="progresscont"
                :diameter="160"
                :total-steps="0"
                :completed-steps="0"
                :innerStrokeColor="'none'"
                :startColor="'none'"
                :stopColor="'none'"
                :strokeLinecap="'flat'"
                :strokeWidth="2"
              >
                <radial-progress-bar
                  :diameter="160"
                  :completed-steps="
                    Math.round((projects.Timeused / projects.Timebudget) * 100)
                  "
                  :total-steps="100"
                  :innerStrokeColor="'#DDDEDF'"
                  :startColor="'#1988c9'"
                  :stopColor="'#1988c9'"
                  :strokeLinecap="'flat'"
                  :strokeWidth="8"
                  :innerStrokeWidth="8"
                >
                  <radial-progress-bar
                    :diameter="140"
                    :completed-steps="100"
                    :total-steps="100"
                    :innerStrokeColor="'#C7C8C9'"
                    :startColor="'#969897'"
                    :stopColor="'#969897'"
                    :strokeLinecap="'flat'"
                    :strokeWidth="8"
                    :innerStrokeWidth="8"
                  >
                    <radial-progress-bar
                      class="deadlinecont"
                      :diameter="139"
                      :total-steps="100"
                      :completed-steps="0"
                      :innerStrokeColor="'none'"
                      :startColor="'none'"
                      :stopColor="''"
                      :strokeLinecap="'flat'"
                      :strokeWidth="2"
                    >
                      <div class="koko">
                        <span class="precst"
                          >{{
                            Math.round(
                              (projects.Timeused / projects.Timebudget) * 100
                            )
                          }}%</span
                        >
                        <span class="optim">{{ 100 }}%</span>
                        <button
                          class="now"
                          @click="
                            Edit(projects.id),
                              (arkiveraoverlay = !arkiveraoverlay)
                          "
                        >
                          Klart
                        </button>
                      </div>
                    </radial-progress-bar>
                  </radial-progress-bar>
                </radial-progress-bar>
              </radial-progress-bar>
            </radial-progress-bar>
          </div>
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
      </div>
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
              <div class="dcapsule">
                <img class="danger" src="@/assets/Danger.png" alt="" />
                <h2 class="dangertext">
                  Raderade projekt försvinner permanent!
                </h2>
                <h1 class="dsure">Säker att du vill radera detta projekt?</h1>
                <div class="dflex">
                  <div class="dinputcapsule">
                    <span class="dwrite"
                      >Skriv in projektetsnamn för att radera</span
                    >
                    <input
                      type="text"
                      v-model="sure"
                      name="sure"
                      class="sureinput"
                      maxlength="20"
                    />
                  </div>
                  <input
                    class="deletebtn"
                    type="submit"
                    value="Radera"
                    @click="sendDelete(), (R = !R)"
                    v-if="sure === rtitle"
                  />
                  <input
                    v-else
                    class="fakerdeletebtn"
                    type="submit"
                    value="Radera"
                    disabled
                    @click="R = !R"
                  />
                </div>
                <button class="dAvbryt" @click="R = !R">Avbryt</button>
              </div>

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
                ref="deletbyname"
              />
            </form>
          </div>
        </div>
      </transition>
      <transition name="slide-fade">
        <div v-if="!T" class="noclick">
          <div id="Editform">
            <iframe
              width="1px"
              height="1px"
              name="dummyframe"
              id="dummyframe"
              style="display: none"
            ></iframe>
            <h2 class="edittitle">Redigera projekt</h2>
            <form id="inputsStyle" action="" method="POST" target="dummyframe">
              <input
                type="hidden"
                name="title"
                id="title"
                :value="this.etitle"
              />

              <input type="hidden" name="date" id="date" :value="this.edate" />
              <input
                type="hidden"
                name="author"
                id="author"
                :value="this.eauthor"
              />
              <span class="e">
                <span>Status</span>
                <span>
                  <input
                    type="radio"
                    name="status"
                    value="A"
                    checked
                    id="status"
                    class="A"
                    v-model="estatus"
                    ref="status"
                  />
                  <input
                    type="radio"
                    name="status"
                    value="B"
                    id="status"
                    class="B"
                    ref="status"
                    v-model="estatus"
                  />
                  <input
                    type="radio"
                    name="status"
                    value="C"
                    id="status"
                    class="C"
                    ref="status"
                    v-model="estatus"
                  />
                </span>
              </span>
              <span class="e">
                <span>Deadline </span
                ><input
                  type="date"
                  name="deadline"
                  v-model="deadline"
                  id="deadline"
                  onkeydown="return false"
                />
              </span>

              <input type="hidden" name="id" id="id" :value="this.z" />
              <span class="e">
                <input
                  type="hidden"
                  name="precentage"
                  id="precentage"
                  value="0"
                  v-model="precentage"
                />
              </span>

              <input
                class="skapaknapp"
                type="submit"
                @click="sendEdit(), (T = !T)"
              />
              <button class="avbryt" type="button" @click="T = !T">
                Avbryt
              </button>
            </form>
          </div>
        </div>
      </transition>
      <transition name="slide-fade">
        <div v-if="arkiveraoverlay" class="noclick">
          <div id="ArkivForm">
            <iframe
              width="1px"
              height="1px"
              name="dummyframe"
              id="dummyframe"
              style="display: none"
            ></iframe>
            <form method="POST" action="" target="dummyframe">
              <h1 class="arkivtitle">Arkivera</h1>
              <h2 class="arkivtitle">{{ this.etitle }}</h2>
              <input type="hidden" name="id" id="id" :value="this.z" />
              <input
                type="hidden"
                name="title"
                id="title"
                :value="this.etitle"
              />
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
              <div class="e">
                <span>Budget</span>
                <input
                  type="number"
                  id="budget"
                  value="0"
                  name="budget"
                  v-model="budget"
                />
              </div>
              <div class="e">
                <span>Belopp</span>
                <input
                  type="Number"
                  id="belopp"
                  value="0"
                  name="belopp"
                  v-model="belopp"
                />
              </div>

              <div class="e">
                <button
                  type="Submit"
                  value="Arkivera"
                  class="completebtn"
                  @click="sendArkiv(), (arkiveraoverlay = !arkiveraoverlay)"
                >
                  complete
                  <span></span>
                  <span></span>
                  <span></span>
                  <span></span>
                </button>

                <button
                  class="arkivavbryt"
                  type="button"
                  @click="arkiveraoverlay = !arkiveraoverlay"
                >
                  Avbryt
                </button>
              </div>
            </form>
          </div>
        </div>
      </transition>
    </div>
    <Postit />
  </div>
</template>
<style scoped>
.canit {
  display: grid;
  grid-template-columns: 75px 105px;
  padding-bottom: 20px;
}
.satuscont {
}
.shown {
  cursor: default;
}
.A {
  cursor: pointer;

  -webkit-appearance: none;
}
.B {
  -webkit-appearance: none;
}
.C {
  -webkit-appearance: none;
}
input[type="radio"]:after {
  background-color: #444;
  border-radius: 25px;
  box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, 0.4),
    0 1px 1px hsla(0, 0%, 100%, 0.8);
  content: "";
  display: block;
  height: 20px;

  position: relative;

  width: 20px;
}
.A:checked:after {
  background-color: rgb(148, 255, 175);
  box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, 0.4),
    inset 0 2px 2px hsla(0, 0%, 100%, 0.4), 0 1px 1px hsla(0, 0%, 100%, 0.8),
    0 0 2px 2px hsla(128, 100%, 51%, 0.4);
}
.B:checked:after {
  background-color: rgb(217, 255, 4);
  box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, 0.4),
    inset 0 2px 2px hsla(0, 0%, 100%, 0.4), 0 1px 1px hsla(0, 0%, 100%, 0.8),
    0 0 2px 2px hsla(64, 100%, 51%, 0.4);
}
.C:checked:after {
  background-color: rgb(255, 0, 0);
  box-shadow: inset 0 0 0 1px hsla(0, 0%, 0%, 0.4),
    inset 0 2px 2px hsla(0, 0%, 100%, 0.4), 0 1px 1px hsla(0, 0%, 100%, 0.8),
    0 0 2px 2px hsla(0, 100%, 51%, 0.4);
}

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
  border-radius: 5px;
  width: 100px;
  height: 40px;
  font-size: 15px;
  font-weight: 600;
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
.now {
  background: #1988c9;
  border: none;

  padding: 5px;
  border-radius: 50px;
  color: rgb(255, 255, 255);

  transition: 1s;

  font-weight: bold;

  font-size: 12px;
}

.progresscont {
  border-radius: 100%;
}
.deadlinecont {
  border-radius: 100%;
}
.tabletop {
  padding: 10px;
  align-items: center;
  display: flex;
  justify-content: space-between;
  border-radius: 15px 15px 0px 0px;

  background: linear-gradient(90deg, #1988c9 0%, #1988c9 100%);
}
.optim {
  color: #969897;
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
  background: black;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;

  font-size: 16px;
  line-height: 16px;
  padding-bottom: 5px;
}
.utförtS {
  display: flex;

  color: black;
  grid-gap: 5px;
}
.deadlineS {
  display: flex;

  color: black;
  grid-gap: 5px;
}
.reddot {
  width: 10px;
  height: 10px;
  border-radius: 25px;
  background-color: #969897;
}
.greendot {
  width: 10px;
  height: 10px;
  border-radius: 25px;
  background-color: #1988c9;
}
.precst {
  font-size: 25px;
  font-weight: bolder;
  color: #1988c9;
}
.radialprogress {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 30px;
}
.inspcript {
  display: flex;
  flex-direction: column;
  position: absolute;
}
.title {
  font-size: 18px;
  font-weight: bold;
  color: rgb(255, 255, 255);
  overflow: hidden;
  height: 100%;
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
#Home {
  margin: 0;
  max-width: 100%;
  width: 100%;
  overflow-y: scroll;
  overflow-x: hidden;
  background: white;
  background-repeat: no-repeat;
  background-size: cover;
}
.Grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  width: 80vw;
  margin: 30px;
  grid-gap: 20px;
}
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&family=Ubuntu:ital@0;1&display=swap");
.Card {
  background: #ffffff;
  border-radius: 15px;

  width: 250px;
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  font-size: 18px;

  padding-bottom: 10px;
  color: #b1abab;
  box-shadow: 0px 5px 10px 1px rgba(85, 85, 85, 0.397);
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
.esd {
  margin-top: -20px;
  margin-bottom: 20px;
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: center;

  font-size: 20px;
  line-height: 25px;

  color: #d5d5d5;
}
.es {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;

  font-size: 20px;
  line-height: 25px;

  color: #d5d5d5;
}
.e {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  display: flex;
  flex-direction: column;

  align-items: center;

  font-size: 20px;
  line-height: 25px;

  color: #d5d5d5;
}
#Editform {
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
  width: 300px;
  padding: 20px;

  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
@media only screen and (max-width: 1000px) {
  #ArkivForm {
    left: 10%;
  }
  #Editform {
    left: 10%;
  }
  #Deleteform {
    left: 0%;
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
  width: 30px;
  border-radius: 25px;
  box-shadow: 0px 2px 5px 1px rgba(100, 100, 100, 0.5);
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
.arkivtitle {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;
  margin: 0;
  color: #4cdb63;
}
.edit {
  display: flex;
}
.edittitle {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;

  color: #4cdb63;
}
#inputsStyle {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  height: 100%;
  grid-gap: 4%;
  text-align: center;
  justify-content: space-between;
  align-items: center;
  grid-gap: 20px;
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
  width: 50%;
  background: linear-gradient(180deg, #6df983 0%, #40cf57 46.88%, #82ed93 100%);
}
.arkivavbryt {
  font-style: normal;
  font-weight: normal;
  background: linear-gradient(180deg, #f96d6d 0%, #cf4040 46.88%, #ed8282 100%);
  width: 104px;
  height: 24px;
  box-shadow: 0px 4px 4px rgba(186, 186, 186, 0.25);
  border-radius: 24px;
  font-size: 15px;
  line-height: 17px;
  border: none;
  font-weight: 600;
  color: #01537c;
  margin-top: 20px;
}
.avbryt {
  font-style: normal;
  font-weight: normal;
  background: linear-gradient(180deg, #f96d6d 0%, #cf4040 46.88%, #ed8282 100%);
  width: 104px;
  height: 24px;
  box-shadow: 0px 4px 4px rgba(186, 186, 186, 0.25);
  border-radius: 24px;
  font-size: 15px;
  line-height: 17px;
  border: none;
  font-weight: 600;
  color: #01537c;
}
.skapaknapp {
  border: none;
  background: linear-gradient(180deg, #6df983 0%, #3db951 46.88%, #82ed93 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 260px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
  color: #01537c;
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
.completebtn {
  border-radius: 12px;
  border: 3px outset #888;
  position: relative;
  display: inline-block;
  padding: 15px 30px;
  color: #eee;
  text-transform: uppercase;
  letter-spacing: 4px;
  overflow: hidden;

  box-shadow: 0 0 10px rgb(0, 0, 0, 1);

  font-size: 28px;
  font-weight: bolder;
  text-decoration: none;
  background: linear-gradient(160deg, #666, #444);
  text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);

  transition: 0.2s;
}
.completebtn:active {
  border: 3px outset #ddd;
  color: #fff;
  background: linear-gradient(160deg, #666, #444);
  text-shadow: 0px 0px 4px #ccc;
  box-shadow: 0 0 10px #fff, 0 0 40px #fff, 0 0 80px #fff;
  transition-delay: 1s;
}

.completebtn span {
  position: absolute;
  display: block;
}

.completebtn span:nth-child(1) {
  top: 0;
  left: -100%;
  width: 100%;
  height: 2px;
  background: linear-gradient(90deg, transparent, #eee);
}
.completebtn:active span:nth-child(1) {
  left: 100%;
  transition: 1s;
}
.completebtn span:nth-child(2) {
  top: -100%;
  right: 0;
  width: 2px;
  height: 100%;
  background: linear-gradient(180deg, transparent, #eee);
}
.completebtn:active span:nth-child(2) {
  top: 100%;
  transition: 1s;
  transition-delay: 0.25s;
}
.completebtn span:nth-child(3) {
  bottom: 0;
  right: -100%;
  width: 100%;
  height: 2px;
  background: linear-gradient(270deg, transparent, #eee);
}
.completebtn:active span:nth-child(3) {
  right: 100%;
  transition: 1s;
  transition-delay: 0.5s;
}

.completebtn span:nth-child(4) {
  bottom: -100%;
  left: 0;
  width: 2px;
  height: 100%;
  background: linear-gradient(360deg, transparent, #eee);
}
.completebtn:active span:nth-child(4) {
  bottom: 100%;
  transition: 1s;
  transition-delay: 0.75s;
}
</style>
<script>
import $ from "jquery";
import RadialProgressBar from "vue-radial-progress";
import Postit from "../components/Postit.vue";
import Workernav from "@/components/Workernav.vue";
import io from "socket.io-client";
import { invalid } from "moment";
import swal from "sweetalert";
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
      deadline: this.edeadline,
      eworkers: "",
      ecompleted: "",
      eprecentage: 0,
      precentage: 0,
      projects: "",
      logged: this.$store.state.someValue,
      estatus: "",
      project: "",
      project: [],
      obj: {},
      start: 0,
      end: 0,
      today: "",
      sure: "",
      array: [],
      timearray: [],
      i: 0,
      q: 0,
      d: 0,
      optimal: 0,
      deletebyname: "",
      budget: "",
      belopp: "",
      fakturerat: "",
      eproject: [],
    };
  },

  created() {
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
        if (result.length === 0) {
          location.replace("https://flexnet.se/#/");
        }
        if (result.length > 0) {
          fetch("188.166.114.141:3000/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.user = result;
            });

          const requestOptionsget = {
            method: "GET",
            mode: "cors",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
            },
          };
          /* fetch("http://192.168.1.191:3000/viewprojects", requestOptionsget)
            .then((response) => response.json())
            .then((result) => {
              this.project = result;
         
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

            }); */
          this.socketInstance = io("188.166.114.141:3000");

          this.socketInstance.on("data:received", (projectdata) => {
            this.project = projectdata;
            this.timearray = [];
            this.array = [];
            for (this.i = 0; this.i < this.project.length; this.i++) {
              this.tu = this.project[this.i].Timeused;
              this.tb = this.project[this.i].Timebudget;
              this.timep = Math.round((this.tu / this.tb) * 100);

              this.start = new Date(this.project[this.i].Date);
              this.end = new Date(this.project[this.i].Deadline);
              this.today = new Date();
              this.q = Math.abs(this.today - this.start);
              this.d = Math.abs(this.end - this.start);

              this.optimal = Math.round((this.q / this.d) * 100);

              if (this.project[this.i].Deadline.length < 1) {
                this.optimal = 0;
              }
              if (this.optimal > 100 || this.end < this.today) {
                this.optimal = 100;
              }
              this.timearray.push(this.timep);
              this.array.push(this.optimal);
            }
          });
        }
      });
  },
  methods: {
    toVictory() {
      sendArkiv();
    },
    sendArkiv() {
      const arkivdata = {
        id: this.z,
        title: this.etitle,
        author: this.eauthor,
        workers: this.eworker,
        budget: this.budget,
        belopp: this.belopp,
        fakturerat: this.fakturerat,
      };
      this.socketInstance.emit("arkiv", arkivdata);
      swal({
        title: "Grattis!",
        text: "Du har Arkiverat projektet!",
        icon: "success",
      });
    },

    sendEdit() {
      const editdata = {
        id: this.z,
        title: this.etitle,
        deadline: this.deadline,
        completed: this.ecompleted,
        precentage: 0,
        status: this.estatus,
      };

      this.socketInstance.emit("edit", editdata);
      swal({
        title: "Projekt Redigerad!",
        text: "Du har redigerat projektet!",
        icon: "success",
      });
    },

    sendDelete() {
      const deletedata = {
        id: this.x,

        author: this.rauthor,
        workers: this.rworker,
      };

      this.socketInstance.emit("delete", deletedata);
      swal({
        title: "Projekt Raderat!",
        text: "Du har raderat projektet!",
        icon: "success",
      });
    },
    Edit(id) {
      this.z = id;
      this.x = id - 1;
      this.eproject = this.project.find((result) => result.id == this.z);

      this.estatus = this.eproject.Statu;
      this.etitle = this.eproject.Title;
      this.edeadline = this.eproject.Deadline;
      this.ecompleted = this.eproject.Completed;
      this.eauthor = this.eproject.Author;
      this.eprecentage = this.eproject.precentage;
      this.edate = this.eproject.Date;
      this.eworker = this.eproject.Workers;
    },
    Remove(id) {
      this.z = id - 1;
      this.x = id;
      this.rproject = this.project.find((result) => result.id == this.x);
      this.rtitle = this.rproject.Title;
      this.rauthor = this.rproject.Author;
      this.rworker = this.rproject.Workers;
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
  },
  computed: {
    someValue: {
      get() {
        return this.$store.state.someValue;
      },
    },
  },
};
</script>
