<template>
  <div id="tabs-with-content">
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="icon has-text-primary is-small"
            ><i class="fas fa-user" aria-hidden="true"></i
          ></span>
          <span class="has-text-primary">User</span>
        </div>
      </div>
    </div>
    <div class="tab-content-container">
      <section class="tab-content admin tab-active">
        <admin-form ref="adminForm"></admin-form>
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
import adminForm from "./user-admin-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: ["Id", "Email", "FirstName", "LastName", "Role"],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "admin",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [5],
        searchType: ["id", "email"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "USER_ADMIN",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("USER_ADMIN_SHOW", function (data) {
      self.$refs.adminForm.showForm(data.data, "show", "Admin Data");
    });

    this.onEmitEvent("USER_ADMIN_EDIT", function (data) {
      self.$refs.adminForm.showForm(data.data, "edit", "Edit Admin Data");
    });

    this.onEmitEvent("USER_ADMIN_REMOVE", function (data) {
      self.submitForm("/admin/user/remove", data.data, "POST");
    });

    this.onEmitEvent("USER_ADMIN_SEARCH", function (data) {
      self.submitForm("/admin/user_admin/search", data, "get");
    });

    this.onEmitEvent("USER_ADMIN_ADD", function (data) {
      self.$refs.adminForm.showForm({}, "add", "Add New Admin");
    });

    this.onEmitEvent("ON_ADD_ADMIN", function (data) {
      console.log("ofc");
      self.$refs.adminForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/user_admin/add", data, "POST");
    });

    this.onEmitEvent("ON_EDIT_ADMIN", function (data) {
      console.log("asd");
      self.$refs.adminForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/user_admin/update", data, "POST");
    });
  },
  methods: {
    addData: function (dataTable, data) {
      dataTable.unshift(data);
    },
    removeData: function (dataTable, index) {
      dataTable.splice(index, 1);
    },
    tabclick: function () {
      this.submitForm("/admin/user_admin", {}, "get");
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/user_admin/";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "admin-form": adminForm,
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
