<template>
  <div id="panel tabs-with-content">
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="subtitle is-4 algolia-lvl1">Product List</span>
        </div>
      </div>
    </div>
    <div class="tab-content-container">
      <section class="tab-content admin tab-active">
        <product-form ref="productForm"></product-form>
        <table-list
          :headers="headers"
          :dataTable="table"
          :options="options"
          :paginationOptions="paginationOptions"
          :keyEvent="keyEvent"
          :searchUrl="searchUrl"
          :removeUrl="removeUrl"
        ></table-list>
      </section>
    </div>
  </div>
</template>

<script>
import tableList from "./../../shared/table-list.vue";
import Form from "./product-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: [
        "Id",
        "Product Name",
        "Product Category Id",
        "Product Category",
        "Price",
        "Stock",
        "Status",
        "Is Active",
        "Moderated By",
        "Updated Date",
      ],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "product",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [2,4, 7],
        searchType: ["id", "name", "product_category", "price"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "PRODUCT",
      searchUrl: "/admin/product/product-list",
      removeUrl: "/admin/product/remove-product-list",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("PRODUCT_SHOW", function (data) {
      self.$refs.productForm.showForm(data.data, "show", "View Product");
      console.log(self.itemsTags);
    });

    this.onEmitEvent("PRODUCT_ADD", function (data) {
      self.$refs.productForm.showForm({price:[],product_category_id: "", is_active: false}, "add", "Add New Product");
    });

    this.onEmitEvent("PRODUCT_EDIT", function (data) {
      self.$refs.productForm.showForm(data.data, "edit", "Edit Product Data");
    });
  },
  methods: {
    tabclick: function () {
      window.location = "/admin/product/product-list";
    },
    setData: function (data) {
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "PRODUCT";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/product/product-list";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "product-form": Form,
  },
};
</script>

<style scoped>
/* Let's get this party started */
::-webkit-scrollbar {
  width: 4px;
  height: 4px;
}

/* Track */
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 2px rgba(0, 0, 0, 0.3);
  -webkit-border-radius: 2px;
  border-radius: 2px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  -webkit-border-radius: 2px;
  border-radius: 2px;
  background: #dbdbdb;
  -webkit-box-shadow: inset 0 0 2px rgba(0, 0, 0, 0.5);
}
::-webkit-scrollbar-thumb:window-inactive {
  background: grey;
}

.tabs {
  border-bottom: 1px solid #dbdbdb;
}
.tab-content {
  display: none;
}
.tab-active {
  display: block;
}
</style>
