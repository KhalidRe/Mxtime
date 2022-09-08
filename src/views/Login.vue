<template>
  <div id="Login">
    <div class="flexnav">
      <div class="mxtimelogo">
        <img src="@/assets/mxklogg2.png" alt="" />
      </div>
      <div class="itemsnav">
        <a href="https://mxtime.se"><div class="getit">Get MX-Time</div></a>
      </div>
    </div>
    <div class="logincaps">
      <iframe
        width="1px"
        height="1px"
        name="dummyframe"
        id="dummyframe"
        style="display: none"
      ></iframe>
      <transition name="slide-fade">
        <div v-if="show" id="LoginForm">
          <h2 class="header">Logga in</h2>

          <div>
            <label for="">Användarnamn</label>
            <br />
            <input
              type="text"
              id="Username"
              name="Username"
              placeholder="Username"
              ref="Username"
            />
          </div>
          <br />
          <div style="margin-bottom: 10px">
            <label for="">Lösenord</label><br />
            <input
              type="password"
              id="Password"
              name="Password"
              placeholder="Password"
              autocomplete="false"
              ref="Password"
            />
          </div>
          <div>
            <input
              style="margin: 5px"
              type="submit"
              @click="login()"
              value="Logga in"
              class="loginbtn"
            />
          </div>
          <div class="errormessage">{{ errormessage.text }}</div>
          <p class="senti">
            har du inget konto? <br /><a href="https://app.mxtime.se"
              >skapa ett här</a
            >
          </p>

          <a href="tel:0707533884">
            <button class="forgotbtn" style="margin: 5px">
              Glömt lösenord
            </button>
          </a>
        </div>
      </transition>
    </div>
    <div class="logocaps">
      <img class="mxklog" src="@/assets/mx-komm-logo.png" alt="" />
    </div>
  </div>
</template>
<style scoped>
.errormessage {
  font-size: 12px;
  color: red;
  text-decoration: underline;
}
.senti {
  font-size: 12px;
}
.itemsnav > a {
  text-decoration: none;
}
.getit {
  border: none;
  padding: 15px;
  margin: 10px;
  border-radius: 20px;
  background: #32b86e;
  color: white;
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
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
.forgotbtn {
  border: none;
  padding: 5px;
  border-radius: 10px;
  background: #3282b8;
  color: white;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
}
.forgotbtn:hover {
  background: #5c9eca;
}
.loginbtn {
  border: none;
  padding: 10px;
  border-radius: 10px;
  background: #3282b8;
  color: white;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
}
.loginbtn:hover {
  background: #5c9eca;
}
label {
  display: flex;
  margin: 0px;
  height: 5px;
}
.header {
  background: #1988c9;
  width: 100%;
  margin-top: 0px;
  border-radius: 20px 20px 0px 0px;
  padding-top: 10px;
  padding-bottom: 10px;
  color: white;
}
.mxtimelogo {
  padding: 10px;
}
.mxtimelogo > img {
  width: 125px;
}

.flexnav {
  width: 100%;
  display: flex;
  justify-content: space-between;
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
::-webkit-scrollbar-thumb {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
#Login {
  width: 100%;
  height: 100vh;
  background: -webkit-linear-gradient(120deg, #9fc0d6, #f3f3f3);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
}
.logincaps {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background: -webkit-linear-gradient(120deg, #9fc0d6, #f3f3f3);
}
#LoginForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;

  width: 300px;
  height: 400px;
  background: rgb(255, 255, 255);
  border-radius: 25px;
  box-shadow: 0px 2px 5px 1px rgb(128, 128, 128);
}
form {
  margin-top: -50px;
}
.logocaps {
  width: 100%;
  display: flex;
  justify-content: flex-end !important;
}
.mxklog {
  width: 300px;
}
input[type="text"] {
  border: none;
  border-bottom-style: solid;

  height: 20px;

  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  border-bottom: 1px solid #217346;
}
input[type="password"] {
  border: none;
  border-bottom-style: solid;
  height: 20px;

  padding: 0;
  background-color: transparent;
  border: 1px solid transparent;
  border-bottom: 1px solid #217346;
}
input[type="text"]:focus {
  outline: none;
}
input[type="password"]:focus {
  outline: none;
}
</style>
<script>
import domain from "../domain";
export default {
  data() {
    return {
      auth: "",
      Username: "",
      show: false,
      errormessage: {
        itswrong: true,
        text: "",
      },
    };
  },
  created() {
    setTimeout(() => {
      this.show = true;
    }, "500");
    this.someValue = "";
  },

  computed: {
    someValue: {
      get() {
        return this.$store.state.someValue;
      },
      set(someValue) {
        this.$store.commit("setSomeValue", someValue);
      },
    },
  },
  methods: {
    login() {
      const auth = {
        method: "POST",
        mode: "cors",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },

        body: JSON.stringify({
          Username: this.$refs.Username.value,
          Password: this.$refs.Password.value,
        }),
      };

      fetch("https://mxtime.se:3000/authenticate", auth)
        .then((response) => response.json())
        .then((result) => {
          this.errormessage = result;
          this.setvalue();
        });
    },
    setvalue() {
      if (this.errormessage.itswrong !== true) {
        this.someValue = this.$refs.Username.value;
        console.log(this.someValue);
        window.location.href = "https://app.mxtime.se/#/Home";
      }
    },
  },
};
</script>
