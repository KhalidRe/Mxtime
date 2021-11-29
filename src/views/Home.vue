<template>
  <div id="Home">
    <div class="Grid">
      <div class="Card" v-for="projects in project" :key="projects.id">
        <div>
          <span
            style="color: blue; float: left"
            v-bind:id="projects.id"
            class="edit"
            @click="Edit(projects.id)"
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

        <p class="id">{{ projects.id }}</p>
        <p class="title">{{ projects.Title }}</p>
        <p class="Author">{{ projects.Author }}</p>
        <p class="Workers">{{ projects.Workers }}</p>
        <p class="Date">{{ projects.Date }}</p>
        <p class="Deadline">{{ projects.Deadline }}</p>
        <p class="Completed">{{ projects.Completed }}</p>
      </div>
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
          <input type="text" name="id" id="id" :value="this.x" />
          <button @click="R = !R">Nej</button>
          <input type="submit" value="JA" @click="reloadPage" />
        </form>
      </div>
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
  overflow: hidden;
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
</style>
<script>
import Postit from "../components/Postit.vue";
export default {
  components: { Postit },
  data() {
    return {
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
      this.x = id - 1;
      console.log(this.x);
      this.etitle = this.project[this.x].Title;
      this.eworkers = this.project[this.x].Workers;
      this.eauthor = this.project[this.x].Author;
      this.edate = this.project[this.x].Date;
      this.edeadline = this.project[this.x].Deadline;
      this.ecompleted = this.project[this.x].Completed;
      console.log(
        this.etitle,
        this.eworkers,
        this.eauthor,
        this.edate,
        this.edeadline,
        this.ecompleted
      );
    },
    Remove(id) {
      this.x = id;
    },
    reloadPage() {
      window.location.reload();
    },
  },
};
</script>
