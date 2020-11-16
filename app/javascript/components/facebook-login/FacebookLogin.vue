<template>
  <button class="button is-small facebook" @click="buttonClicked">
    <span class="icon is-small left-image">
      <img class="fb-icon" :src="icon" />
    </span>
    <span class="text-btn-facebook">{{ getButtonText }}</span>
  </button>
</template>

<script>
import { loadFbSdk, getFbLoginStatus, fbLogout, fbLogin } from "./helpers.js";

// Resources
import icon from "./icon.png";

export default {
  props: {
    appId: {
      type: String,
      required: true,
    },
    version: {
      type: String,
      default: "v2.10",
    },
    loginLabel: {
      type: String,
      default: "Login With Facebook",
    },
    loginOptions: {
      type: Object,
      default: function () {
        return {
          scope: "email",
        };
      },
    },
  },
  data() {
    return {
      isConnected: false,
      icon,
    };
  },
  mounted() {
    loadFbSdk(this.appId, this.version)
      .then(getFbLoginStatus)
      .then((response) => {
        if (response.status === "connected") {
          this.isConnected = true;
        }
        /** Event `get-initial-status` to be deprecated in next major version! */
        this.$emit("get-initial-status", response);
        this.$emit("sdk-loaded", {
          isConnected: this.isConnected,
          FB: window.FB,
        });
      });
  },
  computed: {
    getButtonText() {
      return this.loginLabel;
    },
  },
  methods: {
    buttonClicked() {
      this.$emit("click");
      this.login();
    },
    login() {
      this.isWorking = true;
      fbLogin(this.loginOptions).then((response) => {
        if (response.status === "connected") {
          this.isConnected = true;
        } else {
          this.isConnected = false;
        }
        this.$emit("login", {
          response,
          FB: window.FB,
        });
      });
    },
    logout() {
      fbLogout().then((response) => {
        this.isConnected = false;
        this.$emit("logout", response);
      });
    },
  },
};
</script>

<style scoped>
.facebook {
  width: 240px;
  max-width: 240px;
  max-height: 50px;
  height: 50px;
  background: #3B5998;
  color: white;
}
.left-image{
  width: 33px !important;
  height: 33px !important;
}
.fb-icon {
  display: inline-block;
  vertical-align: middle;
  width: 18px;
  height: 18px;
}
.text-btn-facebook {
    font-size: 14px;
    font-weight: bold;
}
</style>