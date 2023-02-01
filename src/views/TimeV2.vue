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
                <input
                  v-model="etime.Hours"
                  @input="handlenumbers()"
                  type="number"
                  min="0"
                  max="15"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1').replace(/^0[^.]/, '0');"
                />
              </div>
              <div>
                <div>Minuter</div>
                <input
                  v-model="etime.Minutes"
                  @input="handlenumbers()"
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
    <div class="noclickzone" v-if="!openoverlay">
      <div class="overlayzone arbetsupgift">
        <div class="editcontent">
          <h2>Skapa arbetsupgift</h2>
          <div class="pad">
            <div>Titel</div>
            <input type="Text" v-model="presetTitle" />
            <br />
            <div class="e">
              <div style="text-align: center">Beskrivning</div>
              <textarea
                v-model="presetDescription"
                name=""
                id=""
                cols="30"
                rows="10"
              ></textarea>
            </div>
            <br />
            <div
              class="submittimes"
              @click="(openoverlay = !openoverlay), createpreset()"
            >
              Lägg till
            </div>
            <div class="avbryt" @click="openoverlay = !openoverlay">Avbryt</div>
          </div>
        </div>
      </div>
    </div>
    <div class="Topcont">
      <div class="datecaps">
        <div class="picked">
          <div class="datetext">{{ picked }}</div>
          <div @click="open = !open" class="dater">
            <svg
              width="24"
              height="24"
              viewBox="0 0 26 26"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M7.3749 0C7.61625 0 7.84771 0.0958747 8.01837 0.266533C8.18903 0.437191 8.2849 0.668653 8.2849 0.91V2.6117H18.057V0.9217C18.057 0.680353 18.1529 0.448891 18.3235 0.278233C18.4942 0.107575 18.7257 0.0117 18.967 0.0117C19.2083 0.0117 19.4398 0.107575 19.6105 0.278233C19.7811 0.448891 19.877 0.680353 19.877 0.9217V2.6117H23.4C24.0893 2.6117 24.7505 2.88545 25.238 3.37276C25.7256 3.86008 25.9997 4.52106 26 5.2104V23.4013C25.9997 24.0906 25.7256 24.7516 25.238 25.2389C24.7505 25.7263 24.0893 26 23.4 26H2.6C1.91066 26 1.24954 25.7263 0.761982 25.2389C0.274425 24.7516 0.000344669 24.0906 0 23.4013L0 5.2104C0.000344669 4.52106 0.274425 3.86008 0.761982 3.37276C1.24954 2.88545 1.91066 2.6117 2.6 2.6117H6.4649V0.9087C6.46524 0.667578 6.56127 0.43645 6.73189 0.266073C6.90251 0.095696 7.13378 -2.46042e-07 7.3749 0ZM1.82 10.0646V23.4013C1.82 23.5037 1.84018 23.6052 1.87937 23.6998C1.91857 23.7944 1.97603 23.8804 2.04846 23.9528C2.12089 24.0253 2.20687 24.0827 2.30151 24.1219C2.39614 24.1611 2.49757 24.1813 2.6 24.1813H23.4C23.5024 24.1813 23.6039 24.1611 23.6985 24.1219C23.7931 24.0827 23.8791 24.0253 23.9515 23.9528C24.024 23.8804 24.0814 23.7944 24.1206 23.6998C24.1598 23.6052 24.18 23.5037 24.18 23.4013V10.0828L1.82 10.0646ZM8.6671 19.0047V21.1705H6.5V19.0047H8.6671ZM14.0829 19.0047V21.1705H11.9171V19.0047H14.0829ZM19.5 19.0047V21.1705H17.3329V19.0047H19.5ZM8.6671 13.8346V16.0004H6.5V13.8346H8.6671ZM14.0829 13.8346V16.0004H11.9171V13.8346H14.0829ZM19.5 13.8346V16.0004H17.3329V13.8346H19.5ZM6.4649 4.4304H2.6C2.49757 4.4304 2.39614 4.45057 2.30151 4.48977C2.20687 4.52897 2.12089 4.58643 2.04846 4.65886C1.97603 4.73129 1.91857 4.81727 1.87937 4.91191C1.84018 5.00654 1.82 5.10797 1.82 5.2104V8.2459L24.18 8.2641V5.2104C24.18 5.10797 24.1598 5.00654 24.1206 4.91191C24.0814 4.81727 24.024 4.73129 23.9515 4.65886C23.8791 4.58643 23.7931 4.52897 23.6985 4.48977C23.6039 4.45057 23.5024 4.4304 23.4 4.4304H19.877V5.6381C19.877 5.87945 19.7811 6.11091 19.6105 6.28157C19.4398 6.45223 19.2083 6.5481 18.967 6.5481C18.7257 6.5481 18.4942 6.45223 18.3235 6.28157C18.1529 6.11091 18.057 5.87945 18.057 5.6381V4.4304H8.2849V5.6264C8.2849 5.86775 8.18903 6.09921 8.01837 6.26987C7.84771 6.44052 7.61625 6.5364 7.3749 6.5364C7.13355 6.5364 6.90209 6.44052 6.73143 6.26987C6.56077 6.09921 6.4649 5.86775 6.4649 5.6264V4.4304Z"
                fill="#767676"
              />
            </svg>
          </div>
          <date-picker
            v-model="picked"
            value-type="format"
            type="Date"
            :open.sync="open"
            placeholder="Select time"
            style="display: none"
            @change="theday(picked)"
          ></date-picker>
        </div>
        <div class="formCont" v-bind:class="{ onForm: picked !== undefined }">
          <div
            class="Forminnershown"
            v-bind:class="{ innerOnShown: picked !== undefined }"
          >
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
                  @input="handlenumbers()"
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
                  @input="handlenumbers()"
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
            <div class="notescont">
              <div class="e">
                <div class="notenb">
                  <span> Notes </span>

                  <span
                    @click="switcher = !switcher"
                    v-show="switcher == false"
                    class="switcher"
                  >
                    <svg
                      width="12"
                      height="10"
                      viewBox="0 0 12 10"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <line
                        y1="1"
                        x2="12"
                        y2="1"
                        stroke="#5F5F5F"
                        stroke-width="2"
                      />
                      <line
                        y1="5"
                        x2="12"
                        y2="5"
                        stroke="#5F5F5F"
                        stroke-width="2"
                      />
                      <line
                        y1="9"
                        x2="12"
                        y2="9"
                        stroke="#5F5F5F"
                        stroke-width="2"
                      />
                    </svg>
                  </span>
                  <span
                    @click="switcher = !switcher"
                    v-show="switcher == true"
                    class="switcher"
                  >
                    <svg
                      width="12"
                      height="13"
                      viewBox="0 0 12 13"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M1.25 13C0.90625 13 0.612083 12.8728 0.3675 12.6184C0.1225 12.3636 0 12.0575 0 11.7V1.3C0 0.9425 0.1225 0.63635 0.3675 0.38155C0.612083 0.127183 0.90625 0 1.25 0H5.73438C5.90104 0 6.06 0.0325001 6.21125 0.0975001C6.36208 0.1625 6.49479 0.254583 6.60937 0.37375L9.64062 3.52625C9.75521 3.64542 9.84375 3.78343 9.90625 3.9403C9.96875 4.0976 10 4.26292 10 4.43625V6.5H8.75V4.55H6.25C6.07292 4.55 5.92458 4.4876 5.805 4.3628C5.685 4.23843 5.625 4.08417 5.625 3.9V1.3H1.25V11.7H5V13H1.25ZM8.9375 8.14125L9.60938 8.84L7.1875 11.3425V12.025H7.84375L10.2656 9.5225L10.9219 10.205L8.42188 12.805C8.35938 12.87 8.28896 12.9187 8.21062 12.9512C8.13271 12.9837 8.05208 13 7.96875 13H6.5625C6.47917 13 6.40625 12.9675 6.34375 12.9025C6.28125 12.8375 6.25 12.7617 6.25 12.675V11.2125C6.25 11.1258 6.26562 11.042 6.29687 10.961C6.32812 10.8795 6.375 10.8062 6.4375 10.7412L8.9375 8.14125ZM10.9219 10.205L8.9375 8.14125L9.84375 7.19875C9.95833 7.07958 10.1042 7.02 10.2813 7.02C10.4583 7.02 10.6042 7.07958 10.7187 7.19875L11.8281 8.3525C11.9427 8.47167 12 8.62333 12 8.8075C12 8.99167 11.9427 9.14333 11.8281 9.2625L10.9219 10.205Z"
                        fill="#5F5F5F"
                      />
                    </svg>
                  </span>
                </div>

                <textarea
                  v-show="switcher == true"
                  v-model="Notes"
                  name=""
                  id=""
                  cols="30"
                  rows="10"
                ></textarea>
                <div v-show="switcher == false" class="presetcont">
                  <div class="presetlistcont">
                    <input
                      type="text"
                      placeholder="sök bland arbeten"
                      v-model="presetfilter"
                    />
                    <div class="presetgrid">
                      <div
                        :title="preset.Beskrivning"
                        class="presetitem"
                        v-bind:class="{
                          imselected: selecteddescription == preset.Beskrivning,
                        }"
                        @click="selecteddescription = preset.Beskrivning"
                        v-for="preset in presetfilterFunction"
                        :key="preset.index"
                      >
                        {{ preset.Titel }}
                        <svg
                          class="delpreset"
                          @click="deletepreset(preset)"
                          width="19"
                          height="20"
                          viewBox="0 0 19 20"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            data-v-4e01b463=""
                            d="M7 16C7.26522 16 7.51957 15.8946 7.70711 15.7071C7.89464 15.5196 8 15.2652 8 15V9C8 8.73478 7.89464 8.48043 7.70711 8.29289C7.51957 8.10536 7.26522 8 7 8C6.73478 8 6.48043 8.10536 6.29289 8.29289C6.10536 8.48043 6 8.73478 6 9V15C6 15.2652 6.10536 15.5196 6.29289 15.7071C6.48043 15.8946 6.73478 16 7 16ZM17 4H13V3C13 2.20435 12.6839 1.44129 12.1213 0.87868C11.5587 0.316071 10.7956 0 10 0H8C7.20435 0 6.44129 0.316071 5.87868 0.87868C5.31607 1.44129 5 2.20435 5 3V4H1C0.734784 4 0.48043 4.10536 0.292893 4.29289C0.105357 4.48043 0 4.73478 0 5C0 5.26522 0.105357 5.51957 0.292893 5.70711C0.48043 5.89464 0.734784 6 1 6H2V17C2 17.7956 2.31607 18.5587 2.87868 19.1213C3.44129 19.6839 4.20435 20 5 20H13C13.7956 20 14.5587 19.6839 15.1213 19.1213C15.6839 18.5587 16 17.7956 16 17V6H17C17.2652 6 17.5196 5.89464 17.7071 5.70711C17.8946 5.51957 18 5.26522 18 5C18 4.73478 17.8946 4.48043 17.7071 4.29289C17.5196 4.10536 17.2652 4 17 4ZM7 3C7 2.73478 7.10536 2.48043 7.29289 2.29289C7.48043 2.10536 7.73478 2 8 2H10C10.2652 2 10.5196 2.10536 10.7071 2.29289C10.8946 2.48043 11 2.73478 11 3V4H7V3ZM14 17C14 17.2652 13.8946 17.5196 13.7071 17.7071C13.5196 17.8946 13.2652 18 13 18H5C4.73478 18 4.48043 17.8946 4.29289 17.7071C4.10536 17.5196 4 17.2652 4 17V6H14V17ZM11 16C11.2652 16 11.5196 15.8946 11.7071 15.7071C11.8946 15.5196 12 15.2652 12 15V9C12 8.73478 11.8946 8.48043 11.7071 8.29289C11.5196 8.10536 11.2652 8 11 8C10.7348 8 10.4804 8.10536 10.2929 8.29289C10.1054 8.48043 10 8.73478 10 9V15C10 15.2652 10.1054 15.5196 10.2929 15.7071C10.4804 15.8946 10.7348 16 11 16Z"
                            fill="#B54848"
                          ></path>
                        </svg>
                      </div>
                      <div class="howtopreset" v-if="presets.length < 1">
                        <div>Du har inga förinställda arbeten</div>
                        <div>
                          Tryck på + nedan för att skapa nya förinställda
                          arbeten
                        </div>
                      </div>

                      <div class="presetempty" v-if="presets.length < 1"></div>
                    </div>
                  </div>
                  <div class="presetadd">
                    <div @click="openoverlay = !openoverlay">+</div>
                  </div>
                </div>
              </div>
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
            <div id="background-wrap"></div>
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
          <div class="urntimecaps" v-for="biden in datetime" :key="biden.index">
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
                deleteTime(biden.id, biden.Minutes, biden.Hours, biden.fatherid)
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
    </div>
  </div>
