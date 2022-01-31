<template>
  <div id="Home">
    <Victory />
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
                <span>Deadline: </span
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
                  type="range"
                  name="precentage"
                  id="precentage"
                  v-model="precentage"
                />
                <span>{{ this.precentage }}</span>
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
              <div>
                <p class="e">Fakturerat</p>
                <div class="esd">
                  <div class="es">
                    <input
                      type="radio"
                      name="completed"
                      id="completed"
                      value="Nej"
                      checked
                      v-model="fakturerat"
                    />
                    <label for="completed">Nej</label>
                  </div>

                  <div class="es">
                    <input
                      type="radio"
                      name="completed"
                      id="completed"
                      value="Ja"
                      v-model="fakturerat"
                    />
                    <label for="completed">Ja</label>
                  </div>
                </div>
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
  background: -webkit-linear-gradient(120deg, #053250, #000000);
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
.arkivtitle {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;
  margin: 0;
  color: #4cdb63;
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
  font-family: verdana;
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
export default {
  components: { Victory, Postit, Workernav, RadialProgressBar },
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
      deadline: "",
      eworkers: "",
      ecompleted: "",
      eprecentage: 0,
      precentage: 0,
      projects: "",
      logged: this.$store.state.someValue,
      project: "",
      project: [],
      obj: {},
      start: 0,
      end: 0,
      today: "",
      sure: "",
      array: [],
      i: 0,
      q: 0,
      d: 0,
      optimal: 0,
      deletebyname: "",
      budget: "",
      belopp: "",
      fakturerat: "",
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
    fetch("https://mxserver-simdf.ondigitalocean.app/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        console.log(result);
        if (result.length === 0) {
          location.replace("https://flexnet.se/#/");
        }
        if (result.length > 0) {
          fetch("https://mxserver-simdf.ondigitalocean.app/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.user = result;
              console.log(user);
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
              console.log(this.project);
            }); */
          this.socketInstance = io("https://mxserver-simdf.ondigitalocean.app");

          this.socketInstance.on("data:received", (projectdata) => {
            this.project = projectdata;
            this.array = [];
            for (this.i = 0; this.i < this.project.length; this.i++) {
              this.start = new Date(this.project[this.i].Date);
              this.end = new Date(this.project[this.i].Deadline);
              this.today = new Date();
              this.q = Math.abs(this.today - this.start);
              this.d = Math.abs(this.end - this.start);
              this.optimal = Math.round((this.q / this.d) * 100);
              console.log(this.project);
              if (this.project[this.i].Deadline.length < 1) {
                this.optimal = 0;
              }
              if (this.optimal > 100 || this.end < this.today) {
                this.optimal = 100;
              }

              this.array.push(this.optimal);
              console.log(this.array);
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
    },

    sendEdit() {
      const editdata = {
        id: this.z,
        title: this.etitle,
        deadline: this.deadline,
        completed: this.ecompleted,
        precentage: this.precentage,
      };

      this.socketInstance.emit("edit", editdata);
    },
    sendDelete() {
      const deletedata = {
        id: this.x,

        author: this.rauthor,
        workers: this.rworker,
      };

      this.socketInstance.emit("delete", deletedata);
    },
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
      this.rtitle = this.project[this.z].Title;
      this.rauthor = this.project[this.z].Author;
      this.rworker = this.project[this.z].Workers;
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
