<template>
  <section class="section index-section">
    <div class="container">
      <snake-bar ref="snackbar"></snake-bar>
    </div>
    <div class="container">
      <div class="container">
        {{ data.message }}
      </div>
      <div class="container">
        <Facebook-Btn></Facebook-Btn>
        <Google-Btn></Google-Btn>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../components/shared/snackbar.vue";
import { EventBus } from "../../plugins/eventbus.js";
import facebookLogin from "../../components/facebook-login/facebook-login.vue";
import googleLogin from "../../components/google-login/google-login.vue";

export default {
  data: function () {
    return {
      data: {
        message: "",
      },
    };
  },
  props: {
    _datas: {},
  },
  mounted: function () {
    this.data = this._datas;
  },
  components: {
    "Facebook-Btn": facebookLogin,
    "Google-Btn": googleLogin,
    "snake-bar": snackbar,
  },
  created() {
    EventBus.$on("SNACKBAR_TRIGGERED", (val) => {
      this.showSnackbar(val.message, val.type);
    });
  },
  methods: {
    showSnackbar: function (message, type) {
      this.$refs.snackbar.showSnackBar(message, type);
    },
  },
};
</script>

