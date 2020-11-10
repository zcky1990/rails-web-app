
<template>
  <div class="flex" @click="handleClick" :id="id">
    <button
      class="button-login bg-white text-gray font-bold sm:py-2 md:py-2 lg:py-2 sm:px-4 md:px-4 lg:px-4 rounded inline-flex items-center"
    >
      <img
        class="fill-current sm:w-4 md:w-4 lg:w-4 sm:h-4 md:h-4 lg:h-4 sm:mr-2 md:mr-2 lg:mr-2"
        :src="icon"
      />
      <span>{{ getButtonText }}</span>
    </button>
  </div>
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
.button-login {
  width: 206px;
  max-width: 206px;
  max-height: 40px;
  height: 40px;
}
</style>
