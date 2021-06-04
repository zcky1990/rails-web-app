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
          <form class="form-horizontal">
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
                      <select v-model="product.category_id">
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
                      placeholder="Product Price"
                    />
                  </div>
                  <p v-if="error.hasError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>
          </form>
        </section>
        <footer v-if="showButtonSubmit" class="modal-card-foot">
          <button class="button is-primary" v-on:click="onSubmit">
            Submit
          </button>
          <button class="button" v-on:click="onClickCancel">Cancel</button>
        </footer>
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
    onSubmit: function (event) {
      if (this.type == "edit") {
        if (!this.isFailedValidateCategoryData()) {
          this.emitEvent("ON_EDIT_PRODUCT", this.product);
        }
      } else {
        if (!this.isFailedValidateCategoryData()) {
          this.emitEvent("ON_ADD_PRODUCT", this.product);
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
      } else if (!this.product.category_id || 0 === this.product.category_id.length) {
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
