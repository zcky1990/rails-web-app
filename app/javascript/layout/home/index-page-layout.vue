<template>
  <div id="app-layout">
    <p>{{ data.message }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      data: {}
    }
  },
  props:{
    _datas: {}
  },
  mounted: function() {
    this.data = { ...this._datas };
  }
}
</script>
