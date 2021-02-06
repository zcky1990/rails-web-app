<template>
  <section class="section index-section">
    <div class="container">
      <snake-bar ref="snackbar"></snake-bar>
      <spinner ref="spinner"></spinner>
    </div>
    <div class="container">
      <div class="container">
        {{ message }}
      </div>
      <div class="container">
        <content-tab ref="contentTab"></content-tab>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../../components/shared/snackbar.vue";
import spinner from "../../../components/shared/spinner.vue";
import contenttab from "../../../components/admin/user/user-content.vue";

export default {
  data: function () {
    return {
      message: "",
    };
  },
  props: {
    _datas: {},
    notif: {},
    _token: "",
  },
  created() {
    var self = this;
    this.onEmitSnackBar(function (data) {
      self.$refs.snackbar.showSnackBar(data.message, data.type);
    });

    this.onShowSpinner(function () {
      self.$refs.spinner.showSpinner();
    });

    this.onHideSpinner(function () {
      self.$refs.spinner.hideSpinner();
    });
  },
  mounted: function () {
    if (
      this._datas !== null &&
      !(
        Object.keys(this._datas).length === 0 &&
        this._datas.constructor === Object
      )
    ) {
      this.$refs.contentTab.setData(this._datas);
    }
    if (this.notif !== null) {
      this.$refs.snackbar.showSnackBar(this.notif.message, this.notif.status);
    }
  },
  components: {
    "content-tab": contenttab,
    "snake-bar": snackbar,
    spinner: spinner,
  },
};
</script>

