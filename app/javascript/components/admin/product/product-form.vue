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
            ref="formProduct"
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
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      type="text"
                      name="name"
                      placeholder="Product Name"
                    />
                  </div>
                  <p v-if="error.hasErrorName == true" class="help is-danger">
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
                      :class="error.hasErrorNameStock ? 'is-danger' : ''"
                      name="stock"
                      type="number"
                      placeholder="Stock Product"
                    />
                  </div>
                  <p
                    v-if="error.hasErrorNameStock == true"
                    class="help is-danger"
                  >
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
                      :class="error.hasErrorCategory ? 'is-danger' : ''"
                    >
                      <select
                        v-model="product.product_category_id"
                        name="product_category_id"
                      >
                        <option value="" disabled>Select Category</option>
                        <option
                          v-for="option in dropdownList"
                          v-bind:value="option.product_category_id"
                          v-bind:key="option.product_category_id"
                          :disabled="option.product_category_id == ''"
                        >
                          {{ option.product_category_name }}
                        </option>
                      </select>
                    </div>
                  </div>
                  <p
                    v-if="error.hasErrorCategory == true"
                    class="help is-danger"
                  >
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
                    <div class="field has-addons">
                      <p class="control">
                        <span
                          class="select"
                          :class="error.hasErrorPrice ? 'is-danger' : ''"
                        >
                          <select ref="dropdownType" v-model="typeSelected">
                            <option value="" disabled>Select Price Type</option>
                            <option
                              v-for="option in priceTypeDropdownList"
                              v-bind:value="option.id + '-' + option.name"
                              v-bind:key="option.id"
                              :disabled="option.id + '-' + option.name == ''"
                            >
                              {{ option.name }}
                            </option>
                          </select>
                        </span>
                      </p>
                      <p class="control">
                        <input
                          ref="priceInput"
                          class="input"
                          type="number"
                          placeholder="price"
                          :class="error.hasErrorPrice ? 'is-danger' : ''"
                        />
                      </p>
                      <p class="control">
                        <a
                          class="button"
                          :class="error.hasErrorPrice ? 'is-danger' : ''"
                          v-on:click="addPrice"
                        >
                          Add
                        </a>
                      </p>
                    </div>
                  </div>
                  <p v-if="error.hasErrorPrice == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>
            <div class="field is-horizontal">
              <div class="field-label is-normal"></div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="field has-addons"
                      v-for="(pricedData, index) in product.price"
                      :key="`price-data-${index}`"
                    >
                      <p class="control">
                        <a disabled class="button">
                          {{ pricedData.price_type_name }}
                        </a>
                      </p>
                      <p class="control">
                        <input
                          disabled
                          v-model="pricedData.price"
                          class="input"
                          type="text"
                        />
                      </p>
                      <p class="control">
                        <a class="button" v-on:click="removePrice(index)"
                          >remove</a
                        >
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Add-On</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div class="field has-addons">
                      <p class="control">
                        <span
                          class="select"
                          :class="error.hasErrorPrice ? 'is-danger' : ''"
                        >
                          <select
                            ref="addOnDropdown"
                            v-model="dropdownSelected"
                          >
                            <option value="" disabled>Select Add-On</option>
                            <option
                              v-for="option in addOnDropdownList"
                              v-bind:value="
                                option.id +
                                '-' +
                                option.name +
                                '-' +
                                option.price
                              "
                              v-bind:key="option.id"
                              :disabled="
                                option.id +
                                  '-' +
                                  option.name +
                                  '-' +
                                  option.price ==
                                ''
                              "
                            >
                              {{ option.name }} - {{ option.price }}
                            </option>
                          </select>
                        </span>
                      </p>
                      <p class="control">
                        <a
                          class="button"
                          :class="error.hasErrorPrice ? 'is-danger' : ''"
                          v-on:click="addAddOn"
                        >
                          Add
                        </a>
                      </p>
                    </div>
                  </div>
                  <p v-if="error.hasErrorPrice == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal"></div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="field has-addons"
                      v-for="(addon, index) in product.available_add_on"
                      :key="`price-data-${index}`"
                    >
                      <p class="control">
                        <a disabled class="button">
                          {{ addon.add_on_name }}
                        </a>
                      </p>
                      <p class="control">
                        <input
                          disabled
                          v-model="addon.price"
                          class="input"
                          type="text"
                        />
                      </p>
                      <p class="control">
                        <a class="button" v-on:click="removeAddOn(index)"
                          >remove</a
                        >
                      </p>
                    </div>
                  </div>
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
      product: {
        product_category_id: "",
        product_category_name: "",
      },
      typeSelected: "",
      dropdownSelected: "",
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
        { text: "Active", value: true },
        { text: "InActive", value: false },
      ],
      priceTypeDropDownUrl: "/admin/product/get-price-type-list-dropdown",
      priceTypeDropdownList: [],
      addOnDropDownUrl: "/admin/product/get-add-on-list",
      addOnDropdownList: [],
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
      var self = this;
      let headers = {};
      headers["Authorization"] = "Bearer " + this.token;
      headers["Content-Type"] = "application/json";
      this.axios
        .get(self.dropdownUrl, { headers })
        .then((response) => {
          self.dropdownList = response.data.data;
        })
        .catch((e) => {
          self.messageError = e.message;
          self.showMessage = true;
        });
    },
    getPriceTypeDropdown: function () {
      var self = this;
      let headers = {};
      headers["Authorization"] = "Bearer " + this.token;
      headers["Content-Type"] = "application/json";
      this.axios
        .get(self.priceTypeDropDownUrl, { headers })
        .then((response) => {
          self.priceTypeDropdownList = response.data.data;
        })
        .catch((e) => {
          self.messageError = e.message;
          self.showMessage = true;
        });
    },
    getAddOnDropdown: function () {
      var self = this;
      let headers = {};
      headers["Authorization"] = "Bearer " + this.token;
      headers["Content-Type"] = "application/json";
      this.axios
        .get(self.addOnDropDownUrl, { headers })
        .then((response) => {
          self.addOnDropdownList = response.data.data;
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
      this.getPriceTypeDropdown();
      this.getAddOnDropdown();
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
      var datas = this.product.price;
      if (datas != undefined) {
        for (var i = 0; i < datas.length; i++) {
          var priceId = datas[i].price_type_id;
          var priceName = datas[i].price_type_name;
          var priceValue = datas[i].price;

          var type = document.createElement("input");
          type.setAttribute("type", "text");
          type.setAttribute("name", "price[][price_type_id]");
          type.value = priceId;
          type.hidden = true;

          var name = document.createElement("input");
          name.setAttribute("type", "text");
          name.setAttribute("name", "price[][price_type_name]");
          name.value = priceName;
          name.hidden = true;

          var price = document.createElement("input");
          price.setAttribute("type", "text");
          price.setAttribute("name", "price[][price]");
          price.value = priceValue;
          price.hidden = true;

          this.$refs.formProduct.append(type);
          this.$refs.formProduct.append(name);
          this.$refs.formProduct.append(price);
        }
      }

      var addOnDatas = this.product.available_add_on;
      if (addOnDatas != undefined) {
        for (var i = 0; i < addOnDatas.length; i++) {
          var priceId = addOnDatas[i].add_on_id;
          var priceName = addOnDatas[i].add_on_name;
          var priceValue = addOnDatas[i].price;

          var type = document.createElement("input");
          type.setAttribute("type", "text");
          type.setAttribute("name", "available_add_on[][add_on_id]");
          type.value = priceId;
          type.hidden = true;

          var name = document.createElement("input");
          name.setAttribute("type", "text");
          name.setAttribute("name", "available_add_on[][add_on_name]");
          name.value = priceName;
          name.hidden = true;

          var price = document.createElement("input");
          price.setAttribute("type", "text");
          price.setAttribute("name", "available_add_on[][price]");
          price.value = priceValue;
          price.hidden = true;

          this.$refs.formProduct.append(type);
          this.$refs.formProduct.append(name);
          this.$refs.formProduct.append(price);
        }
      }
    },
    resetError() {
      this.error.hasErrorName = false;
      this.error.hasErrorPrice = false;
      this.error.hasErrorStock = false;
      this.error.hasErrorCategory = false;
      this.error.messageError = "";
    },
    isFailedValidateCategoryData() {
      this.resetError();
      let error = false;
      if (!this.product.name || 0 === this.product.name.length) {
        this.error.messageError = "Name is required";
        this.error.hasErrorName = true;
        error = true;
      } else if (!this.product.price || 0 === this.product.price.length) {
        this.error.messageError = "Price is required";
        this.error.hasErrorPrice = true;
        error = true;
      } else if (!this.product.stock || 0 === this.product.stock.length) {
        this.error.messageError = "Stock is required";
        this.error.hasErrorStock = true;
        error = true;
      } else if (
        !this.product.product_category_id ||
        0 === this.product.product_category_id.length
      ) {
        this.error.messageError = "Please select Category";
        this.error.hasErrorCategory = true;
        error = true;
      } else {
        this.resetError();
      }
      return error;
    },
    addPrice() {
      let dorpdownValue = this.$refs.dropdownType.value;
      let splitData = dorpdownValue.split("-");
      let priceValue = this.$refs.priceInput.value;
      let priceId = splitData[0];
      let priceName = splitData[1];
      if (priceId && priceName && priceValue) {
        var data = {
          price_type_id: priceId,
          price_type_name: priceName,
          price: priceValue,
        };
        if (this.product.price == undefined) {
          this.product.price = [];
        }
        this.product.price.push(data);
        this.$refs.dropdownType.value = "";
        this.$refs.priceInput.value = "";
      }
    },
    removePrice(index) {
      this.product.price.splice(index, 1);
    },
    addAddOn() {
      let dorpdownValue = this.$refs.addOnDropdown.value;
      let splitData = dorpdownValue.split("-");
      let id = splitData[0];
      let name = splitData[1];
      let price = splitData[2];
      if (id && name && price) {
        var data = {
          add_on_id: id,
          add_on_name: name,
          price: price,
        };
        if (this.product.available_add_on == undefined) {
          this.product.available_add_on = [];
        }
        this.product.available_add_on.push(data);
        this.$refs.addOnDropdown.value = "";
      }
    },
    removeAddOn(index) {
      this.product.available_add_on.splice(index, 1);
    },
  },
};
</script>

<style scoped>
</style>
