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
      <div id="Formen" v-if="!show">
        <h1 style="margin: 0">Lägg till Projekt</h1>
        <form
          id="inputsStyle"
          action="https://mxserver-simdf.ondigitalocean.app/createproject"
          method="POST"
          target="dummyframe"
        >
          <span class="e">
            <span>Projekt namn: </span
            ><input
              type="text"
              name="title"
              id="title"
              mode="no-cors"
              required
            />
          </span>
          <span class="e">
            <input
              type="hidden"
              :value="this.loggedin.Name"
              name="author"
              id="author"
            />
            <input
              type="hidden"
              id="userid"
              name="userid"
              :value="this.loggedin.id"
            />
          </span>
          <span class="e">
            <span>Arbetare: </span
            ><select name="workers" id="workers">
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
              <option value="Ensam">Ensam</option>
            </select>
          </span>
          <span class="e">
            <span>Datum: </span>
            <input type="date" name="date" id="date" required />
          </span>
          <span>
            <span>Deadline: </span
            ><input type="date" name="deadline" id="deadline" required />
          </span>
          <span class="e">
            <span>%Avklarat: </span>
            <input
              type="range"
              name="precentage"
              id="precentage"
              value="0"
              v-model="precentage"
            />
            <span>{{ this.precentage }}</span>
          </span>

          <input type="submit" @click="reloadPage()" />
        </form>
      </div>
    </transition>

    <div @click="show = !show" id="Addbtn">+</div>
  </div>
</template>
<style scoped>
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
  z-index: 3;
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
/* .slide-fade-leave-active below version 2.1.8 */ {
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
      delay: 1000,
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
  },
  methods: {
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
  },
};
</script>
