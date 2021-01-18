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
                <label class="label">Name</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <p class="control is-expanded has-icons-left">
                    <input
                      class="input"
                      v-model="userData.first_name"
                      :class="error.isFirstNameError ? 'is-danger' : ''"
                      type="text"
                      placeholder="FirstName"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-user"></i>
                    </span>
                  </p>
                  <p
                    v-if="error.isFirstNameError == true"
                    class="help is-danger"
                  >
                    {{ error.messageError }}
                  </p>
                </div>
                <div class="field">
                  <p class="control is-expanded has-icons-left has-icons-right">
                    <input
                      class="input"
                      v-model="userData.last_name"
                      :class="error.isLastNameError ? 'is-danger' : ''"
                      type="text"
                      placeholder="LastName"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-user"></i>
                    </span>
                  </p>
                  <p
                    v-if="error.isLastNameError == true"
                    class="help is-danger"
                  >
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
                  <div class="control has-icons-left has-icons-right">
                    <input
                      class="input"
                      v-model="userData.email"
                      :class="error.isEmailError ? 'is-danger' : ''"
                      type="email"
                      placeholder="email"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-envelope"></i>
                    </span>
                  </div>
                  <p v-if="error.isEmailError == true" class="help is-danger">
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
                <div class="field is-expanded">
                  <div class="field has-addons">
                    <p class="control">
                      <a class="button is-static"> +62 </a>
                    </p>
                    <p class="control is-expanded">
                      <input
                        class="input"
                        v-model="userData.phone_number"
                        :class="error.isPhoneNumber ? 'is-danger' : ''"
                        type="tel"
                        placeholder="Your phone number"
                      />
                    </p>
                  </div>
                  <p v-if="error.isPhoneNumber == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Birthday</label>
              </div>
              <div class="field-body birthday-container">
                <div class="field">
                  <div class="datepicker">
                    <input
                      id="my-element"
                      type="date"
                      hidden
                      :class="error.isBirthdayError ? 'is-danger' : ''"
                      ref="calendarTrigger"
                    />
                  </div>
                  <div class="birthday control has-icons-right">
                    <input
                      v-model="userData.birthday"
                      class="input"
                      :class="error.isBirthdayError ? 'is-danger' : ''"
                      v-on:click="selectDate"
                      type="text"
                      readOnly
                      placeholder="mm/dd/yyyy"
                      ref="datepickerContent"
                    />
                    <span class="icon is-small is-right">
                      <i class="fas fa-calendar"></i>
                    </span>
                  </div>
                  <p
                    v-if="error.isBirthdayError == true"
                    class="help is-danger"
                  >
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Gender</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <div
                      class="select"
                      :class="error.isGenderError ? 'is-danger' : ''"
                    >
                      <select v-model="userData.gender">
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
                  <p v-if="error.isGenderError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Password</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control has-icons-left has-icons-right">
                    <input
                      class="input"
                      v-model="userData.password"
                      :class="error.isPasswordError ? 'is-danger' : ''"
                      type="password"
                      placeholder="password"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-lock"></i>
                    </span>
                  </div>
                  <p
                    v-if="error.isPasswordError == true"
                    class="help is-danger"
                  >
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label"></label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control has-icons-left has-icons-right">
                    <input
                      class="input"
                      v-model="userData.reconfirm_password"
                      :class="error.isVerifyPasswordError ? 'is-danger' : ''"
                      type="password"
                      placeholder="verified password"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-lock"></i>
                    </span>
                  </div>
                  <p
                    v-if="error.isVerifyPasswordError == true"
                    class="help is-danger"
                  >
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">Postal Code</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control has-icons-left has-icons-right">
                    <input
                      class="input"
                      type="text"
                      v-model="userData.postal_code"
                      placeholder="postal code"
                      :class="error.isPostalCodeError ? 'is-danger' : ''"
                    />
                    <span class="icon is-small is-left">
                      <i class="fas fa-globe"></i>
                    </span>
                  </div>
                  <p
                    v-if="error.isPostalCodeError == true"
                    class="help is-danger"
                  >
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
                      v-model="userData.address"
                      :class="error.isAddressError ? 'is-danger' : ''"
                      placeholder="Address"
                    ></textarea>
                  </div>
                  <p v-if="error.isAddressError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>

            <div class="field is-horizontal">
              <div class="field-label is-normal">
                <label class="label">User Description</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <textarea
                      class="textarea"
                      v-model="userData.description"
                      :class="error.isDescError ? 'is-danger' : ''"
                      placeholder="User Description"
                    ></textarea>
                  </div>
                  <p v-if="error.isDescError == true" class="help is-danger">
                    {{ error.messageError }}
                  </p>
                </div>
              </div>
            </div>
          </form>
        </section>
        <footer v-if="showButtonSubmit" class="modal-card-foot">
          <button class="button is-primary" v-on:click="onSubmit">Submit</button>
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
      userData: {
        gender: "",
      },
      title: "",
      type: "",
      date: new Date(),
      error: {
        isFirstNameError: false,
        isLastNameError: false,
        isEmailError: false,
        isPhoneNumber: false,
        isBirthdayError: false,
        isPasswordError: false,
        isVerifyPasswordError: false,
        isPostalCodeError: false,
        isAddressError: false,
        isDescError: false,
        isGenderError: false,
        messageError: "",
      },
      options: [
        { text: "Select Gender", value: "" },
        { text: "Male", value: "M" },
        { text: "Female", value: "F" },
      ],
    };
  },
  mounted() {
    var self = this;
    const calendar = bulmaCalendar.attach(this.$refs.calendarTrigger, {
      type: "date",
      displayMode: "dialog",
      showHeader: true,
      closeOnSelect: true,
      showFooter: false,
      toggleOnInputClick: true,
      dateFormat: "DD/MM/YYYY",
      isRange: false,
    })[0];
    var element = document.querySelector(".datetimepicker-dummy");
    if (element) {
      element.style.visibility = "hidden";
    }

    calendar.on("select", function (e) {
      self.userData.birthday = e.data.value();
      self.closeDatePicker();
      self.$refs.datepickerContent.value = e.data.value();
    });
  },
  computed: {
    showButtonSubmit() {
      if (this.type == "show") {
        return false;
      }
      return true;
    },
    isGenderNotSelected() {
      if (this.userData.gender == "" || this.userData.gender === undefined) {
        return true;
      }
      return false;
    },
  },
  methods: {
    showForm(data, type, title) {
      this.userData = data;
      this.type = type;
      this.title = title;
      if (this.userData.birthday != undefined) {
      } else {
      }
      if (this.userData.gender == undefined || this.userData.gender == "") {
        this.userData.gender = "";
      }
      this.isShow = true;
    },
    hideForm() {
      this.isShow = false;
      this.userData = {};
      this.type = "";
      this.title = "";
    },
    onClickCancel: function () {
      this.hideForm();
    },
    onSubmit: function (event) {
      if (this.type == "edit") {
        if (!this.isFailedValidateUpdateUserData()) {
          this.emitEvent("ON_EDIT_USER", this.userData);
        }
      } else {
        if (!this.isFailedValidateAddUserData()) {
          this.userData.type = "user";
          this.emitEvent("ON_ADD_USER", this.userData);
        }
      }
    },
    selectDate: function () {
      var element = document.querySelector(".datetimepicker-wrapper");
      if (element) {
        element.classList.add("is-active");
      }
    },
    closeDatePicker: function () {
      var element = document.querySelector(".datetimepicker-wrapper");
      if (element) {
        element.classList.remove("is-active");
      }
    },
    resetError() {
      this.error.isPasswordError = false;
      this.error.isVerifyPasswordError = false;
      this.error.isEmailError = false;
      this.error.isFirstNameError = false;
      this.error.isLastNameError = false;
      this.error.isBirthdayError = false;
      this.error.isPhoneNumber = false;
      this.error.isPostalCodeError = false;
      this.error.isAddressError = false;
      this.error.isGenderError = false;
      this.error.messageError = "";
    },
    isFailedValidateAddUserData() {
      this.resetError();
      let error = false;
      if (!this.userData.first_name || 0 === this.userData.first_name.length) {
        this.error.messageError = "Firstname is required";
        this.error.isFirstNameError = true;
        error = true;
      } else if (
        !this.userData.last_name ||
        0 === this.userData.last_name.length
      ) {
        this.error.messageError = "Lastname is required";
        this.error.isLastNameError = true;
        error = true;
      } else if (!this.userData.email || 0 === this.userData.email.length) {
        this.error.isEmailError = true;
        this.error.messageError = "E-mail is required";
        error = true;
      } else if (!/.+@.+\..+/.test(this.userData.email)) {
        this.error.isEmailError = true;
        this.error.messageError = "E-mail must be valid";
        error = true;
      } else if (
        !this.userData.phone_number ||
        0 === this.userData.phone_number.length
      ) {
        this.error.messageError = "Phone Number is required";
        this.error.isPhoneNumber = true;
        error = true;
      } else if (!this.userData.birthday) {
        this.error.messageError = "Birthday is required";
        this.error.isBirthdayError = true;
        error = true;
      } else if (!this.userData.gender || 0 === this.userData.gender.length) {
        this.error.messageError = "Please select gender";
        this.error.isGenderError = true;
        error = true;
      } else if (
        !this.userData.password ||
        0 === this.userData.password.length
      ) {
        this.error.isPasswordError = true;
        this.error.messageError = "Password is required";
        error = true;
      } else if (this.userData.password.length < 8) {
        this.error.isPasswordError = true;
        this.error.messageError = "Minimum password length is 8";
        error = true;
      } else if (
        !this.userData.reconfirm_password ||
        0 === this.userData.reconfirm_password.length
      ) {
        this.error.isVerifyPasswordError = true;
        this.error.messageError = "Verify Password required";
        error = true;
      } else if (this.userData.password !== this.userData.reconfirm_password) {
        this.error.isVerifyPasswordError = true;
        this.error.messageError = "Verify Password failed";
        error = true;
      } else if (
        !this.userData.postal_code ||
        0 === this.userData.postal_code.length
      ) {
        this.error.messageError = "Postal Code is required";
        this.error.isPostalCodeError = true;
        error = true;
      } else if (!this.userData.address || 0 === this.userData.address.length) {
        this.error.messageError = "Address is required";
        this.error.isAddressError = true;
        error = true;
      } else {
        this.resetError();
      }
      return error;
    },
    isFailedValidateUpdateUserData() {
      this.resetError();
      let error = false;
      if (!this.userData.first_name || 0 === this.userData.first_name.length) {
        this.error.messageError = "Firstname is required";
        this.error.isFirstNameError = true;
        error = true;
      } else if (
        !this.userData.last_name ||
        0 === this.userData.last_name.length
      ) {
        this.error.messageError = "Lastname is required";
        this.error.isLastNameError = true;
        error = true;
      } else if (!this.userData.email || 0 === this.userData.email.length) {
        this.error.isEmailError = true;
        this.error.messageError = "E-mail is required";
        error = true;
      } else if (!/.+@.+\..+/.test(this.userData.email)) {
        this.error.isEmailError = true;
        this.error.messageError = "E-mail must be valid";
        error = true;
      } else if (
        !this.userData.phone_number ||
        0 === this.userData.phone_number.length
      ) {
        this.error.messageError = "Phone Number is required";
        this.error.isPhoneNumber = true;
        error = true;
      } else if (!this.userData.birthday) {
        this.error.messageError = "Birthday is required";
        this.error.isBirthdayError = true;
        error = true;
      } else if (!this.userData.gender || 0 === this.userData.gender.length) {
        this.error.messageError = "Please select gender";
        this.error.isGenderError = true;
        error = true;
      } else if (
        !this.userData.postal_code ||
        0 === this.userData.postal_code.length
      ) {
        this.error.messageError = "Postal Code is required";
        this.error.isPostalCodeError = true;
        error = true;
      } else if (!this.userData.address || 0 === this.userData.address.length) {
        this.error.messageError = "Address is required";
        this.error.isAddressError = true;
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
