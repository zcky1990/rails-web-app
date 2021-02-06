<template>
  <section class="section index-section">
    <div class="container">
      <snake-bar ref="snackbar"></snake-bar>
    </div>
    <div class="container">
      <div class="container">
        {{ message }}
      </div>
      <div class="container">
        <login-form ref="loginForm"></login-form>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../../components/shared/snackbar.vue";
import loginForm from "../../../components/admin/web-meta/web-meta-form.vue";

export default {
  data: function () {
    return {
      message: ""
    };
  },
  props: {
    _datas: {},
    _token: ""
  },
  created() {
    var self = this;
    this.onEmitSnackBar(function (data){
      self.$refs.snackbar.showSnackBar(data.message, data.type);
    })
  },
  mounted: function () {
    if(this._datas !== null && !(Object.keys(this._datas).length === 0 && this._datas.constructor === Object)){
      this.$refs.loginForm.setData(this._datas);
    }
    if (this.notif !== null && this.notif !== undefined) {
      this.$refs.snackbar.showSnackBar(this.notif.message, this.notif.status);
    }
  },
  components: {
    "login-form": loginForm,
    "snake-bar": snackbar,
  }
};
</script>

