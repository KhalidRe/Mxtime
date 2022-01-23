<template>
  <div id="Addtime">
    <transition name="slide-fade">
      <Addtimeform class="o" v-if="show" />
    </transition>
    <section>
      <h1>Lägg in tid</h1>
      <div class="tbl-header">
        <table cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th>Projekt</th>
              <th>Timmar</th>
              <th>Minuter</th>
              <th>Beskrivning</th>
              <button class="Openoverlay" @click="show = !show">+</button>
            </tr>
          </thead>
        </table>
      </div>
      <div class="tbl-content">
        <table cellpadding="0" cellspacing="0" border="0">
          <tbody>
            <tr class="row" v-for="times in time" :key="times.id">
              <td>{{ times.Title }}</td>
              <td>{{ times.Hours }}</td>
              <td>{{ times.Minutes }}</td>
              <td>{{ times.Description }}</td>
              <td
                style="color: red"
                v-bind:id="times.id"
                @click="Remove(times.id), (R = !R)"
              >
                DELETE
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
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
          action="https://mxserver-simdf.ondigitalocean.app/deletetime"
          target="dummyframe"
          method="POST"
        >
          <p>Är du säker att du vill radera denna tid?</p>
          <input
            type="text"
            name="id"
            id="id"
            :value="this.x"
            style="display: none"
          />
          <button type="button" @click="R = !R">Nej</button>
          <input type="submit" value="JA" @click="reloadPage" />
        </form>
      </div>
    </transition>
  </div>
</template>
<style scoped>
#Deleteform {
  position: absolute;
  z-index: 1;
  top: 25%;
  left: 40%;
  background: rgb(255, 255, 255);
  width: 300px;
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.377);
  border-radius: 10px;
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
.Openoverlay {
  background-color: rgb(79, 165, 79);
  height: 55px;
  width: 55px;
  border-radius: 100%;
  border: none;
  font-size: 50px;
  align-items: center;
  color: white;
  text-align: center;
  line-height: 50px;
}
#Addtime {
  width: 100%;
}

h1 {
  font-size: 30px;
  color: #fff;
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
}

table {
  width: 100%;
  table-layout: fixed;
}
.tbl-header {
  background-color: rgba(255, 255, 255, 0.3);
}

.tbl-content {
  height: 300px;
  overflow-x: auto;
  margin-top: 0px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: inset 0px 0px 10px 1px rgba(0, 0, 0, 0.137);
  background-color: rgba(255, 255, 255, 0.068);
}
th {
  padding: 20px 15px;
  text-align: left;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  text-transform: uppercase;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 300;
  font-size: 12px;
  color: #fff;
  border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}

/* demo styles */

@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,300,700);
body {
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  font-family: "Roboto", sans-serif;
}
section {
}

/* follow me template */
.made-with-love {
  margin-top: 40px;
  padding: 10px;
  clear: left;
  text-align: center;
  font-size: 10px;
  font-family: arial;
  color: #fff;
}
.made-with-love i {
  font-style: normal;
  color: #f50057;
  font-size: 14px;
  position: relative;
  top: 2px;
}
.made-with-love a {
  color: #fff;
  text-decoration: none;
}
.made-with-love a:hover {
  text-decoration: underline;
}

/* for custom scrollbar for webkit browser*/

::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
</style>
<script>
import Addtimeform from "@/components/Addtimeform.vue";
export default {
  components: {
    Addtimeform,
  },
  data() {
    return {
      R: true,
      show: false,
      time: "",
      logged: this.$store.state.someValue,
      x: 0,
    };
  },
  methods: {
    Remove(id) {
      this.z = id - 1;
      this.x = id;
    },
    reloadPage() {
      window.location.reload();
    },
  },
  created() {
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
    fetch("https://mxserver-simdf.ondigitalocean.app/mytime", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.time = result;
      });
  },
};
</script>
