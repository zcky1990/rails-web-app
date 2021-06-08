<template>
  <section class="section index-section">
    <div class="container">
      <snake-bar ref="snackbar"></snake-bar>
      <spinner ref="spinner"></spinner>
    </div>

    <div class="columns">
      <div class="column is-3">
        <side-bar classname="product-add-on"></side-bar>
      </div>
      <div class="column is-9 right-content">
        <bread-crumb :position="'center'"></bread-crumb>
        <div class="content">
          <add-on ref="contentTab"></add-on>
        </div>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../components/shared/snackbar.vue";
import spinner from "../../components/shared/spinner.vue";
import breadCrumb from "../../components/admin/shared/admin-breadcrumb.vue";
import sidebar from "../../components/admin/shared/admin-sidebar.vue";
import contenttab from "../../components/admin/add-on/add-on-content.vue"

export default {
  data: function () {
    return {
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
      console.log(this._datas)
      this.$refs.contentTab.setData(this._datas);
    }
    if (this.notif !== null && this.notif !== undefined) {
      this.$refs.snackbar.showSnackBar(this.notif.message, this.notif.status);
    }
  },
  components: {
    "side-bar": sidebar,
    "snake-bar": snackbar,
    "spinner": spinner,
    "bread-crumb": breadCrumb,
    "add-on" : contenttab
  },
};
</script>

<style scoped>
.section {
  background: #ECF0F3;
}
</style>

