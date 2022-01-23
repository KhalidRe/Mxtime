<template>
  <div id="Histor">
    <h1>Arkiv</h1>
    <div>
      <table cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr class="trhead">
            <th>Projekt</th>
            <th>Skapare</th>
            <th>Deltagare</th>
            <th>Datum</th>
            <th>Budget</th>
            <th>Belopp</th>
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
            <td>{{ arkivs.Workers }}</td>
            <td>{{ arkivs.Datum }}</td>
            <td>{{ arkivs.Budget }}(.kr)</td>
            <td>{{ arkivs.Belopp }}(.kr)</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<style scoped>
tr:nth-child(odd) {
  background: rgba(156, 156, 156, 0.411);
}
table {
  width: 100%;
  table-layout: fixed;
}
.tbl-header {
  background-color: rgb(43, 131, 131);
}
.trhead {
  background-color: rgb(43, 131, 131) !important;
}
.tbl-content {
  height: 80%;
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
#Histor {
  width: 100%;
  height: 100vh;
  background: -webkit-linear-gradient(120deg, #497771, #80f2ff);
  display: flex;
  align-items: center;
  flex-direction: column;
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
    };
  },
  created() {
    const requestOptionsget = {
      method: "GET",
      mode: "cors",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    };
    fetch(
      "https://mxserver-simdf.ondigitalocean.app/getarkiv",
      requestOptionsget
    )
      .then((response) => response.json())
      .then((result) => {
        this.arkiv = result;
        console.log(this.arkiv);
      });
  },
};
</script>
