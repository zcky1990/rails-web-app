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
        <user-form ref="userForm"></user-form>
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
import userForm from "./user-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: [
        "Id",
        "Email",
        "FirstName",
        "LastName",
        "Birthday",
        "Address",
        "PostalCode",
        "Gender",
        "PhoneNumber",
        "Desc",
      ],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "user",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [5, 9],
        searchType: ["id", "email", "phone_number"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "USER",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("USER_SHOW", function (data) {
      self.$refs.userForm.showForm(data.data, "show", "User Data");
    });

    this.onEmitEvent("USER_EDIT", function (data) {
      self.$refs.userForm.showForm(data.data, "edit", "Edit User Data");
    });

    this.onEmitEvent("USER_REMOVE", function (data) {
      self.submitForm("/admin/user/remove", data.data, "POST");
    });

    this.onEmitEvent("USER_SEARCH", function (data) {
      self.submitForm("/admin/user/search", data, "get");
    });

    this.onEmitEvent("USER_ADD", function (data) {
      self.$refs.userForm.showForm({}, "add", "Add New User");
    });

    this.onEmitEvent("ON_ADD_USER", function (data) {
      self.$refs.userForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/user/add", data, "POST");
    });

    this.onEmitEvent("ON_EDIT_USER", function (data) {
      self.$refs.userForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/user/update", data, "POST");
    });
  },
  methods: {
    tabclick: function () {
      this.submitForm("/admin/user", {}, "get");
    },
    setData: function (data) {
      console.log(data);
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "USER";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/user/";
      if (window.location.href.includes("/search")) {
        this.options.showPaginate = false;
      }
    },
  },
  components: {
    "table-list": tableList,
    "user-form": userForm,
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
