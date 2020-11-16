<template>
  <div class="app-layout">
    <div class="">
      <div class="">
        {{ data.message }}
      </div>
      <div class="">
        <div class="container">
          {{ data.message }}
        </div>
      </div>
      <div class="">
        <Facebook-Btn></Facebook-Btn>
        <Google-Btn></Google-Btn>
      </div>
    </div>
  </div>
</template>

<script>
import facebookLogin from "../../components/facebook-login/facebook-login.vue";
import googleLogin from "../../components/google-login/google-login.vue";

export default {
  data: function () {
    return {
      data: {},
    };
  },
  components: {
    "Facebook-Btn": facebookLogin,
    "Google-Btn": googleLogin,
  },
  props: {
    _datas: {},
  },
  mounted: function () {
    this.data = { ...this._datas };
  },
  methods: {},
};
</script>

