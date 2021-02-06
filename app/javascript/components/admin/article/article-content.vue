<template>
  <div id="panel tabs-with-content">
    <bread-crumb :position="'center'"></bread-crumb>
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="has-text-primary">Article</span>
        </div>
      </div>
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
import tableList from "./../../shared/table-list.vue";
import Form from "./article-form.vue";
import breadCrumb from "./../../shared/admin-breadcrumb.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: ["Id", "Title", "Slug", "Is Publish", "Moderated By"],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "article",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [],
        searchType: ["id", "slug"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "ARTICLE",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("ARTICLE_SHOW", function (data) {
      self.$refs.categoryForm.showForm(data.data, "show", "View Article");
      console.log(self.itemsTags);
    });

    this.onEmitEvent("ARTICLE_ADD", function (data) {
      self.$refs.categoryForm.showForm({}, "add", "Add New Article");
    });

    this.onEmitEvent("ARTICLE_EDIT", function (data) {
      self.$refs.categoryForm.showForm(data.data, "edit", "Edit Article Data");
    });

    this.onEmitEvent("ARTICLE_REMOVE", function (data) {
      self.submitForm("/admin/article/remove", data.data, "POST");
    });

    this.onEmitEvent("ARTICLE_SEARCH", function (data) {
      self.submitForm("/admin/article/search", data, "get");
    });

    this.onEmitEvent("ON_ADD_ARTICLE", function (data) {
      self.$refs.categoryForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/article/add", data, "POST");
    });

    this.onEmitEvent("ON_EDIT_ARTICLE", function (data) {
      self.$refs.categoryForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/article/update", data, "POST");
    });
  },
  methods: {
    tabclick: function () {
      this.submitForm("/admin/article", {}, "get");
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "ARTICLE";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/article/";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "category-form": Form,
    "bread-crumb": breadCrumb,
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
