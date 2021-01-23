<template>
  <div id="tabs-with-content">
    <div class="tabs is-boxed">
      <ul>
        <li class="tab is-active" v-on:click="tabclick">
          <a>
            <span class="icon has-text-primary is-small"
              ><i class="fas fa-user" aria-hidden="true"></i
            ></span>
            <span class="has-text-primary" >Category</span>
          </a>
        </li>
      </ul>
    </div>
    <div class="tab-content-container">
      <section class="tab-content admin tab-active">
        <category-form ref="categoryForm"></category-form>
        <table-list
          :headers="headers"
          :dataTable="table"
          :options="options"
          :paginationOptions="paginationOptions"
          :keyEvent="keyEvent"
        ></table-list>
      </section>
    </div>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";
import tableList from "./table-list.vue";
import Form from "./category-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: [
        "Id",
        "Name",  
        "Desc",
        "Status",
        "Moderated By"
      ],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "category",
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
      keyEvent: "CATEGORY",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("CATEGORY_SHOW", function (data) {
      self.$refs.categoryForm.showForm(data.data, "show", "Category Data");
    });

    this.onEmitEvent("CATEGORY_EDIT", function (data) {
      self.$refs.categoryForm.showForm(data.data, "edit", "Edit Category Data");
    });

    this.onEmitEvent("CATEGORY_REMOVE", function (data) {
      self.submitForm("/admin/category/remove", data.data, "POST");
    });

    this.onEmitEvent("CATEGORY_SEARCH", function (data) {
      self.submitForm("/admin/category/search", data, "get");
    });

    this.onEmitEvent("CATEGORY_ADD", function (data) {
      self.$refs.categoryForm.showForm({}, "add", "Add New Category");
    });

    this.onEmitEvent("ON_ADD_CATEGORY", function (data) {
      self.$refs.categoryForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/category/add", data, "POST");
    });

    this.onEmitEvent("ON_EDIT_CATEGORY", function (data) {
      self.$refs.categoryForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/category/update", data, "POST");
    });
  },
  methods: {
    tabclick: function () {
      this.submitForm("/admin/category", {}, "get");
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "CATEGORY";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/category/";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "category-form": Form,
  },
};
</script>

<style scoped>
.tab-content {
  display: none;
}
.tab-active {
  display: block;
}
</style>
