<template>
  <div id="Addtimeform">
    <iframe
      width="1px"
      height="1px"
      name="dummyframe"
      id="dummyframe"
      style="display: none"
    ></iframe>

    <div id="Formen">
      <h1 style="margin: 0">Lägg till tid</h1>
      <form
        id="inputsStyle"
        action="http://192.168.1.65:3000/addtime"
        method="POST"
        target="dummyframe"
      >
        <span class="e">
          <input
            type="hidden"
            :value="this.loggedin.Name"
            name="name"
            id="name"
          />
          <input
            type="hidden"
            id="username"
            name="username"
            :value="this.loggedin.Username"
          />
        </span>
        <span class="e">
          <span>Projekt: </span
          ><select name="title" id="title">
            <option value="Egen tid">Egen tid</option>
            <option
              v-for="projects in project"
              :key="projects"
              :value="projects.Title"
            >
              {{ projects.Title }}
            </option>
          </select>
        </span>
        <span class="e">
          <span>Timmar: </span>
          <input
            type="number"
            min="0"
            max="10"
            value="0"
            name="hours"
            id="hours"
          />
        </span>
        <span>
          <span>Minuter: </span
          ><input
            type="number"
            min="0"
            max="60"
            value="0"
            name="minutes"
            id="minutes"
          />
        </span>
        <span class="e">
          <span>Beskrivning: </span>
          <input type="text" name="description" id="description" value=".." />
        </span>

        <input type="submit" @click="reloadPage" />
      </form>
    </div>
  </div>
</template>
<style scoped>
#Formen {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;
  min-height: 50vh;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
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
export default {
  data() {
    return {
      hej: "",
      show: true,
      loggedin: "",
      precentage: 0,
      logged: this.$store.state.someValue,
      project: "",
    };
  },
  created() {
    const requestOptions = {
      method: "POST",
      mode: "cors",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("http://192.168.1.65:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
      });
    fetch("http://192.168.1.65:3000/viewprojects")
      .then((response) => response.json())
      .then((result) => {
        this.project = result;
      });
  },
  methods: {
    reloadPage() {
      window.location.reload();
    },
  },
};
</script>
