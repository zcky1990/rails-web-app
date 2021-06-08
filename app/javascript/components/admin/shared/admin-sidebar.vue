<template>
  <aside class="menu">
    <p class="menu-label">General</p>
    <ul class="menu-list">
      <li><a :class="[classname === 'dashboard' ? 'is-active': '' ]" href="/admin">Dashboard</a></li>
      <li><a :class="[classname === 'customer' ? 'is-active': '' ]" href="/admin/customer">Customers</a></li>
    </ul>
    <p class="menu-label">Inventory</p>
    <ul class="menu-list">
      <li><a :class="[classname === 'product-category' ? 'is-active': '' ]" href="/admin/product/product-category" >Product Category</a></li>
      <li><a :class="[classname === 'product-price-type' ? 'is-active': '' ]" href="/admin/product/product-price-type" >Product Price Type</a></li>
      <li><a :class="[classname === 'product-add-on' ? 'is-active': '' ]" href="/admin/product/product-add-on" >Product Add-on</a></li>
      <li><a :class="[classname === 'product-list' ? 'is-active': '' ]" href="/admin/product/product-list" >Product List</a></li>
    </ul>
    <p class="menu-label">Transactions</p>
    <ul class="menu-list">
      <li><a :class="[classname === 'payment' ? 'is-active': '' ]" >Payments</a></li>
      <li><a>Transfers</a></li>
      <li><a>Balance</a></li>
    </ul>
  </aside>
</template>

<script>
export default {
  props: {
    classname: String,
  },
  data: function () {
    return {
      isShow: false,
    };
  },
  methods: {
    showSpinner() {
      this.isShow = true;
    },
    hideSpinner() {
      this.isShow = false;
    },
  },
};
</script>

<style scoped>

</style>
