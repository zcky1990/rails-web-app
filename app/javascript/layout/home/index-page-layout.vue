<template>
<div class="mx-auto">
  <div class="flex sm:flex-col md:flex-row lg:flex-row xl:flex-row flex-wrap">
    <div class="w-full md:w-1/4 bg-gray-400 p-4 text-center text-gray-700"> {{ data.message }}</div>
    <div class="w-full md:w-2/4 bg-gray-500 p-4 text-center text-gray-200"> {{ data.message }}</div>
    <div class="w-full md:w-1/4 bg-gray-400 p-4 text-center text-gray-700"> {{ data.message }}</div>
  </div> 
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
