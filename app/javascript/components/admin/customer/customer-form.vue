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
                      :class="error.hasErrorFirstName ? 'is-danger' : ''"
                      type="text"
                      name="firstname"
                      placeholder="First Name"
                    />
                  </div>
                  <p v-if="error.hasErrorFirstName == true" class="help is-danger">
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
                      :class="error.hasErrorLastName ? 'is-danger' : ''"
                      type="text"
                      name="lastname"
                      placeholder="Last Name"
                    />
                  </div>
                  <p v-if="error.hasErrorLastName == true" class="help is-danger">
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
                      :class="error.hasErrorEmail ? 'is-danger' : ''"
                      name="email"
                      type="email"
                      placeholder="e.g. alexsmith@gmail.com"
                    />
                  </div>
                  <p v-if="error.hasErrorEmail == true" class="help is-danger">
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
                      :class="error.hasErrorPhone ? 'is-danger' : ''"
                      name="phone"
                      type="number"
                      placeholder="phone number.."
                    />
                  </p>
                  <p v-if="error.hasErrorPhone == true" class="help is-danger">
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
                      :class="error.hasErrorAddress ? 'is-danger' : ''"
                      name="address"
                      placeholder="Address...."
                    />
                  </div>
                  <p v-if="error.hasErrorAddress == true" class="help is-danger">
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
      axios: "",
      options: [
        { text: "Active", value: true },
        { text: "InActive", value: false },
      ],
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
  },
  methods: {
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
    },
    resetError() {
      this.error.hasErrorFirstName = false;
      this.error.hasErrorLastName = false;
      this.error.hasErrorEmail = false;
      this.error.hasErrorPhone = false;
      this.error.hasErrorAddress = false;
      this.error.messageError = "";
    },
    isFailedValidateCategoryData() {
      this.resetError();
      let error = false;
      if (!this.postData.firstname || 0 === this.postData.firstname.length) {
        this.error.messageError = "firstname is required";
        this.error.hasErrorFirstName = true;
        error = true;
      } else if (!this.postData.lastname || 0 === this.postData.lastname.length) {
        this.error.messageError = "lastname is required";
        this.error.hasErrorLastName = true;
        error = true;
      } else if (!this.postData.email || 0 === this.postData.email.length) {
        this.error.messageError = "email is required";
        this.error.hasErrorEmail = true;
        error = true;
      }else if (!this.postData.phone || 0 === this.postData.phone.length) {
        this.error.messageError = "phone is required";
        this.error.hasErrorPhone = true;
        error = true;
      }
      else if (!this.postData.address || 0 === this.postData.address.length) {
        this.error.messageError = "address is required";
        this.error.hasErrorAddress = true;
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
