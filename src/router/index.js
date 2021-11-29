import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Histor from "../views/Histor.vue";
import Charts from "../views/Charts.vue";
import Users from "../views/Users.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/",
    name: "Charts",
    component: Charts,
  },
  {
    path: "/",
    name: "Users",
    component: Users,
  },
  {
    path: "/",
    name: "Histor",
    component: Histor,
  },
];

const router = new VueRouter({
  routes,
});

export default router;
