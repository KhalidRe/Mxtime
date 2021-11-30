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
      <form action="http://localhost:3000/authenticate" method="POST">
        <div>
          <input
            type="text"
            id="Username"
            name="Username"
            placeholder="Username"
            v-model="Username"
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
          <input
            style="margin: 5px"
            type="Submit"
            value="Logga in"
            @click="logger()"
          />
        </div>
      </form>
      <button style="margin: 5px" @click="addTask">Forgot password</button>
    </div>
  </div>
</template>
<style scoped>
#Login {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100vw;
  height: 100vh;
}
#LoginForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 30vw;
  height: 30vh;
  border-radius: 25px;
  box-shadow: 0px 0px 5px 5px rgb(128, 128, 128);
}
</style>
<script>
export default {
  data() {
    return {
      Username: "",
    };
  },
  created() {},
  methods: {
    addTask() {
      console.log(this.Username);
    },
  },
};
</script>
