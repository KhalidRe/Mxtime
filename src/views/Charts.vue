<template>
  <div class="Charts">
    <Metricschart />

    <div id="aktivP">
      <h1 style="color: white">Aktiva i project</h1>
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
  overflow-y: scroll;
  overflow-x: hidden;

  background: -webkit-linear-gradient(120deg, #497771, #80f2ff);

  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
#aktivP {
  height: 100%;
  background: linear-gradient(#878f8965, #00000054);
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
    return {};
  },
};
</script>
