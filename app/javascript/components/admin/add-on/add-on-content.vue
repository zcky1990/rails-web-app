<template>
  <div id="panel tabs-with-content">
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="subtitle is-4 algolia-lvl1">Add On</span>
        </div>
      </div>
    </div>
    <div class="tab-content-container algolia-content">
      <section class="tab-content admin tab-active">
        <add-On-form ref="addOnForm"></add-On-form>
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
import Form from "./add-on-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: ["Id", "Name", "Price", "is_active", "Moderated By", "Updated at"],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "add_on",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [],
        searchType: ["id", "name", "price"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "ADD_ON",
      searchUrl: "/admin/product/product-add-on",
      removeUrl: "/admin/product/remove-add-on"
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("ADD_ON_SHOW", function (data) {
      self.$refs.addOnForm.showForm(data.data, "show", "Show Add-On Data");
    });

    this.onEmitEvent("ADD_ON_EDIT", function (data) {
      self.$refs.addOnForm.showForm(data.data, "edit", "Edit Add-On Data");
    });

    this.onEmitEvent("ADD_ON_ADD", function (data) {
      self.$refs.addOnForm.showForm({is_active: false}, "add", "Add New Add-On Data");
    });
  },
  methods: {
    tabclick: function () {
      window.location = "/admin/product/product-add-on";
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "ADD_ON";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/product/product-add-on";
      if (window.location.href.includes("?typeSearch")) {
        this.options.showPaginate = false;
      }else if(this.table.length == 0){
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "add-On-form": Form,
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
