<template>
  <div id="Home">
    <Workernav />
    <div class="christmasspecials"></div>

    <!--
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
      -->

    <div class="Grid">
      <div
        class="Card"
        v-for="(projects, index) in projectnw"
        :key="projects.index"
      >
        <div class="tabletop">
          <span
            style="color: blue; float: left"
            v-bind:id="projects.id"
            class="edit"
            @click="
              Edit(projects.id),
                (T = !T),
                modProject(index, projects.id, projects)
            "
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
          <span
            @click="
              setforchart(projects),
                getAdvanced(projects),
                viewtrello(projects.id)
            "
            class="title"
            >{{ projects.Title }}</span
          >
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
                            holdproject(projects),
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
                            holdproject(projects),
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

                <div class="dflex">
                  <div class="dinputcapsule">
                    <span class="dwrite"
                      >Skriv in projektets namn för att radera</span
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
                <div class="dAvbryt" @click="R = !R">Avbryt</div>
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

              <div class="skapaknapp" @click="sendEdit(), (T = !T)">Ändra</div>
              <div class="avbryt" type="button" @click="T = !T">Avbryt</div>
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
                <h1 style="margin: 0px">Slutför</h1>
                <h2>{{ this.etitle }}</h2>
              </div>
              <div>vill du slutföra förljande projekt?</div>
              <div>{{ this.etitle }}</div>
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

                <div
                  class="arkivavbryt"
                  @click="arkiveraoverlay = !arkiveraoverlay"
                >
                  Avbryt
                </div>
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

    <transition name="slide-fade">
      <div v-if="!advancedview" class="noclick">
        <div id="AdvanceForm">
          <div class="headercont">
            <div></div>
            <h2>{{ advancedataholder.Title }}</h2>

            <div @click="advancedview = !advancedview" class="close">
              <img width="16px" src="@/assets/Kryss2.png" alt="" />
            </div>
          </div>

          <div class="advancedcontent">
            <div class="advancedleft">
              <div
                v-for="addesc in descdisp"
                :key="addesc.index"
                class="flip-card"
              >
                <div v-if="descdisp.length > 0" class="flip-card-inner">
                  <div class="flip-card-front">
                    <div class="frontcapsule">
                      <div class="profileandname">
                        <img
                          class="leftprofile"
                          :src="`https://mxtime.se/mxprofile/${addesc.Profile}.jpg`"
                          alt=""
                        />
                        <h2>{{ addesc.Name }}</h2>
                      </div>
                      <div class="frontdates">
                        <div>
                          {{ parseInt(addesc.Datum) | moment }}
                        </div>
                      </div>
                    </div>
                    <div class="isdebit" v-if="addesc.Debit == 1">Debit</div>
                    <div class="isnotdebit" v-else>Ej Debit</div>
                  </div>
                  <div class="flip-card-back">
                    <div class="topbarcont">
                      <div class="frontcapsule">
                        <div class="profileandname">
                          <img
                            class="leftprofile"
                            :src="`https://mxtime.se/mxprofile/${addesc.Profile}.jpg`"
                            alt=""
                          />
                          <h2>{{ addesc.Name }}</h2>
                        </div>
                        <div class="frontdates">
                          <div>
                            {{ parseInt(addesc.Datum) | moment }}
                          </div>
                        </div>
                      </div>
                      <div class="isdebit" v-if="addesc.Debit == 1">Debit</div>
                      <div class="isnotdebit" v-else>Ej Debit</div>
                    </div>
                    <div class="descriptioncontainer">
                      {{ addesc.Description }}
                    </div>
                  </div>
                </div>
              </div>
              <div v-if="descdisp.length < 1" class="descdispinfo">
                <h2>Arbets notiser</h2>
                <p>
                  Här visas alla deltagares beskrivning på arbete utfört genom
                  den loggade tiden
                </p>

                <router-link class="links" to="/Time">
                  <p class="provalogga">Prova logga tid för detta projekt!</p>
                </router-link>
              </div>
            </div>
            <div class="advancedmiddle">
              <div class="advancedmiddletop">
                <Frekvenschart
                  v-if="amountadvdata.length > 0"
                  id="chart"
                  :to-chart="amountadvdata"
                />
                <div class="diaginfocaps" v-else>
                  <h2>Dags diagram</h2>
                  <h4 class="diaginfo">
                    Här kommer det visas en diagram som visar alla rapporterade
                    dagar med information om vilken dag som har haft störst
                    insats
                  </h4>
                  <h4>
                    I den nedresta blå ruta visas ett diagram med procent insats
                    av den totala tiden spenderat av varje deltagare
                  </h4>
                </div>
              </div>
              <div class="advancedmiddlebot">
                <div class="gradecaps">
                  <div></div>
                  <div class="gradecapper">
                    <div
                      class="grade"
                      v-for="(info, x) in advarr"
                      :key="info.index"
                      :style="{ background: rcolor[x], width: advpr[x] + '%' }"
                    >
                      <div class="pointerholder" v-if="advpr[x] > 1">
                        <svg
                          width="88"
                          height="108"
                          viewBox="0 0 88 108"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <g filter="url(#filter0_d_205_2)">
                            <g filter="url(#filter1_i_205_2)">
                              <rect
                                x="13.0852"
                                width="61.772"
                                height="59.466"
                                rx="20"
                                fill="#FEFEFE"
                              />
                            </g>
                            <g filter="url(#filter2_i_205_2)">
                              <path
                                d="M52.0332 92.1708C48.347 97.1934 46.5039 99.7047 43.9714 99.7047C41.4389 99.7047 39.5958 97.1934 35.9096 92.1708L7.71979 53.7608C5.45634 50.6768 4.32462 49.1347 4.39493 47.3862C4.46523 45.6377 5.71712 44.1916 8.22088 41.2992L36.4107 8.73421C39.9279 4.67112 41.6865 2.63958 43.9714 2.63958C46.2563 2.63958 48.0149 4.67112 51.5321 8.7342L79.7219 41.2992C82.2257 44.1916 83.4776 45.6377 83.5479 47.3862C83.6182 49.1347 82.4865 50.6768 80.223 53.7608L52.0332 92.1708Z"
                                fill="#FEFEFE"
                              />
                            </g>
                            <g filter="url(#filter3_i_205_2)">
                              <rect
                                x="16.8674"
                                y="1.21362"
                                width="55.4687"
                                height="53.3981"
                                rx="20"
                                fill="#FEFEFE"
                              />
                            </g>
                          </g>
                          <g filter="url(#filter4_i_205_2)">
                            <ellipse
                              cx="44.7327"
                              cy="66.5"
                              rx="17.6592"
                              ry="10.5"
                              fill="#FCFCFC"
                            />
                          </g>
                          <defs>
                            <filter
                              id="filter0_d_205_2"
                              x="0.391846"
                              y="0"
                              width="87.1592"
                              height="107.705"
                              filterUnits="userSpaceOnUse"
                              color-interpolation-filters="sRGB"
                            >
                              <feFlood
                                flood-opacity="0"
                                result="BackgroundImageFix"
                              />
                              <feColorMatrix
                                in="SourceAlpha"
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                                result="hardAlpha"
                              />
                              <feOffset dy="4" />
                              <feGaussianBlur stdDeviation="2" />
                              <feComposite in2="hardAlpha" operator="out" />
                              <feColorMatrix
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"
                              />
                              <feBlend
                                mode="normal"
                                in2="BackgroundImageFix"
                                result="effect1_dropShadow_205_2"
                              />
                              <feBlend
                                mode="normal"
                                in="SourceGraphic"
                                in2="effect1_dropShadow_205_2"
                                result="shape"
                              />
                            </filter>
                            <filter
                              id="filter1_i_205_2"
                              x="13.0852"
                              y="0"
                              width="61.772"
                              height="59.4661"
                              filterUnits="userSpaceOnUse"
                              color-interpolation-filters="sRGB"
                            >
                              <feFlood
                                flood-opacity="0"
                                result="BackgroundImageFix"
                              />
                              <feBlend
                                mode="normal"
                                in="SourceGraphic"
                                in2="BackgroundImageFix"
                                result="shape"
                              />
                              <feColorMatrix
                                in="SourceAlpha"
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                                result="hardAlpha"
                              />
                              <feOffset />
                              <feGaussianBlur stdDeviation="1" />
                              <feComposite
                                in2="hardAlpha"
                                operator="arithmetic"
                                k2="-1"
                                k3="1"
                              />
                              <feColorMatrix
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"
                              />
                              <feBlend
                                mode="normal"
                                in2="shape"
                                result="effect1_innerShadow_205_2"
                              />
                            </filter>
                            <filter
                              id="filter2_i_205_2"
                              x="4.39185"
                              y="1.63953"
                              width="79.1592"
                              height="98.0652"
                              filterUnits="userSpaceOnUse"
                              color-interpolation-filters="sRGB"
                            >
                              <feFlood
                                flood-opacity="0"
                                result="BackgroundImageFix"
                              />
                              <feBlend
                                mode="normal"
                                in="SourceGraphic"
                                in2="BackgroundImageFix"
                                result="shape"
                              />
                              <feColorMatrix
                                in="SourceAlpha"
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                                result="hardAlpha"
                              />
                              <feOffset dy="-1" />
                              <feGaussianBlur stdDeviation="1" />
                              <feComposite
                                in2="hardAlpha"
                                operator="arithmetic"
                                k2="-1"
                                k3="1"
                              />
                              <feColorMatrix
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"
                              />
                              <feBlend
                                mode="normal"
                                in2="shape"
                                result="effect1_innerShadow_205_2"
                              />
                            </filter>
                            <filter
                              id="filter3_i_205_2"
                              x="16.8674"
                              y="1.21362"
                              width="55.4688"
                              height="53.3981"
                              filterUnits="userSpaceOnUse"
                              color-interpolation-filters="sRGB"
                            >
                              <feFlood
                                flood-opacity="0"
                                result="BackgroundImageFix"
                              />
                              <feBlend
                                mode="normal"
                                in="SourceGraphic"
                                in2="BackgroundImageFix"
                                result="shape"
                              />
                              <feColorMatrix
                                in="SourceAlpha"
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                                result="hardAlpha"
                              />
                              <feOffset />
                              <feGaussianBlur stdDeviation="1" />
                              <feComposite
                                in2="hardAlpha"
                                operator="arithmetic"
                                k2="-1"
                                k3="1"
                              />
                              <feColorMatrix
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"
                              />
                              <feBlend
                                mode="normal"
                                in2="shape"
                                result="effect1_innerShadow_205_2"
                              />
                            </filter>
                            <filter
                              id="filter4_i_205_2"
                              x="27.0735"
                              y="56"
                              width="35.3184"
                              height="21"
                              filterUnits="userSpaceOnUse"
                              color-interpolation-filters="sRGB"
                            >
                              <feFlood
                                flood-opacity="0"
                                result="BackgroundImageFix"
                              />
                              <feBlend
                                mode="normal"
                                in="SourceGraphic"
                                in2="BackgroundImageFix"
                                result="shape"
                              />
                              <feColorMatrix
                                in="SourceAlpha"
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                                result="hardAlpha"
                              />
                              <feOffset />
                              <feGaussianBlur stdDeviation="1" />
                              <feComposite
                                in2="hardAlpha"
                                operator="arithmetic"
                                k2="-1"
                                k3="1"
                              />
                              <feColorMatrix
                                type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"
                              />
                              <feBlend
                                mode="normal"
                                in2="shape"
                                result="effect1_innerShadow_205_2"
                              />
                            </filter>
                          </defs>
                        </svg>

                        <img
                          class="profileadv"
                          :src="`https://mxtime.se/mxprofile/${info[0].Profile}.jpg`"
                          alt=""
                        />
                        <div class="precentage">{{ advpr[x] }}%</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="advancedright">
              <div class="advtrelloview">
                <div class="textinfo" v-if="atrello.length < 1">
                  <h2>Skapa Uppgifter för projektet</h2>
                  <p>
                    Här kommer dina uppgifter som delas med deltagarna att visas
                  </p>
                  <p>Skapa uppgifter genom att använda fälten nedan!</p>
                </div>
                <div
                  class="trellocard advtrellocard"
                  v-for="trello in atrello"
                  :key="trello.id"
                >
                  <transition name="notsoepic-form">
                    <div v-if="trello.completed === 0">
                      <div class="trellohead">
                        <div>{{ trello.title }}</div>
                      </div>
                      <div class="trellooptions">
                        <div
                          class="trellodelete"
                          @click="trellodelete(trello.id)"
                        >
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
                        <pre class="prerenderstuff">{{
                          trello.description
                        }}</pre>
                      </div>
                    </div>
                  </transition>
                  <transition name="epic-form">
                    <div class="trellochecked" v-if="trello.completed === 1">
                      <div class="trellohead">
                        <div>{{ trello.title }}</div>
                      </div>
                      <div class="trellooptions">
                        <div
                          class="trellodelete"
                          @click="trellodelete(trello.id)"
                        >
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
                        <pre class="prerenderstuff">{{
                          trello.description
                        }}</pre>
                      </div>
                    </div>
                  </transition>
                </div>
              </div>
              <div class="inputsholdernshadow">
                <div class="textareapadtitle">
                  <input
                    class="advtrellotext"
                    v-model="Ttitle"
                    placeholder="Title"
                  />
                </div>
                <div class="advtrelloinput">
                  <div class="textareapad">
                    <textarea
                      class="advtrellotext"
                      name=""
                      id=""
                      cols="30"
                      rows="10"
                      placeholder="Aa"
                      v-model="Tdescription"
                      @keyup.13.exact="
                        if (Ttitle.length > 0 && Tdescription.length > 0) {
                          addtrello(projects.id);
                        }
                      "
                    ></textarea>
                  </div>

                  <div
                    class="advtrellosend"
                    v-if="
                      this.Ttitle.length > 0 && this.Tdescription.length > 0
                    "
                    @click="addtrello(projects.id)"
                  >
                    Skapa
                  </div>
                  <div
                    class="advtrellosendfaker"
                    v-if="
                      this.Ttitle.length < 1 || this.Tdescription.length < 1
                    "
                  >
                    Skapa
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>
<style scoped>
.christmasspecials {
  background: url("~@/assets/christmasspecials.png");

  height: 190px !important;
  width: 100vw !important;
}
.christmasspecials > img {
}
.crhistmasborder {
}
.diaginfocaps {
  width: 100%;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
}
.diaginfo {
  display: flex;
  justify-content: center;
  width: 70%;
  text-align: center;
  align-items: center;
}
.descdispinfo {
  height: 100%;
  font-size: 18px;
  display: flex;
  flex-direction: column;
}
@media only screen and (max-width: 1200px) {
  .advancedcontent {
    flex-direction: column;
    height: 90% !important;
    width: 100% !important;
    justify-items: center !important;
    overflow-y: auto;
    overflow-x: hidden;
    display: block !important;
  }
  .advancedmiddle {
    justify-self: center !important;
    max-width: unset !important;
    width: 100% !important;
    justify-content: center !important;
    align-items: center;
  }
  .advancedmiddletop {
    width: 100%;
  }
  .advancedmiddlebot {
    margin-top: 50px;
    width: 100%;
  }
  .advancedleft {
    height: 50%;
    flex: 1 !important;
  }
  .advancedright {
    margin-bottom: 2code0px !important;
  }
  #AdvanceForm {
  }
}
.leftprofile {
  width: 50px;
  height: 50px;
  border-radius: 20px;
}
.profileandname {
  display: flex;
  margin-left: 8px;
  margin-top: 5px;
  grid-gap: 5px;
  align-items: center;
  font-size: 12px;
}
.frontcapsule {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  color: white;
}
.frontdates {
  text-align: left;
  margin-left: 10px;
}
.isdebit {
  background: white;
  border-radius: 5px;
  padding: 5px;
  padding-left: 15px;
  padding-right: 15px;
  margin-right: 25px;
  font-weight: bold;

  height: 20px;
}
.isnotdebit {
  background: white;
  border-radius: 5px;
  padding: 5px;
  padding-left: 15px;
  padding-right: 15px;
  margin-right: 25px;
  font-weight: bold;
  height: 20px;
}
.flip-card-back > .topbarcont > .isdebit,
.isnotdebit {
  margin-top: 30px;
}
.topbarcont {
  display: flex;
  justify-content: space-between;
  width: 100%;
}
.advancedleft {
  background-color: white;
  margin: 5px;
  flex: 2;
  overflow-y: scroll;
  overflow-x: hidden;
}
.flip-card {
  background-color: transparent;
  width: 100%;
  height: 100px;
  perspective: 1000px;
  transition: 1s;
  margin-bottom: 5px;
  margin-top: 5px;
}
.descriptioncontainer {
  color: white;
  height: 100%;
  overflow-y: auto;
  word-wrap: break-word;
}
.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100px;
  text-align: center;

  transition: height 1s;
  transition: transform 0.6s;
  transform-style: preserve-3d;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  transition-delay: transform 300ms;
  margin-bottom: 120px;
}

