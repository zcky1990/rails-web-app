<template>
  <div class="modal" :class="isShow ? 'is-active' : 'is-hidden'">
    <div class="modal-background"></div>
    <div class="modal-content">
      <!-- Any other Bulma elements you want -->
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
                <label class="label">Category Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="controlx">
                    <input
                      class="input"
                      v-model="category.name"
                      :class="error.isNameError ? 'is-danger' : ''"
                      type="text"
                      placeholder="Add Category Name"
                    />
                  </div>
                  <p v-if="error.isNameError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Category Description</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <textarea
                      class="textarea"
                      v-model="category.desc"
                      :class="error.isDescError ? 'is-danger' : ''"
                      placeholder="Category Description"
                    ></textarea>
                  </div>
                  <p v-if="error.isDescError == true" class="help is-danger">
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
                      <select v-model="category.status">
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
      <!-- dad -->
    </div>
  </div>
</template>

<script>
import bulmaCalendar from "bulma-calendar/dist/js/bulma-calendar.min.js";

export default {
  data: function () {
    return {
      isShow: false,
      messageError: "",
      showMessage: false,
      category: {},
      title: "",
      type: "",
      date: new Date(),
      error: {
        isNameError: false,
        isDescError: false,
        isActiveError: false,
        messageError: "",
      },
      options: [
        { text: "Active", value: "true" },
        { text: "InActive", value: "false" },
      ],
    };
  },
  computed: {
    showButtonSubmit() {
      if (this.type == "show") {
        return false;
      }
      return true;
    },
    isStatusNotSelected() {
      if (
        this.category.status == "" ||
        this.category.status === undefined
      ) {
        return true;
      }
      return false;
    },
  },
  methods: {
    showForm(data, type, title) {
      this.category = data;
      this.type = type;
      this.title = title;
      if (
        this.category.status == undefined ||
        this.category.status == ""
      ) {
        this.category.status = "false";
      }
      this.isShow = true;
    },
    hideForm() {
      this.isShow = false;
      this.category = {};
      this.type = "";
      if (
        this.category.status == undefined ||
        this.category.status == ""
      ) {
        this.category.status = "false";
      }
      this.title = "";
    },
    onClickCancel: function () {
      this.hideForm();
    },
    onSubmit: function (event) {
      if (this.type == "edit") {
        if (!this.isFailedValidateCategoryData()) {
          this.emitEvent("ON_EDIT_CATEGORY", this.category);
        }
      } else {
        if (!this.isFailedValidateCategoryData()) {
          this.category.type = "category";
          this.emitEvent("ON_ADD_CATEGORY", this.category);
        }
      }
    },
    resetError() {
      this.error.isNameError = false;
      this.error.isDescError = false;
      this.error.isActiveError = false;
      this.error.messageError = "";
    },
    isFailedValidateCategoryData() {
      this.resetError();
      let error = false;
      if (!this.category.name || 0 === this.category.name.length) {
        this.error.messageError = "Name is required";
        this.error.isNameError = true;
        error = true;
      } else if (
        !this.category.status ||
        0 === this.category.status.length
      ) {
        this.error.messageError = "Please select Status";
        this.error.isActiveError = true;
        error = true;
      } else if (!this.category.desc || 0 === this.category.desc.length) {
        this.error.messageError = "Description is required";
        this.error.isDescError = true;
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
.birthday-container {
  max-height: 40px !important;
}
.birthday {
  position: relative;
  top: -40px;
}
</style>
