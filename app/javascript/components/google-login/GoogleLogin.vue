
<template>
  <button class="button is-small google" @click="handleClick" :id="id">
    <span class="icon is-small left-image">
      <img class="google-icon" :src="icon" />
    </span>
    <span class="text-btn-google">{{ getButtonText }}</span>
  </button>
</template>

<script>
let componentId = 0;
import GoogleAuth from "./GoogleAuth";
import icon from "./icon.svg";

export default {
  name: "GoogleLogin",
  props: {
    params: {
      type: Object,
      required: true,
    },
    onCurrentUser: {
      type: Function,
      default: () => {},
    },
    onSuccess: {
      type: Function,
      default: () => {},
    },
    onFailure: {
      type: Function,
      default: () => {},
    },
    loginLabel: {
      type: String,
      default: "Sign in With Google",
    },
  },
  beforeCreate() {
    this.id = `google-signin-btn-${componentId++}`;
  },
  data() {
    return {
      icon,
    };
  },
  methods: {
    handleClick() {
      const method = this.logoutButton ? "signOut" : "signIn";
      GoogleAuth[method]()
        .then((result) => {
          this.isWorking = false;
          return this.onSuccess(result);
        })
        .catch((err) => {
          this.isWorking = false;
          return this.onFailure(err);
        });
    },
  },
  computed: {
    getButtonText() {
      return this.loginLabel;
    },
  },
  mounted() {
    GoogleAuth.load(this.params)
      .then(() => {
        if (this.renderParams && this.logoutButton === false) {
          window.gapi.signin2.render(this.id, this.renderParams);
        }
        if (GoogleAuth.isSignedIn()) {
          this.onCurrentUser(GoogleAuth.currentUser());
        }
      })
      .catch((err) => {
        console.log(err);
      });
  },
};
</script>

<style>
.google {
  width: 240px;
  max-width: 240px;
  max-height: 50px;
  height: 50px;
}
.left-image{
  width: 33px !important;
  height: 33px !important;
}
.google-icon {
  display: inline-block;
  vertical-align: middle;
  width: 18px;
  height: 18px;
}
.text-btn-google {
    font-size: 14px;
    font-weight: bold;
      /* Use the Roboto font that is loaded in the <head> */
    font-family: 'Roboto', sans-serif;
}
</style>
