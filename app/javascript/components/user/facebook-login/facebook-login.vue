<template>
  <Facebook-Login-Button
    class="button"
    appId="462577024718487"
    @login="getUserData"
    @get-initial-status="getUserData"
  >
  </Facebook-Login-Button>
</template>

<script>
import facebookLogin from "./FacebookLogin.vue";

export default {
  data() {
    return {};
  },
  components: {
    "Facebook-Login-Button": facebookLogin,
  },
  methods: {
    onLogout: function (response) {},
    getUserData: function (response) {
      if (response.response) {
        var authResponse = response.response.authResponse;
        var facebookId = authResponse.userID;
        var facebookToken = authResponse.accessToken;
        //send ajax to login in app
        console.log(authResponse);
      }

      console.log("clicked");
    },
  },
};
</script>