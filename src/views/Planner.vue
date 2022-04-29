<template>
  <div id="Planner">
    <div class="planoverlay" @click="addplan = !addplan" v-if="addplan"></div>
    <div class="planformcaps" v-if="addplan">
      <div class="pads">
        <div class="ovone">
          <h3>New Plan</h3>
          <div class="closeaddplan" @click="addplan = !addplan">close</div>
        </div>

        <input v-model="plantitle" placeholder="Plan Name" type="text" />
      </div>
      <div class="planbtncreate" @click="createPlan(), (addplan = !addplan)">
        create plan
      </div>
    </div>
    <div
      class="planoverlay"
      @click="(plansure = !plansure), (plansurechecked = false)"
      v-if="plansure"
    ></div>
    <div class="planformcapsdelete" v-if="plansure">
      <div class="pads">
        <div class="ovone">
          <h3>Delete plan</h3>
          <div
            class="closeaddplan"
            @click="(plansure = !plansure), (plansurechecked = false)"
          >
            close
          </div>
        </div>

        <div class="suretext">
          You are about to permanently delete this plan and all of its tasks.
        </div>
        <div class="plansurecheckbox">
          <input
            id="surely"
            @click="plansurechecked = !plansurechecked"
            type="checkbox"
          />
          <label class="surely" for="surely"
            >I understand that this plan and all of its tasks will be
            permanently deleted</label
          >
        </div>
      </div>
      <div
        v-if="plansurechecked"
        class="planbtncreate"
        @click="deletePlan(), (plansure = !plansure), (plansurechecked = false)"
      >
        Delete plan
      </div>
      <div v-if="!plansurechecked" class="fakerplanbtncreate">Delete plan</div>
    </div>
    <div class="planoverlay" @click="openMod = !openMod" v-if="openMod"></div>
    <div class="taskformcaps" v-if="openMod">
      <div class="closeformcaps">close</div>
      <div class="taskforminnercaps">
        <div class="modcaps">
          <div class="toptitlemod">
            <h5 class="taskplantitle" v-if="plan.length > 0">
              {{ plan[z].Title }}
            </h5>
            <input
              class="tasktitleinput"
              @change="test(tester)"
              v-model="tester"
              type="text"
            />
          </div>
          <div class="assignstuff">
            <dropdown-menu
              :overlay="false"
              :withDropdownCloser="true"
              :closeOnClickOutside="true"
              class="dropfag"
            >
              <div slot="trigger" class="addtasksetworker">
                <img class="datepickerimg" src="@/assets/addusers.png" alt="" />
                <div>Assign</div>
                <div></div>
              </div>
              <div slot="body">
                <div class="workerlistmod">
                  <div
                    id="Fruits"
                    v-for="deltag in deltagare"
                    :key="deltag.index"
                    class="workchecks"
                    v-if="usersid.includes(deltag.id)"
                  >
                    <div @click="removeUser(deltag.id)" class="itemcont">
                      <div class="imgandtxt">
                        <img
                          class="deltagare va"
                          :src="require(`@/assets/${deltag.Name}.jpg`)"
                          alt=""
                        />
                        {{ deltag.Name }}
                      </div>
                      <div>+</div>
                    </div>
                  </div>
                  <div class="showme">add new</div>
                  <div
                    id="Fruits"
                    v-for="deltag in deltagare"
                    :key="deltag.index"
                    class="workchecks"
                    v-if="!usersid.includes(deltag.id)"
                    @click="addUser(deltag.id)"
                  >
                    <div class="itemcont">
                      <div class="imgandtxt">
                        <img
                          class="deltagare va"
                          :src="require(`@/assets/${deltag.Name}.jpg`)"
                          alt=""
                        />
                        {{ deltag.Name }}
                      </div>
                      <div>+</div>
                    </div>
                  </div>
                </div>
              </div>
            </dropdown-menu>
          </div>
          <div class="proprio">
            <div class="pp">
              <label for="pet-select">progress</label>
              <select name="pets" id="pet-select">
                <option value="">low</option>
                <option value="dog">Dog</option>
                <option value="cat">Cat</option>
              </select>
            </div>
            <div class="pp">
              <label for="pet-select">priority</label>
              <select name="pets" id="pet-select">
                <option value="">low</option>
                <option value="dog">Dog</option>
                <option value="cat">Cat</option>
              </select>
            </div>
          </div>
          <div class="proprio">
            <div class="ppd">
              <date-picker v-model="time2" valueType="format"></date-picker>
              <div>Start date</div>
            </div>
            <div class="ppd">
              <div></div>
              <date-picker v-model="time1" valueType="format"></date-picker>
              <div>Due date</div>
            </div>
          </div>
          <div class="notecaps">
            <div>notes</div>
            <textarea
              v-model="note"
              name="textarea"
              id=""
              cols="30"
              rows="10"
            ></textarea>
          </div>
        </div>
      </div>
    </div>

    <div class="topnav">
      <div class="maincaps">
        <div class="minimize">
          <div>close</div>
        </div>

        <div class="planoptions">
          <div class="addplan" @click="addplan = !addplan">
            <div class="optionicon">
              <svg
                width="20"
                height="20"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
                class="svg"
                fill="currentColor"
              >
                <path
                  d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                ></path>
              </svg>
            </div>

            <div class="optiontext">New plan</div>
          </div>
        </div>

        <div class="planoptions">
          <div class="whatis">Plans</div>
          <div class="planlist">
            <div
              @click="intoplan(plans.id), indexplan(index)"
              class="planselector"
              v-for="(plans, index) in plan"
              :key="plans.id"
              :class="{ active: plans.id == x }"
            >
              <div
                v-bind:style="{
                  backgroundColor: '#' + plans.color,
                }"
                class="planicon"
              >
                {{
                  plans.Title.charAt(0).toUpperCase() +
                  plans.Title.charAt(plans.Title.length - 1).toUpperCase()
                }}
              </div>
              <div class="plantitle">{{ plans.Title }}</div>
            </div>
          </div>
        </div>
      </div>
      <div class="tryit">
        <div class="logmen">
          <div class="logowthredot">
            <div
              v-if="plan.length > 0"
              v-bind:style="{ backgroundColor: '#' + plan[z].color }"
              class="loggo"
            >
              {{
                plan[z].Title.charAt(0).toUpperCase() +
                plan[z].Title.charAt(plan[z].Title.length - 1).toUpperCase()
              }}
            </div>
            <div>
              <div v-if="plan.length > 0">{{ plan[z].Title }}</div>
              <dropdown-menu
                :overlay="false"
                :withDropdownCloser="true"
                :closeOnClickOutside="true"
                class="dropfag"
              >
                <div class="taskthredot" slot="trigger">...</div>
                <div slot="body">
                  <div
                    @click="(logmen = !logmen), (plansure = !plansure)"
                    class="dropdownitemcaps"
                    dropdown-closer
                  >
                    <img
                      dropdown-closer
                      width="19px"
                      height="20px"
                      src="@/assets/trash.png"
                      alt=""
                    />
                    <div dropdown-closer>Delete plan</div>
                  </div>
                </div>
              </dropdown-menu>
            </div>
          </div>

          <div class="men">
            <div>Board</div>
            <div>Chart</div>
            <div>Schedule</div>
          </div>
          <div class="members">
            <span></span>
            <div>
              <img />
            </div>
          </div>
        </div>
        <div v-dragscroll @scroll="taskmenu = false" class="cardcaps">
          <div class="cardcont">
            <div
              v-for="buckets in bucketarray"
              :key="buckets.id"
              class="plancards"
            >
              <div class="cardhead">
                <div>{{ buckets.title }}</div>
                <div>
                  <dropdown-menu
                    @click="logdelbucket(buckets.id)"
                    :overlay="false"
                    :withDropdownCloser="true"
                    :closeOnClickOutside="true"
                    class="dropfag"
                  >
                    <div class="taskthredot" slot="trigger">...</div>
                    <div slot="body">
                      <div
                        @click="deleteBucket(buckets.id), (logdel = null)"
                        class="dropdownitemcaps"
                        dropdown-closer
                      >
                        <img
                          dropdown-closer
                          width="19px"
                          height="20px"
                          src="@/assets/trash.png"
                          alt=""
                        />
                        <div dropdown-closer>Delete bucket</div>
                      </div>
                    </div>
                  </dropdown-menu>
                </div>
                <div
                  @click="logbucket = !logbucket"
                  v-if="logbucket"
                  class="logmenover"
                ></div>
              </div>
              <div
                @click="
                  BucketId(buckets.id),
                    (addworkoverlay = false),
                    (tasktitle = ''),
                    (time1 = ''),
                    (selected = [])
                "
                class="addtrel"
              >
                <div class="trelicon">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                    class="svg"
                    fill="currentColor"
                  >
                    <path
                      d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                    ></path>
                  </svg>
                </div>

                <div class="treltext">Add task</div>
              </div>
              <div class="addtaskcont" v-if="buckets.id == bucketid">
                <div class="addtasktopcont">
                  <label class="circle" for=""></label>
                  <input
                    v-model="tasktitle"
                    minlength="1"
                    maxlength="30"
                    type="text"
                    placeholder="Enter a task name"
                  />
                </div>
                <div class="addtasksetdue">
                  <label for="pickduedate"
                    ><img
                      class="datepickerimg"
                      src="@/assets/datepicker.png"
                      alt=""
                  /></label>
                  <date-picker
                    id="pickduedate"
                    v-model="time1"
                    valueType="format"
                  ></date-picker>
                </div>
                <div
                  @click="addworkoverlay = !addworkoverlay"
                  class="addtasksetworker"
                >
                  <img
                    class="datepickerimg"
                    src="@/assets/addusers.png"
                    alt=""
                  />
                  <div>Assign</div>
                </div>
                <transition name="open-fade">
                  <div class="workerlist" v-show="addworkoverlay">
                    <div
                      id="tblFruits"
                      v-for="deltag in deltagare"
                      :key="deltag.Name"
                      class="workcheck"
                    >
                      <label class="container">
                        <input
                          :id="deltag.Name + deltag.id"
                          class="deltagcheckbox"
                          type="checkbox"
                          :value="deltag.id"
                        />
                        <label :for="deltag.Name + deltag.id" class="checkmark"
                          ><img
                            class="icons"
                            :src="require(`@/assets/${deltag.Name}.jpg`)"
                          />
                          <div>{{ deltag.Name }}</div>
                        </label>
                      </label>
                    </div>
                  </div>
                </transition>
                <div
                  @click="
                    createTask(buckets.id),
                      (addworkoverlay = !addworkoverlay),
                      (bucketid = false)
                  "
                  class="addtaskinnerbtn"
                >
                  <div>Add task</div>
                </div>
              </div>
              <div class="alltaskcont">
                <div
                  v-for="(tasks, index) in task"
                  :key="tasks.id"
                  v-if="
                    (tasks.fatherid == buckets.id && tasks.progress == 0) ||
                    (tasks.fatherid == buckets.id && tasks.progress == 1)
                  "
                >
                  <div
                    class="taskcont"
                    @mouseover="showByIndex2 = tasks.id"
                    @mouseleave="showByIndex2 = null"
                  >
                    <div class="iconntext">
                      <div
                        class="svgc"
                        @mouseover="showByIndex = tasks.id"
                        @mouseleave="showByIndex = null"
                        @click="completeTask(tasks.id)"
                      >
                        <div class="child-one" v-if="showByIndex !== tasks.id">
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                            class="svg"
                            fill="currentColor"
                            focusable="false"
                          >
                            <path
                              d="M10 3a7 7 0 100 14 7 7 0 000-14zm-8 7a8 8 0 1116 0 8 8 0 01-16 0z"
                            ></path>
                          </svg>
                        </div>
                        <div class="child-two" v-if="showByIndex === tasks.id">
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                            class="svg"
                            fill="currentColor"
                            focusable="false"
                          >
                            <path
                              d="M10 2a8 8 0 110 16 8 8 0 010-16zm0 1a7 7 0 100 14 7 7 0 000-14zm3.36 4.65c.17.17.2.44.06.63l-.06.07-4 4a.5.5 0 01-.64.07l-.07-.06-2-2a.5.5 0 01.63-.77l.07.06L9 11.3l3.65-3.65c.2-.2.51-.2.7 0z"
                            ></path>
                          </svg>
                        </div>
                      </div>
                      <div
                        @click="
                          (openMod = !openMod),
                            (tester = tasks.title),
                            (time1 = tasks.enddate),
                            (time2 = tasks.startdate);
                          modTask(index, tasks.id);
                        "
                        class="tti"
                      >
                        {{ tasks.title }}
                      </div>
                    </div>

                    <dropdown-menu
                      :overlay="false"
                      :withDropdownCloser="true"
                      :closeOnClickOutside="true"
                      class="dropfag"
                    >
                      <div class="taskthredot" slot="trigger">...</div>
                      <div slot="body">
                        <div
                          @click="deleteTask(tasks.id)"
                          dropdown-closer
                          class="dropdownitemcaps"
                        >
                          <img
                            dropdown-closer
                            width="19px"
                            height="20px"
                            src="@/assets/trash.png"
                            alt=""
                          />
                          <div dropdown-closer>Delete task</div>
                        </div>
                      </div>
                    </dropdown-menu>
                  </div>
                  <div class="taskinfocont">
                    <div>
                      <div
                        v-if="
                          new Date(tasks.enddate).getTime() <=
                          new Date().getTime()
                        "
                        class="datecaps due"
                      >
                        <div>
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                            class="svg"
                            fill="#FFFFFF"
                            focusable="false"
                          >
                            <path
                              d="M7 11a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm4-5.5A2.5 2.5 0 0014.5 3h-9A2.5 2.5 0 003 5.5v9A2.5 2.5 0 005.5 17h9a2.5 2.5 0 002.5-2.5v-9zM4 7h12v7.5c0 .83-.67 1.5-1.5 1.5h-9A1.5 1.5 0 014 14.5V7zm1.5-3h9c.83 0 1.5.67 1.5 1.5V6H4v-.5C4 4.67 4.67 4 5.5 4z"
                            ></path>
                          </svg>
                        </div>
                        <div>
                          {{
                            new Date(tasks.enddate).getDate() +
                            "/" +
                            (new Date(tasks.enddate).getMonth() + 1)
                          }}
                        </div>
                      </div>
                      <div
                        v-if="
                          new Date(tasks.enddate).getTime() >
                          new Date().getTime()
                        "
                        class="datecaps in"
                      >
                        <div>
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                            class="svg"
                            fill="#5A9675"
                            focusable="false"
                          >
                            <path
                              d="M7 11a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm4-5.5A2.5 2.5 0 0014.5 3h-9A2.5 2.5 0 003 5.5v9A2.5 2.5 0 005.5 17h9a2.5 2.5 0 002.5-2.5v-9zM4 7h12v7.5c0 .83-.67 1.5-1.5 1.5h-9A1.5 1.5 0 014 14.5V7zm1.5-3h9c.83 0 1.5.67 1.5 1.5V6H4v-.5C4 4.67 4.67 4 5.5 4z"
                            ></path>
                          </svg>
                        </div>
                        <div>
                          {{
                            new Date(tasks.enddate).getDate() +
                            "/" +
                            (new Date(tasks.enddate).getMonth() + 1)
                          }}
                        </div>
                      </div>
                    </div>
                    <div>
                      <img
                        v-for="sparrs in sparr[index]"
                        :key="sparrs.index"
                        class="deltagare va"
                        :src="require(`@/assets/${sparrs.Name}.jpg`)"
                        alt=""
                      />
                    </div>
                  </div>
                </div>
                <div
                  v-for="(tasks, index) in task"
                  :key="tasks.id"
                  v-if="tasks.fatherid == buckets.id && tasks.progress == 2"
                >
                  <div>
                    <div
                      class="taskcont completedtask"
                      @mouseover="showByIndex2 = tasks.id"
                      @mouseleave="showByIndex2 = null"
                    >
                      <div class="iconntext">
                        <div
                          class="svgc svgcomplete"
                          @mouseover="showByIndex = tasks.id"
                          @mouseleave="showByIndex = null"
                          @click="completeTask(tasks.id)"
                        >
                          <div
                            class="child-one"
                            v-if="showByIndex !== tasks.id"
                          >
                            <svg
                              width="20"
                              height="20"
                              viewBox="0 0 20 20"
                              xmlns="http://www.w3.org/2000/svg"
                              class="svg"
                              fill="currentColor"
                              focusable="false"
                            >
                              <path
                                d="M10 3a7 7 0 100 14 7 7 0 000-14zm-8 7a8 8 0 1116 0 8 8 0 01-16 0z"
                              ></path>
                            </svg>
                          </div>
                          <div
                            class="child-two"
                            v-if="showByIndex === tasks.id"
                          >
                            <svg
                              width="20"
                              height="20"
                              viewBox="0 0 20 20"
                              xmlns="http://www.w3.org/2000/svg"
                              class="svg"
                              fill="currentColor"
                              focusable="false"
                            >
                              <path
                                d="M10 2a8 8 0 110 16 8 8 0 010-16zm0 1a7 7 0 100 14 7 7 0 000-14zm3.36 4.65c.17.17.2.44.06.63l-.06.07-4 4a.5.5 0 01-.64.07l-.07-.06-2-2a.5.5 0 01.63-.77l.07.06L9 11.3l3.65-3.65c.2-.2.51-.2.7 0z"
                              ></path>
                            </svg>
                          </div>
                        </div>
                        <div
                          @click="
                            (openMod = !openMod),
                              (tester = tasks.title),
                              (time1 = tasks.enddate),
                              (time2 = tasks.startdate);
                            modTask(index, tasks.id);
                          "
                          class="tti tticomplete"
                        >
                          {{ tasks.title }}
                        </div>
                      </div>

                      <dropdown-menu
                        :overlay="false"
                        :withDropdownCloser="true"
                        :closeOnClickOutside="true"
                        class="dropfag"
                      >
                        <div class="taskthredot" slot="trigger">...</div>
                        <div slot="body">
                          <div
                            @click="deleteTask(tasks.id)"
                            dropdown-closer
                            class="dropdownitemcaps"
                          >
                            <img
                              dropdown-closer
                              width="19px"
                              height="20px"
                              src="@/assets/trash.png"
                              alt=""
                            />
                            <div dropdown-closer>Delete task</div>
                          </div>
                        </div>
                      </dropdown-menu>
                    </div>
                    <div class="taskinfocont taskinfocomplete">
                      <div>
                        <div
                          v-if="
                            new Date(tasks.enddate).getTime() <=
                            new Date().getTime()
                          "
                          class="datecaps due"
                        >
                          <div>
                            <svg
                              width="20"
                              height="20"
                              viewBox="0 0 20 20"
                              xmlns="http://www.w3.org/2000/svg"
                              class="svg"
                              fill="#FFFFFF"
                              focusable="false"
                            >
                              <path
                                d="M7 11a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm4-5.5A2.5 2.5 0 0014.5 3h-9A2.5 2.5 0 003 5.5v9A2.5 2.5 0 005.5 17h9a2.5 2.5 0 002.5-2.5v-9zM4 7h12v7.5c0 .83-.67 1.5-1.5 1.5h-9A1.5 1.5 0 014 14.5V7zm1.5-3h9c.83 0 1.5.67 1.5 1.5V6H4v-.5C4 4.67 4.67 4 5.5 4z"
                              ></path>
                            </svg>
                          </div>
                          <div>
                            {{
                              new Date(tasks.enddate).getDate() +
                              "/" +
                              (new Date(tasks.enddate).getMonth() + 1)
                            }}
                          </div>
                        </div>
                        <div
                          v-if="
                            new Date(tasks.enddate).getTime() >
                            new Date().getTime()
                          "
                          class="datecaps in"
                        >
                          <div>
                            <svg
                              width="20"
                              height="20"
                              viewBox="0 0 20 20"
                              xmlns="http://www.w3.org/2000/svg"
                              class="svg"
                              fill="#5A9675"
                              focusable="false"
                            >
                              <path
                                d="M7 11a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm1 2a1 1 0 11-2 0 1 1 0 012 0zm2-2a1 1 0 100-2 1 1 0 000 2zm4-5.5A2.5 2.5 0 0014.5 3h-9A2.5 2.5 0 003 5.5v9A2.5 2.5 0 005.5 17h9a2.5 2.5 0 002.5-2.5v-9zM4 7h12v7.5c0 .83-.67 1.5-1.5 1.5h-9A1.5 1.5 0 014 14.5V7zm1.5-3h9c.83 0 1.5.67 1.5 1.5V6H4v-.5C4 4.67 4.67 4 5.5 4z"
                              ></path>
                            </svg>
                          </div>
                          <div>
                            {{
                              new Date(tasks.enddate).getDate() +
                              "/" +
                              (new Date(tasks.enddate).getMonth() + 1)
                            }}
                          </div>
                        </div>
                      </div>
                      <div>
                        <img
                          v-for="sparrs in sparr[index]"
                          :key="sparrs.index"
                          class="deltagare va"
                          :src="require(`@/assets/${sparrs.Name}.jpg`)"
                          alt=""
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div id="space">
              <div>
                <input
                  v-if="plan.length > 0"
                  v-on:keyup.enter="createBucket()"
                  v-model="buckettitle"
                  type="text"
                  class="s"
                  maxlength="30"
                  minlength="1"
                  required
                  placeholder="Add Bucket"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.taskinfocont {
  margin-bottom: 30px;
}
.taskinfocomplete {
  margin-bottom: 5px !important;
  padding: 0px !important;
}
.taskcont {
}
.completedtask {
  height: 30px;
  background: rgb(189, 218, 189);
  margin-top: 0px !important;
  margin-bottom: px !important;
}
.alltaskcont {
  margin-top: 20px;
}
.due {
  background: #d13438;
  color: white;
  border-radius: 5px;
}
.datecaps {
  display: flex;
  padding: 5px;
  grid-gap: 5px;
}
.svgc {
  padding: 20px;
}
.svgcomplete {
  padding: 0px !important;
  padding-left: 20px !important;
}
.tticomplete {
  height: 100%;
  padding: 0px !important;
}
.tti {
  width: 100%;
  height: 30px;
  padding: 15px;
}
.showme {
  background: #217346;
  width: 100%;
  height: 2px;
}
.imgandtxt {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
  font-size: 20px;
}
.workchecks {
  width: 100%;
}
.itemcont {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px;
}
.workerlistmod {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  overflow-y: scroll;
  background: rgb(255, 255, 255);
  height: 150px;
  border-top: #049c4b solid 1px;
}
.taskinfocont {
  border-top: 1px solid rgba(211, 211, 211, 0.733);
  display: flex;
  justify-content: space-between;
  background: white;
  box-shadow: rgb(0 0 0 / 13%) 0px 3.2px 7.2px 0px,
    rgb(0 0 0 / 11%) 0px 0.6px 1.8px 0px;
  border-radius: 0px 0px 3px 3px;
  padding: 5px;
}
.deltagare {
  width: 30px;
  border-radius: 25px;
  box-shadow: 0px 2px 5px 1px rgba(100, 100, 100, 0.5);
  margin-left: -10px;
}
.notecaps {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}
.notecaps textarea {
  width: 100%;
}
.tasktitleinput:hover {
  border: solid 1px black;
}
.tasktitleinput:focus {
  outline: none;
  border: #0078d4 solid 2px;
  border-radius: 3px;
}
.tasktitleinput {
  font-size: 17px;
  font-weight: 300;
  font-weight: 600;
  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  height: 32px;
  line-height: 32px;
}
.taskplantitle {
  color: rgb(33, 115, 70);
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 4px;
}
.pp > select {
  width: 210px;
  padding: 5px;
}
.ppd {
  display: flex;
  flex-direction: column-reverse;
  align-items: flex-start;
  width: 100%;
}
.pp {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
}
.datep {
}
.proprio {
  display: flex;
  align-items: center;
  width: 100%;
}
.assignstuff {
  display: flex;

  justify-content: flex-start;
  align-items: flex-start;
}
.modcaps {
  padding: 20px;
  display: flex;
  flex-direction: column;

  width: 100%;
  grid-gap: 40px;
}
.toptitlemod {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}
.closeformcaps {
  float: right !important;
}
.taskforminnercaps {
  width: 100%;
  height: 100%;
  display: flex;
}
.taskformcaps {
  position: absolute;

  width: 40vw;
  height: 70%;
  background: white;
  z-index: 3;
  border-radius: 3px;
  padding: 20px;
  left: 35%;
  top: 10%;
}
.dropdownbody {
  box-shadow: 0px 3px 10px 3px rgba(66, 66, 66, 0.158);
}
.dropdownitemcaps {
  display: flex;
  padding: 15px;
  grid-gap: 10px;
}
.dropdownitemcaps:hover {
  background-color: rgb(237, 235, 233);
}
.dropfag {
}
.taskmenu {
}
.taskthredot {
  content: "...";
  display: flex;
  justify-content: center;
  align-items: center;
  align-content: center;
  padding: 2px;
  padding-bottom: 19px;
  margin-right: 5px;
  height: 0px;
  font-size: 26px;
  border-radius: 5px;
}
.taskthredot:hover {
  background-color: #c8c6c4;
}
.members {
  display: flex;
  justify-content: center;
  grid-gap: 20px;
}
.membersicons {
  width: 30px;
  border-radius: 100%;
}

