<template>
  <div id="Connection"><div class="concaps"></div></div>
</template>
<style>
.concaps {
  width: 250px;
  height: 250px;
  border-radius: 25px;
  background: white;
  box-shadow: 0px 0px 5px 0px rgb(122, 122, 122);
}
#Connection {
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  z-index: 999;
  background: rgba(0, 0, 0, 0.185);
}
</style>
<script>
import io from "socket.io-client";
export default {
  data() {
    return {
      hej: "",
      show: true,
      loggedin: "",
      precentage: 0,
      logged: this.$store.state.someValue,
      project: "",
      loggedstatus: "",
    };
  },
  created() {
    const requestOptions = {
      method: "POST",
      mode: "cors",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
      body: JSON.stringify({ user: this.logged }),
    };

    fetch("https://mxtime.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        this.loggedstatus = this.loggedin.Status;
        console.log(this.loggedstatus == "Admin");
        fetch("https://mxtime.se:3000/viewprojects")
          .then((response) => response.json())
          .then((result) => {
            if (this.loggedstatus == "Admin") {
              this.project = result;
            } else {
              this.project = result.filter(
                (result) => result.Authorstatus == this.loggedstatus
              );
            }
          });
      });

    this.socketInstance = io("https://mxtime.se:3000/");
  },

  methods: {
    reloadPage() {
      setTimeout(window.location.reload(), 2000);
    },
    createTime() {
      const timedata = {
        title: this.$refs.title.value,
        name: this.$refs.name.value,
        user: this.$refs.username.value,
        description: this.$refs.description.value,
        timmar: this.$refs.timmar.value,
        minuter: this.$refs.minuter.value,
      };

      this.socketInstance.emit("time", timedata);
    },
  },
};
</script>
