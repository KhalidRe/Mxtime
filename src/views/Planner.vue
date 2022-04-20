<template>
  <div id="Planner">
    <div class="planoverlay" v-if="addplan">
      <div class="planformcaps">
        <div class="pads">
          <div class="ovone">
            <h3>New Plan</h3>
            <div class="closeaddplan" @click="addplan = !addplan">close</div>
          </div>

          <input placeholder="Plan Name" type="text" />
        </div>
        <div class="planbtncreate" @click="addplan = !addplan">create plan</div>
      </div>
    </div>
    <div class="topnav">
      <div class="maincaps">
        <div class="minimize">
          <div>close</div>
        </div>
        <hr />
        <div class="planoptions">
          <div class="addplan" @click="addplan = !addplan">
            <div class="optionicon">
              <svg
                width="20"
                height="20"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
                class="svg"
                fill="currentColor"
              >
                <path
                  d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                ></path>
              </svg>
            </div>

            <div class="optiontext">New plan</div>
          </div>
        </div>
        <hr />
        <div class="planoptions">
          <div class="whatis">Plans</div>
          <div class="addplan">
            <div class="optionicon">
              <svg
                width="20"
                height="20"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
                class="svg"
                fill="currentColor"
              >
                <path
                  d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                ></path>
              </svg>
            </div>
            <div class="optiontext">plan name</div>
          </div>
        </div>
      </div>
      <div class="tryit">
        <div class="logmen">
          <div class="loggo">loggo</div>
          <div class="men">
            <div>Board</div>
            <div>Chart</div>
            <div>Schedule</div>
          </div>
          <div>members</div>
        </div>
        <div v-dragscroll class="cardcaps">
          <div class="cardcont">
            <div class="plancards">
              <div class="cardhead">
                <div>Name</div>
                <div>opt</div>
              </div>
              <div class="addtrel">
                <div class="trelicon">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                    class="svg"
                    fill="currentColor"
                  >
                    <path
                      d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                    ></path>
                  </svg>
                </div>
                <div class="treltext">Add task</div>
              </div>
            </div>
            <div class="plancards">
              <div class="cardhead">
                <div>Name</div>
                <div>opt</div>
              </div>
              <div class="addtrel">
                <div class="trelicon">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                    class="svg"
                    fill="currentColor"
                  >
                    <path
                      d="M10 2.5a.5.5 0 00-1 0V9H2.5a.5.5 0 000 1H9v6.5a.5.5 0 001 0V10h6.5a.5.5 0 000-1H10V2.5z"
                    ></path>
                  </svg>
                </div>
                <div class="treltext">Add task</div>
              </div>
            </div>

            <div class="s">addasdasd nasddasdsadew</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.closeaddplan {
  cursor: pointer;
  color: #049c4b;
}
.pads {
  padding: 20px;
}
.planbtncreate {
  width: 100%;
  color: white;
  background: #217346;
  border-radius: 0px 0px 3px 3px;
  height: 60px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}
.planbtncreate:hover {
  cursor: pointer;
  background-color: #1e673f;
}
.planformcaps > .pads > input[type="text"] {
  margin-top: 100px;
  width: 90%;

  border: none;
  border-bottom-style: solid;

  height: 40px;
  line-height: 40px;
  font-size: 28px;
  font-weight: 100;
  font-weight: 400;
  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  border-bottom: 1px solid #217346;
}
.planformcaps > .pads > input[type="text"]:focus {
  outline: none;
}
.ovone h3 {
  margin: 0px;
  padding: 0px;
}
.ovone {
  display: flex;
  justify-content: space-between;
}
.planformcaps {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 600px;
  height: 400px;
  background: white;

  border-radius: 3px;
}
.planoverlay {
  position: absolute;
  left: 0%;
  width: 100%;
  height: 100%;
  top: 0%;
  z-index: 2;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(0, 0, 0, 0.363);
}
.trelicon {
  padding-left: 10px;
  padding-right: 10px;
}
.addtrel {
  margin-top: 20px;
  border-radius: 5px;
  box-shadow: 0px 3px 5px 1px rgba(66, 66, 66, 0.158);
  padding: 8px;
  display: flex;
  color: #217346;
}
.cardhead {
  display: flex;
  justify-content: space-between;
}
.s {
  padding: 20px;
}
.plancards {
  width: 300px;
  height: 400px;
}
.cardcaps {
  white-space: nowrap;
  overflow-x: scroll;
  min-width: 100%;
}
.cardcont {
  padding: 20px;
  display: grid;
  grid-auto-flow: column dense;
  grid-gap: 50px;
}
.uppcont {
  background: rgb(136, 136, 136);
  max-width: 100%;
  height: 100%;
}
.whatis {
  margin-bottom: 20px;
}
.planoptions {
  margin-top: 25px;
  margin-bottom: 25px;
}
.optionicon {
  margin-left: 20px;
  margin-right: 20px;
}
.addplan {
  display: flex;
  background: #049c4b;
}
.minimize {
  align-items: center;
  display: flex;
  padding-left: 20px;
  height: 50px;
}
.tryit {
  width: 100%;
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 80px auto;
}

.maincaps {
  width: 250px;
  background: rgb(255, 255, 255);
  border-right: 1px solid rgb(224, 224, 224);
}
.tablemen {
  width: 250px;

  background: rgb(255, 255, 255);
}
.men {
  width: 300px;
  display: flex;
  justify-content: space-evenly;
}
.logmen {
  display: flex;
  justify-content: space-between;
  padding: 20px;
}
.topnav {
  background: white;
  width: 100%;
  height: 100%;
  display: flex;
}
#Planner {
  font-family: "Segoe UI", "Segoe UI Web (West European)", "Segoe UI",
    -apple-system, BlinkMacSystemFont, Roboto, "Helvetica Neue", sans-serif;
  font-weight: 400;
  background: rgb(141, 141, 141);
  width: 100%;
}
::-webkit-scrollbar {
  width: 5px;
  height: 10px;
}
::-webkit-scrollbar-track {
}
::-webkit-scrollbar-thumb {
  background-color: #c8c6c4;
  border-radius: 20px;
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateY(-100%);
  opacity: 0;
}
</style>
<script>
import { dragscroll } from "vue-dragscroll";
export default {
  directives: {
    dragscroll: dragscroll,
  },
  data() {
    return {
      addplan: false,
      addtask: false,
    };
  },
};
</script>
