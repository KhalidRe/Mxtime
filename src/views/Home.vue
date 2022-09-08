<template>
  <div id="Home">
    <Workernav />
    <Timer id="Timepos" />
    <div class="filterbtncont">
      <div
        class="filterbtn"
        @click="(filterwhereiam = !filterwhereiam), testfilter()"
        :class="{ filterbtnactive: filterwhereiam }"
      >
        <div class="filterball" :class="{ filterballactive: filterwhereiam }">
          <div
            class="lightball"
            :class="{ lightballactive: filterwhereiam }"
          ></div>
        </div>
      </div>
    </div>
    <div class="Grid">
      <div
        class="Card"
        v-for="(projects, index) in project"
        :key="projects.index"
      >
        <div class="tabletop">
          <span
            style="color: blue; float: left"
            v-bind:id="projects.id"
            class="edit"
            @click="Edit(projects.id), (T = !T), modProject(index, projects.id)"
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
            style="float: right; color: red; cursor: pointer"
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
                            Edit(projects.id, index),
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
                ) >= 100
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
                            Edit(projects.id, index),
                              modProject(
                                index,
                                projects.id
                              )((arkiveraoverlay = !arkiveraoverlay))
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
            <div
              class="opentrello"
              @click="viewtrello(projects.id), (trelloopen = !trelloopen)"
            >
              Tasks
            </div>
            <span class="nrtrello">{{
              trellodata.filter((result) => result.fatherid == projects.id)
                .length
            }}</span>
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
            :title="projects.Author"
            class="deltagare"
            :src="`https://mxtime.se/mxprofile/${projects.Authorprofile}.jpg`"
            alt=""
          />
          <img
            :title="sparrs.Name"
            v-for="sparrs in sparr[index]"
            :key="sparrs.index"
            class="deltagare va"
            :src="`https://mxtime.se/mxprofile/${sparrs.Profile}.jpg`"
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
                  id="deadline"
                  onkeydown="return false"
                  ref="fdeadline"
                  :value="edeadline"
                />
              </span>

              <div
                @click="addworkoverlay = !addworkoverlay"
                class="addtasksetworker"
              >
                <img class="datepickerimg" src="@/assets/addusers.png" alt="" />
                <div>Bjud in</div>
              </div>
              <transition name="open-fade">
                <div class="workerlistmod" v-show="addworkoverlay">
                  <div class="excluded">
                    <h3>Inbjuden</h3>
                    <div
                      id="Fruits"
                      v-for="deltag in workerson"
                      :key="deltag.index"
                      class="excludedro workchecks"
                      v-if="
                        usersid.includes(deltag.id) && deltag.id !== eauthorid
                      "
                    >
                      <div @click="removeUser(deltag)" class="itemcont">
                        <div class="imgandtxt">
                          <img
                            class="deltagares va"
                            :src="`https://mxtime.se/mxprofile/${deltag.Profile}.jpg`"
                            alt=""
                          />
                          <div>
                            {{ deltag.Name }}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="included">
                    <h3>Bjud in</h3>
                    <div
                      id="Fruits"
                      v-for="deltag in workerson"
                      :key="deltag.index"
                      class="workchecks includedro"
                      v-if="
                        !usersid.includes(deltag.id) && deltag.id !== eauthorid
                      "
                      @click="addUser(deltag)"
                    >
                      <div class="itemcont">
                        <div class="imgandtxt">
                          <img
                            class="deltagares va"
                            :src="`https://mxtime.se/mxprofile/${deltag.Profile}.jpg`"
                            alt=""
                          />
                          <div>
                            {{ deltag.Name }}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </transition>
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
              <div class="arkivtitle">
                <h1 style="margin: 0px">Arkivera</h1>
                <h2>{{ this.etitle }}</h2>
              </div>

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
      <transition name="slide-fade-left">
        <div class="Minitrello" v-if="trelloopen">
          <div class="closetrello" @click="trelloopen = !trelloopen">close</div>
          <div class="trellocapsule">
            <div class="trellocard" v-for="trello in atrello" :key="trello.id">
              <transition name="notsoepic-form">
                <div v-if="trello.completed === 0">
                  <div class="trellohead">
                    <div>{{ trello.title }}</div>
                  </div>
                  <div class="trellooptions">
                    <div class="trellodelete" @click="trellodelete(trello.id)">
                      X
                    </div>
                    <div class="trellodone" @click="trellodone(trello.id)">
                      <img
                        width="25px"
                        src="@/assets/Trellocomplete.png"
                        alt=""
                      />
                    </div>
                  </div>

                  <div class="trellodesc">
                    <pre class="prerenderstuff">{{ trello.description }}</pre>
                  </div>
                </div>
              </transition>
              <transition name="epic-form">
                <div class="trellochecked" v-if="trello.completed === 1">
                  <div class="trellohead">
                    <div>{{ trello.title }}</div>
                  </div>
                  <div class="trellooptions">
                    <div class="trellodelete" @click="trellodelete(trello.id)">
                      X
                    </div>
                    <div class="trellodone" @click="trellodone(trello.id)">
                      <img
                        width="25px"
                        src="@/assets/Trellocomplete.png"
                        alt=""
                      />
                    </div>
                  </div>

                  <div class="trellodesc">
                    <pre class="prerenderstuff">{{ trello.description }}</pre>
                  </div>
                </div>
              </transition>
            </div>
          </div>
          <div class="addtrello">
            <button @click="addT = !addT" class="addtrello-btn">
              Lägg till uppgifter
            </button>
          </div>
        </div>
      </transition>
    </div>
    <transition name="slide-fade">
      <div class="addtrelloform" v-if="!addT">
        <div class="addtrellocard">
          <h1>Skapa Uppdrag</h1>
          <h3 style="margin: 0">title</h3>

          <input type="text" name="title" v-model="Ttitle" />
          <h3 style="margin-bottom: 0">Beskrivning</h3>
          <textarea
            style="resize: none"
            class="trellotext"
            name="description"
            id=""
            cols="30"
            rows="10"
            v-model="Tdescription"
          ></textarea
          ><br />
          <button
            v-if="this.Ttitle.length > 0 && this.Tdescription.length > 0"
            @click="addtrello(projects.id), (addT = !addT)"
            class="creatitnow"
          >
            Skapa
          </button>
          <button
            v-if="this.Ttitle.length < 1 || this.Tdescription.length < 1"
            class="creatitnowfaker"
          >
            Skapa
          </button>
          <br />
          <button @click="addT = !addT" class="stopitnow">Avbryt</button>
        </div>
      </div>
    </transition>
    <Postit />
  </div>
