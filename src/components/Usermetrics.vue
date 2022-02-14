<template>
  <div class="Usermetrics">
    <h1 class="fokoff">Mina Projekt</h1>
    <div class="tbl-header">
      <table cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr class="trhead">
            <th>Projekt</th>
            <th>Deadline</th>
            <th>Färdigt</th>
            <th>Tid / Använt</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="tbl-content">
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody class="tablebod">
          <tr
            class="Card"
            v-for="(projects, index) in project"
            :key="projects.id"
          >
            <td>{{ projects.Title }}</td>
            <td class="progress optimalC">
              <progress
                class="optimal"
                :value="array[index]"
                min="0"
                max="100"
              ></progress>
            </td>
            <td class="progress currentC">
              <progress
                class="current"
                :value="timearray[index]"
                min="0"
                max="100"
              ></progress>
            </td>
            <td>
              <span class="timebudget">{{ projects.Timebudget }}</span>
              <span class="slash"> / </span>
              <span class="timeused">{{ projects.Timeused }}</span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<style scoped>
.Usermetrics {
  background: #006aae;
  color: white;
  box-shadow: inset 0px 0px 5px 5px rgba(0, 0, 0, 0.185);
}

.fokoff {
  background: black;
  margin: 0px;
  padding: 10px;
  background-color: #1988c9;
}
.slash {
  font-size: 20px;
}
.timebudget {
  color: #ffffff;
  font-size: 15px;
  font-weight: 700;
}
.timeused {
  color: #33ff00;
  font-size: 15px;
  font-weight: 700;
}
.Metricschart {
  overflow-y: scroll;
  max-height: 20px;
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
tr:nth-child(even) {
  background: #0089d0;
}
tr:nth-child(odd) {
  background: #006aae;
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

.Usermetrics .Card:nth-of-type(odd) {
  background: #0089d0;
  color: white;
}
.Usermetrics .Card:nth-of-type(even) {
  background: #006aae;
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
  background-color: #d4d4d4;
  margin: 0;
}
.trhead {
}
.tbl-content {
  height: 300px;
  overflow-x: auto;
  margin-top: 0px;
}
th {
  padding: 20px 15px;
  text-align: left;
  font-weight: 600;
  font-size: 14px;
  color: #fff;
  text-transform: uppercase;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 600;
  font-size: 14px;
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
      logged: this.$store.state.someValue,
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
      timearray: [],
      index: 0,
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
    fetch("188.166.114.141:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length == 0) {
          location.replace("https://flexnet.se/#/");
        }
        if (result.length > 0) {
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
          fetch("188.166.114.141:3000/myprojects", requestOptions)
            .then((response) => response.json())
            .then((result) => {
              this.project = result;
              this.timearray = [];
              this.array = [];
              for (this.i = 0; this.i < this.project.length; this.i++) {
                this.tu = this.project[this.i].Timeused;
                this.tb = this.project[this.i].Timebudget;
                this.timep = Math.round((this.tu / this.tb) * 100);

                this.start = new Date(this.project[this.i].Date);
                this.end = new Date(this.project[this.i].Deadline);
                this.today = new Date();
                this.q = Math.abs(this.today - this.start);
                this.d = Math.abs(this.end - this.start);
                this.optimal = Math.round((this.q / this.d) * 100);

                if (this.project[this.i].Deadline.length < 1) {
                  this.optimal = 0;
                }
                if (this.optimal > 100 || this.end < this.today) {
                  this.optimal = 100;
                }
                this.timearray.push(this.timep);
                this.array.push(this.optimal);
              }
            });
          fetch("188.166.114.141:3000/getusers")
            .then((response) => response.json())
            .then((result) => {
              this.user = result;
            });
        }
      });
  },
};
</script>
