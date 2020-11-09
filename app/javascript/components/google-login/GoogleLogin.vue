
<template>
  <div class="google-btn" @click="handleClick" :id="id">
    <div class="google-icon-wrapper">
      <img class="google-icon" :src="icon" />
    </div>
    <p class="btn-text"><b>Sign in with google</b></p>
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
    logoutButton: {
      type: Boolean,
      default: false,
    },
    renderParams: {
      type: Object,
      required: false,
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
.google-btn {
  width: 225px;
  height: 42px;
  background-color: #4285f4;
  border-radius: 2px;
  box-shadow: 0 3px 4px 0 rgba(0, 0, 0, 0.25);
}
.google-icon-wrapper {
  position: absolute;
  margin-top: 1px;
  margin-left: 1px;
  width: 40px;
  height: 40px;
  border-radius: 2px;
  background-color: #fff;
}
.google-icon {
  position: absolute;
  margin-top: 11px;
  margin-left: 11px;
  width: 18px;
  height: 18px;
}
.btn-text {
  position: relative;
  line-height: 42px;
  min-width: 225px;
  padding: 0 15px 0px 46px;
  color: #fff;
  font-size: 14px;
  letter-spacing: 0.2px;
}
.google-btn:hover {
  box-shadow: 0 0 6px #4285f4;
}
.google-btn:active {
  background: #1669f2;
}
</style>