</template>
<style scoped>
.howtopreset {
  width: 330px;
  height: 100%;
  justify-self: center !important;
  align-self: center !important;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  justify-content: center;
  grid-gap: 20px;
}
.imselected {
  background: rgb(67, 147, 238) !important;
}
.delpreset {
  float: right;
  text-align: left;
  margin-right: 5px;
}
.mx-input {
  display: none !important;
}
.presetadd {
}
.presetadd > div {
  padding: 10px;
  text-align: center;
  width: 17px;
  float: right;

  background: rgb(152, 255, 152);
  box-shadow: 0px 0px 5px 0px black;
  margin: 10px;
  margin-top: -15px;
  border-radius: 50px;
  cursor: pointer;
}
.presetlistcont {
  flex: 5;
  display: flex;
  justify-content: center;
  flex-direction: column;
}
.presetitem {
  justify-content: center;
  align-items: center;
  text-align: center;
  max-width: 100%;
  margin: 10px;
  height: 20px;
  padding-top: 10px;
  padding-bottom: 10px;
  background: rgb(236, 236, 236);
  box-shadow: 0px 0px 5px 0px black;
  border-radius: 20px;
}
.presetitem:hover {
  box-shadow: 0px 0px 5px 0px rgb(71, 175, 207);
  cursor: pointer;
}
.presetcont {
  background: white;
  width: 100%;
  height: 300px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.presetgrid {
  display: flex;
  flex-direction: column;

  max-height: 250px;
  height: 250px;
  overflow-y: auto;
  grid-gap: 10px;
}
.notenb {
  display: flex;
  align-items: center;
  grid-gap: 5px;
  margin-bottom: 5px;
}
.switcher {
  background: rgb(255, 255, 255);
  padding: 10px;
  height: 10px;
  width: 10px;
  border-radius: 55px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  box-shadow: 0px 0px 5px 0px rgb(95, 95, 95);
  cursor: pointer;
}
.notescont > .e {
  width: 100%;
}
.notescont {
  display: flex;
}
.taggercaps {
  background: grey;
  height: 100%;
}
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

/* ANIMATIONS */

/* OBJECTS */

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
.arbetsupgift {
  height: unset !important;
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
}
.innerOnShown {
  opacity: 1;
}
.formCont {
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
  animation: wave 100s linear infinite;
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

  margin-top: 10px;
}
.singDate {
  font-size: 12px;
}

.nextWC {
  display: flex;
  align-items: top;
}
.daycont {
}
.nextW {
  display: flex;
  justify-content: center;
  align-items: center;

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

  height: 50px;
  background-color: #1988c9;
  color: white;
  cursor: pointer;
}
.dater {
  background: rgb(255, 255, 255);
  padding: 5px;
  border-radius: 20px;
  box-shadow: 0px 0px 5px 0px rgb(177, 177, 177);
}
a:focus {
  background-color: rgb(29, 57, 100);
}
.daypick:hover {
  background-color: rgb(29, 57, 100);
}
.datecaps {
  flex: 1;
}
.datetext {
  font-size: 20px;
  color: rgb(95, 95, 95);
}
.picked {
  background: white;
  box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.438);
  width: 200px;
  height: 50px;
  border-radius: 0px 0px 30px 0px;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.datecaps {
  text-align: left;
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
  flex: 1;
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
  .howtopreset {
    width: 230px;
  }
  .daypick {
    font-size: 10px;
  }
  .singDate {
    font-size: 10px;
  }
  .nextW {
    font-size: 10px;
  }
  #Time {
    flex-direction: column;
  }
  .MnW {
    width: 100%;
    justify-content: space-around;
  }
  .Topcont {
    display: block;
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
  .datecaps {
    width: 100% !important;
    display: flex;
    flex-direction: column;
  }
  .formCont {
    width: 95%;
    align-self: center;
  }
  .Forminnershown {
    width: 100%;
  }
}
@media only screen and (max-width: 800px) {
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
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";
export default {
  components: {
    AddtimeN,
    Usermetrics,
    DropdownMenu,
    RadialProgressBar,
    DatePicker,
  },
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
      switcher: false,
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
      open: false,
      edate: "",
      combtime: 0,
      precentage: 100,
      openoverlay: true,
      presetDescription: "",
      presetTitle: "",
      presets: [],
      presetfilter: "",
      selecteddescription: "",
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

        this.socketInstance = io("https://mxtime.se:3000/", {
          transports: ["websocket"],
          pingInterval: 1000 * 60 * 10,
          pingTimeout: 1000 * 60 * 5,
          reconnection: true,
          reconnectionDelay: 1000,
          reconnectionDelayMax: 5000,
          reconnectionAttempts: Infinity,
        });
        var socketInstance = this.socketInstance;
        var loggedin = this.loggedin;
        socketInstance.on("connect", function () {
          console.log("Connected to server");
          socketInstance.emit("loggedinfo", loggedin);
          socketInstance.emit("mytime", loggedin.Username);
          socketInstance.emit("Preset:get", loggedin.id);
        });

        this.socketInstance.on("disconnect", function () {
          console.log("Disconnected from server");
        });

        this.socketInstance.on("ping", function () {});

        this.socketInstance.on("pong", function () {
          console.log("Received pong from server");
        });

        if (this.loggedin.nanoid == undefined) {
          window.location.reload();
        }

        if (this.loggedin.nanoid == undefined) {
          window.location.reload();
        }
        this.socketInstance.on("specificproject", (specificproject) => {
          this.project = specificproject;
        });
        this.socketInstance.on("Preset:recived", (presetrecived) => {
          this.presets = presetrecived;
          console.log(this.presets);
        });
        this.socketInstance.on("mytimedata", (mytimedata) => {
          this.time = mytimedata;
          console.log(this.time);

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
    deletepreset(gotem) {
      const delpreset = gotem;

      this.socketInstance.emit("deletepreset", delpreset);
    },
    createpreset() {
      console.log(this.loggedin.id);
      console.log(this.presetDescription);
      console.log(this.presetTitle);
      const presetdata = {
        presetTitle: this.presetTitle,
        PresetDescription: this.presetDescription,
        id: this.loggedin.id,
      };
      this.socketInstance.emit("createpreset", presetdata);
    },
    openCalendar() {
      this.$refs.dataPicker.showCalendar();
    },
    handlenumbers() {
      if (this.Hours == "") {
        this.Hours = 0;
      }
      if (this.Minutes == "") {
        this.Minutes = 0;
      }
      if (this.etime.Minutes == "") {
        this.etime.Minutes = 0;
      }
      if (this.etime.Hours == "") {
        this.etime.Hours = 0;
      }
    },
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
    theday() {
      this.amountonhours = [];
      this.amountonminutes = [];

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
      if (this.switcher == false) {
        addtimedata.description = this.selecteddescription;
      }
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
    presetfilterFunction() {
      return this.presets.filter((p) => {
        // return true if the product should be visible

        // in this example we just check if the search string
        // is a substring of the product name (case insensitive)
        return (
          p.Titel.toLowerCase().indexOf(this.presetfilter.toLowerCase()) != -1
        );
      });
    },
  },
};
</script>