.iconntext {
  display: flex;
  grid-gap: 20px;
  width: 100%;
  text-align: left;
  justify-content: space-around;
  align-items: center;
}
.taskcont {
  display: flex;
  justify-content: space-between;
  align-items: center;

  box-shadow: rgb(0 0 0 / 13%) 0px 3.2px 7.2px 0px,
    rgb(0 0 0 / 11%) 0px 0.6px 1.8px 0px;
  margin-top: 30px;
  cursor: pointer;
}
.taskcont:hover {
  box-shadow: 0px 3px 10px 3px rgba(66, 66, 66, 0.158);
}
#space {
  margin-top: 32px;
  margin-right: 200px;
  width: 500px;
}
.surely {
  cursor: pointer;
}
.surely:hover {
  color: #969696;
}
#tblFruits {
  height: 50px;
  width: 50px;
  margin-top: 10px;
  margin: 10px;
  box-shadow: 0px 5px 10px rgb(0, 0, 0);
  border-radius: 100%;
}
.icons {
  width: 50px;
  border-radius: 100%;
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
.workerlist::-webkit-scrollbar {
  width: 6px;
}
.workerlist::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(81, 182, 250, 0.3);
}
.workerlist::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 0px 5px rgb(84, 161, 224);
}
.Texten {
  font-size: 14px;
}
/* Hide the browser's default checkbox */
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
.workerlist {
  justify-content: center;
  overflow-y: scroll;
  background: rgb(255, 255, 255);
  width: 250px;
  height: 250px;
  display: grid;
  grid-gap: 20px;
  grid-template-columns: auto auto;
  margin-left: 20px;
  margin-bottom: 20px;
}
.workerlist {
  transition: 1s;
}
.addtasktopcont input {
  border: none;
  border-bottom-style: solid;

  font-weight: 400;
  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  border-bottom: 1px solid #217346;
}
.addtasktopcont input:focus {
  outline: none;
}
.datepickerimg {
  width: 20px;
}
.circle {
  width: 15px;
  height: 15px;
  border-radius: 10px;
  border: solid 1px rgb(138, 138, 138);
}
.addtasksetworker {
  margin-left: 20px;
  display: flex;
  grid-gap: 10px;
}
.addtasksetdue {
  margin-left: 20px;
  display: flex;
  grid-gap: 10px;
  justify-content: center;
  align-items: center;
}
.addtasktopcont {
  margin-left: 20px;
  display: flex;
  grid-gap: 10px;
  justify-content: center;
  align-items: center;
}
.addtaskinnerbtn {
  font-weight: 400;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 50px;
  background: #217346;
}
.addtaskcont {
  margin-top: 20px;
  width: 100%;
  min-height: 160px;
  box-shadow: 0px 2px 5px 1px rgba(66, 66, 66, 0.158);
  border-radius: 3px;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  padding-top: 20px;
  align-items: baseline;
}
.plansurecheckbox {
  margin-top: 20px;
}
.planformcapsdelete {
  position: absolute;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 40vw;
  min-height: 250px;
  background: white;
  z-index: 3;
  border-radius: 3px;
  left: 35%;
  top: 20%;
}
.suretext {
  margin-top: 50px;
  font-size: 20px;
}
.logmenover {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
}
.logmenmen {
  position: absolute;
  background: rgb(194, 194, 194);
  padding: 10px;
  cursor: pointer;
}
.logmenmens {
  overflow: visible;

  color: rgb(253, 144, 144);
  cursor: pointer;
}
.logowthredot {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 20px;
}
.thredot {
  font-weight: 900;
  font-size: 20px;
  cursor: pointer;
  color: #454645;
}
.thredot:hover {
  color: #888a88;
}
.loggo {
  height: 50px;
  width: 50px;
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  font-weight: 900;
}
.planselector {
  text-decoration: none;
  color: black;
  display: flex;
  padding-left: 4px;
  grid-gap: 20px;

  align-items: center;
  margin-bottom: 5px;
  margin-top: 5px;
  padding-top: 5px;
  padding-bottom: 5px;
  cursor: pointer;
}
.active {
  background-color: rgb(237, 235, 233);
}
.planicon {
  box-shadow: 0px 0px 5px 1px rgba(160, 160, 160, 0.562);

  font-weight: 900;
  font-size: 10px;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 35px;
  height: 35px;
  border-radius: 3px;
}
.closeaddplan {
  cursor: pointer;
  color: #049c4b;
}
.pads {
  padding: 20px;
}
.fakerplanbtncreate {
  width: 100%;
  color: white;
  background: #969696;
  border-radius: 0px 0px 3px 3px;
  height: 60px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}
