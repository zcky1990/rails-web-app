<template>
<div class="container mx-auto">
  {{ data.message }}
</div>
</template>

<script>
export default {
  data: function () {
    return {
      data: {},
    };
  },
  props: {
    _datas: {},
  },
  mounted: function () {
    this.data = { ...this._datas };
  },
};
</script>
