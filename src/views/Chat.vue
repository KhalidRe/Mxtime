<template>
  <div id="Chat">
    <div class="chatcont">
      <div class="messagewindow">
        <span class="bouble" v-for="message in messages" :key="message.id">
          <b class="usernamechat"> {{ message.user }}:</b>
          <b class="messagelength">
            {{ message.text }}
          </b>
          <div>
            <b class="timestamp">{{ message.id }}</b>
          </div>
          <img class="profile" :src="message.icon" alt="" />
        </span>
      </div>
      <div class="inputsborder">
        <div class="inputs">
          <textarea
            id="text-Message"
            ref="textmessage"
            v-model="text"
            v-on:keyup.enter="sendMessage"
          ></textarea>
          <button class="sendmessage" @click="sendMessage()">Send</button>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.messagelength {
  max-width: 400px;
  display: block; /* or inline-block */
  text-overflow: ellipsis;
  word-wrap: break-word;
  overflow: hidden;
}
.profile {
  width: 50px;
  height: 50px;
  border-radius: 20px;
  position: absolute;
  margin-left: -60px;
}
.timestamp {
  font-size: 14px;
  color: rgb(105, 105, 105);
}
.bouble {
  display: flex;

  background-color: white;
  min-width: 200px;
  max-width: 450px;
  padding: 20px;
  border-radius: 25px 25px 25px 1px;
  margin: 5px;
  margin-left: 50px;
  justify-content: space-between;
}
.messagewindow {
  width: 100%;
  height: 100%;
}
.sendmessage {
  width: 5%;
  height: 45px;
  border-radius: 10px;
  background-color: #72eb4d;
  color: green;
}
#text-Message {
  width: 95%;
  height: 30px;
  border: none;
  padding: 10px;
  border-radius: 25px;
  font-size: 16px;
  font-weight: bold;
}
#text-Message:active {
  border: none;
}
.inputsborder {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 75px;
  background: rgb(197, 197, 197);
}
.textwrap {
}
.inputs {
  display: flex;
  width: 100%;
}

.chatcont {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-end;
}
#Chat {
  margin: 0;
  max-width: 100%;
  width: 100%;
  overflow-y: scroll;
  overflow-x: hidden;
  background-repeat: no-repeat;
  background-size: 100%;
  background: url("~@/assets/chatback.png");
}
</style>
<script>
import moment from "moment";
import io from "socket.io-client";

export default {
  data() {
    return {
      joined: false,
      text: "",
      messages: [],
      logged: this.$store.state.someValue,
      currentUser: "",
      Profile: "",
      icon: "",
    };
  },
  created() {
    this.socketInstance = io("https://mxserver-simdf.ondigitalocean.app");
    this.socketInstance.on("message:received", (data) => {
      this.messages = this.messages.concat(data);
    });

    const auth = {
      method: "POST",
      mode: "cors",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("https://mxserver-simdf.ondigitalocean.app/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        console.log(result);

        if (result.length > 0) {
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
          fetch(
            "https://mxserver-simdf.ondigitalocean.app/workernav",
            requestOptions
          )
            .then((response) => response.json())
            .then((result) => {
              this.loggedin = result;
              this.currentUser = this.loggedin[0].Name;
              this.profile = this.loggedin[0].Profile;
              console.log(this.currentUser);
            });
        }
      });
  },
  methods: {
    sendMessage() {
      if (this.text.length > 0) {
        this.addMessage();
        this.text = "";
      }
    },
    addMessage() {
      const message = {
        id: moment().format("LT"),
        text: this.text,
        user: this.currentUser,
        icon:
          this.loggedin[0].Profile &&
          require(`../assets/${this.loggedin[0].Profile}`),
      };
      this.messages = this.messages.concat(message);
      this.socketInstance.emit("message", message);
    },
  },
};
</script>
