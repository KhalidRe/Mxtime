<template>
  <div class="Metricschart">
    <h1>Pågående Projekt</h1>
    <div class="tbl-header">
      <table cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <th>Projekt</th>
            <th>Deadline</th>
            <th>Färdigt</th>
            <th>Deltagare</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="tbl-content">
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody>
          <tr v-for="projects in project" :key="projects.id">
            <td>{{ projects.Title }}</td>
            <td class="progress optimalC">
              <progress
                class="optimal"
                :value="array[projects.id - 1]"
                min="0"
                max="100"
              ></progress>
            </td>
            <td class="progress currentC">
              <progress
                class="current"
                :value="timearray[projects.id - 1]"
                min="0"
                max="100"
              ></progress>
            </td>
            <td>{{ projects.Author }}, {{ projects.Workers }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<style scoped>
.Metricschart {
  overflow-y: scroll;
  max-height: 250px;
}

progress {
  animation: progress 3s linear infinite alternate;
  -webkit-animation: progress 3s linear infinite alternate;
}
progress[value] {
  width: 250px;
  height: 10px;
  -webkit-appearance: none;
  box-shadow: 0px 0px 5px 1px rgba(255, 255, 255, 0.377);

  appearance: none;
}

progress[value]::-webkit-progress-bar {
  background-color: #eee;
  border-radius: 2px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.25) inset;
}
.currentC progress[value]::-webkit-progress-value {
  background-image: -webkit-linear-gradient(
      -45deg,
      transparent 33%,
      rgba(0, 0, 0, 0.1) 33%,
      rgba(0, 0, 0, 0.1) 66%,
      transparent 66%
    ),
    -webkit-linear-gradient(top, rgba(255, 255, 255, 0.25), rgba(0, 0, 0, 0.25)),
    -webkit-linear-gradient(left, #09c, rgb(74, 255, 68));

  border-radius: 2px;
  background-size: 35px 20px, 100% 100%, 100% 100%;
}
.optimalC progress[value]::-webkit-progress-value {
  background-image: -webkit-linear-gradient(
      -45deg,
      transparent 33%,
      rgba(0, 0, 0, 0.1) 33%,
      rgba(0, 0, 0, 0.1) 66%,
      transparent 66%
    ),
    -webkit-linear-gradient(top, rgba(255, 255, 255, 0.25), rgba(0, 0, 0, 0.25)),
    -webkit-linear-gradient(left, rgb(66, 9, 9), rgb(255, 0, 0));

  border-radius: 2px;
  background-size: 35px 20px, 100% 100%, 100% 100%;
}

.Metricschart .Card:nth-of-type(odd) {
  background-color: rgb(17, 65, 57);
  box-shadow: inset 0px 0px 1px 1px white;
  color: white;
}
.Metricschart .Card:nth-of-type(even) {
  box-shadow: inset 0px 0px 1px 1px rgb(0, 0, 0);
}
.Card {
}
.current {
  height: 25px;
  width: 30vw;
}
.optimal {
  height: 25px;
  width: 30vw;
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

section {
  margin: 50px;
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
@media only screen and (max-width: 1000px) {
  progress {
  }
  progress[value] {
    width: 100%;
  }

  progress[value]::-webkit-progress-bar {
  }
  .currentC progress[value]::-webkit-progress-value {
  }
  .optimalC progress[value]::-webkit-progress-value {
  }
}
</style>
<script>
export default {
  data() {
    return {
      projects: "",
      project: "",
      obj: {},
      start: 0,
      end: 0,
      today: "",
      array: [],
      i: 0,
      q: 0,
      d: 0,
      optimal: 0,
      logged: this.$store.state.someValue,
      timearray: [],
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
    fetch("https://mxserver-simdf.ondigitalocean.app/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        console.log(result);
        if (result.length == 0) {
          location.replace("https://flexnet.se/#/");
        }
        if (result.length > 0) {
          fetch("https://mxserver-simdf.ondigitalocean.app/viewprojects")
            .then((response) => response.json())
            .then((result) => {
              this.project = result;

              this.timearray = [];
              this.array = [];
              for (this.i = 0; this.i < this.project.length; this.i++) {
                this.tu = this.project[this.i].Timeused;
                this.tb = this.project[this.i].Timebudget;
                this.timep = Math.round((this.tu / this.tb) * 100);
                console.log(this.timep, "hej");
                this.start = new Date(this.project[this.i].Date);
                this.end = new Date(this.project[this.i].Deadline);
                this.today = new Date();
                this.q = Math.abs(this.today - this.start);
                this.d = Math.abs(this.end - this.start);
                this.optimal = Math.round((this.q / this.d) * 100);
                console.log(this.project);
                if (this.project[this.i].Deadline.length < 1) {
                  this.optimal = 0;
                }
                if (this.optimal > 100 || this.end < this.today) {
                  this.optimal = 100;
                }
                this.timearray.push(this.timep);
                this.array.push(this.optimal);
                console.log(this.array);
              }
            });
          fetch("https://mxserver-simdf.ondigitalocean.app/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.user = result;
            });
        }
      });
  },
};
</script>
