<template>
  <div id="Histor">
    <h1 style="color: white">Slutförda Projekt</h1>
    <div>
      <table cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr class="trhead">
            <th>Projekt</th>
            <th>Skapare</th>
            <th>Datum</th>
            <th>Tidsbudget</th>
            <th>Använt tid</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="tbl-content">
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody class="tablebod">
          <tr class="row" v-for="arkivs in arkiv" :key="arkivs.id">
            <td>{{ arkivs.Title }}</td>
            <td>{{ arkivs.Author }}</td>
            <td>{{ arkivs.Datum }}</td>
            <td>{{ arkivs.Budget }}h</td>
            <td
              class="safezone"
              v-if="parseFloat(arkivs.Budget) >= parseFloat(arkivs.Belopp)"
            >
              {{ arkivs.Belopp }}h
            </td>
            <td class="dangerzone" v-else>{{ arkivs.Belopp }}h</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<style scoped>
.overall {
  height: 100%;
}
tbody {
  box-shadow: 0px 0px 5px 5px rgba(0, 0, 0, 0.37);
}
.safezone {
  color: rgb(115, 255, 150);
}
.dangerzone {
  color: rgb(253, 119, 119);
}
h1 {
  background-color: #006aae;
  margin: 0;
  padding: 10px;
}
tr:nth-child(odd) {
  background-color: #0089d0;
}
tr:nth-child(even) {
  background-color: #006aae;
}
table {
  width: 100%;
  table-layout: fixed;
}
.tbl-header {
}

.tbl-content {
  display: flex;
  height: 90%;
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
  background-color: #004e95 !important;
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
#Histor {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
  background-color: #ffffff;
  overflow-x: auto;
}
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
export default {
  data() {
    return {
      arkiv: "",
      logged: this.$store.state.someValue,
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

    fetch("https://mxtime.se:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length == 0) {
          location.replace("https://app.mxtime.se/#/");
        }
        const requestOptions = {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },

          body: JSON.stringify({ user: this.logged }),
        };
        fetch("https://mxtime.se:3000/workernav", requestOptions)
          .then((response) => response.json())
          .then((result) => {
            this.loggedin = result[0];
            const searchnano = {
              method: "POST",

              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },

              body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
            };
            if (result.length > 0) {
              fetch("https://mxtime.se:3000/getarkiv", searchnano)
                .then((response) => response.json())
                .then((result) => {
                  this.arkiv = result;
                });
            }
          });
      });
  },
};
</script>
