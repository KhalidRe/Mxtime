<template>
  <div id="Time">
    <Usermetrics />
    <AddtimeN />
  </div>
</template>
<style scoped>
#Time {
  overflow-y: scroll;
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0px 10px 6px rgba(27, 247, 255, 0.993);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0px 6px rgb(0, 0, 0);
}
</style>
</style>
<script>
import AddtimeN from "../components/AddtimeN.vue";
import Usermetrics from "../components/Usermetrics.vue";
export default {
  components: { AddtimeN, Usermetrics },
};
</script>
