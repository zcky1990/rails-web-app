<template>
  <div class="table-container">
      <div class="container">
        <div class="columns">
          <div class="column"></div>
          <div class="column">
            <div class="field is-grouped is-grouped-right">
              <p class="control">
                <a v-on:click="onAddNewUser" class="button is-info is-small">
                  Add New {{type}}
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
              <span class="select is-small">
                <select v-model="typeSearch">
                  <option disabled value="">Please select one</option>
                  <option v-for="(value, index) in searchType"
                    :key="`data-${index}`">{{value}}</option>
                </select>
              </span>
            </div>
            <div class="control is-expanded">
              <input v-model="query" class="input is-small" type="text" placeholder="Find user">
            </div>
            <div class="control">
              <a v-on:click="onSearch" class="button is-info is-small">
                Search
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <table class="table is-fullwidth is-hoverable ">
      <thead>
        <tr>
          <th
            v-for="(header, index) in tableHeaders"
            :key="`tableHeaders-${index}`"
            v-if="itemsNotContains(index)"
          >
            <div class="has-text-centered is-size-7">
              {{ header }}
            </div>
          </th>
          <th v-if="actionShow == true">
            <div class="container has-text-centered is-size-7">Action</div>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="isDataEmpty()">
          <td :colspan="getNumberOfColumn()" class="has-text-centered padded">
            No Data Available
          </td>
        </tr>
        <tr
          v-else
          v-for="(datas, index) in dataTable"
          :key="`dataTable-${index}`"
        >
          <td
            v-for="(value, name, index) in datas"
            :key="`data-${index}`"
            v-if="itemsNotContains(index)"
          >
            <div class="has-text-centered is-size-7">
              {{ value }}
            </div>
          </td>
          <td v-if="actionShow == true">
            <div class="has-text-centered">
              <span class="icon is-small">
                <abbr
                  :id="`${index}`"
                  title="Show"
                  class="SHOW"
                  v-on:click="onClick"
                >
                  <i class="fas fa-eye"></i
                ></abbr>
                <abbr
                  :id="`${index}`"
                  title="Edit"
                  class="EDIT"
                  v-on:click="onClick"
                >
                  <i class="ml-2 fas fa-edit"></i
                ></abbr>
                <abbr
                  :id="`${index}`"
                  title="Delete"
                  class="REMOVE"
                  v-on:click="onClick"
                >
                  <i class="ml-2 fas fa-trash"></i
                ></abbr>
              </span>
            </div>
          </td>
        </tr>
        <tr v-if="showPaginate() == true">
          <paginate-table v-bind:page="page" v-bind:totalPage="totalPage" v-bind:keyEvent="keyEvent"></paginate-table>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import paginate from "./table-list-pagination.vue"

export default {
  components: {
    "paginate-table": paginate
  },
  props: {
    tableHeaders: Array,
    dataTable: Array,
    hideColumn: Array,
    actionShow: Boolean,
    keyEvent: String,
    page: Number,
    totalPage: Number,
    maxRow: Number,
    searchType:Array,
    type: String
  },
  data: function () {
    return {
      query:"",
      typeSearch: ""
    };
  },
  methods: {
    showPaginate: function(){
      if (this.totalPage > 1 || this.dataTable.length > this.maxRow){
        return true
      }
      return false
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
    onClick: function (event) {
      let id = event.currentTarget.id;
      let type = event.currentTarget.classList[0];
      let eventKey = this.keyEvent + "_" + type;
      let data = this.getData(id);
      let eventData = {
        data: data,
        eventKey: eventKey,
        type: type,
        index: id,
      };
      this.emitEvent(eventKey, eventData);
    },
    onSearch: function(){
      if (this.typeSearch === ""){
        this.showSnackBar("Please select search category first", "error")
      }else{
        let eventKey = this.keyEvent + "_SEARCH";
        let eventData = {
          query: this.query,
          typeSearch: this.typeSearch,
          eventKey: eventKey,
        };
        this.emitEvent(eventKey, eventData);
      }
    },
    onAddNewUser: function(){
      let eventKey = this.keyEvent + "_ADD";
      this.emitEvent(eventKey, {});
    },
    itemsNotContains: function (n) {
      return !(this.hideColumn.indexOf(n) > -1);
    }
}
}
</script>

<style scoped>
.padded {
  padding: 25px;
}
</style>
