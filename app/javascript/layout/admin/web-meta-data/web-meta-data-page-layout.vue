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
        <login-form></login-form>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../../components/shared/snackbar.vue";
import loginForm from "../../../components/admin/web-meta-form.vue";

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
  created() {
    var self = this;
    this.onEmitSnackBar(function (data){
      self.$refs.snackbar.showSnackBar(data.message, data.type);
    })
  },
  mounted: function () {
    if(this._datas !== null){
      this.data = this._datas;
    }
  },
  components: {
    "login-form": loginForm,
    "snake-bar": snackbar,
  }
};
</script>

