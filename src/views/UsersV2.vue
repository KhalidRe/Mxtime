<template>
  <div id="UsersV2">
    <transition name="fade">
      <div
        style="transition-delay: 0.5s"
        class="profileview"
        v-if="showprofile"
      >
        <video autoplay muted loop webkit-playsinline="true" playsinline="true">
          <source src="@/assets/energy.webm" type="video/mp4" />
        </video>

        <div class="metrics">
          <div class="close" @click="showprofile = !showprofile">
            <img width="40vw" src="@/assets/closebtn.png" alt="" />
          </div>
          <div class="infocapsule">
            <div class="gotit">
              <img
                class="imgin"
                :src="require(`@/assets/${this.eprofile}`)"
                alt=""
              />
              <h1>{{ this.ename }}</h1>
            </div>
            <div class="stats">
              <div class="fe">
                <div class="n">
                  <div>{{ this.eactive }}</div>
                </div>
                <div class="d">Active</div>
              </div>

              <div class="fe">
                <div class="n">
                  <div>{{ this.ecreated }}</div>
                </div>
                <div class="d">Created</div>
              </div>

              <div class="fe">
                <div class="n">
                  <div>{{ this.ecompleted }}</div>
                </div>
                <div class="d">Success</div>
              </div>
            </div>
            <div class="chart">
              <Linechart id="chart" :to-chart="filteredArray" />
            </div>
          </div>
        </div>
      </div>
    </transition>
    <div>
      <div class="usnc">
        <h2>Users</h2>
        <div
          class="createuserbtn"
          v-if="loggedin.Status == 'Admin'"
          @click="createuser = !createuser"
        >
          Skapa Användare
        </div>
      </div>

      <table cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr class="trhead">
            <th>Profile</th>
            <th>Stats <span>?</span></th>
            <th>Chart</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="tbl-content">
      <div class="shadow"></div>
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody class="tablebod">
          <tr class="row" v-for="users in user" :key="users.id">
            <td class="firsttd">
              <img
                class="img"
                :src="require(`@/assets/${users.Profile}`)"
                alt=""
              />{{ users.Name }}
            </td>
            <td>
              {{ users.Active }}/{{ users.Created }}/{{ users.Completion }}
            </td>
            <td>
              <button
                class="readmorebtn"
                @click="View(users.id), (showprofile = !showprofile)"
              >
                View
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <ViewtimeV2 />
    <Viewtime />
    <transition name="slide-fade">
      <div v-if="createuser" class="createusernoclick">
        <div class="createusercaps">
          <div class="createusertitle">Skapa användare</div>
          <div class="createuserinputs">
            <div>
              <div>Användarnamn</div>
              <input v-model="newusername" type="text" />
            </div>
            <div>
              <div>Lösenord</div>
              <input v-model="newpassword" type="text" />
            </div>
            <div>
              <div>Typ av Användare</div>
              <select v-model="newtype" name="" id="acctype">
                <option value="Admin">Admin</option>
                <option value="Finanse">Finanse</option>
                <option value="Dev">Dev</option>
              </select>
            </div>
            <div class="confirmation">
              <div class="userconf" v-if="newusername.length > 5">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M5.00011 0.554688C4.12108 0.554688 3.26179 0.81535 2.53091 1.30371C1.80002 1.79207 1.23037 2.4862 0.893979 3.29832C0.55759 4.11043 0.469575 5.00406 0.641065 5.8662C0.812555 6.72834 1.23585 7.52026 1.85741 8.14183C2.47898 8.7634 3.2709 9.18669 4.13304 9.35818C4.99518 9.52967 5.88881 9.44165 6.70093 9.10526C7.51304 8.76887 8.20717 8.19922 8.69553 7.46833C9.18389 6.73745 9.44456 5.87816 9.44456 4.99913C9.44456 3.82039 8.9763 2.68993 8.14281 1.85644C7.30931 1.02294 6.17885 0.554688 5.00011 0.554688V0.554688ZM7.90289 3.50747L4.25289 7.15469L2.09733 4.99913C2.02366 4.92546 1.98227 4.82554 1.98227 4.72135C1.98227 4.61717 2.02366 4.51725 2.09733 4.44358C2.171 4.36991 2.27092 4.32852 2.37511 4.32852C2.4793 4.32852 2.57922 4.36991 2.65289 4.44358L4.25844 6.04913L7.35289 2.95747C7.38937 2.92099 7.43267 2.89205 7.48033 2.87231C7.528 2.85257 7.57908 2.84241 7.63067 2.84241C7.68225 2.84241 7.73334 2.85257 7.781 2.87231C7.82866 2.89205 7.87197 2.92099 7.90844 2.95747C7.94492 2.99394 7.97386 3.03725 7.9936 3.08491C8.01334 3.13257 8.0235 3.18365 8.0235 3.23524C8.0235 3.28683 8.01334 3.33791 7.9936 3.38558C7.97386 3.43324 7.94492 3.47654 7.90844 3.51302L7.90289 3.50747Z"
                    fill="#5CAB2B"
                  />
                </svg>

                Username longer than 6 characters
              </div>
              <div class="userconf" v-if="newpassword.length > 7">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M5.00011 0.554688C4.12108 0.554688 3.26179 0.81535 2.53091 1.30371C1.80002 1.79207 1.23037 2.4862 0.893979 3.29832C0.55759 4.11043 0.469575 5.00406 0.641065 5.8662C0.812555 6.72834 1.23585 7.52026 1.85741 8.14183C2.47898 8.7634 3.2709 9.18669 4.13304 9.35818C4.99518 9.52967 5.88881 9.44165 6.70093 9.10526C7.51304 8.76887 8.20717 8.19922 8.69553 7.46833C9.18389 6.73745 9.44456 5.87816 9.44456 4.99913C9.44456 3.82039 8.9763 2.68993 8.14281 1.85644C7.30931 1.02294 6.17885 0.554688 5.00011 0.554688V0.554688ZM7.90289 3.50747L4.25289 7.15469L2.09733 4.99913C2.02366 4.92546 1.98227 4.82554 1.98227 4.72135C1.98227 4.61717 2.02366 4.51725 2.09733 4.44358C2.171 4.36991 2.27092 4.32852 2.37511 4.32852C2.4793 4.32852 2.57922 4.36991 2.65289 4.44358L4.25844 6.04913L7.35289 2.95747C7.38937 2.92099 7.43267 2.89205 7.48033 2.87231C7.528 2.85257 7.57908 2.84241 7.63067 2.84241C7.68225 2.84241 7.73334 2.85257 7.781 2.87231C7.82866 2.89205 7.87197 2.92099 7.90844 2.95747C7.94492 2.99394 7.97386 3.03725 7.9936 3.08491C8.01334 3.13257 8.0235 3.18365 8.0235 3.23524C8.0235 3.28683 8.01334 3.33791 7.9936 3.38558C7.97386 3.43324 7.94492 3.47654 7.90844 3.51302L7.90289 3.50747Z"
                    fill="#5CAB2B"
                  /></svg
                >password longer than 8 characters
              </div>
              <div class="userconf" v-if="newtype.length > 1">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M5.00011 0.554688C4.12108 0.554688 3.26179 0.81535 2.53091 1.30371C1.80002 1.79207 1.23037 2.4862 0.893979 3.29832C0.55759 4.11043 0.469575 5.00406 0.641065 5.8662C0.812555 6.72834 1.23585 7.52026 1.85741 8.14183C2.47898 8.7634 3.2709 9.18669 4.13304 9.35818C4.99518 9.52967 5.88881 9.44165 6.70093 9.10526C7.51304 8.76887 8.20717 8.19922 8.69553 7.46833C9.18389 6.73745 9.44456 5.87816 9.44456 4.99913C9.44456 3.82039 8.9763 2.68993 8.14281 1.85644C7.30931 1.02294 6.17885 0.554688 5.00011 0.554688V0.554688ZM7.90289 3.50747L4.25289 7.15469L2.09733 4.99913C2.02366 4.92546 1.98227 4.82554 1.98227 4.72135C1.98227 4.61717 2.02366 4.51725 2.09733 4.44358C2.171 4.36991 2.27092 4.32852 2.37511 4.32852C2.4793 4.32852 2.57922 4.36991 2.65289 4.44358L4.25844 6.04913L7.35289 2.95747C7.38937 2.92099 7.43267 2.89205 7.48033 2.87231C7.528 2.85257 7.57908 2.84241 7.63067 2.84241C7.68225 2.84241 7.73334 2.85257 7.781 2.87231C7.82866 2.89205 7.87197 2.92099 7.90844 2.95747C7.94492 2.99394 7.97386 3.03725 7.9936 3.08491C8.01334 3.13257 8.0235 3.18365 8.0235 3.23524C8.0235 3.28683 8.01334 3.33791 7.9936 3.38558C7.97386 3.43324 7.94492 3.47654 7.90844 3.51302L7.90289 3.50747Z"
                    fill="#5CAB2B"
                  /></svg
                >User type chosen
              </div>
              <div class="userconf" v-if="newusername.length < 6">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M5.00008 0.416016C2.46883 0.416016 0.416748 2.4681 0.416748 4.99935C0.416748 7.5306 2.46883 9.58268 5.00008 9.58268C7.53133 9.58268 9.58342 7.5306 9.58342 4.99935C9.58342 2.4681 7.53133 0.416016 5.00008 0.416016ZM6.54466 4.04393C6.62056 3.96535 6.66256 3.8601 6.66161 3.75085C6.66066 3.6416 6.61684 3.53709 6.53959 3.45984C6.46234 3.38259 6.35783 3.33877 6.24858 3.33782C6.13933 3.33687 6.03408 3.37887 5.9555 3.45477L5.00008 4.41018L4.04466 3.45477C4.00623 3.41497 3.96025 3.38323 3.90942 3.36139C3.85858 3.33955 3.80391 3.32806 3.74858 3.32758C3.69326 3.3271 3.63839 3.33764 3.58718 3.35859C3.53598 3.37954 3.48946 3.41048 3.45033 3.4496C3.41121 3.48872 3.38027 3.53524 3.35932 3.58645C3.33837 3.63766 3.32783 3.69252 3.32831 3.74785C3.32879 3.80317 3.34029 3.85785 3.36212 3.90868C3.38396 3.95952 3.4157 4.0055 3.4555 4.04393L4.41092 4.99935L3.4555 5.95477C3.4157 5.9932 3.38396 6.03918 3.36212 6.09001C3.34029 6.14085 3.32879 6.19552 3.32831 6.25085C3.32783 6.30617 3.33837 6.36104 3.35932 6.41225C3.38027 6.46345 3.41121 6.50998 3.45033 6.5491C3.48946 6.58822 3.53598 6.61916 3.58718 6.64011C3.63839 6.66106 3.69326 6.6716 3.74858 6.67112C3.80391 6.67064 3.85858 6.65915 3.90942 6.63731C3.96025 6.61547 4.00623 6.58373 4.04466 6.54393L5.00008 5.58852L5.9555 6.54393C6.03408 6.61983 6.13933 6.66183 6.24858 6.66088C6.35783 6.65993 6.46234 6.61611 6.53959 6.53886C6.61684 6.4616 6.66066 6.3571 6.66161 6.24785C6.66256 6.1386 6.62056 6.03335 6.54466 5.95477L5.58925 4.99935L6.54466 4.04393Z"
                    fill="#F06363"
                  />
                </svg>
                Username longer than 6 characters
              </div>
              <div class="userconf" v-if="newpassword.length < 8">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M5.00008 0.416016C2.46883 0.416016 0.416748 2.4681 0.416748 4.99935C0.416748 7.5306 2.46883 9.58268 5.00008 9.58268C7.53133 9.58268 9.58342 7.5306 9.58342 4.99935C9.58342 2.4681 7.53133 0.416016 5.00008 0.416016ZM6.54466 4.04393C6.62056 3.96535 6.66256 3.8601 6.66161 3.75085C6.66066 3.6416 6.61684 3.53709 6.53959 3.45984C6.46234 3.38259 6.35783 3.33877 6.24858 3.33782C6.13933 3.33687 6.03408 3.37887 5.9555 3.45477L5.00008 4.41018L4.04466 3.45477C4.00623 3.41497 3.96025 3.38323 3.90942 3.36139C3.85858 3.33955 3.80391 3.32806 3.74858 3.32758C3.69326 3.3271 3.63839 3.33764 3.58718 3.35859C3.53598 3.37954 3.48946 3.41048 3.45033 3.4496C3.41121 3.48872 3.38027 3.53524 3.35932 3.58645C3.33837 3.63766 3.32783 3.69252 3.32831 3.74785C3.32879 3.80317 3.34029 3.85785 3.36212 3.90868C3.38396 3.95952 3.4157 4.0055 3.4555 4.04393L4.41092 4.99935L3.4555 5.95477C3.4157 5.9932 3.38396 6.03918 3.36212 6.09001C3.34029 6.14085 3.32879 6.19552 3.32831 6.25085C3.32783 6.30617 3.33837 6.36104 3.35932 6.41225C3.38027 6.46345 3.41121 6.50998 3.45033 6.5491C3.48946 6.58822 3.53598 6.61916 3.58718 6.64011C3.63839 6.66106 3.69326 6.6716 3.74858 6.67112C3.80391 6.67064 3.85858 6.65915 3.90942 6.63731C3.96025 6.61547 4.00623 6.58373 4.04466 6.54393L5.00008 5.58852L5.9555 6.54393C6.03408 6.61983 6.13933 6.66183 6.24858 6.66088C6.35783 6.65993 6.46234 6.61611 6.53959 6.53886C6.61684 6.4616 6.66066 6.3571 6.66161 6.24785C6.66256 6.1386 6.62056 6.03335 6.54466 5.95477L5.58925 4.99935L6.54466 4.04393Z"
                    fill="#F06363"
                  /></svg
                >password longer than 8 characters
              </div>
              <div class="userconf" v-if="newtype.length < 1">
                <svg
                  width="15"
                  height="15"
                  viewBox="0 0 10 10"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M5.00008 0.416016C2.46883 0.416016 0.416748 2.4681 0.416748 4.99935C0.416748 7.5306 2.46883 9.58268 5.00008 9.58268C7.53133 9.58268 9.58342 7.5306 9.58342 4.99935C9.58342 2.4681 7.53133 0.416016 5.00008 0.416016ZM6.54466 4.04393C6.62056 3.96535 6.66256 3.8601 6.66161 3.75085C6.66066 3.6416 6.61684 3.53709 6.53959 3.45984C6.46234 3.38259 6.35783 3.33877 6.24858 3.33782C6.13933 3.33687 6.03408 3.37887 5.9555 3.45477L5.00008 4.41018L4.04466 3.45477C4.00623 3.41497 3.96025 3.38323 3.90942 3.36139C3.85858 3.33955 3.80391 3.32806 3.74858 3.32758C3.69326 3.3271 3.63839 3.33764 3.58718 3.35859C3.53598 3.37954 3.48946 3.41048 3.45033 3.4496C3.41121 3.48872 3.38027 3.53524 3.35932 3.58645C3.33837 3.63766 3.32783 3.69252 3.32831 3.74785C3.32879 3.80317 3.34029 3.85785 3.36212 3.90868C3.38396 3.95952 3.4157 4.0055 3.4555 4.04393L4.41092 4.99935L3.4555 5.95477C3.4157 5.9932 3.38396 6.03918 3.36212 6.09001C3.34029 6.14085 3.32879 6.19552 3.32831 6.25085C3.32783 6.30617 3.33837 6.36104 3.35932 6.41225C3.38027 6.46345 3.41121 6.50998 3.45033 6.5491C3.48946 6.58822 3.53598 6.61916 3.58718 6.64011C3.63839 6.66106 3.69326 6.6716 3.74858 6.67112C3.80391 6.67064 3.85858 6.65915 3.90942 6.63731C3.96025 6.61547 4.00623 6.58373 4.04466 6.54393L5.00008 5.58852L5.9555 6.54393C6.03408 6.61983 6.13933 6.66183 6.24858 6.66088C6.35783 6.65993 6.46234 6.61611 6.53959 6.53886C6.61684 6.4616 6.66066 6.3571 6.66161 6.24785C6.66256 6.1386 6.62056 6.03335 6.54466 5.95477L5.58925 4.99935L6.54466 4.04393Z"
                    fill="#F06363"
                  /></svg
                >User type chosen
              </div>
            </div>
            <div
              v-if="
                newusername.length > 5 &&
                newpassword.length > 7 &&
                newtype.length > 1
              "
              class="skapaanv"
              @click="createnewuser(), (createuser = !createuser)"
            >
              Skapa
            </div>
            <div
              v-if="
                newusername.length < 6 ||
                newpassword.length < 8 ||
                newtype.length < 1
              "
              class="skapaanvf"
            >
              Skapa
            </div>
            <div class="avbrtanv" @click="createuser = !createuser">Avbryt</div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>
