<template>
  <div id="Login">
    <iframe
      width="1px"
      height="1px"
      name="dummyframe"
      id="dummyframe"
      style="display: none"
    ></iframe>
    <div id="LoginForm">
      <h2>Logga in</h2>
      <form action="http://192.168.1.191:3000/authenticate" method="POST">
        <div>
          <input
            type="text"
            id="Username"
            name="Username"
            ref="Username"
            value=""
          />
        </div>
        <br />
        <div style="margin-bottom: 10px">
          <input
            type="password"
            id="Password"
            name="Password"
            placeholder="Password"
            autocomplete="false"
          />
        </div>
        <div>
          <input style="margin: 5px" type="submit" @click="setvalue()" />
        </div>
      </form>
      <button style="margin: 5px">Forgot password</button>
    </div>
  </div>
</template>
<style scoped>
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
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100vh;
  background: -webkit-linear-gradient(120deg, #497771, #80f2ff);
}
#LoginForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 300px;

  border-radius: 25px;
  box-shadow: 0px 0px 5px 5px rgb(128, 128, 128);
}
</style>
<script>
import domain from "../domain";
export default {
  data() {
    return {
      auth: "",
      Username: "",
    };
  },
  created() {},

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
    setvalue() {
      this.someValue = this.$refs.Username.value;
    },
  },
};
</script>
