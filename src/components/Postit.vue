<template>
  <div id="Postit">
    <iframe
      width="1px"
      height="1px"
      name="dummyframe"
      id="dummyframe"
      style="display: none"
    ></iframe>
    <transition name="slide-fade">
      <div v-if="show" class="noclick">
        <div id="Formen">
          <h1 class="title">Lägg till Projekt</h1>
          <form id="inputsStyle" action="" method="POST" target="dummyframe">
            <span class="e">
              <span>Projekt namn</span
              ><input
                type="text"
                name="title"
                id="title"
                mode="no-cors"
                required
                v-model="title"
                maxlength="18"
              />
            </span>
            <span class="e">
              <input
                type="hidden"
                :value="this.loggedin.Name"
                name="author"
                id="author"
                ref="author"
              />
              <input
                type="hidden"
                id="userid"
                name="userid"
                :value="this.loggedin.id"
                ref="userid"
              />
            </span>
            <span class="e">
              <span>Deltagare</span
              ><select name="workers" id="workers" v-model="workers">
                <option value="Ensam">Eget</option>
                <option v-if="this.loggedin.Name != 'Ljung'" value="Ljung">
                  Ljung
                </option>
                <option v-if="this.loggedin.Name != 'Kvist'" value="Kvist">
                  Kvist
                </option>
                <option v-if="this.loggedin.Name != 'Anders'" value="Anders">
                  Anders
                </option>
                <option v-if="this.loggedin.Name != 'Philip'" value="Philip">
                  Philip
                </option>
                <option v-if="this.loggedin.Name != 'Khalid'" value="Khalid">
                  Khalid
                </option>
              </select>
            </span>
            <div class="dateanddead">
              <span class="e">
                <span>Datum</span>
                <input
                  type="date"
                  name="date"
                  id="date"
                  v-model="date"
                  required
                  onkeydown="return false"
                />
              </span>
              <span class="e">
                <span>Deadline</span
                ><input
                  type="date"
                  name="deadline"
                  id="deadline"
                  v-model="deadline"
                  required
                  onkeydown="return false"
                />
              </span>
            </div>
            <span class="e">
              <span>Avklarat</span>
              <input
                type="range"
                name="precentage"
                id="precentage"
                value="0"
                v-model="precentage"
              />
              <span>{{ this.precentage }}</span>
            </span>

            <input
              type="submit"
              class="skapaknapp"
              v-if="
                this.title.replace(/\s/g, '').length > 0 &&
                this.workers.length > 0 &&
                this.date.length > 0 &&
                this.deadline.length > 0
              "
              @click="createProject(), (show = !show)"
            />
            <input
              v-else
              type="submit"
              class="fakerskapaknapp"
              title="Fyll i alla fält"
              disabled
            />
            <button class="avbryt" type="button" @click="show = !show">
              Avbryt
            </button>
          </form>
        </div>
      </div>
    </transition>

    <div @click="show = !show" id="Addbtn">+</div>
  </div>
</template>
<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&display=swap");
.dateanddead {
  display: flex;
}
.noclick {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
}
.title {
  font-family: Scada;
  font-style: normal;
  font-weight: normal;
  font-size: 36px;
  line-height: 45px;

  color: #4cdb63;
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
.fakerskapaknapp {
  border: none;
  background: linear-gradient(180deg, #aab1ab 0%, #c3cec5 46.88%, #bdc9bf 100%);
  box-shadow: 0px 5px 5px 1px rgba(255, 255, 255, 0.151);
  width: 260px;
  height: 60px;
  border-radius: 25px;
  font-size: 30px;
  font-weight: bold;
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
#Addbtn {
  overflow: hidden;
  position: fixed;
  font-size: 40px;
  font-weight: bolder;
  background-color: chartreuse;
  padding: 25px;
  padding-top: 15px;
  padding-bottom: 15px;
  margin: 0;
  border-radius: 100px;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.39);
  right: 5vw;
  top: 80vh;
  z-index: 0;
}
#Addbtn:active {
  background-color: rgb(6, 143, 36);
  box-shadow: 0px 0px 25px 10px rgba(2, 217, 255, 0.979);
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8  :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"*/ {
  transform: translateY(-100%);
  opacity: 0;
}
#Postit {
}
#Formen {
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
  min-height: 50vh;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
  padding-bottom: 10px;
}
@media only screen and (max-width: 1000px) {
  #Formen {
    left: 20%;
  }
}
#inputsStyle {
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  align-items: center;

  grid-gap: 10px;
  text-align: center;
}
input[type="text"] {
  background-color: rgb(238, 238, 238);
  border: none;
  border-radius: 5px;
  height: 25px;
  box-shadow: inset 0px 0px 1px 1px rgb(15, 130, 196);
  background: linear-gradient(180deg, #129426 0%, #40cf57 46.88%, #129628 100%);
}
select {
  border: none;
  background: linear-gradient(180deg, #6df983 0%, #40cf57 46.88%, #82ed93 100%);
  padding: 10px;
  border-radius: 10px 10px 0px 0px;
  font-weight: bolder;
}
::-webkit-datetime-edit-year-field:not([aria-valuenow]),
::-webkit-datetime-edit-month-field:not([aria-valuenow]),
::-webkit-datetime-edit-day-field:not([aria-valuenow]) {
  color: transparent;
}
input[type="date"] {
  padding: 5px;
  border-radius: 5px;
  border: none;
  box-shadow: 0px 0px 5px 1px black;
  width: 50%;
  background: linear-gradient(180deg, #6df983 0%, #40cf57 46.88%, #82ed93 100%);
}

input[type="range"] {
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
</style>
<script>
import io from "socket.io-client";
export default {
  data() {
    return {
      hej: "",
      show: false,
      loggedin: "",
      precentage: 0,
      logged: this.$store.state.someValue,
      delay: 1000,
      title: "",
      workers: "",
      date: "",
      deadline: "",
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
    fetch("https://mxserver-simdf.ondigitalocean.app/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
      });
    this.socketInstance = io("https://mxserver-simdf.ondigitalocean.app");
  },
  methods: {
    createProject() {
      const postdata = {
        title: this.title.replace(/'/g, ``),
        author: this.$refs.author.value,
        workers: this.workers,
        date: this.date,
        deadline: this.deadline,
        precentage: this.precentage,
        userid: this.$refs.userid.value,
      };

      this.socketInstance.emit("post", postdata);
    },
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
  },
};
</script>
