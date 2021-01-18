<template>
  <div class="table-container">
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
            <div class="control">
              <span
                class="select is-small"
                :class="isShowError ? 'is-danger' : ''"
              >
                <select v-model="typeSearch">
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
                placeholder="Find user"
              />
            </div>
            <div class="control">
              <a v-on:click="onSearch" class="button is-primary is-small">
                Search
              </a>
            </div>
          </div>
          <p v-if="isShowError == true" class="help is-danger">
            {{ searchMessageError }}
          </p>
          <p v-else></p>
        </div>
      </div>
    </div>
    <table class="table is-fullwidth is-hoverable is-striped">
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
          <td class="has-text-centered padded">No Data Available</td>
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
            <div class="has-text-centered">
              <span :id="`${index}`" class="icon is-small">
                <abbr title="Show" class="SHOW" v-on:click="onClick">
                  <i class="fas fa-eye"></i
                ></abbr>
                <abbr title="Edit" class="EDIT" v-on:click="onClick">
                  <i class="ml-2 fas fa-edit"></i
                ></abbr>
                <abbr title="Delete" class="REMOVE" v-on:click="onClick">
                  <i class="ml-2 fas fa-trash"></i
                ></abbr>
              </span>
            </div>
          </td>
        </tr>
      </tbody>
      <div v-if="options.showPaginate">
            <paginate-table
              :page="paginationOptions.page"
              :totalPage="paginationOptions.totalPage"
              :type="options.type"
              :url="options.tableListUrl"
            ></paginate-table>
          </div>
    </table>
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
  },
  data: function () {
    return {
      query: "",
      typeSearch: "",
      searchMessageError: "Please select search category first",
      isShowError: false,
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
    onSearch: function () {
      if (this.typeSearch === "") {
        this.isShowError = true;
      } else {
        let eventKey = this.keyEvent + "_SEARCH";
        let eventData = {
          query: this.query,
          typeSearch: this.typeSearch,
          type: this.options.type,
        };
        this.emitEvent(eventKey, eventData);
      }
    },
    onAddNewUser: function () {
      let eventKey = this.keyEvent + "_ADD";
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
</style>
