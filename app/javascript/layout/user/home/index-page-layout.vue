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
        <facebook-btn></facebook-btn>
        <google-btn></google-btn>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../../components/shared/snackbar.vue";
import facebookLogin from "../../../components/user/facebook-login/facebook-login.vue";
import googleLogin from "../../../components/user/google-login/google-login.vue";

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
    if(this._datas !== null){
      this.data = this._datas;
    }
  },
  components: {
    "facebook-btn": facebookLogin,
    "google-btn": googleLogin,
    "snake-bar": snackbar,
  },
  created() {
   var self = this;
    this.onEmitSnackBar(function (data){
      self.$refs.snackbar.showSnackBar(data.message, data.type);
    })
  },
  methods: {
    
  }
};
</script>