<style scoped>
.userconf {
  font-size: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}
.slide-fade-enter-active {
  transition: all 0.6s ease;
}
.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8  :startColor="'#6EF56D'"
                :stopColor="'#2A9EBE'"*/ {
  transform: translateY(-100%);
  opacity: 0;
}
#acctype {
  padding: 6px;
  width: 150px;
}
.avbrtanv {
  background: #808181;
  border-radius: 20px;
  padding: 5px;
  width: 70px;
  color: white;
  align-self: center;
  cursor: pointer;
  font-size: 13px;
}
.avbrtanv:hover {
  background: rgb(153, 75, 75);
}
.skapaanv {
  background: #3382df;
  border-radius: 20px;
  padding: 10px;
  width: 90px;
  color: white;
  align-self: center;
  cursor: pointer;
}
.skapaanvf {
  background: #464646;
  border-radius: 20px;
  padding: 10px;
  width: 90px;
  color: white;
  align-self: center;
  cursor: not-allowed;
}
.createusertitle {
  padding: 10px;
  background-color: #3382df;
  width: 250px;
  color: white;
  font-size: 18px;
  border-radius: 20px 20px 0px 0px;
}
.createuserinputs {
  height: 90%;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
}
.createusernoclick {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0%;
  left: 0%;
  overflow: hidden;
  display: flex;
  justify-content: center;
}
.createusercaps {
  position: absolute;
  top: 20%;
  background: white;
  height: 350px;
  border-radius: 20px;
  box-shadow: 0px 5px 5px 1px rgba(88, 88, 88, 0.178);
}
.createuserbtn {
  margin: 20px;
  padding: 10px;
  height: 17px;
  background: #4790ff;
  color: white;
  border-radius: 10px;
  cursor: pointer;
  transition: 0.5s;
}
.createuserbtn:hover {
  transition: 0.5s;
  background: #006aae;
}
.usnc {
  display: flex;
  justify-content: space-between;
}
.firsttd {
  display: flex;
  align-items: center;
  grid-gap: 5px;
}
.img {
  width: 30px;
  border-radius: 20px;
}
.shadow {
  height: 3px;
  background: linear-gradient(rgb(179, 179, 179), rgb(255, 255, 255));
}
h2 {
  text-align: left;
  padding-left: 20px;
}
.tbl-content {
}
h1 {
  background-color: #f0f0f0;
  margin: 0;
  padding: 10px;
}
tr:nth-child(odd) {
  background: linear-gradient(180deg, #a8a8a88a 0%, #f5f5f5 3.12%);
}
tr:nth-child(1) {
  background: #f5f5f5;
}
tr:nth-child(even) {
  background: linear-gradient(180deg, #a8a8a88a 0%, #f0f0f0 3.12%);
}
table {
  width: 100%;
  table-layout: fixed;
}
.tbl-header {
}

.tbl-content {
  max-height: 50%;

  overflow-x: auto;
  margin-top: 0px;
}
th {
  padding: 20px 15px;
  text-align: left;
  font-weight: 600;
  font-size: 14px;
  color: rgb(94, 94, 94);
  text-transform: uppercase;
  background-color: #ffffff !important;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 600;
  font-size: 14px;
  color: rgb(112, 112, 112);
  border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}
#UsersV2 {
  width: 100%;
  height: 100vh;
  background-color: #ffffff;
  overflow-y: scroll;
  overflow-x: hidden;
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
@media only screen and (max-width: 1000px) {
  .createusercaps {
    position: absolute;
    top: 20%;
    left: 23%;
  }
}
@keyframes FadeIn {
  0% {
    opacity: 0;
    transform: perspective(400px) translateZ(200px);
  }
  10% {
    opacity: 0;
  }

  85% {
    box-shadow: 0px 0px 0px rgba(242, 242, 242, 0.28);
  }
  100% {
    transform: perspective(400px) translateZ(0px);
    box-shadow: 0px 6px 9px rgba(242, 242, 242, 0.28);
  }
}

.fe {
  animation: FadeIn 1s linear;
  animation-fill-mode: both;
}

.stats .fe:nth-child(1) {
  animation-delay: 0.5s;
}
.stats .fe:nth-child(2) {
  animation-delay: 1s;
}
.stats .fe:nth-child(3) {
  animation-delay: 1.5s;
}
.stats .fe:nth-child(4) {
  animation-delay: 2s;
}
.digitalstats {
  display: grid;
  grid-template-columns: auto auto auto;
  justify-content: center;
  grid-gap: 10px;
}
#chart {
  width: 100%;
}
.chart {
  width: 100%;
  background-color: #000000cc;

  float: right;
  color: white;
}
.gotit > h1 {
  background: none;
}
.infocapsule {
  width: 100%;
  height: 90%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
}
.close {
  float: right;
  padding: 20px;
}
#line-chart {
  width: 100vw;
}
.metrics {
  width: 100%;
  height: 100%;
  position: absolute;
}
video {
  width: 100%;
  height: 100%;
  position: fixed;
  object-fit: cover;
  z-index: 0;
  left: 0;
}
.fade-enter-active,
.fade-leave-active {
  transition: 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
.profileview {
  width: 100%;
  height: 100%;
  position: absolute;
  z-index: 1;

  left: 0%;
}
.readmore {
}
.readmorebtn {
  font-weight: 700;
  padding: 10px;
  border: none;
  background: #7387a4;
  border-radius: 20px;
}
.readmorebtn:hover {
  background: -webkit-linear-gradient(left, #3bf0a4, #38c6d3);
}
.readmorebtn:active {
  background: -webkit-linear-gradient(left, #113526, #113a3d);
  border: none;
}
#Your {
  width: 100%;
}
.Users {
  background-color: #006aae;
  color: white;
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
.imgin {
  width: 100px;
  border-radius: 50px;
  border: solid #38abe0;
  box-shadow: 0px 5px 10px 2px rgba(114, 114, 114, 0.507);
  margin-top: 5px;
}
.card {
  width: 300px;

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
.fe {
  width: 85px;
  height: 120px;
  background: linear-gradient(156.98deg, #585858 3.66%, #000000 97.3%);

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
.transform {
  -webkit-transition: all 2s ease;
  -moz-transition: all 2s ease;
  -o-transition: all 2s ease;
  -ms-transition: all 2s ease;
  transition: all 2s ease;
}

.transform-active {
  background-color: #45cee0;
  height: 200px;
  width: 200px;
}
</style>
<script>
import Linechart from "../components/Linechart.vue";
import $ from "jquery";
import Usermetrics from "../components/Usermetrics.vue";
import Addtime from "../components/Addtime.vue";
import ViewtimeV2 from "../components/ViewtimeV2.vue";
import Viewtime from "../components/Viewtime.vue";
export default {
  components: {
    Addtime,
    Usermetrics,
    Linechart,
    ViewtimeV2,
    Viewtime,
  },
  data() {
    return {
      showprofile: false,
      user: "",
      projects: "",
      logged: this.$store.state.someValue,
      arkivs: "",
      success: true,
      arr2: "",
      index: "",
      value2: "",
      datumchart: [],
      count: {},
      second: {},
      createuser: false,
      filteredArray: [],
      datacollection: null,
      loggedin: [],
      ename: "",
      eprofile: "",
      eactive: "",
      ecreated: "",
      ecompleted: "",
      newusername: "",
      newpassword: "",
      newtype: "",
    };
  },
  created() {
    const requestOptions = {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    const auth = {
      method: "POST",
      mode: "cors",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },

      body: JSON.stringify({ user: this.logged }),
    };
    fetch("https://flexn.se:3000/loggedin", auth)
      .then((response) => response.json())
      .then((result) => {
        this.loggedin = result[0];
        if (result.length == 0) {
          location.replace("https//flexnet.se/#/");
        }
        if (result.length > 0) {
          fetch("https://flexn.se:3000/workernav", requestOptions)
            .then((response) => response.json())
            .then((result) => {
              this.loggedin = result[0];
              const searchnano = {
                method: "POST",

                headers: {
                  "Content-Type": "application/json",
                  Accept: "application/json",
                },

                body: JSON.stringify({ nanoid: this.loggedin.nanoid }),
              };
              fetch("https://flexn.se:3000/getusers", searchnano)
                .then((response) => response.json())
                .then((result) => {
                  this.user = result;
                });

              fetch("https://flexn.se:3000/myprojects", requestOptions)
                .then((response) => response.json())
                .then((result) => {
                  this.myprojects = result;
                });

              fetch("https://flexn.se:3000/getarkiv", searchnano)
                .then((response) => response.json())
                .then((result) => {
                  this.arkivs = result;
                });
            });
        }
      });
  },
  methods: {
    View(id) {
      this.z = id;
      this.x = id;
      this.euser = this.user.filter((result) => result.id == this.x);
      console.log(this.euser);
      this.ename = this.euser[0].Name;
      this.eprofile = this.euser[0].Profile;
      this.eactive = this.euser[0].Active;
      this.ecreated = this.euser[0].Created;
      this.ecompleted = this.euser[0].Completion;

      this.chartdata = this.arkivs.filter(
        (arkiv) => arkiv.Author == this.euser[0].Name
      );
      console.log(this.chartdata);

      this.count = this.chartdata.map((item) => item.Datum);

      this.second = {};
      for (let i = 0; i < this.count.length; i++) {
        this.second[this.count[i]] = this.second[this.count[i]] + 1 || 1;
      }
      this.filteredArray = Object.keys(this.second).reduce((acc, cur) => {
        acc.push({ Datum: cur, result: this.second[cur] });
        return [...acc];
      }, []);

      this.index = this.chartdata
        .map((e) => e["Datum"])
        .map((e, i, final) => final.indexOf(e) === i && i)
        .filter((obj) => this.chartdata[obj])
        .map((e) => this.chartdata[e]);
    },
    createnewuser() {
      console.log(
        this.newusername,
        this.newpassword,
        this.newtype,
        this.loggedin.nanoid
      );
    },
  },
};
</script>
