<template>
  <div id="Minitrello">
    <div class="trellopopup" v-if="show">
      hej
      <div @click="show = !show">close</div>
    </div>
    <div class="showpopup" @click="show = !show">Open</div>
  </div>
</template>
<style scoped>
#Minitrello {
  margin-top: -180px;
  margin-right: -180px;
  position: absolute;
}
.trellopopup {
  position: absolute;

  background-color: black;
  height: 80vh;
  width: 90vw;
  z-index: 1000;
}
</style>
<script>
export default {
  data() {
    return {
      show: false,
    };
  },
  created() {},
  methods() {},
};
</script>
