<template>
  <div id="tabs-with-content">
    <div class="tabs is-boxed">
      <ul>
        <li class="tab is-active" v-on:click="tabclick">
          <a>
            <span class="icon is-small"
              ><i class="fas fa-user" aria-hidden="true"></i
            ></span>
            <span>User</span>
          </a>
        </li>
      </ul>
    </div>
    <div class="tab-content-container">
      <section class="tab-content admin tab-active">
        <user-form ref="userForm"></user-form>
        <table-list
          :objectData="user"
          :isPaginateTableShow="showPaginate"
        ></table-list>
      </section>
    </div>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";
import tableList from "./table-list.vue";
import userForm from "./user-form.vue";

export default {
  data: function () {
    return {
      showPaginate: true,
      user: {
        tableHeaders: ["id", "email", "firstname", "lastname"],
        tabelData: [],
        hiddenColumn: [],
        isShowActionColumn: true,
        keyEvent: "USER",
        searchType: ["email", "id"],
        type: "user",
        maxRow: 10,
        totalPage: 1,
        totalData: 1,
        page: 1,
        tableListUrl: "",
      },
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
    addData: function (dataTable, data) {
      dataTable.unshift(data);
    },
    removeData: function (dataTable, index) {
      dataTable.splice(index, 1);
    },
    tabclick: function () {
      this.submitForm("/admin/user", {}, "get");
    },
    setData: function (data) {
      this.user = data;
      this.user.isShowActionColumn = true;
      this.user.keyEvent = "USER";
      this.user.searchType = ["email", "id"];
      this.user.tableListUrl = "/admin/user/";
      if (window.location.href.includes("/search")) {
        this.showPaginate = false;
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
