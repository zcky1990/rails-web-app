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
        <content-tab ref="contentTab"></content-tab>
      </div>
    </div>
  </section>
</template>


<script>
import snackbar from "../../../components/shared/snackbar.vue";
import contenttab from "../../../components/admin/user-tab-content.vue";

export default {
  data: function () {
    return {
      message: "",
    };
  },
  props: {
    _datas: {},
    _token: "",
  },
  created() {
    var self = this;
    this.onEmitSnackBar(function (data) {
      self.$refs.snackbar.showSnackBar(data.message, data.type);
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
      this.$refs.contentTab.setData(JSON.parse(this._datas));
    }
  },
  components: {
    "content-tab": contenttab,
    "snake-bar": snackbar,
  },
};
</script>

