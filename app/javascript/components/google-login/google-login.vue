
<template>
  <Google-Login-Button
    :params="params"
    :onSuccess="onSuccess"
    :onFailure="onFailure"
    >Login</Google-Login-Button
  >
</template>

<script>
import Vue from "vue";
import googleLogin from "./GoogleLogin.vue";

export default {
  data: function () {
    return {
      data: {},
      params: {
        client_id:
          "551900531951-ni5a2d3s61f10ueukec0iprim35nalen.apps.googleusercontent.com",
      },
      renderParams: {
        width: 250,
        height: 50,
        longtitle: true,
      },
    };
  },
  components: {
    "Google-Login-Button": googleLogin,
  },
  methods: {
    onCurrentUser(googleUser) {
      console.log("onCurrentUser", googleUser);
    },
    onSuccess(googleUser) {
      console.log("googleUser", googleUser);
      var googleId = googleUser.getId();
      var googleToken = googleUser.getAuthResponse().id_token;
      var firstName = googleUser.getBasicProfile().getGivenName();
      var lastName = googleUser.getBasicProfile().getFamilyName();
      var email = googleUser.getBasicProfile().getEmail();
      var imageUrl = googleUser.getBasicProfile().getImageUrl();
    },
    onFailure(err) {
      console.log(err);
    },
    handleClick() {
      Vue.GoogleAuth.then((auth2) => {
        console.log(auth2.isSignedIn.get());
      });
    },
  },
};
</script>

<style scoped>
</style>