</template>
<style scoped>
.included {
  background: rgb(252, 219, 219);
}
.excluded {
  background: rgb(215, 252, 214);
}
.excludedro:hover {
  background: rgb(206, 247, 205);
}
.includedro:hover {
  background: rgb(180, 135, 135);
}
.workerlistmod {
  width: 100%;
  display: grid;
  grid-template-columns: 50% 50%;

  overflow-y: scroll;
  background: rgb(255, 255, 255);
  height: 150px;
  border-top: #049c4b solid 1px;
}
.filterbtncont {
  display: flex;
  width: 100%;
  height: 50px;
  justify-content: flex-end;
  align-items: center;
  margin-top: -50px;
  margin-bottom: 10px;
}
.filterbtn {
  width: 70px;
  height: 25px;
  border-radius: 50px;
  background: rgb(97, 103, 110);

  margin-right: 10%;
  margin-top: 7px;
  box-shadow: inset 0px 0px 5px 1px rgba(42, 82, 72, 0.596);
  display: flex;

  transition: 0.5s;
}
.filterbtnactive {
  width: 70px;
  height: 25px;
  border-radius: 50px;
  background: rgb(113, 198, 255);

  margin-right: 10%;
  margin-top: 7px;
  box-shadow: inset 0px 0px 5px 1px rgba(42, 82, 72, 0.596);
  display: flex;

  transition: 0.5s;
}
.filterball {
  width: 30px;
  height: 30px;
  background: rgb(72, 138, 236);
  border-radius: 30px;
  box-shadow: #000000 0px 0px 5px 1px;
  margin-top: -2px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 0px;
  transition: 0.5s;
}
.filterballactive {
  width: 30px;
  height: 30px;
  background: rgb(72, 138, 236);
  border-radius: 30px;
  box-shadow: #000000 0px 0px 5px 1px;
  margin-top: -2px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 40px;
  transition: 0.5s;
}
.lightball {
  width: 20px;
  height: 20px;

  border-radius: 15px;
  background: rgb(72, 138, 236);
  box-shadow: inset rgb(54, 99, 168) 0px 0px 5px 5px;
}
.lightballactive {
  width: 20px;
  height: 20px;

  border-radius: 15px;
  background: rgb(73, 245, 101);
  box-shadow: inset rgba(54, 168, 88, 0.349) 0px 0px 5px 5px;
}
.trellochecked {
  box-shadow: inset 0px 0px 10px 5px rgb(73, 230, 73);
  background-color: rgb(133, 250, 133);
  border-radius: 10px;
}
.prerenderstuff {
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-size: 16px;
  font-weight: 600;
  text-align: left;
  white-space: pre-wrap;
}
.trellodelete {
  display: flex;

  box-shadow: inset 0px 0px 5px 1px rgba(255, 0, 0, 0.425);
  width: 100%;
  height: 100%;
  justify-content: center;
  align-items: center;
}
.trellodone {
  display: flex;
  box-shadow: inset 0px 0px 5px 1px rgba(0, 255, 85, 0.425);
  width: 100%;
  height: 100%;
  justify-content: center;
  align-items: center;
}
.trellodone:hover {
  transition: 1s;
  box-shadow: inset 0px 0px 20px 5px rgba(0, 255, 85, 0.425);
}
.trellodelete:hover {
  transition: 1s;
  box-shadow: inset 0px 0px 20px 5px rgba(255, 0, 0, 0.425);
}
.trellooptions {
  display: flex;
  justify-content: space-around;
  height: 30px;
  background: #e4e4e4;
  align-items: center;
}
.creatitnowfaker {
  border: none;
  width: 100px;

  padding: 10px;
  background: #5e5e5e;
  color: white;
  font-size: 18px;
  border-radius: 20px;
}
.stopitnow {
  border: none;
  width: 70px;

  padding: 7px;
  background: #d00000;
  color: white;
  font-size: 14px;
  border-radius: 20px;
  margin-top: 5px;
}
.creatitnow {
  border: none;
  width: 100px;

  padding: 10px;
  background: #0089d0;
  color: white;
  font-size: 18px;
  border-radius: 20px;
}
.trellotext {
  height: 65%;
}
.addtrellocard {
  position: absolute;
  right: 2%;
  top: 10%;
  background: white;
  width: 300px;
  height: 80%;
  z-index: 99999;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.377);
  border-radius: 20px;
}
.addtrelloform {
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0%;
  left: 0%;
  z-index: 99998;
}
.trellodesc {
  max-width: 90%;

  padding-left: 15px;
  padding-top: 15px;
  padding-bottom: 15px;
  /* or inline-block */
  text-overflow: ellipsis;
  word-wrap: break-word;
  overflow: hidden;
}
.addtrello-btn {
  border: none;
  background-color: #0089d0;
  padding: 20px;
  border-radius: 20px;
  color: white;
  font-size: 15px;
  font-weight: 600;
  border: 1px solid #057bb6;
  box-shadow: 0px 0px 10px 5px #0471a8;
  cursor: pointer;
}
.addtrello-btn:active {
  border: none;
  background-color: #052b3d;
  padding: 20px;
  border-radius: 20px;
  color: white;
  font-size: 15px;
  font-weight: 600;
}
.addtrello {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 10%;
  background: #0089d0;
  border: solid 1px rgb(139, 139, 139);
}
.trellohead {
  background-color: #0089d0;
  border-radius: 10px 10px 0px 0px;
  font-size: 25px;
  font-weight: 800px;
  color: white;
}
.trellocard {
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.329);

  margin-top: 25px;
  border-radius: 10px;
  width: 80%;
}
.trellocapsule {
  display: flex;

  align-items: center;
  flex-direction: column;
  overflow-y: scroll;
  overflow-x: hidden;
  height: 85%;
  background: white;
}
.closetrello {
  padding: 20px;
  transition: 1s;
  background: white;
  border: 1px solid rgb(223, 223, 223);
}
.closetrello:hover {
  transition: 1s;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.253);
  background: #dfdfdf;
}
.Minitrello {
  display: flex;
  flex-direction: column;
  overflow: hidden;
  background-color: rgb(214, 214, 214);
  position: absolute;
  width: 300px;
  right: 0%;
  top: 0%;
  height: 100%;
  z-index: 10000;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.363);
}
.opentrello {
  margin-top: -180px;
  margin-right: -65px;
}
.nrtrello {
  color: white;
  background-color: rgb(83, 175, 187);
  border-radius: 100%;
  padding: 5px;
  height: 8px;
  margin-top: -180px;
  margin-right: 4px;
  font-size: 10px;
  display: flex;
  justify-content: center;
  text-align: center;
  align-items: center;
}
.opentrello:hover {
  text-decoration: underline 2px;
  cursor: pointer;
  background: linear-gradient(90deg, #dd707000 0%, #78b0e446 100%);

  border-radius: 5px;
}
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

  justify-content: center;
}
.imgandtxt {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  align-content: center;
  font-size: 15px;
}
.imgandtxt > div {
  margin-left: -10px;
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
  justify-content: center;
  align-items: center;
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
  margin-top: 20px;
}
.deletebtn {
  background: linear-gradient(180deg, #dd7070 0%, #c24a4a 50.06%, #e47878 100%);
  border: none;
  border-radius: 5px;
  width: 100px;
  height: 40px;
  font-size: 15px;
  font-weight: 600;
  margin-top: 20px;
  cursor: pointer;
}
.dAvbryt {
  background: linear-gradient(180deg, #4dacc1 0%, #5578ad 50.52%, #4dacc1 100%);
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  padding-left: 20px;
  padding-right: 20px;
  height: 20px;
  cursor: pointer;
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
  cursor: pointer;
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
  padding-bottom: 15px;
  z-index: 1;
  top: 25%;
  left: 40%;
  width: 300px;
  background: white;

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
  width: 95%;

  margin: 30px;
  margin-top: 0px;
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
.slide-fade-left-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-left-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-left-enter, .slide-fade-left-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  width: 0px;
  opacity: 0;
}
.epic-form-enter-active {
  transition: all 0.6s ease;
  animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
  transform: translate3d(0, 0, 0);
}
.epic-form-leave-active {
}
.epic-form-enter, .epic-form-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  display: none;
}
.notsoepic-form-enter-active {
  transition: all 0.1s;
}
.notsoepic-form-leave-active {
}
.notsoepic-form-enter, .notsoepic-form-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  display: none;
}
@keyframes shake {
  10%,
  90% {
    transform: translate3d(-1px, 0, 0);
  }
  20%,
  80% {
    transform: translate3d(1px, 0, 0);
  }
  30%,
  50%,
  70% {
    transform: translate3d(-2px, 0, 0);
  }
  40%,
  60% {
    transform: translate3d(2px, 0, 0);
  }
}
epic-form .esd {
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

  color: black;
}
#Editform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: white;
  width: 300px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
  padding-bottom: 20px;
  transition: 1s;
}
@media only screen and (max-width: 1000px) {
  #ArkivForm {
    left: 10%;
  }
  #Editform {
    left: 10%;
    transition: 1s;
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
  height: 30px;
  border-radius: 25px;
  box-shadow: 0px 2px 5px 1px rgba(100, 100, 100, 0.5);
  transition: 1;
  object-fit: cover !important;
}
.deltagares {
  width: 40px;
  height: 40px;
  border-radius: 25px;
  box-shadow: 0px 2px 5px 1px rgba(100, 100, 100, 0.5);
  transition: 1;
  object-fit: cover !important;
  align-self: center;
}
.deltagare:hover {
  margin-top: -10px;
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
.icons {
  width: 50px;
  border-radius: 100%;
}
.deltagname {
  font-size: 13px;
}
.arkivtitle {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  line-height: 45px;
  margin: 0px;
  border-radius: 10px 10px 0px 0px;
  color: white;
  background: #1988c9;
}
.edit {
  display: flex;
}
.workerscaps {
  justify-content: center;
  overflow-y: scroll;
  background: rgb(255, 255, 255);
  width: 100%;
  height: 150px;
  display: grid;
  grid-gap: 20px;
  grid-template-columns: auto auto;
}
#tblFruits {
  height: 50px;
  width: 50px;
  margin-top: 10px;
  margin: 10px;
  box-shadow: 0px 5px 10px rgb(0, 0, 0);
  border-radius: 100%;
}
.edit:hover {
  cursor: pointer;
}
.edittitle {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;
  background: #1988c9;
  color: white;
  padding-bottom: 20px;
  padding-top: 20px;
  margin-top: 0px;
  border-radius: 10px 10px 0px 0px;
  width: 300px;
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
  color: black;
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
  background: #1988c9;
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
  cursor: pointer;
}
.container {
  display: block;
  position: relative;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  height: 32px;
  width: 45px;
  border-radius: 100%;
}
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;

  border-radius: 100%;
}
/* Create a custom checkbox */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  width: 50px;
  height: 50px;
  background-color: #e0eeff;

  border: solid white 2px;
  border-radius: 100%;
}
.container:hover input ~ .checkmark {
  background-color: #e0eeff;
}
.container input:checked ~ .checkmark {
  background-color: #44f321;
  border: 2px rgb(103, 218, 103) solid;
  border-radius: 100%;
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
  cursor: pointer;
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
  cursor: pointer;
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
  margin-top: 20px;
  box-shadow: 0 0 10px rgb(0, 0, 0, 1);
  cursor: pointer;
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
@media only screen and (max-width: 786px) {
  .filterbtncont {
    margin-top: 0px;
  }
}
@media only screen and (max-width: 786px) {
  #Timepos {
    position: fixed;
    bottom: 0%;

    display: flex;
    z-index: 2;
  }
}
* {
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
}
.open-fade-enter-active {
  transition: all 0.6s ease;
}
.open-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.open-fade-enter, .open-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  height: 0px;
  opacity: 0;
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
import Minitrello from "../components/Minitrello.vue";

