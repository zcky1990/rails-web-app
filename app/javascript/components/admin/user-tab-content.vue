<template>
  <div id="tabs-with-content">
    <div class="tabs is-centered is-boxed">
      <ul>
        <li class="tab admin is-active" v-on:click="onClickTab">
          <a>
            <span class="icon is-small"
              ><i class="fas fa-user" aria-hidden="true"></i
            ></span>
            <span>Admin</span>
          </a>
        </li>
        <li class="tab user" v-on:click="onClickTab">
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
        <admin-form ref="adminForm"></admin-form>
        <table-list ref="admin" :objectData="admin"></table-list>
      </section>
      <section class="tab-content user">
        <!-- <table-list
          ref="user"
        ></table-list> -->
      </section>
    </div>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";
import tableList from "./table-list.vue";
import adminForm from "./user-admin-form.vue";

export default {
  data: function () {
    return {
      admin: {
        tableHeaders: ["email", "firstname", "lastname"],
        tabelData: [],
        hiddenColumn: [],
        isShowActionColumn: true,
        keyEvent: "USER_ADMIN",
        searchType: ["email", "id"],
        type: "Admin",
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
      console.log(data);
    });

    this.onEmitEvent("USER_ADMIN_ADD", function (data) {
      self.$refs.adminForm.showForm({}, "add", "Add New Admin");
    });

    this.onEmitEvent("ON_ADD_ADMIN", function (data) {
      self.$refs.adminForm.hideForm();
      self.showSpinner();
      self.submitForm("/admin/user/add", data, "POST");
    });

    this.onEmitEvent("ON_EDIT_ADMIN", function (data) {
      self.$refs.adminForm.hideForm();
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
    onClickTab: function (event) {
      var currentEl = event.currentTarget;
      var prevActiveTab = document.querySelector(".is-active");
      prevActiveTab.classList.remove("is-active");
      currentEl.classList.add("is-active");
      var currSection = "";
      if (currentEl.classList.contains("user")) {
        currSection = "user";
      } else {
        currSection = "admin";
      }
      var prevActiveContent = document.querySelector(".tab-active");
      prevActiveContent.classList.remove("tab-active");
      var currentActiveContent = document.querySelector(
        ".tab-content" + "." + currSection
      );
      currentActiveContent.classList.add("tab-active");
    },
    setData: function (data) {
      if (data.type == "admin") {
        this.admin = data;
        this.admin.isShowActionColumn = true;
        this.admin.keyEvent = "USER_ADMIN";
        this.admin.searchType = ["email", "id"];
        this.admin.tableListUrl = "/admin/user/";
      } else {
        this.user = data;
        this.user.isShowActionColumn = true;
        this.user.keyEvent = "USER";
        this.user.searchType = ["email", "id"];
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
