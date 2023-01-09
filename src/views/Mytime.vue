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
    fetch("https://mxtime.se:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length == 0) {
          location.replace("https://app.mxtime.se/#/");
        }
      });
  },
};
</script>
<style scoped>
#Mytime {
}
.va {
  height: 100%;
  margin-bottom: 0px !important;
  overflow-x: hidden !important;
}
</style>