.flip-card:hover .flip-card-inner {
  transition: 1s;
  margin-bottom: 120px;
  transform: rotateY(180deg);

  height: 200px;

  transition: 1s;
}
.flip-card:hover {
  margin-bottom: 105px;
}
.flip-card-front,
.flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
  margin-bottom: 120px;
}

.flip-card-front {
  background-color: #1988c9;

  transition: 1s;
  margin-bottom: 120px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.flip-card-back {
  background-color: #2980b9;

  transition: 1s;
  margin-bottom: 120px;
  transform: rotateY(180deg);
  display: flex;
  flex-direction: column;
  grid-gap: 20px;
}
.textinfo {
  margin-top: 50px;
}
.gradecapper {
  background: linear-gradient(180deg, #1d80ab 0%, #31b3ff 100%);
  display: flex;
  height: 70%;
  align-items: flex-end;
  border-radius: 20px 20px 0px 0px;
  width: 100%;
  align-self: baseline;
  box-shadow: 0px 0px 5px 1px rgb(158, 158, 158);
}
.inputsholdernshadow {
  padding-top: 5px;
  box-shadow: 0px -5px 5px -6px rgb(214, 214, 214);
}
.advtrellocard {
  margin-left: auto;
  margin-right: auto;
}
.textareapad {
  padding: 10px;
  border-radius: 20px;
  height: 20px;
  border-radius: 20px;
  width: 90%;
  background: #f3f3f5;
}
.textareapadtitle {
  padding: 10px;
  border-radius: 20px;
  height: 20px;
  width: 20%;
  margin-left: 25px;
  background: #f3f3f5;
}
.advtrelloview {
  height: 100%;
  overflow-y: scroll;
  justify-content: center;
  box-shadow: inset 0px 0px 5px 1px rgb(214, 214, 214);
}

.advtrellotext {
  height: 20px;
  width: 100%;
  resize: none;
  border: none;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
  outline: none;
  background: #f3f3f5;
}
.advtrelloinput:focus {
  border: none;
}
.advtrelloinput:active {
  border: none;
}
.advtrellosendfaker {
  display: flex;
  background: rgb(114, 114, 114);
  width: 75px;
  justify-content: center;
  align-items: center;
  text-align: center;
  border-radius: 50px;
}
.advtrellosend {
  display: flex;
  background: #1988c9;
  color: white;
  width: 75px;
  justify-content: center;
  align-items: center;
  text-align: center;
  border-radius: 50px;
}
.advtrelloinput {
  display: flex;
  width: 90%;
  align-self: center;
  grid-gap: 5px;
  background: #f3f3f5;
  border-radius: 30px;
  padding: 5px;
  margin: 5px;
}
.grade {
  height: 55px;
  display: flex;
  justify-content: flex-end;
  margin-bottom: 20px;
}
.precentage {
  margin-top: -50px;
  margin-left: 20px;
  font-size: 12px;
}
.pointerholder {
  margin-top: -80px;
}
.profileadv {
  margin-left: -69px;
  margin-bottom: 55px !important;
  border-radius: 20px;
  width: 51px;
  height: 51px;
  object-fit: cover;
  image-resolution: 10dpi;
}
.gradecaps {
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: space-between;
  align-items: bottom;
}
.advancedcontent {
  display: flex;
  width: 100%;
  height: 90%;
  grid-gap: 1vw;
  overflow-y: auto;
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
}
.advancedmiddletop {
  background-color: white;
  height: 75%;
  box-shadow: #d1d1d1 0px 0px 5px 1px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 0px 0px 20px 20px;
}
.advancedmiddlebot {
  background: #fffefe;
  height: 20%;
}
.advancedmiddle {
  background-color: rgb(255, 255, 255);
  margin: 5px;
  flex: 5;
  max-width: 50%;
  display: flex;
  grid-gap: 20px;
  flex-direction: column;

  justify-content: space-between;
}
.advancedright {
  flex: 2;

  background-color: white;
  height: 99%;
  box-shadow: #d1d1d1 0px 0px 5px 1px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 0px 0px 20px 20px;
}
.close {
  padding-right: 20px;
  padding-top: 10px;
}
.headercont {
  display: flex;
  justify-content: space-between;
  border-radius: 10px 10px 0px 0px;
  background: #0089d0;
  color: white;
}
#AdvanceForm {
  position: absolute;
  padding-bottom: 15px;
  z-index: 1;
  width: 80%;
  height: 80%;
  background: white;
  border-radius: 11px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
}
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
  -webkit-user-select: text; /* Safari */
  -moz-user-select: text; /* Firefox */
  -ms-user-select: text; /* IE10+/Edge */
  user-select: text;
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
  background: white;
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
  display: flex;
  justify-content: center;
  align-items: center;
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
  width: 100%;
}
.title:hover {
  cursor: pointer;
  text-decoration: underline;
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
  background: rgb(234, 241, 248);
  background-repeat: no-repeat;
  background-size: cover;

  align-items: center;
}
.Grid {
  display: grid;

  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  width: 95%;

  margin-top: -150px;
  margin-left: 2%;
  margin-right: 2.5%;
  grid-gap: 20px;
  justify-items: center !important;
  justify-self: center !important;
  align-self: center !important;
  align-items: center;
}
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&family=Ubuntu:ital@0;1&display=swap");
.Card {
  background: #ffffff;
  border-radius: 15px;
  display: inline-block;
  width: 250px;
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  font-size: 18px;

  padding-bottom: 10px;
  color: #b1abab;
  box-shadow: 0px 5px 10px 1px rgba(85, 85, 85, 0.397);
  transition: 1s;
}
.Card:hover {
  transition: 0.6s;
  transform: scale(1.1);
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
  transition: 0.2s;
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
  transition: 0.2s;
  transform: translateY(-5px);
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
  margin-top: 10px;
  background: rgb(218, 81, 81);
  border-radius: 20px;
  width: 100px;
  height: 20px;
  text-align: center;
  color: white;
  font-size: 15px;
  font-weight: 800;
  padding: 5px;
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
  margin-top: 10px;
  background: rgb(218, 81, 81);
  border-radius: 20px;
  width: 100px;
  height: 20px;
  text-align: center;
  color: white;
  font-size: 15px;
  font-weight: 800;
  padding: 5px;
  cursor: pointer;
}
.skapaknapp {
  background: #1988c9;
  width: 80%;
  cursor: pointer;
  padding: 10px;
  color: white;
  border-radius: 20px;
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
<script src="https://cdn.jsdelivr.net/npm/underscore@1.13.6/underscore-umd-min.js"></script>
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
import Frekvenschart from "../components/Frekvenschart.vue";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
import moment from "moment";

export default {
  components: {
    Postit,
    Workernav,
    RadialProgressBar,
    Minitrello,
    Timer,
    DropdownMenu,
    Frekvenschart,
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
      advancedview: true,
      advancedataholder: [],
      advancetimeholder: [],
      advarr: [],
      advpr: [],
      descdisp: [],
      amountadvdata: [],
      advanceid: 0,
      projectnw: [],
      arkivholder: [],
      rcolor: [
        "#63b598",
        "#ce7d78",
        "#ea9e70",
        "#a48a9e",
        "#c6e1e8",
        "#648177",
        "#0d5ac1",
        "#f205e6",
        "#1c0365",
        "#14a9ad",
        "#4ca2f9",
        "#a4e43f",
        "#d298e2",
        "#6119d0",
        "#d2737d",
        "#c0a43c",
        "#f2510e",
        "#651be6",
        "#79806e",
        "#61da5e",
        "#cd2f00",
        "#9348af",
        "#01ac53",
        "#c5a4fb",
        "#996635",
        "#b11573",
        "#4bb473",
        "#75d89e",
        "#2f3f94",
        "#2f7b99",
        "#da967d",
        "#34891f",
        "#b0d87b",
        "#ca4751",
        "#7e50a8",
        "#c4d647",
        "#e0eeb8",
        "#11dec1",
        "#289812",
        "#566ca0",
        "#ffdbe1",
        "#2f1179",
        "#935b6d",
        "#916988",
        "#513d98",
        "#aead3a",
        "#9e6d71",
        "#4b5bdc",
        "#0cd36d",
        "#250662",
        "#cb5bea",
        "#228916",
        "#ac3e1b",
        "#df514a",
        "#539397",
        "#880977",
        "#f697c1",
        "#ba96ce",
        "#679c9d",
        "#c6c42c",
        "#5d2c52",
        "#48b41b",
        "#e1cf3b",
        "#5be4f0",
        "#57c4d8",
        "#a4d17a",
        "#be608b",
        "#96b00c",
        "#088baf",
        "#f158bf",
        "#e145ba",
        "#ee91e3",
        "#05d371",
        "#5426e0",
        "#4834d0",
        "#802234",
        "#6749e8",
        "#0971f0",
        "#8fb413",
        "#b2b4f0",
        "#c3c89d",
        "#c9a941",
        "#41d158",
        "#fb21a3",
        "#51aed9",
        "#5bb32d",
        "#21538e",
        "#89d534",
        "#d36647",
        "#7fb411",
        "#0023b8",
        "#3b8c2a",
        "#986b53",
        "#f50422",
        "#983f7a",
        "#ea24a3",
        "#79352c",
        "#521250",
        "#c79ed2",
        "#d6dd92",
        "#e33e52",
        "#b2be57",
        "#fa06ec",
        "#1bb699",
        "#6b2e5f",
        "#64820f",
        "#21538e",
        "#89d534",
        "#d36647",
        "#7fb411",
        "#0023b8",
        "#3b8c2a",
        "#986b53",
        "#f50422",
        "#983f7a",
        "#ea24a3",
        "#79352c",
        "#521250",
        "#c79ed2",
        "#d6dd92",
        "#e33e52",
        "#b2be57",
        "#fa06ec",
        "#1bb699",
        "#6b2e5f",
        "#64820f",
        "#9cb64a",
        "#996c48",
        "#9ab9b7",
        "#06e052",
        "#e3a481",
        "#0eb621",
        "#fc458e",
        "#b2db15",
        "#aa226d",
        "#792ed8",
        "#73872a",
        "#520d3a",
        "#cefcb8",
        "#a5b3d9",
        "#7d1d85",
        "#c4fd57",
        "#f1ae16",
        "#8fe22a",
        "#ef6e3c",
        "#243eeb",
        "#dd93fd",
        "#3f8473",
        "#e7dbce",
        "#421f79",
        "#7a3d93",
        "#635f6d",
        "#93f2d7",
        "#9b5c2a",
        "#15b9ee",
        "#0f5997",
        "#409188",
        "#911e20",
        "#1350ce",
        "#10e5b1",
        "#fff4d7",
        "#cb2582",
        "#ce00be",
        "#32d5d6",
        "#608572",
        "#c79bc2",
        "#00f87c",
        "#77772a",
        "#6995ba",
        "#fc6b57",
        "#f07815",
        "#8fd883",
        "#060e27",
        "#96e591",
        "#21d52e",
        "#d00043",
        "#b47162",
        "#1ec227",
        "#4f0f6f",
        "#1d1d58",
        "#947002",
        "#bde052",
        "#e08c56",
        "#28fcfd",
        "#36486a",
        "#d02e29",
        "#1ae6db",
        "#3e464c",
        "#a84a8f",
        "#911e7e",
        "#3f16d9",
        "#0f525f",
        "#ac7c0a",
        "#b4c086",
        "#c9d730",
        "#30cc49",
        "#3d6751",
        "#fb4c03",
        "#640fc1",
        "#62c03e",
        "#d3493a",
        "#88aa0b",
        "#406df9",
        "#615af0",
        "#2a3434",
        "#4a543f",
        "#79bca0",
        "#a8b8d4",
        "#00efd4",
        "#7ad236",
        "#7260d8",
        "#1deaa7",
        "#06f43a",
        "#823c59",
        "#e3d94c",
        "#dc1c06",
        "#f53b2a",
        "#b46238",
        "#2dfff6",
        "#a82b89",
        "#1a8011",
        "#436a9f",
        "#1a806a",
        "#4cf09d",
        "#c188a2",
        "#67eb4b",
        "#b308d3",
        "#fc7e41",
        "#af3101",
        "#71b1f4",
        "#a2f8a5",
        "#e23dd0",
        "#d3486d",
        "#00f7f9",
        "#474893",
        "#3cec35",
        "#1c65cb",
        "#5d1d0c",
        "#2d7d2a",
        "#ff3420",
        "#5cdd87",
        "#a259a4",
        "#e4ac44",
        "#1bede6",
        "#8798a4",
        "#d7790f",
        "#b2c24f",
        "#de73c2",
        "#d70a9c",
        "#88e9b8",
        "#c2b0e2",
        "#86e98f",
        "#ae90e2",
        "#1a806b",
        "#436a9e",
        "#0ec0ff",
        "#f812b3",
        "#b17fc9",
        "#8d6c2f",
        "#d3277a",
        "#2ca1ae",
        "#9685eb",
        "#8a96c6",
        "#dba2e6",
        "#76fc1b",
        "#608fa4",
        "#20f6ba",
        "#07d7f6",
        "#dce77a",
        "#77ecca",
      ],
      selectedproject: "",
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
                      console.log(this.deltagare);
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
                  this.socketInstance.on(
                    "data:received",
                    async (projectdata) => {
                      this.project = projectdata;
                      this.projectplaceholder = projectdata;

                      this.timearray = [];
                      this.array = [];
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
                                  result.projectid ==
                                  this.project[this.forinpw].id
                              )
                            );
                          }
                          this.testarr = [];
                          this.filtredproject = [];
                          if (this.loggedin.Status !== "Admin") {
                            this.mycreated = this.project.filter(
                              (result) => result.Authorid == this.loggedin.id
                            );

                            for (
                              this.findex = 0;
                              this.sparr.length > this.findex;
                              this.findex++
                            ) {
                              this.testarr.push(
                                this.sparr[this.findex].find(
                                  (results) =>
                                    results.workerid == this.loggedin.id
                                )
                              );
                            }

                            this.testarr = this.testarr.filter((element) => {
                              return element !== undefined;
                            });
                            for (
                              this.findex = 0;
                              this.testarr.length > this.findex;
                              this.findex++
                            )
                              this.filtredproject.push(
                                this.project.find(
                                  (result) =>
                                    result.id ==
                                    this.testarr[this.findex].projectid
                                )
                              );
                            this.filtredproject = this.filtredproject.concat(
                              this.mycreated
                            );

                            this.project = this.filtredproject;

                            //     }
                            /*if (this.filterwhereiam == false) {
                      this.project = this.projectplaceholder;
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
                    } */

                            for (
                              this.i = 0;
                              this.i < this.project.length;
                              this.i++
                            ) {
                              this.tu = this.project[this.i].Timeused;
                              this.tb = this.project[this.i].Timebudget;
                              this.timep = Math.round(
                                (this.tu / this.tb) * 100
                              );

                              this.start = new Date(this.project[this.i].Date);
                              this.end = new Date(
                                this.project[this.i].Deadline
                              );
                              this.today = new Date();
                              this.q = Math.abs(this.today - this.start);
                              this.d = Math.abs(this.end - this.start);

                              this.optimal = Math.round(
                                (this.q / this.d) * 100
                              );

                              if (this.project[this.i].Deadline.length < 1) {
                                this.optimal = 0;
                              }
                              if (this.optimal > 100 || this.end < this.today) {
                                this.optimal = 100;
                              }
                              this.timearray.push(this.timep);
                              this.array.push(this.optimal);
                            }
                            this.projectnw = this.project;
                            this.projectnw.sort((a, b) => {
                              let fa = a.Statu.toLowerCase(),
                                fb = b.Statu.toLowerCase();

                              if (fa < fb) {
                                return -1;
                              }
                              if (fa > fb) {
                                return 1;
                              }
                              return 0;
                            });
                            console.log(this.projectnw);
                            this.sparr = [];
                            for (
                              this.forinpw = 0;
                              this.project.length > this.forinpw;
                              this.forinpw++
                            ) {
                              this.sparr.push(
                                this.workersassignd.filter(
                                  (result) =>
                                    result.projectid ==
                                    this.project[this.forinpw].id
                                )
                              );
                            }
                          } else {
                            this.projectnw = this.project;
                          }
                        }
                      );
                    }
                  );
                  this.socketInstance.on("trello:received", (trellodata) => {
                    this.trellodata = trellodata;
                    this.atrello = this.trellodata.filter(
                      (result) => result.fatherid == this.trelloprojectid
                    );
                  });
                }
              });
          });
      });
  },
  filters: {
    moment: function (date) {
      return moment(date).format("L");
    },
  },
  //#1D80AB,#31FFF3 background: linear-gradient(90deg, #1D80AB 0%, #31FFF3 100%);
  watch: {
    see: function () {},
  },
  methods: {
    holdproject(project) {
      this.arkivholder = project;
      console.log(this.arkivholder);
    },
    setforchart(id) {
      this.advanceid = id;
    },
    moment: function () {
      return moment();
    },
    setforchart(advancedata) {
      this.socketInstance.emit("getamountadvanced", advancedata);
      this.socketInstance.on("anothertester", (getamountadvancedrecived) => {
        this.amountadvdata = getamountadvancedrecived;
        this.advancedataholder = advancedata;
        this.advancedview = false;
      });
    },
    getAdvanced(advancedata) {
      this.socketInstance.emit("getadvancedata", advancedata);

      this.socketInstance.on("advancedatarecived", (advancedatarecived) => {
        this.advancetimeholder = advancedatarecived;
        var grouped = {};
        var sumtotal = {};

        for (var i = 0; i < advancedatarecived.length; i++) {
          var p = advancedatarecived[i].Name;
          var s = advancedatarecived[i].Name;
          if (!sumtotal[p]) {
            sumtotal[p] = [];
          }
          if (!grouped[p]) {
            grouped[p] = [];
          }
          grouped[p].push(advancedatarecived[i]);
        }
        let kt = [];
        console.log("CHECKIT G", grouped);
        Object.keys(grouped).forEach(function (key, index) {
          let unique = [
            grouped[key].map((item) => item.Hours + item.Minutes / 60),
          ];
          console.log(unique[0]);
          unique = unique[0].reduce((a, b) => a + b, 0);
          kt.push(Math.round((100 * unique) / advancedata.Timeused));
        });

        console.log(kt);
        this.advpr = kt;
        console.log(this.advpr);
        let ov = [];
        Object.keys(grouped).forEach(function (key, index) {
          if (!ov[index]) {
            ov[index] = [];
          }
          ov[index].push(grouped[key]);
        });
        let pt = [];
        for (var i = 0; i < ov.length; i++) {
          if (!undefined) {
            pt.push(ov[i][0]);
          }
        }

        this.advarr = pt;
        console.log("shitgotcrazy", this.advarr);
      });
      this.socketInstance.emit("getadvancedatatime", advancedata);
      this.socketInstance.on(
        "advancedatatimerecived",
        (advancedattimearecived) => {
          this.descdisp = advancedattimearecived;
        }
      );
    },

    testfilter() {},

    toVictory() {
      sendArkiv();
    },
    sendArkiv() {
      const arkivdata = this.arkivholder;
      console.log("HÄR ÄR DEN FÖFFFAN", arkivdata);
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
    addUser(x, project) {
      console.log(x);
      const addworkerdata = {
        user: x,
        taskid: this.selectedtaskid,
        project: this.selectedproject,
      };
      this.socketInstance.emit("adduserP", addworkerdata);
      setTimeout(() => {
        this.modProject(this.selectedtaskindex, this.selectedtaskid);
      }, 100);
    },
    modProject(x, y, fefan) {
      console.log(x, y, fefan);
      this.selectedproject = fefan;
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
      this.Ttitle = "";
      this.Tdescription = "";
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
