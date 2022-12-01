<template>
  <div id="Time">
    <div class="noclickzone" v-if="!vieweditwindow">
      <div class="overlayzone">
        <div class="editcontent">
          <h2>Ändra tid</h2>
          <div class="pad">
            <input type="date" v-model="edate" />
            <div class="mh">
              <div>
                <div>Timmar</div>
                <input v-model="etime.Hours" type="number" min="0" max="15" />
              </div>
              <div>
                <div>Minuter</div>
                <input v-model="etime.Minutes" type="number" min="0" max="60" />
              </div>
            </div>
            <div class="dbcaps">
              <div class="db">
                <label class="container">
                  <input
                    v-model="etime.debit"
                    id="debitja"
                    class="deltagcheckbox"
                    type="radio"
                    value="1"
                  />
                  <label for="debitja" class="checkmark">
                    <div>DEBIT</div>
                  </label>
                </label>
                <label class="container">
                  <input
                    v-model="etime.debit"
                    id="debitnej"
                    class="deltagcheckbox"
                    type="radio"
                    value="0"
                  />
                  <label for="debitnej" class="checkmark">
                    <div>EJ DEBIT</div>
                  </label>
                </label>
              </div>
            </div>
            <div class="e">
              <div>Notes</div>
              <textarea
                v-model="etime.Description"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
            <br />
            <div
              class="submittimes"
              @click="editTime(), (vieweditwindow = !vieweditwindow)"
            >
              Lägg till
            </div>
            <div
              class="avbryt"
              @click="(vieweditwindow = !vieweditwindow), avbrytedit()"
            >
              Avbryt
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="Topcont">
      <div class="datecaps">
        <div class="MnW">
          <h3 style="margin: 0px">Vecka {{ this.week - 1 }}</h3>
          <h3 style="margin: 0px">Månad {{ this.month + 1 }}</h3>
        </div>
        <div class="daycont">
          <div class="nextWC">
            <div class="nextW" @click="previousWeek()">Tillbaka</div>
          </div>
          <div class="daybtn" @click="selectday(Mon)">
            <a href="/#/Time/#Mon" class="daypick">M</a>
            <div class="singDate">{{ this.MonDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Tue)">
            <a href="/#/Time/#Tue" class="daypick">T</a>
            <div class="singDate">{{ this.TueDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Wed)">
            <a href="/#/Time/#Wed" class="daypick">O</a>
            <div class="singDate">{{ this.WedDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Thu)">
            <a href="/#/Time/#Thu" class="daypick">T</a>
            <div class="singDate">{{ this.ThuDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Fri)">
            <a href="/#/Time/#Fri" class="daypick">F</a>
            <div class="singDate">{{ this.FriDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Sat)">
            <a href="/#/Time/#Sat" class="daypick">L</a>
            <div class="singDate">{{ this.SatDate }}</div>
          </div>
          <div class="daybtn" @click="selectday(Sun)">
            <a href="/#/Time/#Sun" class="daypick">S</a>
            <div class="singDate">{{ this.SunDate }}</div>
          </div>
          <div class="nextWC">
            <div class="nextW" @click="nextWeek()">Nästa</div>
          </div>
        </div>
        <div class="formCont" v-bind:class="{ onForm: picked !== undefined }">
          <div
            class="Forminnershown"
            v-bind:class="{ innerOnShown: picked !== undefined }"
          >
            <h3>{{ picked }}</h3>
            <div class="LSVS">
              <div class="db">
                <label class="container"
                  ><label
                    @click="(chosenproject = 'Ledig'), (chosenid = 0)"
                    v-if="chosenproject !== 'Ledig'"
                    for="Ledig"
                    class="checkmark"
                    ><div>Ledig</div></label
                  ></label
                ><label class="container"
                  ><label
                    @click="(chosenproject = 'Semester'), (chosenid = 0)"
                    v-if="chosenproject !== 'Semester'"
                    for="Semester"
                    class="checkmark"
                    ><div>Semester</div></label
                  ></label
                >
                <label class="container"
                  ><label
                    @click="(chosenproject = 'VAB'), (chosenid = 0)"
                    v-if="chosenproject !== 'VAB'"
                    for="VAB"
                    class="checkmark"
                    ><div>VAB</div></label
                  ></label
                >
                <label class="container"
                  ><label
                    @click="(chosenproject = 'Sjuk'), (chosenid = 0)"
                    v-if="chosenproject !== 'Sjuk'"
                    for="Sjuk"
                    class="checkmark"
                    ><div>Sjuk</div></label
                  ></label
                >
              </div>
            </div>
            <div class="projectcaps">
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
                      :key="projects.id"
                      @click="dataPrimer(projects.id, projects.Title)"
                    >
                      {{ projects.Title }}
                    </div>
                  </div>
                </div>
              </dropdown-menu>
            </div>

            <br />
            <div class="mh">
              <div>
                <div>Timmar</div>
                <input
                  v-model="Hours"
                  type="number"
                  min="0"
                  max="15"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1').replace(/^0[^.]/, '0');"
                />
              </div>
              <div>
                <div>Minuter</div>
                <input
                  v-model="Minutes"
                  type="number"
                  min="0"
                  max="60"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1').replace(/^0[^.]/, '0');"
                />
              </div>
            </div>
            <div class="dbcaps">
              <div class="db">
                <label class="container">
                  <input
                    v-model="debit"
                    id="debitja"
                    class="deltagcheckbox"
                    type="radio"
                    value="1"
                  />
                  <label for="debitja" class="checkmark">
                    <div>DEBIT</div>
                  </label>
                </label>
                <label class="container">
                  <input
                    v-model="debit"
                    id="debitnej"
                    class="deltagcheckbox"
                    type="radio"
                    value="0"
                  />
                  <label for="debitnej" class="checkmark">
                    <div>EJ DEBIT</div>
                  </label>
                </label>
              </div>
            </div>
            <br />
            <div class="e">
              <div>Notes</div>
              <textarea
                v-model="Notes"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
            <br />
            <div
              v-if="chosenproject.length > 0"
              class="submittime"
              @click="addTime()"
            >
              Lägg till
            </div>
            <div v-if="chosenproject.length == 0" class="submittime fakerbtn">
              Lägg till
            </div>
            <br />
          </div>
        </div>
      </div>

      <div class="UrnCaps">
        <div class="s">
          <!--
<radial-progress-bar
            :diameter="140"
            :completed-steps="
              parseInt(this.amountonhours + this.amountonminutes)
            "
            :total-steps="8"
            :innerStrokeColor="'#C7C8C9'"
            :startColor="'rgb(57, 124, 226)'"
            :stopColor="'#397ce2'"
            :strokeLinecap="'flat'"
            :strokeWidth="10"
            :innerStrokeWidth="10"
          >
            <div>
              <span class="datatime">{{
                this.amountonhours + this.amountonminutes
              }}</span
              ><span class="slash">/</span><span class="worktime">8h</span>
            </div>
          </radial-progress-bar>
         
function 
        -->
          <div class="center">
            <div class="circle">
              <div class="tidcaps">
                <span class="datatime">{{ combtime }}h</span>
              </div>
              <div class="wave" :style="{ top: precentage + '%' }"></div>
              <div id="background-wrap">
                <div class="bubble x1"></div>
                <div class="bubble x2"></div>
                <div class="bubble x3"></div>
                <div class="bubble x4"></div>
                <div class="bubble x5"></div>
                <div class="bubble x6"></div>
                <div class="bubble x7"></div>
                <div class="bubble x8"></div>
                <div class="bubble x9"></div>
                <div class="bubble x10"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="bfcaps">
          <div class="bf" @click="previousDay()">Tillbaka</div>
          <div class="urndate">{{ picked }}</div>
          <div class="bf" @click="nextDay()">Nästa</div>
        </div>

        <div class="dayinfo">
          <div class="spacer">
            <div
              class="urntimecaps"
              v-for="biden in datetime"
              :key="biden.index"
            >
              <div class="editimg">
                <img
                  @click="
                    Edit(biden.id, biden.Datum),
                      (vieweditwindow = !vieweditwindow)
                  "
                  src="@/assets/edit.png"
                  width="20px"
                  alt=""
                />
              </div>
              <div class="urntimetitle">
                {{ biden.Title }}
                <span class="debinf" v-if="biden.debit == 1">(debit)</span>
                <span class="debinf" v-if="biden.debit == 0">(Ejdebit)</span>
              </div>

              <div class="urntimetime">
                {{ biden.Hours }}h {{ biden.Minutes }}m
              </div>
              <span
                @click="
                  deleteTime(
                    biden.id,
                    biden.Minutes,
                    biden.Hours,
                    biden.fatherid
                  )
                "
                class="deletetime"
              >
                <svg
                  width="19"
                  height="20"
                  viewBox="0 0 19 20"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M7 16C7.26522 16 7.51957 15.8946 7.70711 15.7071C7.89464 15.5196 8 15.2652 8 15V9C8 8.73478 7.89464 8.48043 7.70711 8.29289C7.51957 8.10536 7.26522 8 7 8C6.73478 8 6.48043 8.10536 6.29289 8.29289C6.10536 8.48043 6 8.73478 6 9V15C6 15.2652 6.10536 15.5196 6.29289 15.7071C6.48043 15.8946 6.73478 16 7 16ZM17 4H13V3C13 2.20435 12.6839 1.44129 12.1213 0.87868C11.5587 0.316071 10.7956 0 10 0H8C7.20435 0 6.44129 0.316071 5.87868 0.87868C5.31607 1.44129 5 2.20435 5 3V4H1C0.734784 4 0.48043 4.10536 0.292893 4.29289C0.105357 4.48043 0 4.73478 0 5C0 5.26522 0.105357 5.51957 0.292893 5.70711C0.48043 5.89464 0.734784 6 1 6H2V17C2 17.7956 2.31607 18.5587 2.87868 19.1213C3.44129 19.6839 4.20435 20 5 20H13C13.7956 20 14.5587 19.6839 15.1213 19.1213C15.6839 18.5587 16 17.7956 16 17V6H17C17.2652 6 17.5196 5.89464 17.7071 5.70711C17.8946 5.51957 18 5.26522 18 5C18 4.73478 17.8946 4.48043 17.7071 4.29289C17.5196 4.10536 17.2652 4 17 4ZM7 3C7 2.73478 7.10536 2.48043 7.29289 2.29289C7.48043 2.10536 7.73478 2 8 2H10C10.2652 2 10.5196 2.10536 10.7071 2.29289C10.8946 2.48043 11 2.73478 11 3V4H7V3ZM14 17C14 17.2652 13.8946 17.5196 13.7071 17.7071C13.5196 17.8946 13.2652 18 13 18H5C4.73478 18 4.48043 17.8946 4.29289 17.7071C4.10536 17.5196 4 17.2652 4 17V6H14V17ZM11 16C11.2652 16 11.5196 15.8946 11.7071 15.7071C11.8946 15.5196 12 15.2652 12 15V9C12 8.73478 11.8946 8.48043 11.7071 8.29289C11.5196 8.10536 11.2652 8 11 8C10.7348 8 10.4804 8.10536 10.2929 8.29289C10.1054 8.48043 10 8.73478 10 9V15C10 15.2652 10.1054 15.5196 10.2929 15.7071C10.4804 15.8946 10.7348 16 11 16Z"
                    fill="#B54848"
                  />
                </svg>
              </span>
            </div>
          </div>
        </div>

        <p></p>
      </div>
    </div>
  </div>
</template>
<style scoped>
#background-wrap {
  bottom: 0;
  left: 0;
  position: absolute;
  right: 0;
  top: 0;
  width: 100%;
  height: 90%;
  top: 30%;
  z-index: 98;
}

/* KEYFRAMES */

@-webkit-keyframes animateBubble {
  0% {
    margin-top: 1000px;
  }
  100% {
    margin-top: -100%;
  }
}

@-moz-keyframes animateBubble {
  0% {
    margin-top: 1000px;
  }
  100% {
    margin-top: -100%;
  }
}

@keyframes animateBubble {
  0% {
    margin-top: 1000px;
  }
  100% {
    margin-top: -100%;
  }
}

@-webkit-keyframes sideWays {
  0% {
    margin-left: 0px;
  }
  100% {
    margin-left: 50px;
  }
}

@-moz-keyframes sideWays {
  0% {
    margin-left: 0px;
  }
  100% {
    margin-left: 50px;
  }
}

@keyframes sideWays {
  0% {
    margin-left: 0px;
  }
  100% {
    margin-left: 50px;
  }
}

/* ANIMATIONS */

.x1 {
  -webkit-animation: animateBubble 25s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  -moz-animation: animateBubble 25s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  animation: animateBubble 25s linear infinite,
    sideWays 2s ease-in-out infinite alternate;

  left: -25%;
  top: 5%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x2 {
  -webkit-animation: animateBubble 20s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  -moz-animation: animateBubble 20s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  animation: animateBubble 20s linear infinite,
    sideWays 4s ease-in-out infinite alternate;

  left: -35%;
  top: 80%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x3 {
  -webkit-animation: animateBubble 28s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  -moz-animation: animateBubble 28s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  animation: animateBubble 28s linear infinite,
    sideWays 2s ease-in-out infinite alternate;

  left: -10%;
  top: 40%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x4 {
  -webkit-animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;
  -moz-animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;
  animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;

  left: -35%;
  top: 0;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x5 {
  -webkit-animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  -moz-animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;

  left: -20%;
  top: 50%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x6 {
  -webkit-animation: animateBubble 21s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  -moz-animation: animateBubble 21s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  animation: animateBubble 21s linear infinite,
    sideWays 2s ease-in-out infinite alternate;

  left: -30%;
  top: 0;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x7 {
  -webkit-animation: animateBubble 20s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  -moz-animation: animateBubble 20s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  animation: animateBubble 20s linear infinite,
    sideWays 2s ease-in-out infinite alternate;

  left: -45%;
  top: 70%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x8 {
  -webkit-animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;
  -moz-animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;
  animation: animateBubble 22s linear infinite,
    sideWays 3s ease-in-out infinite alternate;

  left: -15%;
  top: 10%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x9 {
  -webkit-animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  -moz-animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;
  animation: animateBubble 29s linear infinite,
    sideWays 4s ease-in-out infinite alternate;

  left: -25%;
  top: 50%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

.x10 {
  -webkit-animation: animateBubble 26s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  -moz-animation: animateBubble 26s linear infinite,
    sideWays 2s ease-in-out infinite alternate;
  animation: animateBubble 26s linear infinite,
    sideWays 2s ease-in-out infinite alternate;

  left: -20%;
  top: 80%;

  -webkit-transform: scale(0.1);
  -moz-transform: scale(0.1);
  transform: scale(0.1);
}

/* OBJECTS */

.bubble {
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;

  -webkit-box-shadow: 0 20px 30px rgba(0, 0, 0, 0.2),
    inset 0px 10px 30px 5px rgba(255, 255, 255, 1);
  -moz-box-shadow: 0 20px 30px rgba(0, 0, 0, 0.2),
    inset 0px 10px 30px 5px rgba(255, 255, 255, 1);
  box-shadow: 0 20px 30px rgba(0, 0, 0, 0.2),
    inset 0px 10px 30px 5px rgba(255, 255, 255, 1);

  height: 200px;
  position: absolute;
  width: 200px;
}

.bubble:after {
  background: -moz-radial-gradient(
    center,
    ellipse cover,
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0) 70%
  ); /* FF3.6+ */
  background: -webkit-gradient(
    radial,
    center center,
    0px,
    center center,
    100%,
    color-stop(0%, rgba(255, 255, 255, 0.5)),
    color-stop(70%, rgba(255, 255, 255, 0))
  ); /* Chrome,Safari4+ */
  background: -webkit-radial-gradient(
    center,
    ellipse cover,
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0) 70%
  ); /* Chrome10+,Safari5.1+ */
  background: -o-radial-gradient(
    center,
    ellipse cover,
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0) 70%
  ); /* Opera 12+ */
  background: -ms-radial-gradient(
    center,
    ellipse cover,
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0) 70%
  ); /* IE10+ */
  background: radial-gradient(
    ellipse at center,
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0) 70%
  ); /* W3C */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#80ffffff', endColorstr='#00ffffff',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */

  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;

  -webkit-box-shadow: inset 0 20px 30px rgba(255, 255, 255, 0.3);
  -moz-box-shadow: inset 0 20px 30px rgba(255, 255, 255, 0.3);
  box-shadow: inset 0 20px 30px rgba(255, 255, 255, 0.3);

  content: "";
  height: 180px;
  left: 10px;
  position: absolute;
  width: 180px;
}
.tidcaps {
  position: absolute;
  left: 25%;
  right: 25%;
  top: 35%;
  z-index: 99;
  text-shadow: 1px 1px 2px white;
}
.submittimes {
  background: #1988c9;
  width: 80%;
  cursor: pointer;
  padding: 10px;
  color: white;
  border-radius: 20px;
}
.avbryt {
  margin-top: 10px;
  background: rgb(218, 81, 81);
  border-radius: 20px;
  width: 100px;
  height: 20px;
  text-align: center;
  color: white;
  font-size: 15px;
  padding: 5px;
  cursor: pointer;
}
.editimg {
  margin-right: 5px;
}
.editimg > img {
  width: 20px;
  transition: 0.5s;
}
.editimg > img:hover {
  width: 25px;
  cursor: pointer;
}
.editcontent > h2 {
  background: #1988c9;
  border-radius: 20px 20px 0px 0px;
  padding: 10px;
  color: white;
  margin-top: 0;
}
.pad {
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.noclickzone {
  position: absolute;
  width: 100vw;
  height: 100vh;
  top: 0%;
  left: 0%;
  background: #00000036;
  z-index: 10;
  display: flex;
  justify-content: center;

  align-items: center;
}
.overlayzone {
  width: 300px;
  height: 500px;
  background: white;
  border-radius: 20px;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.356);
}
.editcontent {
}
.fakerbtn {
  background: #7c7c7c !important;
  cursor: not-allowed !important;
}
.dropper {
  height: 250px !important;
  overflow-y: scroll;
}
.LSVS {
  margin: 20px;
}
.debinf {
  font-size: 8px;
}
.deletetime {
  flex: 0;
  color: #c93319;
  font-size: 10px;
  cursor: pointer;
  align-self: center;
  margin: 2px;
  margin-left: 10px;

  width: 50px !important;
}
.deletetime:hover {
  transition: 0.2s;
  color: #ff3916;
  font-size: 10px;
  transform: scale(1.3);
}
.projectcaps {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
}
.checkmark {
  position: absolute;
  width: 50px;
  padding: 10px;
  background-color: #e0eeff;

  border: solid white 2px;
}
.container:hover input ~ .checkmark {
  background-color: #e0eeff;
}
.container input:checked ~ .checkmark {
  background-color: #1988c9;
  color: white;
  border: 2px rgb(32, 102, 151) solid;
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
.container {
  display: block;
  position: relative;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  margin-right: 70px;
  font-size: 12px;
}
.deltagcheckbox {
  appearance: none;
}
.debitstuff {
  height: 100%;
  width: 100%;
  padding: 10px;
  border-radius: 20px;
  color: white;
  background: #1988c9;
}
.debitcheck {
  appearance: none;
}
.dbcaps {
  margin-top: 15px;
}
.db {
  display: flex;
  justify-content: center;
  grid-gap: 20px;
  height: 50px;
}
.spacer {
  margin-top: 20px;
  display: flex;
  flex-direction: column;

  align-items: center;
  width: 100%;
}
.urntimecaps {
  padding: 20px;
  display: flex;
  width: 90%;
  justify-content: space-between;
  align-items: center;
  text-align: center;
}

.urntimecaps:nth-child(odd) {
  background: #d8d8d8;
}
.urntimecaps:nth-child(even) {
  background: #f0f0f0;
  border-top: solid 1px rgba(0, 0, 0, 0.247);
}
.urntimecaps:hover {
  background: rgb(176, 189, 190);
}
.urntimetitle {
  display: flex;
  align-items: right;
  text-align: right;
  font-size: 12px;
}
.urntimetime {
  flex: 1;
  display: flex;
  justify-content: flex-end;
  align-items: right;
  text-align: right;
}
.bfcaps {
  width: 100%;

  display: flex !important;
  justify-content: space-around !important;
  align-items: center;
}
.urndate {
  background: #397ce2;
  padding: 5px;
  color: white;

  border-radius: 5px;
}
.bf {
  padding: 5px;
  cursor: pointer;
  background: rgb(60, 126, 167);
  color: white;
  border-radius: 5px;
  width: 25%;
}
.mh {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
}

.submittime {
  background: #1988c9;
  cursor: pointer;
  padding: 10px;
  color: white;
  border-radius: 20px;
}
.e {
  display: flex;
  flex-direction: column;
  align-items: left;
  text-align: left;
  justify-content: flex-start;
}
textarea {
  resize: none;
  height: 100px;
}
.drop-item {
  width: 100%;
  padding-top: 10px;
  padding-bottom: 10px;
  background: white;
  cursor: pointer;
}
.drop-item:hover {
  background: rgb(226, 226, 226);
}
.chooseproject {
  cursor: pointer;
  padding: 10px;
  border-radius: 5px;
  background: rgb(238, 244, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.185);
}
.chooseproject:hover {
  background: rgb(225, 238, 249);
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.32);
}
.dayinfo {
  color: rgb(105, 105, 105);
  text-align: left;
  height: 100%;
  overflow-y: scroll;
  width: 100%;
  padding: 10px;
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
  display: flex;
  flex-direction: column;
  width: 50%;
  margin-bottom: 20px;
  padding: 30px;

  background: rgb(238, 249, 255);
}
.innerOnShown {
  opacity: 1;
}
.formCont {
  width: 100%;

  background: rgb(255, 255, 255);
  display: flex;
  justify-content: center;
}

.center {
  width: 175px;
  height: 175px;
  margin-bottom: 50px;
  border-radius: 100px;
  box-shadow: 2px 3px 5px 5px rgb(255, 255, 255);
}
.circle {
  position: relative;
  width: 100%;
  height: 100%;
  background: linear-gradient(rgb(250, 250, 250), #c0e3f8);
  border: 2px solid #fff;
  border-radius: 50%;
  overflow: hidden;
  -webkit-backface-visibility: hidden;
  -moz-backface-visibility: hidden;
  -webkit-transform: translate3d(0, 0, 0);
  -moz-transform: translate3d(0, 0, 0);
  box-shadow: inset 2px 0px 5px 0px rgba(71, 73, 73, 0.322);

  cursor: pointer;
}
.wave {
  background-color: #1988c9;
  position: absolute;
  top: 110%;
  height: 200%;
  width: 200%;
  border-radius: 38%;
  left: -50%;
  transform: rotate(360deg);
  transition: all 1s ease;
  animation: wave 50s linear infinite;
  box-shadow: inset 2px 0px 5px 5px rgba(154, 252, 255, 0.322);
}
@keyframes wave {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(3600deg);
  }
}
.circle:hover .wave {
  top: 20%;
}
.onForm {
}
.UrnCaps {
  background: rgb(246, 246, 246);
  padding: 20px;
  width: 250px;
  display: flex;
  align-items: center;
  flex-direction: column;
  float: right;
  border-left: 1px solid rgba(128, 128, 128, 0.228);
}
.MnW {
  width: 350px;
  display: flex;
  justify-content: space-between;

  margin-top: 50px;
}
.singDate {
  font-size: 12px;
}

.nextWC {
  display: flex;
  align-items: top;
  height: 100%;
}
.daycont {
}
.nextW {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: 6vw;
  height: 50px;
  background-color: #1988c9;
  color: white;
  cursor: pointer;
}
.nextW:hover {
  background: #4d8be9;
}
.daypick {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;

  height: 50px;
  background-color: #1988c9;
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
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left: 20px;
  padding-right: 20px;
}
.daycont {
  display: flex;
  background-color: rgb(255, 255, 255);
  align-items: center;
  width: 100%;
  justify-content: center;
}
.daybtn {
  width: 100%;
}

#Time {
  width: 100%;
  height: 100%;
  display: flex;

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
  background: rgb(241, 241, 241);
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0px 10px 6px rgba(221, 221, 221, 0.993);
  border-radius: 20px;
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0px 10px rgb(139, 139, 139);
  border-radius: 20px;
}
@media only screen and (max-width: 800px) {
  .daypick {
    font-size: 10px;
  }
  .singDate {
    font-size: 10px;
  }
  .nextW {
    font-size: 10px;
  }
  .MnW {
    width: 100%;
    justify-content: space-around;
  }
  .Topcont {
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
  }
  .datecaps {
    flex: 0;

    padding-left: 0px;
    padding-right: 0px;
    width: 95%;
  }
  .UrnCaps {
    width: 90%;
    padding: 0px;
  }
  .Topcont {
    font-size: 15px;
  }
  .nextW {
    padding-left: 5px;
    padding-right: 5px;
  }
}
@media only screen and (max-width: 800px) {
  .Forminnershown {
    width: 100%;
    padding: 0;
  }
  .formCont {
    width: 100%;
  }
  .db {
    display: grid;
    grid-template-columns: auto auto;
    grid-template-rows: auto auto;

    height: 100px;
  }
  .dropper {
  }
  .chooseproject {
    width: 200px;
  }
}
</style>

<script>
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
import AddtimeN from "../components/AddtimeN.vue";
import Usermetrics from "../components/Usermetrics.vue";
import moment from "moment";
import RadialProgressBar from "vue-radial-progress";
import io from "socket.io-client";
import $ from "jquery";

export default {
  components: { AddtimeN, Usermetrics, DropdownMenu, RadialProgressBar },
  data() {
    return {
      Sun: 7,
      Mon: 1,
      Tue: 2,
      Wed: 3,
      logged: this.$store.state.someValue,
      time: "",
      search: "",
      datetime: "s",
      amountonhours: [],
      amountonminutes: [],
      Ledig: false,
      Sjuk: false,
      VAB: false,
      Semester: false,
      vieweditwindow: true,
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
      loggedin: "",
      project: [],
      chosenproject: "",
      chosenid: 0,
      Hours: 0,
      Minutes: 0,
      Notes: "",
      debit: 1,
      toltip: false,
      etime: "",
      edate: "",
      combtime: 0,
      precentage: 100,
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
        if (result.length == 0) {
          location.replace("https://app.mxtime.se/#/");
        }
      });

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
        this.loggedstatus = this.loggedin.Status;

        this.socketInstance = io("https://mxtime.se:3000/");
        this.socketInstance.emit("loggedinfo", this.loggedin);
        if (this.loggedin.nanoid == undefined) {
          window.location.reload();
        }
        this.socketInstance.on("specificproject", (specificproject) => {
          this.project = specificproject;
        });
        this.socketInstance.emit("mytime", this.loggedin.Username);

        this.socketInstance.on("mytimedata", (mytimedata) => {
          this.time = mytimedata;

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
          this.amountonminutes = this.amountonminutes.reduce(
            (a, b) => a + b,
            0
          );

          this.amountonminutes = parseFloat(this.amountonminutes / 60).toFixed(
            2
          );
          this.amountonminutes = parseFloat(this.amountonminutes);
          this.combtime = parseFloat(
            this.amountonhours + this.amountonminutes
          ).toFixed(2);
          this.precentage = 105 - Math.round((100 * this.combtime) / 8);
          if (this.precentage < 5) {
            this.precentage = 5;
          }
        });
      });
  },
  methods: {
    checkthatbitch(bitch) {
      console.log(indexOf(bitch));
    },
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
      this.amountonminutes = this.amountonminutes.reduce((a, b) => a + b, 0);

      this.amountonminutes = parseFloat(this.amountonminutes / 60).toFixed(2);
      this.amountonminutes = parseFloat(this.amountonminutes);
      this.combtime = parseFloat(
        this.amountonhours + this.amountonminutes
      ).toFixed(2);
      this.precentage = 105 - Math.round((100 * this.combtime) / 8);
      if (this.precentage < 5) {
        this.precentage = 5;
      }
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
      this.amountonminutes = this.amountonminutes.reduce((a, b) => a + b, 0);
      console.log(this.amountonminutes);
      this.amountonminutes = parseFloat(this.amountonminutes / 60).toFixed(2);
      this.amountonminutes = parseFloat(this.amountonminutes);
      this.combtime = parseFloat(
        this.amountonhours + this.amountonminutes
      ).toFixed(2);
      this.precentage = 105 - Math.round((100 * this.combtime) / 8);
      if (this.precentage < 5) {
        this.precentage = 5;
      }
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
      this.amountonminutes = this.amountonminutes.reduce((a, b) => a + b, 0);

      this.amountonminutes = parseFloat(this.amountonminutes / 60).toFixed(2);
      this.amountonminutes = parseFloat(this.amountonminutes);
      this.combtime = parseFloat(
        this.amountonhours + this.amountonminutes
      ).toFixed(2);
      this.precentage = 105 - Math.round((100 * this.combtime) / 8);
      if (this.precentage < 5) {
        this.precentage = 5;
      }
    },
    dataPrimer(id, title) {
      this.chosenproject = title;
      this.chosenid = id;
    },
    test() {},
    avbrytedit() {
      console.log(this.edate);
      console.log(this.etime);
      this.socketInstance.emit("mytime", this.loggedin.Username);
    },
    addTime() {
      let addtimedata = {
        projectid: this.chosenid,
        title: this.chosenproject,
        name: this.loggedin.Name,
        user: this.loggedin.Username,
        description: this.Notes,
        timmar: this.Hours,
        minuter: this.Minutes,
        datepicked: new Date(this.picked).getTime(),
        fatherid: this.chosenid,
        debit: this.debit,
        nanoid: this.loggedin.nanoid,
      };
      console.log(addtimedata);

      this.socketInstance.emit("time", addtimedata);
      // window.location.reload();
      this.chosenid = "";
      this.chosenproject = "";
      this.Notes = "";
      this.Hours = 0;
      this.Minutes = 0;
    },
    ledig() {
      if (this.Ledig == true) {
        this.chosenproject = "Ledig";
      }
      if (this.Semester == true) {
        this.chosenproject = "Semester";
      }
      if (this.VAB == true) {
        this.chosenproject = "VAB";
      }
    },
    deleteTime(id, minuter, hours, fatherid) {
      let dtimedata = {
        id: id,
        minuter: minuter,
        hours: hours,
        fatherid: fatherid,
        user: this.loggedin.Username,
      };

      this.socketInstance.emit("delet:time", dtimedata);
      //window.location.reload();
    },
    editTime() {
      const sender = {
        etime: this.etime,
        oldhours: this.oldhours,
        oldminutes: this.oldminutes,
      };
      this.etime.Datum = new Date(this.edate).getTime();
      this.socketInstance.emit("edittime", sender);
      console.log(sender);
    },
    Edit(id, datum) {
      this.z = id;
      this.x = id - 1;
      this.etime = this.time.find((result) => result.id == this.z);
      this.oldhours = this.etime.Hours;
      this.oldminutes = this.etime.Minutes;
      this.edate = this.picked;
    },
  },
  mounted() {
    $("input:checkbox").on("click", function () {
      var $box = $(this);
      if ($box.is(":checked")) {
        var group = "input:checkbox[name='" + $box.attr("name") + "']";
        $(group).prop("checked", false);
        $box.prop("checked", true);
      } else {
        $box.prop("checked", false);
      }
    });
  },
  computed: {
    filterFunction() {
      return this.project.filter((p) => {
        // return true if the product should be visible

        // in this example we just check if the search string
        // is a substring of the product name (case insensitive)
        return p.Title.toLowerCase().indexOf(this.search.toLowerCase()) != -1;
      });
    },
  },
};
</script>
