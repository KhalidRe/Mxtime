<template>
  <div id="Navbar">
    <router-link class="links" to="/Home">projects</router-link>
    <router-link class="links" to="/Charts">Charts</router-link>
    <router-link class="links" to="/Users">Users</router-link>
    <router-link class="links" to="/History">History</router-link>
  </div>
</template>
<script></script>

<style scoped>
#Navbar {
  background: rgb(235, 235, 235);
  display: flex;
  flex-direction: column;
  grid-gap: 10vh;
  height: 100vh;
  width: 100px;
  box-shadow: 0px 0px 4px 1px rgb(145, 145, 145);
}
.links {
  padding-top: 30px;
  padding-bottom: 30px;
}
</style>
