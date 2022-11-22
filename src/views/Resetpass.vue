<template>
  <div id="Forgotpass">
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

      <div v-if="secondhold == true && cani == true" id="LoginForm">
        <h2 class="header">Ändra Lösenord</h2>

        <div>
          <label for="">Ange nytt lösenord</label>
          <br />
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Lösenord.."
            ref="password"
            v-model="password"
            @keyup="checker()"
          />
          <br />
          <br />
          <label for="">Ange samma lösenord igen</label>
          <br />

          <input
            type="password"
            id="passwordc"
            name="passwordc"
            placeholder="Lösenord.."
            ref="passwordc"
            v-model="passwordc"
            @keyup="checker()"
          />
        </div>
        <div v-if="!checker()" class="errormessage">
          Båda lösenorden måste vara samma
        </div>
        <div v-if="this.password.length < 8" class="errormessage">
          Lösenordet måste vara längre än 8
        </div>
        <div>
          <input
            v-if="this.password.length >= 8 && this.password === this.passwordc"
            style="margin: 5px"
            type="submit"
            @click="resetpass()"
            value="Byt lösenord"
            class="loginbtn"
          />
          <input
            v-else
            style="margin: 5px"
            type="submit"
            value="Logga in"
            class="loginbtnf"
          />
        </div>
      </div>
      <div class="notgilt" v-if="secondhold == false && cani == false">
        <h1>Länken är inte giltig</h1>
      </div>
    </div>
    <div class="logocaps">
      <img class="mxklog" src="@/assets/mx-komm-logo.png" alt="" />
    </div>
  </div>
</template>
<style scoped>
.notgilt {
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  align-content: center;
  background: white;
  width: 80%;
  height: 80%;
  border-radius: 30px;
  box-shadow: 0px 2px 5px 6px rgba(0, 0, 0, 0.322);
}
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
.loginbtnf {
  border: none;
  padding: 10px;
  border-radius: 10px;
  background: #6f767a;
  color: white;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
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
#Forgotpass {
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
import { nanoid } from "nanoid";
export default {
  name: "Resettpass",
  data() {
    return {
      auth: "",
      nanoholder: "",
      show: false,
      password: "",
      passwordc: "",
      cani: false,
      secondhold: true,
      errormessage: {
        itswrong: true,
        text: "",
      },
      wth: "",
    };
  },
  created() {
    this.show = true;

    const auth = {
      method: "POST",
      mode: "cors",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },

      body: JSON.stringify({
        nanoid: this.$route.query.key,
      }),
    };
    fetch("https://mxtime.se:3000/resetpasswordcheck", auth)
      .then((response) => response.json())
      .then((result) => {
        this.cani = result.itsok;
        this.secondhold = result.itsok;
        this.nanoholder = result.results[0].rpnano;
      });
  },
  computed: {},
  watch: {
    // whenever question changes, this function will run
    question(newQuestion, oldQuestion) {
      if (newQuestion.includes("?")) {
        this.getAnswer();
      }
    },
  },

  methods: {
    checker() {
      if (this.password === this.passwordc) {
        return true;
      } else return false;
    },
    resetpass() {
      const auth = {
        method: "POST",
        mode: "cors",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },

        body: JSON.stringify({
          password: this.password,
          nanoidholder: this.nanoholder,
        }),
      };
      fetch("https://mxtime.se:3000/resetpass", auth)
        .then((response) => response.json())
        .then((result) => {
          this.wth = result;
          this.setvalue();
        });
    },
    setvalue() {
      if (this.wth == true) {
        window.location.href = "https://app.mxtime.se/#/";
      } else {
        alert("critical error");
      }
    },
  },
};
</script>
