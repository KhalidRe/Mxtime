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
      <form action="/authenticate" method="POST">
        <div>
          <input
            type="text"
            id="Username"
            name="Username"
            v-model="someValue"
            value=""
          />
        </div>
        <br />
        <div style="margin-bottom: 10px">
          <input
            type="text"
            id="Password"
            name="Password"
            placeholder="Password"
          />
        </div>
        <div>
          <input style="margin: 5px" type="submit" />
        </div>
      </form>
      <button style="margin: 5px">Forgot password</button>
    </div>
  </div>
</template>
<style scoped>
#Login {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100vh;
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
}
#LoginForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 300px;
  height: 30vh;
  border-radius: 25px;
  box-shadow: 0px 0px 5px 5px rgb(128, 128, 128);
}
</style>
<script>
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
  methods: {},
};
</script>
