<template>
  <div class="Charts">
    <Metricschart />

    <div id="aktivP">
      <h1 style="color: white">Aktiva i project</h1>
      <Barchart />
    </div>
  </div>
</template>
<style scoped>
#aktivP {
  background: linear-gradient(#878f8965, #00000054);
}
.Charts {
  width: 100%;

  overflow-y: scroll;
  overflow-x: hidden;

  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
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
