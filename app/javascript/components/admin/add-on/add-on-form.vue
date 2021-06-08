<template>
  <div class="modal" :class="isShow ? 'is-active' : 'is-hidden'">
    <div class="modal-background"></div>
    <div class="modal-content">
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">{{ title }}</p>
          <button
            class="delete"
            aria-label="close"
            v-on:click="onClickCancel"
          ></button>
        </header>
        <section class="modal-card-body">
          <form
            class="form-horizontal"
            id="app"
            @submit="onSubmit"
            :action="getUrlSubmit"
            method="post"
          >
            <input type="hidden" name="authenticity_token" :value="csrf" />
            <input
              class="input"
              v-model="datas.id"
              name="id"
              type="hidden"
            />
            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Add-on Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="controlx">
                    <input
                      class="input"
                      v-model="datas.name"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      type="text"
                      name="name"
                      placeholder="Product Name"
                    />
                  </div>
                  <p v-if="error.hasError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Add-on Price</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <textarea
                      class="input"
                      v-model="datas.price"
                      :class="error.hasError ? 'is-danger' : ''"
                      name="price"
                      type="number"
                      placeholder="Price..."
                    />
                  </div>
                  <p v-if="error.hasErrorDesc == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Status</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="select"
                      :class="error.isActiveError ? 'is-danger' : ''"
                    >
                      <select v-model="datas.is_active" name="is_active">
                        <option
                          v-for="option in options"
                          v-bind:value="option.value"
                          v-bind:key="option.text"
                          :disabled="option.value == ''"
                        >
                          {{ option.text }}
                        </option>
                      </select>
                    </div>
                  </div>
                  <p v-if="error.isActiveError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>
            <footer v-if="showButtonSubmit" class="modal-card-foot">
              <button class="button is-primary">Submit</button>
              <button class="button" v-on:click="onClickCancel">Cancel</button>
            </footer>
          </form>
        </section>
      </div>
      <div class="is-desktop is-centered modal-card"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      isShow: false,
      messageError: "",
      showMessage: false,
      datas: {},
      title: "",
      type: "",
      date: new Date(),
      error: {
        hasError: false,
        messageError: "",
      },
      axios: "",
      options: [
        { text: "Active", value: "true" },
        { text: "InActive", value: "false" },
      ],
      addUrl: "/admin/product/add-add-on",
      updateUrl: "/admin/product/update-add-on",
      csrf: document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };
  },
  created() {
    this.axios = axios;
  },
  computed: {
    showButtonSubmit() {
      if (this.type == "show") {
        return false;
      }
      return true;
    },
    getUrlSubmit() {
      if (this.type == "edit") {
        return this.updateUrl;
      } else {
        return this.addUrl;
      }
    },
  },
  methods: {
    getDropdown: function () {
      var self = this;
      let headers = {};
      headers["Authorization"] = "Bearer " + this.token;
      headers["Content-Type"] = "application/json";
      this.axios
        .get(self.dropdownUrl, { headers })
        .then((response) => {
          self.dropdownList = response.data.data;
          self.isDropdownShow = true;
        })
        .catch((e) => {
          self.messageError = e.message;
          self.showMessage = true;
        });
    },
    showForm(data, type, title) {
      this.datas = data;
      this.type = type;
      this.title = title;
      this.getDropdown();
      this.isShow = true;
    },
    hideForm() {
      this.isShow = false;
      this.category = {};
      this.title = "";
    },
    onClickCancel: function () {
      this.hideForm();
    },
    onSubmit: function (e) {
      if (this.type == "edit") {
        if (this.isFailedValidateCategoryData()) {
          e.preventDefault();
        }
      } else {
        if (this.isFailedValidateCategoryData()) {
          e.preventDefault();
        }
      }
    },
    resetError() {
      this.error.hasErrorName = false;
      this.error.hasErrorDesc = false;
      this.error.messageError = "";
    },
    isFailedValidateCategoryData() {
      this.resetError();
      let error = false;
      if (!this.datas.name || 0 === this.datas.name.length) {
        this.error.messageError = "Name is required";
        this.error.hasErrorName = true;
        error = true;
      } else if (!this.datas.price || 0 === this.datas.price.length) {
        this.error.messageError = "Price is required";
        this.error.hasErrorDesc = true;
        error = true;
      } else {
        this.resetError();
      }
      return error;
    },
  },
};
</script>

<style scoped>
</style>
