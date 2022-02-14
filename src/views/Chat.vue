<template>
  <div id="Chat">
    <div class="chatcont">
      <div class="messagewindow">
        <span v-for="message in messages" :key="message.id">
          <span
            v-bind:class="[
              message.user === currentUser ? boubleactive : '',
              boubleothers,
            ]"
          >
            <img class="profile" :src="message.icon" alt="" />

            <div id="ugotit">
              <b class="usernamechat"> {{ message.user }}</b>
              <b class="messagelength">
                {{ message.text }}
              </b>
            </div>

            <div>
              <b class="timestamp">{{ message.time }}</b>
            </div>
          </span>
        </span>
        <span ref="scrollhere">ok</span>
      </div>
      <div class="inputsborder">
        <div class="inputs">
          <textarea
            id="text-Message"
            ref="textmessage"
            v-model="text"
            maxlength="150"
          ></textarea>
          <button class="sendmessage" @click="sendMessage()">Send</button>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.usernamechat {
  text-align: left;
  color: #5f5e88;
}
.othersnamechat {
  text-align: left;
  color: #263123;
}
#ugotit {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
.messagelength {
  max-width: 400px;
  /* or inline-block */
  text-overflow: ellipsis;
  word-wrap: break-word;
  overflow: hidden;
  text-align: left;
}
.profile {
  width: 30px;
  height: 30px;
  border-radius: 20px;

  margin-left: -32px;
}
.timestamp {
  font-size: 14px;
  color: rgb(105, 105, 105);
}
.boubleothers {
  display: grid;
  grid-template-columns: 5% auto 10%;
  color: black;
  background-color: #b9d6db;
  min-width: 20vw;
  max-width: 30vw;
  max-width: 450px;
  padding: 20px;
  border-radius: 25px 25px 25px 1px;
  margin: 5px;
  margin-left: 50px;
}
.boubleactive {
  display: grid;
  grid-template-columns: 0% auto 5%;

  background-color: #b4ffb8;
  color: rgb(58, 51, 51);
  min-width: 20vw;
  max-width: 30vw;
  max-width: 450px;
  padding: 20px;
  border-radius: 25px 25px 25px 25px;
  margin: 5px;
  margin-left: 50px;
  margin-bottom: 25px;
}

.messagewindow {
  margin: 0;
  max-width: 100%;
  width: 100%;
  height: 95%;
  overflow-y: scroll;
  overflow-x: hidden;
}
.messagewindow::-webkit-scrollbar {
  width: 6px;
}
.messagewindow::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
.messagewindow::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}

.sendmessage {
  width: 60px;
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
  justify-content: space-between;
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
#Chat::-webkit-scrollbar {
  display: none;
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
      i: 0,
      holder: [],
      areulogged: false,
      boubleactive: "boubleactive",
      boubleothers: "boubleothers",
      usernamechat: "usernamechat",
      othersnamechat: "othersnamechat",
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
    fetch("188.166.114.141:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        if (result.length === 0) {
          location.replace("https://flexnet.se/#/");
        }
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
          fetch("188.166.114.141:3000/workernav", requestOptions)
            .then((response) => response.json())
            .then((result) => {
              this.loggedin = result;
              this.currentUser = this.loggedin[0].Name;
              this.profile = this.loggedin[0].Profile;
              this.scrollToElement();
            });
        }
      });
    this.socketInstance = io("188.166.114.141:3000");

    this.socketInstance.on("message:received", (result) => {
      this.messages = result;
      this.scrollToElement();
    });
  },
  methods: {
    sendMessage() {
      if (this.text.length > 0) {
        this.scrollToElement();
        this.addMessage();
        this.text = "";
      }
    },
    addMessage() {
      const message = {
        time: moment().format("LT"),
        user: this.currentUser,
        text: this.text,
        icon:
          this.loggedin[0].Profile &&
          require(`../assets/${this.loggedin[0].Profile}`),
      };

      this.socketInstance.emit("message", message);
    },
    scrollToElement() {
      const el = this.$refs.scrollhere;

      if (el) {
        // Use el.scrollIntoView() to instantly scroll to the element
        el.scrollIntoView();
      }
    },
  },
  mounted() {
    this.scrollToElement();
  },
};
</script>
