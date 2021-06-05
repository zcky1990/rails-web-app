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
            <input class="input" v-model="product.id" name="id" type="hidden" />
            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Product Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="controlx">
                    <input
                      class="input"
                      v-model="product.name"
                      :class="error.hasError ? 'is-danger' : ''"
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
                <label class="label">Stock Product</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <input
                      class="input"
                      v-model="product.stock"
                      :class="error.hasError ? 'is-danger' : ''"
                      name="stock"
                      type="number"
                      placeholder="Stock Product"
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
                <label class="label">Product Category</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="select"
                      :class="error.hasError ? 'is-danger' : ''"
                    >
                      <select
                        v-model="product.product_category_id"
                        name="product_category_id"
                      >
                        <option
                          v-for="option in dropdownList"
                          v-bind:value="option.id"
                          v-bind:key="option.id"
                          :disabled="option.value == ''"
                        >
                          {{ option.name }}
                        </option>
                      </select>
                    </div>
                  </div>
                  <p v-if="error.hasError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Price</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <input
                      class="input"
                      v-model="product.price"
                      :class="error.hasError ? 'is-danger' : ''"
                      type="number"
                      name="price"
                      placeholder="Product Price"
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
                <label class="label">Status</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="select"
                      :class="error.isActiveError ? 'is-danger' : ''"
                    >
                      <select v-model="product.is_active" name="is_active">
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
      product: {},
      title: "",
      type: "",
      date: new Date(),
      error: {
        hasError: false,
        messageError: "",
      },
      dropdownUrl: "/admin/product/get-category-list-dropdown",
      axios: "",
      dropdownList: [],
      options: [
        { text: "Active", value: "true" },
        { text: "InActive", value: "false" },
      ],
      addUrl: "/admin/product/add-product-list",
      updateUrl: "/admin/product/update-product-list",
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
    isCategoryNotSelected() {
      if (this.product.category == "" || this.product.category === undefined) {
        return true;
      }
      return false;
    },
  },
  methods: {
    getDropdown: function () {
      console.log("call api");
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
      this.product = data;
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
      this.error.hasError = false;
      this.error.messageError = "";
    },
    isFailedValidateCategoryData() {
      this.resetError();
      let error = false;
      if (!this.product.name || 0 === this.product.name.length) {
        this.error.messageError = "Name is required";
        this.error.hasError = true;
        error = true;
      } else if (!this.product.price || 0 === this.product.price.length) {
        this.error.messageError = "Price is required";
        this.error.hasError = true;
        error = true;
      } else if (!this.product.stock || 0 === this.product.stock.length) {
        this.error.messageError = "Stock is required";
        this.error.hasError = true;
        error = true;
      } else if (
        !this.product.product_category_id ||
        0 === this.product.product_category_id.length
      ) {
        this.error.messageError = "Please select Category";
        this.error.hasError = true;
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
