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
      currentIndex: null,
      admin: {
        tableHeaders: ["email", "firstname", "lastname"],
        tabelData: [
          // { email: "asd@a.com", first_name: "1sadasdas", last_name: "1asdas" },
        ],
        hiddenColumn: [],
        isShowActionColumn: true,
        keyEvent: "USER_ADMIN",
        searchType: ["email", "id"],
        type: "Admin",
        maxRow: 10,
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("USER_ADMIN_SHOW", function (data) {
      self.$refs.adminForm.showForm(data.data, "show", "Admin Data");
      // let a = { a: "asd", b: "d", c: "1", d: "1", e: "esda" };
      // if (self.adminDataTable.length <= self.adminTablemaxRow) {
      //   self.addData(self.adminDataTable, a);
      // } else {
      //   self.addData(self.adminDataTable, a);
      //   self.adminTotalData = self.adminTotalData + 1;
      //   self.adminDataTotalPage = Math.ceil(
      //     self.adminTotalData / self.adminTablemaxRow
      //   );
      //   self.adminDataTable.pop();
      // }
    });

    this.onEmitEvent("USER_ADMIN_EDIT", function (data) {
      self.currentIndex = data.index;
      self.$refs.adminForm.showForm(data.data, "edit", "Edit Admin Data");
    });

    this.onEmitEvent("USER_ADMIN_REMOVE", function (data) {
      let index = data.index;
      self.removeData(self.adminDataTable, index);
    });

    this.onEmitEvent("USER_ADMIN_LIST", function (data) {
      if (self.adminCurrentPage != data.page) {
        self.adminCurrentPage = data.page;
        console.log(data);
      }
    });

    this.onEmitEvent("USER_ADMIN_SEARCH", function (data) {
      console.log(data);
    });

    this.onEmitEvent("USER_ADMIN_ADD", function (data) {
      console.log("adasd");
      self.$refs.adminForm.showForm({}, "add", "Add New Admin");
    });

    this.onEmitEvent("ON_ADD_ADMIN", function (data) {
      self.$refs.adminForm.hideForm();
      self.showSpinner();
      let headers = self.getJsonHeaders();
      self.post(
        "/api/admin/user/add_new_admin",
        data,
        headers,
        function (response) {
          debugger;
          if (response.data.status === "success") {
            responseData = response.data.data;
            if (self.admin.tabelData.length <= self.admin.maxRow) {
              self.addData(self.admin.tabelData, responseData);
            } else {
              self.addData(self.admin.tabelData, responseData);
              self.admin.totalData = self.admin.totalData + 1;
              self.admin.totalPage = Math.ceil(
                self.admin.totalData / self.admin.maxRow
              );
              self.admin.tabelData.pop();
            }
            self.hideSpinner();
          } else {
            self.hideSpinner();
            self.showSnackBar(response.data.error_message, "error");
          }
        },
        function (e) {
          self.hideSpinner();
          self.showSnackBar(e.message, "error");
        }
      );
    });

    this.onEmitEvent("ON_EDIT_ADMIN", function (data) {
      self.$refs.adminForm.hideForm();
      self.showSpinner();
      let headers = self.getJsonHeaders();
      self.post(
        "/api/admin/user/update_admin",
        data,
        headers,
        function (response) {
          debugger;
          if (response.data.status === "success") {
            self.removeData(self.currentIndex);
            self.currentIndex = null;
            responseData = response.data.data;
            self.addData(self.admin.tabelData, responseData);
            self.hideSpinner();
          } else {
            self.hideSpinner();
            self.showSnackBar(response.data.error_message, "error");
          }
        },
        function (e) {
          self.hideSpinner();
          self.showSnackBar(e.message, "error");
        }
      );
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
    setData: function (data) {},
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
