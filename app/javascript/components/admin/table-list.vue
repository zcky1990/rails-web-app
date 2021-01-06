<template>
  <div class="table-container">
    <div class="container">
      <div class="columns">
        <div class="column"></div>
        <div class="column">
          <div class="field is-grouped is-grouped-right">
            <p class="control">
              <a v-on:click="onAddNewUser" class="button is-info is-small">
                Add New {{ objectData.type }}
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
                  <option
                    v-for="(value, index) in objectData.searchType"
                    :key="`data-${index}`"
                  >
                    {{ value }}
                  </option>
                </select>
              </span>
            </div>
            <div class="control is-expanded">
              <input
                v-model="query"
                class="input is-small"
                type="text"
                placeholder="Find user"
              />
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
    <table class="table is-fullwidth is-hoverable">
      <thead>
        <tr>
          <th
            v-for="(header, index) in objectData.tableHeaders"
            :key="`tableHeaders-${index}`"
            v-if="itemsNotContains(index)"
          >
            <div class="has-text-centered is-size-7">
              {{ header }}
            </div>
          </th>
          <th v-if="objectData.isShowActionColumn == true">
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
          v-for="(datas, index) in objectData.tabelData"
          :key="`tabelData-${index}`"
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
          <td v-if="objectData.isShowActionColumn == true">
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
        <tr>
          <div v-if="isPaginateTableShow">
          <paginate-table
            :page="objectData.page"
            :totalPage="objectData.totalPage"
            :type="objectData.type"
            :url="objectData.tableListUrl"
          ></paginate-table>
          </div>
        </tr>
      </tbody>
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
    objectData: Object,
    isPaginateTableShow: Boolean
  },
  data: function () {
    return {
      query: "",
      typeSearch: "",
    };
  },
  methods: {
    showPaginate: function () {
      if (
        this.objectData.totalPage > 1 ||
        this.objectData.tabelData.length > this.objectData.maxRow
      ) {
        return true;
      }
      return false;
    },
    getNumberOfColumn: function () {
      return this.objectData.tableHeaders.length;
    },
    isDataEmpty: function () {
      if (
        this.objectData.tabelData === undefined ||
        this.objectData.tabelData.length == 0
      ) {
        return true;
      } else {
        return false;
      }
    },
    getData: function (index) {
      return this.objectData.tabelData[index];
    },
    onClick: function (event) {
      let id = event.currentTarget.parentElement.id;
      let type = event.currentTarget.classList[0];
      let eventKey = this.objectData.keyEvent + "_" + type;
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
        this.showSnackBar("Please select search category first", "error");
      } else {
        let eventKey = this.objectData.keyEvent + "_SEARCH";
        let eventData = {
          query: this.query,
          typeSearch: this.typeSearch,
          type: this.objectData.type,
        };
        this.emitEvent(eventKey, eventData);
      }
    },
    onAddNewUser: function () {
      let eventKey = this.objectData.keyEvent + "_ADD";
      this.emitEvent(eventKey, {});
    },
    itemsNotContains: function (n) {
      return !(this.objectData.hiddenColumn.indexOf(n) > -1);
    },
  },
};
</script>

<style scoped>
.padded {
  padding: 25px;
}
</style>