.planbtncreate {
  width: 100%;
  color: white;
  background: #217346;
  border-radius: 0px 0px 3px 3px;
  height: 60px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}
.planbtncreate:hover {
  cursor: pointer;
  background-color: #1e673f;
}
.planformcaps > .pads > input[type="text"] {
  margin-top: 100px;
  width: 90%;

  border: none;
  border-bottom-style: solid;

  height: 40px;
  line-height: 40px;
  font-size: 28px;
  font-weight: 100;
  font-weight: 400;
  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  border-bottom: 1px solid #217346;
}
.planformcaps > .pads > input[type="text"]:focus {
  outline: none;
}

.ovone h3 {
  margin: 0px;
  padding: 0px;
}
.ovone {
  display: flex;
  justify-content: space-between;
}
.planformcaps {
  position: absolute;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 40vw;
  height: 400px;
  background: white;
  z-index: 3;
  border-radius: 3px;
  left: 35%;
  top: 20%;
}
.planoverlay {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(0, 0, 0, 0.363);
}
.trelicon {
  padding-left: 10px;
  padding-right: 10px;
}
.addtrel {
  cursor: pointer;
  margin-top: 20px;
  border-radius: 5px;
  box-shadow: rgb(0 0 0 / 13%) 0px 3.2px 7.2px 0px,
    rgb(0 0 0 / 11%) 0px 0.6px 1.8px 0px;
  padding: 8px;
  display: flex;
  color: #217346;
}
.addtrel:hover {
  box-shadow: 0px 3px 10px 3px rgba(66, 66, 66, 0.158);
}
.cardhead {
  font-weight: 600;
  display: flex;
  margin-top: 200px;
  margin: 0;
  justify-content: space-between;
  align-items: center;
  width: 98%;
}
.cardhead:hover .thredots {
  display: block;
}
.thredots {
  display: none;
  font-weight: 900;
}

