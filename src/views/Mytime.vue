<template>
  <div id="Mytime">
    <ViewtimeV2 class="va" />
    <Viewtime class="va" />
  </div>
</template>
<script>
import ViewtimeV2 from "../components/ViewtimeV2.vue";
import Viewtime from "../components/Viewtime.vue";
export default {
  components: { ViewtimeV2, Viewtime },
};
</script>
<style scoped>
#Mytime {
}
.va {
  height: 100%;
  margin-bottom: 0px !important;
}
</style>
