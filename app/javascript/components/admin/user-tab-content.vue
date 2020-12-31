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
        <table-list
          ref="admin"
          v-bind:tableHeaders="adminTableHeaders"
          v-bind:dataTable="adminDataTable"
          v-bind:hideColumn="adminHideColumn"
          v-bind:actionShow="adminActionShow"
          v-bind:keyEvent="keyEventAdmin"
          v-bind:page="page"
          v-bind:totalPage="totalPage"
          v-bind:searchType="adminSearchType"
        ></table-list>
      </section>
      <section class="tab-content user">
        <table-list
          ref="user"
          v-bind:tableHeaders="adminTableHeaders"
          v-bind:dataTable="adminDataTable"
          v-bind:hideColumn="adminHideColumn"
          v-bind:actionShow="adminActionShow"
          v-bind:keyEvent="keyEventAdmin"
          v-bind:maxRow="maxRow"
        ></table-list>
      </section>
    </div>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";
import tableList from "./table-list.vue";

export default {
  data: function () {
    return {
      adminTableHeaders: ["0", "1", "2", "3", "4"],
      adminDataTable: [{ a: "asd", b: "dasdasdasda", c: "1sadasdas", d: "1asdas", e: "esda" }],
      adminHideColumn: [0],
      adminActionShow: true,
      keyEventAdmin: "USER_ADMIN",
      adminSearchType:["email", "user_id"],
      maxRow: 10,
      page:1,
      totalPage: 80
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("USER_ADMIN_SHOW", function (data) {
      let a = { a: "asd", b: "d", c: "1", d: "1", e: "esda" };
      self.addData(self.adminDataTable, a);
    });
    this.onEmitEvent("USER_ADMIN_EDIT", function (data) {
      console.log(data);
    });
    this.onEmitEvent("USER_ADMIN_REMOVE", function (data) {
      let index = data.index;
      self.removeData(self.adminDataTable, index);
    });
    this.onEmitEvent("USER_ADMIN_LIST", function (data) {
      self.page = data.page
    });
    this.onEmitEvent("USER_ADMIN_SEARCH", function (data) {
      console.log(data);
    });
  },
  methods: {
    addData: function (dataTable, data) {
      dataTable.push(data);
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
