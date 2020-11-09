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
        <facebook-login
          class="button"
          appId="462577024718487"
          @login="getUserData"
          @logout="onLogout"
          @get-initial-status="getUserData"
        >
        </facebook-login>
      </div>
    </div>
  </div>
</template>

<script>
import facebookLogin from "../../components/facebook-login/facebook-login.vue";

export default {
  data: function () {
    return {
      data: {},
    };
  },
  components: {
    facebookLogin,
  },
  props: {
    _datas: {},
  },
  mounted: function () {
    this.data = { ...this._datas };
  },
  methods: {
    onLogout: function (response) {
      
    },
    getUserData: function (response) {
      if (response.response){
        var authResponse = response.response.authResponse;
        var facebookId = authResponse.userID;
        var facebookToken = authResponse.accessToken;
        //send ajax to login in app
      }
      
      console.log("clicked")
    },
  },
};
</script>
