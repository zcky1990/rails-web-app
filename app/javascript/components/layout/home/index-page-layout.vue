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
    console.log("reasdasda")
    this.data = { ...this._datas };
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
