<template>
  <div class="app-layout">
    <div class="flex sm:flex-col md:flex-row lg:flex-row xl:flex-row flex-wrap">
      <div class="w-full md:w-1/5 bg-gray-400 p-4 text-center text-gray-700">
        {{ data.message }}
      </div>
      <div class="w-full md:w-3/5 bg-gray-500 p-4 text-center text-gray-200">
        <div class="container mx-auto">
          {{ data.message }}
        </div>
      </div>
      <div class="w-full md:w-1/5 bg-blue-400 p-4 text-center text-gray-700">
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

