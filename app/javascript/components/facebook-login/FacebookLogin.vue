<template>
  <div class="flex" @click="buttonClicked">
    <button
      class="button-login bg-gradient-to-r from-indigo-700 to-indigo-800 text-white font-bold py-2 px-4 rounded inline-flex items-center"
    >
      <img class="fill-current w-4 h-4 mr-2" :src="icon" />
      <span>{{ getButtonText }}</span>
    </button>
  </div>
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
.button-login {
  width: 206px;
  max-width: 206px;
  max-height: 40px;
  height: 40px;
}
</style>