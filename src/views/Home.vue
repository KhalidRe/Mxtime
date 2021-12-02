<template>
  <div id="Home">
    <Workernav />
    <div class="Grid">
      <div class="Card" v-for="projects in project" :key="projects.id">
        <div>
          <span
            style="color: blue; float: left"
            v-bind:id="projects.id"
            class="edit"
            @click="Edit(projects.id), (T = !T)"
          >
            edit
          </span>
          <span
            v-bind:id="projects.id"
            @click="Remove(projects.id), (R = !R)"
            style="float: right; color: red"
            >X</span
          >
        </div>
        <p class="title">{{ projects.Title }}</p>
        <p class="Author">{{ projects.Author }}</p>
        <p class="Workers">{{ projects.Workers }}</p>
        <p class="Date">{{ projects.Date }}</p>
        <p class="Deadline">{{ projects.Deadline }}</p>
        <p class="Completed">{{ projects.Completed }}</p>
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
            action="http://localhost:3000/deleteproject"
            target="dummyframe"
            method="POST"
          >
            <p>Är du säker att du vill radera detta project?</p>
            <input
              type="text"
              name="id"
              id="id"
              :value="this.x"
              style="display: none"
            />
            <input
              type="text"
              name="author"
              id="author"
              :value="this.rauthor"
              style="display: none"
            />
            <input
              type="text"
              name="workers"
              id="workers"
              :value="this.rworker"
              style="display: none"
            />
            <input
              type="text"
              name="username"
              id="username"
              :value="this.$store.state.someValue"
              style="display: none"
            />
            <button @click="R = !R">Nej</button>
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
            action="http://localhost:3000/editproject"
            method="POST"
            target="dummyframe"
          >
            <span class="e">
              <span>Projekt namn: </span
              ><input
                type="text"
                name="title"
                id="title"
                :value="this.etitle"
                required
              />
            </span>
            <span>
              <span>Deadline: </span
              ><input
                type="date"
                name="deadline"
                :value="this.edeadline"
                id="deadline"
              />
            </span>
            <input
              type="text"
              name="id"
              id="id"
              :value="this.z"
              style="display: none"
            />
            <span class="e">
              <span>Avklarat: </span>
              <span
                ><input type="radio" value="JA" name="completed" /><span
                  >JA</span
                >
                |<input type="radio" checked value="NEJ" name="completed" />
                NEJ</span
              >
            </span>

            <input type="submit" @click="reloadPage" />
          </form>
        </div>
      </transition>
    </div>
    <Postit />
  </div>
</template>
<style scoped>
#Deleteform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 20vw;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
}
#Home {
  width: 100vw;
  height: 100vh;
  overflow-y: scroll;
  overflow-x: hidden;
}
.Grid {
  display: grid;
  grid-template-columns: auto auto auto auto auto;
  grid-template-rows: auto auto auto auto;
  width: 80vw;
  margin: 30px;
  grid-gap: 20px;
}
.Card {
  background: rgb(224, 224, 252);
  padding: 10px;
  border-radius: 10px;
  box-shadow: 0px 10px 10px 1px rgba(68, 68, 68, 0.37);
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
  width: 20vw;
  height: 50vh;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
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
</style>
<script>
import Postit from "../components/Postit.vue";
import Workernav from "@/components/Workernav.vue";
export default {
  components: { Postit, Workernav },
  data() {
    return {
      T: true,
      R: true,
      project: "",
      x: "",
      i: 0,
      etitle: "",
      eauthor: "",
      edate: "",
      edeadline: "",
      eworkers: "",
      ecompleted: "",
    };
  },
  created() {
    fetch("http://localhost:3000/viewprojects")
      .then((response) => response.json())
      .then((result) => {
        this.project = result;
      });
  },
  methods: {
    Edit(id) {
      this.z = id;
      this.x = id - 1;
      console.log(this.x);

      this.edeadline = this.project[this.x].Deadline;
      this.ecompleted = this.project[this.x].Completed;
      this.eauthor = this.project[this.x].Author;
      console.log(this.eauthor);
    },
    Remove(id) {
      this.z = id - 1;
      this.x = id;
      this.rauthor = this.project[this.z].Author;
      this.rworker = this.project[this.z].Workers;
      console.log(this.rworker);
    },
    reloadPage() {
      window.location.reload();
    },
  },
};
</script>
