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
        <h1>Lägg till Projekt</h1>
        <form
          id="inputsStyle"
          action="http://localhost:3000/createproject"
          method="POST"
          target="dummyframe"
        >
          <span class="e">
            <span>Projekt namn: </span
            ><input type="text" name="title" id="title" required />
          </span>
          <span class="e">
            <span>Skapare: </span
            ><input type="text" name="author" id="author" required />
          </span>
          <span class="e">
            <span>Arbetare: </span
            ><select name="workers" id="workers">
              <option value="Ljung">Ljung</option>
              <option value="Kvist">Kvist</option>
              <option value="Anders">Anders</option>
              <option value="Philip">Philip</option>
              <option value="Khalid">Khalid</option>
            </select>
          </span>
          <span class="e">
            <span>Datum: </span>
            <input type="date" name="date" id="date" required />
          </span>
          <span>
            <span>Deadline: </span
            ><input type="date" name="deadline" id="deadline" />
          </span>

          <span class="e">
            <span>Avklarat: </span>
            <span
              ><input type="radio" value="JA" name="completed" /><span>JA</span>
              |<input type="radio" checked value="NEJ" name="completed" />
              NEJ</span
            >
          </span>

          <input type="submit" @click="reloadPage" />
        </form>
      </div>
    </transition>

    <div @click="show = !show" id="Addbtn">+</div>
  </div>
</template>
<style scoped>
#Addbtn {
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
export default {
  data() {
    return {
      hej: "",
      show: true,
    };
  },
  methods: {
    reloadPage() {
      window.location.reload();
    },
  },
};
</script>
