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
            <input
              class="input"
              v-model="postData.id"
              name="id"
              type="hidden"
            />
            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">First Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="controlx">
                    <input
                      class="input"
                      v-model="postData.firstname"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      type="text"
                      name="firstname"
                      placeholder="First Name"
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
                <label class="label">Last Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <input
                      class="input"
                      v-model="postData.lastname"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      type="text"
                      name="lastname"
                      placeholder="Last Name"
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
                <label class="label">Email</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <input
                      class="input"
                      v-model="postData.email"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      name="email"
                      type="email"
                      placeholder="e.g. alexsmith@gmail.com"
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
                <label class="label">Phone Number</label>
              </div>
              <div class="field-body">
                <div class="field has-addons">
                  <p class="control">
                    <a class="button" disabled> +62 </a>
                  </p>
                  <p class="control">
                    <input
                      class="input"
                      v-model="postData.phone"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      name="phone"
                      type="number"
                      placeholder="phone number.."
                    />
                  </p>
                  <p v-if="error.hasErrorName == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Address</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <textarea
                      class="textarea"
                      v-model="postData.address"
                      :class="error.hasErrorName ? 'is-danger' : ''"
                      name="address"
                      placeholder="Address...."
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
                <label class="label">Status</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="select"
                      :class="error.isActiveError ? 'is-danger' : ''"
                    >
                      <select v-model="postData.is_active" name="is_active">
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
      postData: {},
      typeSelected: "",
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
      addUrl: "/admin/customer/add-customer",
      updateUrl: "/admin/customer/update-customer",
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
    showForm(data, type, title) {
      this.postData = data;
      this.type = type;
      this.title = title;
      this.isShow = true;
      console.log("call");
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
  },
};
</script>

<style scoped>
</style>