select {
  font-size: 0.9rem;
  padding: 2px 5px;
}

footer {
  font-size: 0.8rem;
  position: absolute;
  bottom: 30px;
  left: 30px;
}

.output {
  background: center/cover no-repeat url("/media/cc0-images/hamster.jpg");
  position: relative;
}

.s {
  height: 30px;

  width: 100px;
  margin-top: 20px;
}
.plancards {
  margin-top: 10px;
  width: 300px;
  height: 400px;
}
.cardcaps {
  white-space: nowrap;
  overflow: auto;

  min-width: 100%;
}
.cardcont {
  padding-left: 20px;
  padding-right: 20px;
  display: grid;
  grid-auto-flow: column dense;
  grid-gap: 50px;
}
.uppcont {
  background: rgb(136, 136, 136);
  max-width: 100%;
  height: 100%;
}
.whatis {
  margin-bottom: 20px;
}
.planlist {
  height: 74vh;
  overflow-y: auto;
}
.planoptions {
  margin-top: 25px;
  margin-bottom: 25px;
}
.addplan:hover {
  background-color: #c8c6c4;
}
.optionicon {
  margin-left: 15px;
  margin-right: 15px;
}
.addplan {
  display: flex;
  padding-top: 20px;
  padding-bottom: 20px;
}
.minimize {
  align-items: center;
  display: flex;
  padding-left: 20px;
  height: 50px;
  border-bottom: solid 1px rgba(133, 133, 133, 0.171);
}
.tryit {
  width: 100%;
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 80px auto;
}

