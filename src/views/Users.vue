<template>
  <div class="Users">
    <Usermetrics />
    <Addtime />
    <h1>Hela laget Föffan</h1>
    <div class="Grid">
      <div class="s" v-for="users in user" :key="users.id">
        <div name="id" id="id" class="card" :value="users.id">
          <div class="profile">
            <img
              class="img"
              :src="require(`@/assets/${users.Profile}`)"
              alt=""
            />
          </div>
          <div>
            <h2 class="name">
              <div>{{ users.Name }}</div>
            </h2>
          </div>
          <div class="stats">
            <div class="a">
              <div class="n">
                <div>{{ users.Active }}</div>
              </div>
              <div class="d">Active</div>
            </div>
            <div class="a">
              <div class="n">
                <div>{{ users.Created }}</div>
              </div>
              <div class="d">Created</div>
            </div>
            <div class="a">
              <div class="n">
                <div>{{ users.Completion }}</div>
              </div>
              <div class="d">Success</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
#Your {
  width: 100%;
}
.Users {
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  width: 100%;
  height: 100vh;
  overflow-y: scroll;
  overflow-x: hidden;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.s {
}
.Grid {
  width: 80vw;
  margin-top: 50px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  grid-gap: 50px;
  padding-bottom: 50px;
}
.img {
  width: 100px;
  border-radius: 50px;
  border: solid #38abe0;
  box-shadow: 0px 5px 10px 2px rgba(114, 114, 114, 0.507);
  margin-top: 5px;
}
.card {
  width: 300px;
  height: 400px;
  background: linear-gradient(180deg, #5f94a5 0%, #000000 100%);
  box-shadow: 0px 5px 5px 1px rgba(0, 253, 42, 0.322);
  border-radius: 40% 20px 20px 20px;
}
.name {
  margin-top: 5px;
  color: #6dff91;
}
.stats {
  display: grid;
  grid-template-columns: auto auto auto;
  justify-content: center;
  grid-gap: 10px;
}
.a {
  width: 85px;
  height: 120px;
  background: linear-gradient(156.98deg, #585858 3.66%, #000000 97.3%);
  box-shadow: 0px 6px 9px rgba(242, 242, 242, 0.28);
  border-radius: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.n > div {
  background: -webkit-linear-gradient(
    148.95deg,
    #63ab37 14.93%,
    rgba(43, 108, 117, 0.93) 89.41%
  );
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.n {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;

  background: linear-gradient(
    131.77deg,
    #000000 12.15%,
    rgba(55, 55, 55, 0.65) 56.17%,
    #3382df 87.64%
  );
  border-radius: 100px;
  width: 70px;
  height: 70px;

  font-size: 50px;
  font-weight: bolder;
  color: rgb(130, 255, 130);
  margin-top: 5px;
}
.d {
  font-size: 18px;
  font-weight: bold;
  color: #b7ff8a;
  margin-top: 10px;
}
.detail {
  margin-top: 50px;
  padding: 10px;
  background-color: green;
  box-shadow: 0px 3px 5px 1px rgba(255, 255, 255, 0.432);
}
</style>
<script>
import Usermetrics from "../components/Usermetrics.vue";
import Addtime from "../components/Addtime.vue";
export default {
  components: {
    Addtime,
    Usermetrics,
  },
  data() {
    return {
      user: "",
      projects: "",
      logged: this.$store.state.someValue,
    };
  },
  created() {
    fetch("http://192.168.1.140:3000/getusers")
      .then((response) => response.json())
      .then((result) => {
        this.user = result;
        console.log(this.user);
      });
    const requestOptions = {
      method: "POST",
      mode: "cors",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("http://192.168.1.140:3000/myprojects", requestOptions)
      .then((response) => response.json())
      .then((result) => {
        this.myprojects = result;
        console.log(this.myprojects);
      });
  },
};
</script>
