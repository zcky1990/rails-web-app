<template>
  <div class="container pagination-page">
    <nav
      class="pagination is-right is-fullwidth is-small"
      role="navigation"
      aria-label="pagination"
    >
      <a v-on:click="onClickPaginaton" id="prev" class="pagination-previous"
        >Previous</a
      >
      <a v-on:click="onClickPaginaton" id="next" class="pagination-next"
        >Next page</a
      >
      <ul class="pagination-list">
        <li v-if="showFirstPage() == true" v-on:click="onClickPaginaton" id="1">
          <a class="pagination-link" aria-label="Goto page 1">1</a>
        </li>
        <li v-if="showPrevElipsis() == true">
          <span class="pagination-ellipsis">&hellip;</span>
        </li>
        <li
          v-if="showPrev() === true"
          v-on:click="onClickPaginaton"
          :id="`${getPrevPage()}`"
        >
          <a class="pagination-link">{{ getPrevPage() }}</a>
        </li>
        <li>
          <a
            :id="`${getCurrentPage()}`"
            v-on:click="onClickPaginaton"
            class="pagination-link is-current"
            aria-current="page"
            >{{ getCurrentPage() }}</a
          >
        </li>
        <li
          v-if="showNext() == true"
          v-on:click="onClickPaginaton"
          :id="`${getNextPage()}`"
        >
          <a class="pagination-link">{{ getNextPage() }}</a>
        </li>
        <li v-if="showNextElipsis() == true">
          <span class="pagination-ellipsis">&hellip;</span>
        </li>
        <li>
          <a
            v-if="showLastPage() == true"
            v-on:click="onClickPaginaton"
            :id="`${totalPage}`"
            class="pagination-link"
            aria-label="Goto page 86"
            >{{ totalPage }}</a
          >
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";

export default {
  props: {
    page: Number,
    totalPage: Number,
    type: String,
    url: String,
  },
  methods: {
    firstPage: function () {
      return 1;
    },
    lastPage: function () {
      return this.totalPage;
    },
    showFirstPage: function () {
      if (this.page >= 3) {
        return true;
      }
      return false;
    },
    showLastPage: function () {
      if (this.totalPage - this.page >= 2) {
        return true;
      }
      return false;
    },
    showPrev: function () {
      if (this.page == 1) {
        return false;
      }
      return true;
    },
    showNext: function () {
      if (this.page <= this.totalPage - 1) {
        return true;
      }
      return false;
    },
    showPrevElipsis: function () {
      if (this.page - 1 > 2) {
        return true;
      }
      return false;
    },
    showNextElipsis: function () {
      if (this.totalPage - this.page > 2) {
        return true;
      }
      return false;
    },
    getCurrentPage: function () {
      return this.page;
    },
    getPrevPage: function () {
      if (this.totalPage === 1) {
        return 1;
      }
      if (this.page === 1) {
        return this.page;
      } else {
        return parseInt(this.page) - 1;
      }
    },
    getNextPage: function () {
      if (this.totalPage === 1) {
        return 1;
      }
      if (this.page === this.lastPage()) {
        return this.page;
      } else {
        return parseInt(this.page) + 1;
      }
    },
    getNumberOfColumn: function () {
      return this.tableHeaders.length;
    },
    isDataEmpty: function () {
      if (this.dataTable === undefined || this.dataTable.length == 0) {
        return true;
      } else {
        return false;
      }
    },
    getData: function (index) {
      return this.dataTable[index];
    },
    onClickPaginaton: function (event) {
      let id = event.currentTarget.id;
      let targetPage = 0;
      if (id == "prev") {
        targetPage = this.getPrevPage();
      } else if (id == "next") {
        targetPage = this.getNextPage();
      } else {
        targetPage = parseInt(id);
      }
      let params = {
        type: this.type,
        page: targetPage,
      };
      this.submitFormPageList(this.url, params, "get");
    },
    submitFormPageList: function (path, params, method) {
      const form = document.createElement("form");
      form.method = method;
      form.action = path;
      for (const key in params) {
        if (params.hasOwnProperty(key)) {
          const hiddenField = document.createElement("input");
          hiddenField.type = "hidden";
          hiddenField.name = key;
          hiddenField.value = params[key];

          form.appendChild(hiddenField);
        }
      }
      document.body.appendChild(form);
      form.submit();
    },
  },
};
</script>

<style scoped>
.padded {
  padding: 25px;
}
.pagination-page {
  padding: 2rem;
  width: 100% !important;
  position: absolute;
}
</style>