.maincaps {
  width: 250px;
  background: rgb(255, 255, 255);
  border-right: 1px solid rgb(224, 224, 224);
}
.tablemen {
  width: 250px;

  background: rgb(255, 255, 255);
}
.men {
  width: 300px;
  display: flex;
  justify-content: space-evenly;
}
.logmen {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
}
.topnav {
  background: white;
  width: 100%;
  height: 100%;
  display: flex;
}
#Planner {
  font-family: "Segoe UI", "Segoe UI Web (West European)", "Segoe UI",
    -apple-system, BlinkMacSystemFont, Roboto, "Helvetica Neue", sans-serif;
  font-weight: 400;
  background: rgb(141, 141, 141);
  width: 100%;
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
  height: 100%;
}
::-webkit-scrollbar {
  width: 5px;
  height: 10px;
}
::-webkit-scrollbar-track {
}
::-webkit-scrollbar-thumb {
  background-color: #c8c6c4;
  border-radius: 20px;
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
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";
import io from "socket.io-client";
import $ from "jquery";
import { dragscroll } from "vue-dragscroll";
import DropdownMenu from "v-dropdown-menu";
import "v-dropdown-menu/dist/v-dropdown-menu.css";
export default {
  components: { DatePicker, DropdownMenu },
  directives: {
    dragscroll: dragscroll,
  },
  data() {
    return {
      logged: this.$store.state.someValue,
      addplan: false,
      addtask: false,
      plan: [],
      i: 0,
      plantitle: "",
      x: 0,
      bucket: [],
      buckettitle: "",
      z: 0,
      logmen: false,
      plansure: false,
      plansurechecked: false,
      bucketarray: [],
      openaddtask: false,
      bucketid: null,
      time1: null,
      addworkoverlay: false,
      deltagare: [],
      user: [],
      deletebucket: null,
      logbucket: false,
      delbucketov: false,
      logdel: null,
      showByIndex: null,
      task: [],
      taskarray: [],
      selected: [],
      tasktitle: "",
      showByIndex2: null,
      openMod: false,
      taskmenu: false,
      show: false,
      time3: null,
      time4: null,
      tester: "",
      selectedtaskid: null,
      selectedtaskindex: null,
      workersassignd: [],
      sparr: [],
      forinpw: 0,
      note: "",
      lol: 0,
      usersid: [],
      anit: 0,
      selectedusers: [],
      anits: 0,
      showcompleted: false,
      showcompletedrow: null,
      countershown: null,
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
    fetch("https://flexn.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];

        fetch("https://flexn.se:3000/getusers")
          .then((response) => response.json())
          .then((result) => {
            this.user = result;
            this.deltagare = this.user;
          });
      });

    this.socketInstance = io("https://flexn.se:3000/");

    this.socketInstance.on("planner:received", (plannerarr) => {
      if (plannerarr.length > 0) {
        this.plan = plannerarr;
        this.x = this.plan[0].id;
      } else {
        this.plan = [];
      }
    });
    this.socketInstance.on("bucket:received", (bucketarr) => {
      this.bucket = bucketarr;
      this.bucketarray = this.bucket.filter(
        (result) => result.fatherid == this.x
      );
    });
    this.socketInstance.on("task:received", (taskarr) => {
      this.task = taskarr;
      this.workersassignd = [];
      this.sparr = [];
      this.forinpw = 0;
    });

    this.socketInstance.on("worker:received", (workerarr) => {
      this.workersassignd = [];
      this.workersassignd = workerarr;
      this.sparr = [];
      this.forinpw = 0;

      for (this.forinpw = 0; this.task.length > this.forinpw; this.forinpw++) {
        this.sparr.push(
          this.workersassignd.filter(
            (result) => result.taskid == this.task[this.forinpw].id
          )
        );
      }
    });
  },
  methods: {
    createPlan() {
      const plandata = {
        plantitle: this.plantitle.replace(/'/g, ``),
        plancolor: Math.floor(Math.random() * 16777215).toString(16),
      };

      this.socketInstance.emit("planner", plandata);
    },
    deletePlan() {
      const deleteplandata = {
        id: this.x,
      };

      this.socketInstance.emit("deleteplanner", deleteplandata);
    },
    showCompleted(x) {
      this.showcompletedrow = x;
      console.log(this.showcompletedrow);
    },
    logdelbucket(id) {
      if (this.logdel == null) {
        this.logdel = id;
      } else {
        this.logdel = null;
      }
    },
    test(o) {
      this.selected = [];
      var chks = document.getElementsByClassName("deltagcheckbox");
      console.log(chks);
      for (var i = 0; i < chks.length; i++) {
        if (chks[i].checked) {
          this.selected.push(parseInt(chks[i].value));
        }
      }
      console.log(this.selected);
      console.log(this.tester);
      console.log(this.time1);
      console.log(this.time2);
    },
    createBucket() {
      const bucketdata = {
        buckettitle: this.buckettitle.replace(/'/g, ``),
        bucketfatherid: this.x,
      };
      if (this.buckettitle.length > 0) {
        this.socketInstance.emit("bucket", bucketdata);
        this.buckettitle = "";
      }
    },
    deleteBucket(ff) {
      const deletebucketdata = {
        id: ff,
      };
      this.socketInstance.emit("deletebucket", deletebucketdata);
    },
    BucketId(id) {
      if (this.bucketid == null) {
        this.bucketid = id;
      } else {
        this.bucketid = null;
      }
      console.log(this.bucketid);
    },
    removeUser(x) {
      const removeworkerdata = {
        id: x,
        taskid: this.selectedtaskid,
      };
      this.socketInstance.emit("removeuser", removeworkerdata);
      setTimeout(() => {
        this.modTask(this.selectedtaskindex, this.selectedtaskid);
      }, 100);
    },
    addUser(x) {
      const addworkerdata = {
        id: x,
        taskid: this.selectedtaskid,
      };
      this.socketInstance.emit("adduser", addworkerdata);
      setTimeout(() => {
        this.modTask(this.selectedtaskindex, this.selectedtaskid);
      }, 100);
    },
    modTask(x, y) {
      this.selectedtaskid = y;
      this.selectedtaskindex = x;
      this.selectedusers = [];
      this.usersid = [];
      this.anit = 0;
      for (this.anit = 0; this.sparr[x].length > this.anit; this.anit++) {
        this.selectedusers.push(
          this.deltagare.filter(
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

    createTask(id) {
      this.selected = [];
      this.addworkoverlay = false;
      var chks = document.getElementsByClassName("deltagcheckbox");
      console.log(chks);
      for (var i = 0; i < chks.length; i++) {
        if (chks[i].checked) {
          this.selected.push(parseInt(chks[i].value));
        }
      }

      const taskdata = {
        taskfatherid: id,
        enddate: this.time1,
        authorid: this.loggedin.id,
        tasktitle: this.tasktitle,
        deltag: this.selected,
      };
      this.socketInstance.emit("task", taskdata);
    },
    completeTask(x) {
      const completetaskdata = {
        id: x,
      };
      this.socketInstance.emit("completetask", completetaskdata);
    },
    deleteTask(id) {
      const deletetaskdata = {
        id: id,
      };
      this.socketInstance.emit("deletetask", deletetaskdata);
    },
    intoplan(id) {
      this.x = id;
      console.log(this.x);
      this.bucketarray = this.bucket.filter(
        (result) => result.fatherid == this.x
      );
    },
    indexplan(index) {
      this.z = index;
    },
  },
};
</script>
