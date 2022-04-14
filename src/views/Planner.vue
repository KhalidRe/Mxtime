<template>
  <div id="Planner">
    <div class="topnav">
      <div class="logmen">
        <div class="loggo">loggo</div>
        <div class="men">
          <div>Board</div>
          <div>Chart</div>
          <div>Schedule</div>
        </div>
      </div>
      <div><div>members</div></div>
    </div>
    <div class="maincaps">
      <div class="tablemen">
        <div>a</div>
      </div>
      <div class="uppcont">
        <div>b</div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.maincaps {
  display: flex;
  height: 100%;
  background: rgb(167, 164, 164);
}
.tablemen {
  box-shadow: 0px 4px 0px 2px rgb(70, 70, 70);
  width: 300px;
  height: 100%;
  background: rgb(255, 255, 255);
}
.men {
  width: 300px;
  display: flex;
  justify-content: space-evenly;
}
.logmen {
  width: 600px;
  display: flex;
  justify-content: space-between;
}
.topnav {
  background: white;
  padding: 20px;

  display: flex;
  justify-content: space-between;
}
#Planner {
  background: rgb(141, 141, 141);
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
</style>
<script>
export default {
  data() {
    return {};
  },
};
</script>
