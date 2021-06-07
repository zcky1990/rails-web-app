<template>
  <div class="table-content-container algolia-content">
    <div class="container">
      <div class="columns">
        <div class="column"></div>
        <div class="column">
          <div class="field is-grouped is-grouped-right">
            <p class="control">
              <a v-on:click="onAddNewUser" class="button is-primary is-small">
                Add New {{ options.type }}
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="columns">
        <div class="column"></div>
        <div class="column">
          <div class="field has-addons">
            <form
              class="control"
              id="serachbar"
              @submit="onSearch"
              :action="searchUrl"
              method="get"
            >
              <div class="control">
                <span
                  class="select is-small"
                  :class="isShowError ? 'is-danger' : ''"
                >
                  <select v-model="typeSearch" name="typeSearch">
                    <option disabled value="">Please select one</option>
                    <option
                      v-for="(value, index) in options.searchType"
                      :key="`data-${index}`"
                    >
                      {{ value }}
                    </option>
                  </select>
                </span>
              </div>
              <div class="control is-expanded">
                <input
                  :class="isShowError ? 'is-danger' : ''"
                  v-model="query"
                  class="input is-small"
                  type="text"
                  name="query"
                  placeholder="type something here..."
                />
              </div>
              <div class="control">
                <button class="button is-primary is-small">Search</button>
              </div>
            </form>
          </div>
          <p v-if="isShowError == true" class="help is-danger">
            {{ searchMessageError }}
          </p>
          <p v-else></p>
        </div>
      </div>
    </div>
    <div class="table-container">
      <table class="table is-fullwidth is-hoverable">
        <thead>
          <tr>
            <th
              v-for="(header, index) in headers"
              :key="`headers-${index}`"
              v-if="itemsNotContains(index)"
            >
              <div class="has-text-centered is-size-7">
                {{ header }}
              </div>
            </th>
            <th v-if="options.isShowActionColumn == true">
              <div class="container has-text-centered is-size-7">Action</div>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="isDataEmpty()">
            <td class="has-text-centered padded" :colspan="getNumberOfcolumn()">
              No Data Available
            </td>
          </tr>
          <tr
            v-else
            v-for="(datas, index) in dataTable"
            :key="`tabel-row-${index}`"
          >
            <td
              v-for="(value, name, index) in datas"
              :key="`table-column-${index}`"
              v-if="itemsNotContains(index)"
            >
              <div class="has-text-centered is-size-7">
                {{ value }}
              </div>
            </td>
            <td v-if="options.isShowActionColumn == true">
              <div
                :id="`${index}`"
                class="buttons are-small has-addons is-centered"
                style="min-width: 200px"
              >
                <button class="SHOW button" v-on:click="onClick">View</button>
                <button class="EDIT button" v-on:click="onClick">Edit</button>
                <form id="removeForm" :action="removeUrl" method="post">
                  <input
                    type="hidden"
                    name="authenticity_token"
                    :value="csrf"
                  />
                  <input
                    :id="`removeId${index}`"
                    type="hidden"
                    name="id"
                    value=""
                  />
                  <button
                    class="REMOVE button"
                    v-on:click="onClickDelete(index, $event)"
                  >
                    Remove
                  </button>
                </form>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-if="options.showPaginate">
      <paginate-table
        :page="paginationOptions.page"
        :totalPage="paginationOptions.totalPage"
        :type="options.type"
        :url="options.tableListUrl"
      ></paginate-table>
    </div>
  </div>
</template>

<script>
import paginate from "./table-list-pagination.vue";

export default {
  components: {
    "paginate-table": paginate,
  },
  props: {
    headers: Array,
    dataTable: Array,
    options: Object,
    paginationOptions: Object,
    keyEvent: String,
    searchUrl: String,
    removeUrl: String,
  },
  data: function () {
    return {
      query: "",
      typeSearch: "",
      searchMessageError: "Please select search category first",
      isShowError: false,
      csrf: document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };
  },
  methods: {
    showPaginate: function () {
      if (
        this.paginationOptions.totalPage > 1 ||
        this.dataTable.length > this.options.maxRow
      ) {
        return true;
      }
      return false;
    },
    isDataEmpty: function () {
      if (this.dataTable === undefined || this.dataTable.length == 0) {
        return true;
      } else {
        return false;
      }
    },
    getNumberOfcolumn: function () {
      return this.headers.length;
    },
    getData: function (index) {
      return this.dataTable[index];
    },
    onClick: function (event) {
      let id = event.currentTarget.parentElement.id;
      let type = event.currentTarget.classList[0];
      let eventKey = this.keyEvent + "_" + type;
      let data = this.getData(id);
      let eventData = {
        data: data,
        type: type,
        index: parseInt(id),
      };
      this.emitEvent(eventKey, eventData);
    },
    onClickDelete: function (selectedIndex, event) {
      var data = this.getData(selectedIndex);
      let value = data.id;
      document.querySelector("#removeId" + selectedIndex).value = value;
      event.currentTarget.parentElement.submit();
    },
    onSearch: function () {
      if (this.typeSearch === "") {
        this.isShowError = true;
        return false;
      }
    },
    onAddNewUser: function () {
      let eventKey = this.keyEvent + "_ADD";
      console.log(this.keyEvent);
      this.emitEvent(eventKey, {});
    },
    itemsNotContains: function (n) {
      return !(this.options.hiddenColumn.indexOf(n) > -1);
    },
  },
};
</script>

<style scoped>
.padded {
  padding: 25px;
}

#serachbar {
  display: flex;
  width: 100%;
}
</style>
