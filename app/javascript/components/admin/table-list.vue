<template>
  <div class="table-container">
    <table class="table is-fullwidth is-hoverable">
      <thead>
        <tr>
          <th
            v-for="(header, index) in tableHeaders"
            :key="`tableHeaders-${index}`"
            v-if="itemsNotContains(index)"
          >
            <div class="has-text-centered">
              {{ header }}
            </div>
          </th>
          <th v-if="actionShow == true">
            <div class="container has-text-centered">Action</div>
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
            <div class="has-text-centered">
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
      </tbody>
    </table>
  </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";

export default {
  props: {
    tableHeaders: Array,
    dataTable: Array,
    hideColumn: Array,
    actionShow: Boolean,
    keyEvent: String,
    page: Number,
  },
  data: function () {
    return {};
  },
  methods: {
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
    itemsNotContains: function (n) {
      return !(this.hideColumn.indexOf(n) > -1);
    },
  },
};
</script>

<style scoped>
.padded {
  padding: 25px;
}
</style>
