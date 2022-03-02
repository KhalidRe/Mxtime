import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Histor from "../views/Histor.vue";
import Charts from "../views/Charts.vue";
import Users from "../views/Users.vue";
import Login from "../views/Login.vue";
import Chat from "../views/Chat.vue";
import Time from "../views/Time.vue";
Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Login",
    component: Login,
  },
  {
    path: "/Chat",
    name: "Chat",
    component: Chat,
  },
  {
    path: "/Home",
    name: "Home",
    component: Home,
  },
  {
    path: "/Charts",
    name: "Charts",
    component: Charts,
  },
  {
    path: "/Users",
    name: "Users",
    component: Users,
  },
  {
    path: "/Histor",
    name: "Histor",
    component: Histor,
  },
  {
    path: "/Time",
    name: "Time",
    component: Time,
  },
];

const router = new VueRouter({
  routes,
});

export default router;
