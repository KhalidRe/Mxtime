<template>
  <div class="Charts">
    <div id="aktivP">
      <h1>Aktiva i projekt</h1>
      <Barchart class="barchart" />
    </div>
  </div>
</template>
<style scoped>
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}

.Charts {
  height: 100%;
  width: 100%;
  overflow-y: scroll;
  overflow-x: hidden;

  background: white;

  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
#aktivP {
  height: 100%;
  width: 100%;
  background: linear-gradient(rgb(205, 228, 241), #72cbff);
}
#aktivP > h1 {
  color: #646464;
}
.barchart {
  height: 80%;
}
</style>
<script>
import Metricschart from "../components/Metricschart.vue";
import Barchart from "../components/Barchart.vue";
import Areachart from "../components/Areachart.vue";
export default {
  components: {
    Barchart,
    Areachart,
    Metricschart,
  },
  data() {
    return {
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
    fetch("https://mxtime:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length == 0) {
          location.replace("https://app.mxtime.se/#/");
        }
      });
  },
};
</script>
