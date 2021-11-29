<template>
  <div id="Home">
    <Postit />
    <div class="Grid">
      <div class="Card" v-for="projects in project" :key="projects.id">
        <div v-bind:id="projects.id" class="edit" @click="test(projects.id)">
          x
        </div>
        <p class="id">{{ projects.id }}</p>
        <p class="title">{{ projects.Title }}</p>
        <p class="Author">{{ projects.Author }}</p>
        <p class="Workers">{{ projects.Workers }}</p>
        <p class="Date">{{ projects.Date }}</p>
        <p class="Deadline">{{ projects.Deadline }}</p>
        <p class="Completed">{{ projects.Completed }}</p>
      </div>
    </div>
  </div>
</template>
<style scoped>
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
      project: "",
      x: "",
      i: 0,
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
    test(id) {
      this.x = id;
      console.log(this.x);
      console.log(this.project[this.x].Title);
    },
  },
};
</script>
