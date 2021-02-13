<template>
  <div class="container is-desktop">
    <div class="column">
      <div class="field">
        <label for="" class="label">{{ title }}</label>
        <div v-if="isSearchAble == true" class="control has-icons-right">
          <input
            v-model="query"
            type="text"
            placeholder="search tags...."
            class="input"
            v-on:keyup="searchTags"
            v-on:keydown.enter="searchTags"
          />
        </div>
        <div v-else class="control has-icons-right">
          <input
            v-model="query"
            type="text"
            placeholder="search tags...."
            class="input"
            v-on:keyup="searchTagsOnList"
            v-on:keydown.enter="searchTagsOnList"
          />
        </div>
        <div class="dropdown" :class="isDropdownShow ? 'is-active' : ''">
          <div class="dropdown-menu" id="dropdown-menu4" role="menu">
            <div class="dropdown-content">
              <div class="item-dropdown" v-for="item in list" :key="item.name">
                <div class="dropdown-item" @click="selectItem(item)">
                  {{ item.name }}
                </div>
              </div>
            </div>
          </div>
        </div>
        <p v-if="showMessage === true" class="help is-danger">
          {{ messageError }}
        </p>
      </div>
      <div class="field is-grouped is-grouped-multiline">
        <div v-for="(item, index) in items" :key="item.name" class="control">
          <div class="tags has-addons">
            <span class="tag is-danger">{{ item.name }}</span>
            <a class="tag is-delete" @click="deleteTagsInput(item, index)"></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    title: String,
    isSearchAble: Boolean,
    url: String,
    token: String,
    items: Array,
    searchList: Array,
  },
  created() {
    this.axios = axios;
    this.list = [];
  },
  data: function () {
    return {
      messageError: "test",
      showMessage: false,
      isDropdownShow: false,
      query: "",
      list: [],
      password: "",
      axios: "",
    };
  },
  methods: {
    searchTags: function () {
      console.log("call api");
      var self = this;
      if (this.query.length >= 3) {
        let headers = {};
        headers["Authorization"] = "Bearer " + this.token;
        headers["Content-Type"] = "application/json";
        var model = {
          query: this.query,
        };
        this.axios
          .post(self.url, model, { headers })
          .then((response) => {
            self.list = response.data.data;
            self.isDropdownShow = true;
          })
          .catch((e) => {
            self.messageError = e.message;
            self.showMessage = true;
          });
      }
    },
    searchTagsOnList: function () {
      var x;
      this.list = [];
      if (this.query.length >= 3) {
        for (x in this.searchList) {
          if (this.searchList[x].name.toLowerCase().indexOf(this.query) > -1) {
            this.list.push(this.searchList[x]);
          }
        }
      }
      this.isDropdownShow = true;
    },
    selectItem: function (item) {
      if (this.items == undefined) {
        this.items = [];
      }
      if (!this.containsObject(item, this.items)) {
        this.items.push(item);
      }
      this.isDropdownShow = false;
    },
    deleteTagsInput: function (item, index) {
      this.items.splice(index, 1);
    },
    containsObject: function (obj, list) {
      var i;
      for (i = 0; i < list.length; i++) {
        if (list[i].id === obj.id) {
          return true;
        }
      }
      return false;
    },
  },
};
</script>
