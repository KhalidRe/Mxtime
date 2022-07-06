<template>
  <div id="Workernav">
    <div v-show="openoverlay" class="changeprofileoverlay">
      <div class="overlay">
        <h2 class="header">Byt profilbild</h2>
        <div class="flexit">
          <label class="lab" for="siofu_input">
            <img
              class="Cprofile"
              ref="profilepreview"
              :src="`https://flexn.se/mxprofile/${profileimage}.jpg`"
              alt=""
            />
          </label>
          <div class="pwup">
            <div class="inputWrapper">
              <label class="lab" for="siofu_input">Välj fil</label>
              <input
                class="previewbtn"
                id="siofu_input"
                type="file"
                ref="files"
                accept="image/png, image/gif, image/jpeg"
                min="1"
                max="1"
                max-file-size="10240000"
                @change="preview()"
              />
            </div>

            <button
              class="uploadbtn"
              @click="upload()"
              v-if="previewprimed.length > 0"
            >
              Spara
            </button>
            <button class="uploadbtn faker" v-if="previewprimed.length == 0">
              Spara
            </button>
          </div>
          <button class="close" @click="openoverlay = !openoverlay">
            Stäng
          </button>
        </div>
      </div>
    </div>
    <div class="e aktiv">
      <span>Aktiv</span>
      <span class="st A">{{ Aktiv.length }}</span>
    </div>
    <div class="e waiting">
      <span>Väntande</span>
      <span class="st B">{{ Waiting.length }}</span>
    </div>
    <div class="e paused">
      <span>Pausade</span>
      <span class="st C">{{ Pausad.length }}</span>
    </div>
    <div class="profname">
      <span>{{ loggedin.Name }}</span>
      <img
        @click="openoverlay = !openoverlay"
        class="profile"
        ref="profile"
        :src="`https://flexn.se/mxprofile/${profileimage}.jpg`"
        alt=""
      />
    </div>
  </div>
</template>
<style scoped>
.profile {
  cursor: pointer;
}
.lab {
  cursor: pointer;
}
.close {
  border: none;
  width: 50%;
  align-self: center;
  padding: 10px;
  border-radius: 10px;
  font-size: 20px;
  background: #2b91cc;
  color: white;
  font-weight: 600;
  cursor: pointer;
}
.close:hover {
  background: #1988c9;
}
.flexit {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 80%;
}
.inputWrapper {
  cursor: pointer;
  padding: 10px;
  height: 20px;
  width: 50px;
  overflow: hidden;

  cursor: pointer;
  /*Using a background color, but you can use a background image to represent a button*/
  background-color: #ddf;
  color: black;
}
.previewbtn {
  cursor: pointer;

  /*This makes the button huge. If you want a bigger button, increase the font size*/
  font-size: 50px;
  /*Opacity settings for all browsers*/
  opacity: 0;
  -moz-opacity: 0;
  filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
}

.pwup {
  visibility: hidden;
  display: flex;
  justify-content: space-around;
}
.Cprofile {
  margin: 20px;
  width: 100px;

  height: 100px !important;
  object-fit: cover !important;
  border-radius: 100px;
}
.header {
  margin: 0px;
  padding-top: 10px;
  padding-bottom: 10px;
  border-radius: 20px 20px 0px 0px;
  background: #1988c9;
}
.changeprofileoverlay {
  position: absolute;
  z-index: 100;
  width: 100%;
  height: 100%;
  left: 0%;
  top: 0%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.overlay {
  position: absolute;
  top: 10%;
  background: white;
  width: 300px;
  height: 400px;
  box-shadow: 0px 2px 5px 1px rgba(0, 0, 0, 0.623);
  border-radius: 20px;
  display: flex;
  flex-direction: column;
}
.st {
  box-shadow: inset 0px 0px 5px 5px rgba(255, 255, 255, 0.212);
  border-radius: 25px;
  width: 40px;
  text-align: center;
}

.e {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 20px;
}
* {
  -webkit-user-select: none; /* Safari */
  -moz-user-select: none; /* Firefox */
  -ms-user-select: none; /* IE10+/Edge */
  user-select: none; /* Standard */
}
/*

.aktiv {
  color: rgb(193, 255, 193);
}
.waiting {
  color: rgb(244, 252, 142);
}
.paused {
  color: rgb(255, 102, 102);
}
*/
@import url("https://fonts.googleapis.com/css2?family=Scada&family=Sen:wght@700&family=Ubuntu:ital@0;1&display=swap");
#Workernav {
  width: 100%;
  background: #1988c9;
  color: white;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  grid-gap: 10vh;
  height: 60px;
  font-family: "Scada", sans-serif;
  font-family: "Sen", sans-serif;
  font-family: "Ubuntu", sans-serif;
  font-weight: bolder;
  box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
  font-size: 17px;
}
.profile {
  width: 50px;
  height: 50px;
  border-radius: 25px;
  object-fit: cover !important;
}
.profname {
  display: flex;
  justify-content: center;
  align-items: center;
  grid-gap: 10px;
  font-weight: bolder;
}
@media only screen and (max-width: 1000px) {
  #Workernav {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around;
    grid-gap: 0vh;
    height: 60px;
    width: normal;
    box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
  }
  @media only screen and (max-width: 444px) {
    * {
      font-size: 10px;
    }
  }
}
</style>
<script>
import io from "socket.io-client";
import SocketIOFileUpload from "socketio-file-upload";

export default {
  data() {
    return {
      users: {},
      loggedin: "",
      logged: this.$store.state.someValue,
      Aktiv: "",
      Waiting: "",
      Pausad: "",
      icon: "",
      loggedstatus: "",
      project: "",
      openoverlay: false,
      previewprimed: "",
      imagefile: "",
      profileimage: "",
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

    fetch("https://flexn.se:3000/workernav", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        this.profileimage = result[0].Profile;
        console.log(this.loggedin);

        this.socketInstance = io("https://flexn.se:3000");
        this.uploader = new SocketIOFileUpload(this.socketInstance);

        this.socketInstance.emit("loggedinfo", this.loggedin);
        this.socketInstance.on("data:received", (projectdata) => {
          if (this.loggedstatus == "Admin") {
            this.project = projectdata;
          } else {
            this.project = projectdata.filter(
              (result) => result.Authorstatus == this.loggedin.Status
            );
          }

          this.Aktiv = this.project.filter((results) => {
            return results.Statu.includes("A");
          });
          this.Waiting = this.project.filter((results) => {
            return results.Statu.includes("B");
          });
          this.Pausad = this.project.filter((results) => {
            return results.Statu.includes("C");
          });
        });
        this.uploader.listenOnInput(document.getElementById("siofu_input"));
        this.uploader.addEventListener("complete", function (event) {
          setTimeout(() => {
            window.location.reload();
          }, 3000);
        });
      });
  },
  methods: {
    preview() {
      let filer = new File(
        [this.$refs.files.files],
        this.loggedin.id +
          this.loggedin.nanoid.toLowerCase() +
          this.loggedin.Username.toLowerCase() +
          "." +
          this.$refs.files.files[0].name
            .substring(this.$refs.files.files[0].name.indexOf(".") + 1)
            .toLowerCase()
      );

      console.log(filer);
      let preview = URL.createObjectURL(this.$refs.files.files[0]);
      console.log(preview);
      this.$refs.profilepreview.src = preview;
      this.previewprimed = preview;
    },
    upload() {},
  },
};
</script>
