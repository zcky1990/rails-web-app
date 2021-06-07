<template>
  <div id="panel tabs-with-content">
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="subtitle is-4 algolia-lvl1">Product Price Type</span>
        </div>
      </div>
    </div>
    <div class="tab-content-container algolia-content">
      <section class="tab-content admin tab-active">
        <price-type-form ref="categoryForm"></price-type-form>
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
import tableList from "../../shared/table-list.vue";
import Form from "./price-type-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: ["Id", "Name", "Description", "is_active", "Moderated By", "Updated at"],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "price_type",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [],
        searchType: ["id", "name"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "PRICE_TYPE",
      searchUrl: "/admin/product/product-price-type",
      removeUrl: "/admin/product/remove-product-category"
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("PRICE_TYPE_SHOW", function (data) {
      self.$refs.categoryForm.showForm(data.data, "show", "Price Type Data");
    });

    this.onEmitEvent("PRICE_TYPE_EDIT", function (data) {
      self.$refs.categoryForm.showForm(data.data, "edit", "Edit Price Type Data");
    });

    this.onEmitEvent("PRICE_TYPE_ADD", function (data) {
      self.$refs.categoryForm.showForm({is_active: false}, "add", "Add New Price Type Data");
    });
  },
  methods: {
    tabclick: function () {
      window.location = "/admin/product/product-price-type";
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "PRICE_TYPE";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/product/product-price-type";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "price-type-form": Form,
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