import water from "../assets/soundeffect/water.mp3";
import cash from "../assets/soundeffect/cash.mp3";
import ding from "../assets/soundeffect/ding.mp3";
import pop from "../assets/soundeffect/pop.mp3";
import Timer from "@/components/Timer.vue";
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
export default {
  components: {
    Postit,
    Workernav,
    RadialProgressBar,
    Minitrello,
    Timer,
    DropdownMenu,
  },
  //
  data() {
    return {
      audioSources: ["assets/soundeffect/water.mp3"],
      arkiveraoverlay: false,
      completedSteps: 0,
      totalSteps: 10,
      T: true,
      R: true,
      x: "",
      etitle: "",
      trelloopen: false,
      eauthor: "",
      edate: "",
      edeadline: "",
      deadline: this.edeadline,
      eworkers: "",
      ecompleted: "",
      eprecentage: 0,
      precentage: 0,
      eauthorid: 0,
      projects: "",
      logged: this.$store.state.someValue,
      estatus: "",
      project: "",
      project: [],
      addT: true,
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
      trellodata: [],
      vtrello: [],
      trelloprojectid: 0,
      Ttitle: "",
      Tdescription: "",
      atrello: [],
      loggedstatus: "",
      watersound: "",
      popsound: "",
      dingsound: "",
      cashsound: "",
      workersassignd: [],
      forinpw: 0,
      sparr: [],
      index: 0,
      arkivworkers: [],
      mylogged: [],
      myfilter: [],
      loggedin: [],
      findex: 0,
      ok: "hej",
      testarr: [],
      filtredproject: [],
      filterby: "",
      mycreated: [],
      filterwhereiam: false,
      projectplaceholder: [],
      enanoid: "",
      deltagare: "",
      usersid: [],
      anit: 0,
      selectedusers: [],
      anits: 0,
      selectedtaskid: null,
      selectedtaskindex: null,
      addworkoverlay: false,
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

    fetch("https://mxtime.se:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        console.log("hej");
        if (result.length == 0) {
          location.replace("https://app.mxtime.se/#/");
        }

        fetch("https://mxtime.se:3000/workernav", auth)
          .then((response) => response.json())
          .then((result) => {
            this.loggedin = result[0];

            fetch("https://mxtime.se:3000/loggedin", auth)
              .then((response) => response.json())
              .then((result) => {
                this.loggedstatus = result[0].Status;
                if (result.length == 0) {
                  location.replace("https://app.mxtime.se/#/");
                }
                if (result.length > 0) {
                  const searchnano = {
                    method: "POST",

                    headers: {
                      "Content-Type": "application/json",
                      Accept: "application/json",
                    },

                    body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
                  };
                  fetch("https://mxtime.se:3000/getusers", searchnano)
                    .then((response) => response.json())
                    .then((result) => {
                      this.user = result;
                      this.deltagare = this.user.filter(
                        (e) => !e.Name.includes(this.loggedin.Name)
                      );
                      this.workerson = this.user;
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
                  this.socketInstance = io("https://mxtime.se:3000/", {
                    transports: ["websocket"],
                    pingInterval: 1000 * 60 * 10,
                    pingTimeout: 1000 * 60 * 5,
                  });
                  this.socketInstance.emit("loggedinfo", this.loggedin);
                  this.socketInstance.on("data:received", (projectdata) => {
                    if (this.loggedstatus == "Admin") {
                      this.project = projectdata;
                      this.projectplaceholder = projectdata;
                    } else {
                      this.project = projectdata.filter(
                        (result) => result.Authorstatus == this.loggedstatus
                      );
                      this.projectplaceholder = projectdata.filter(
                        (result) => result.Authorstatus == this.loggedstatus
                      );
                    }

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
                  this.socketInstance.on("trello:received", (trellodata) => {
                    this.trellodata = trellodata;
                    this.atrello = this.trellodata.filter(
                      (result) => result.fatherid == this.trelloprojectid
                    );
                  });
                  this.socketInstance.on(
                    "workerdeltag:received",
                    (workerdeltag) => {
                      this.workersassignd = workerdeltag;
                      this.workerson = this.user;
                      this.sparr = [];
                      for (
                        this.forinpw = 0;
                        this.project.length > this.forinpw;
                        this.forinpw++
                      ) {
                        this.sparr.push(
                          this.workersassignd.filter(
                            (result) =>
                              result.projectid == this.project[this.forinpw].id
                          )
                        );
                      }
                    }
                  );
                }
              });
          });
      });
  },
  watch: {
    see: function () {},
  },
  methods: {
    testfilter() {
      this.testarr = [];
      this.filtredproject = [];
      if (this.filterwhereiam == true) {
        this.mycreated = this.project.filter(
          (result) => result.Authorid == this.loggedin.id
        );

        for (this.findex = 0; this.sparr.length > this.findex; this.findex++) {
          this.testarr.push(
            this.sparr[this.findex].find(
              (results) => results.workerid == this.loggedin.id
            )
          );
        }

        this.testarr = this.testarr.filter((element) => {
          return element !== undefined;
        });
        for (this.findex = 0; this.testarr.length > this.findex; this.findex++)
          this.filtredproject.push(
            this.project.find(
              (result) => result.id == this.testarr[this.findex].projectid
            )
          );
        this.filtredproject = this.filtredproject.concat(this.mycreated);

        this.project = this.filtredproject;
        this.sparr = [];
        for (
          this.forinpw = 0;
          this.project.length > this.forinpw;
          this.forinpw++
        ) {
          this.sparr.push(
            this.workersassignd.filter(
              (result) => result.projectid == this.project[this.forinpw].id
            )
          );
        }
      }
      if (this.filterwhereiam == false) {
        this.project = this.projectplaceholder;
        this.sparr = [];
        for (
          this.forinpw = 0;
          this.project.length > this.forinpw;
          this.forinpw++
        ) {
          this.sparr.push(
            this.workersassignd.filter(
              (result) => result.projectid == this.project[this.forinpw].id
            )
          );
        }
      }
    },

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
        deltagare: this.arkivworkers,
        authornanoid: this.enanoid,
      };
      this.socketInstance.emit("arkiv", arkivdata);
      swal({
        title: "Grattis!",
        text: "Du har Arkiverat projektet!",
        icon: "success",
      });
      this.cashsound.play();
    },
    removeUser(x) {
      const removeworkerdata = {
        id: x.id,
        taskid: this.selectedtaskid,
      };
      this.socketInstance.emit("removeuserP", removeworkerdata);
      setTimeout(() => {
        this.modProject(this.selectedtaskindex, this.selectedtaskid);
      }, 100);
    },
    addUser(x) {
      console.log(x);
      const addworkerdata = {
        user: x,
        taskid: this.selectedtaskid,
      };
      this.socketInstance.emit("adduserP", addworkerdata);
      setTimeout(() => {
        this.modProject(this.selectedtaskindex, this.selectedtaskid);
      }, 100);
    },
    modProject(x, y) {
      console.log(x, y);
      this.selectedtaskid = y;
      this.selectedtaskindex = x;
      this.selectedusers = [];
      this.usersid = [];
      this.anit = 0;
      for (this.anit = 0; this.sparr[x].length > this.anit; this.anit++) {
        this.selectedusers.push(
          this.workerson.filter(
            (result) => result.id == this.sparr[x][this.anit].workerid
          )
        );
      }
      this.anits = 0;
      for (
        this.anits = 0;
        this.selectedusers.length > this.anits;
        this.anits++
      ) {
        this.usersid.push(this.selectedusers[this.anits][0].id);
      }
      console.log(this.usersid);
    },
    sendEdit() {
      var selected = new Array();

      var chks = document.getElementsByClassName("deltagcheckbox");
      for (var i = 0; i < chks.length; i++) {
        if (chks[i].checked) {
          selected.push(chks[i]._value);
        }
      }
      const editdata = {
        id: this.z,
        title: this.etitle,
        deadline: this.$refs.fdeadline.value,
        completed: this.ecompleted,
        precentage: 0,
        status: this.estatus,
        deltag: selected,
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
      this.popsound.play();
    },
    Edit(id, index) {
      this.z = id;
      this.x = id - 1;
      this.eproject = this.project.find((result) => result.id == this.z);

      this.estatus = this.eproject.Statu;
      this.etitle = this.eproject.Title;
      this.edeadline = this.eproject.Deadline;
      this.ecompleted = this.eproject.Completed;
      this.eauthor = this.eproject.Author;
      this.eauthorid = this.eproject.Authorid;
      this.eprecentage = this.eproject.precentage;
      this.edate = this.eproject.Date;
      this.eworker = this.eproject.Workers;
      this.enanoid = this.eproject.nanoid;
      console.log(this.eauthorid);

      if (index) {
        if (this.sparr[index].length > 0) {
          this.arkivworkers = this.sparr[index].filter(
            (result) => result.projectid == this.z
          );
        } else {
          this.arkivworkers = [];
        }
      }
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
    viewtrello(id) {
      this.trelloprojectid = id;

      this.vtrello = [];
      if (
        this.trellodata.filter(
          (result) => result.fatherid == this.trelloprojectid
        ).length > 0
      ) {
        this.atrello = this.trellodata.filter(
          (result) => result.fatherid == id
        );
      } else this.atrello = [];
    },
    refreshtrello() {},
    addtrello(id) {
      const trello = {
        fatherid: this.trelloprojectid,
        project: "Null",
        title: this.Ttitle,
        description: this.Tdescription,
      };
      this.socketInstance.emit("trello:created", trello);
      this.dingsound.play();
    },
    trellodone(id) {
      const trellostatus = {
        id: id,
      };
      this.socketInstance.emit("trello:status", trellostatus);
      this.watersound.play();
    },
    trellodelete(id) {
      const deletetrello = {
        id: id,
      };
      this.socketInstance.emit("trello:delete", deletetrello);
      this.popsound.play();
    },
  },
  mounted() {
    this.watersound = new Audio(water);
    this.dingsound = new Audio(ding);
    this.cashsound = new Audio(cash);
    this.popsound = new Audio(pop);
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
