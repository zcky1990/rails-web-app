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
              <div class="field-body">
                <div class="field">
                  <div class="control">
                    <input
                      type="date"
                      :class="error.isBirthdayError ? 'is-danger' : ''"
                      ref="calendarTrigger"
                    />
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
                <label class="label">Password</label>
              </div>
              <div class="field-body">
                <div class="field">
                  <div class="control has-icons-left has-icons-right">
                    <input
                      class="input"
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
          <button class="button is-info" v-on:click="onSubmit">Submit</button>
          <button class="button" v-on:click="onClickCancel">Cancel</button>
        </footer>
      </div>
      <div class="is-desktop is-centered modal-card"></div>
      <!-- dad -->
    </div>
  </div>
</template>

<script>
import BulmaTagsInput from "@creativebulma/bulma-tagsinput";
import bulmaCalendar from "bulma-calendar/dist/js/bulma-calendar.min.js";

export default {
  data: function () {
    return {
      isShow: false,
      messageError: "",
      showMessage: false,
      userData: {},
      title: "",
      type: "",
      date: new Date(),
      error: {
        isFirstNameError: true,
        isLastNameError: true,
        isEmailError: true,
        isPhoneNumber: true,
        isBirthdayError: true,
        isPasswordError: true,
        isVerifyPasswordError: true,
        isPostalCodeError: true,
        isAddressError: true,
        isDescError: true,
        messageError: "test",
      },
    };
  },
  mounted() {
    const tagsInputs = BulmaTagsInput.attach();
    const calendar = bulmaCalendar.attach(this.$refs.calendarTrigger, {
      type: "date",
      displayMode: "dialog",
      startDate: "",
      showHeader: false,
      closeOnSelect: true,
      showFooter: false,
      toggleOnInputClick: true,
      dateFormat: "MM/DD/YYYY",
    })[0];
    calendar.on("select", function (e) {
      console.log("select");
    });
  },
  computed: {
    showButtonSubmit() {
      if (this.type == "show") {
        return false;
      }
      return true;
    },
  },
  methods: {
    showForm(data, type, title) {
      this.isShow = true;
      this.userData = data;
      this.type = type;
      this.title = title;
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
      if (this.validate(this.userData)) {
        if (this.type == "edit") {
          console.log(this.userData);
          this.emitEvent("ON_EDIT_USER", this.userData);
        } else {
          console.log(this.userData);
          this.userData.type = "user";
          this.emitEvent("ON_ADD_USER", this.userData);
        }
      } else {
        console.log(this.messageError);
        // this.showSnackBar(this.messageError, "error");
      }
    },
    validate: function (data) {
      let hasError = true;
      if (this.type === "edit") {
        if (!data.email || 0 === data.email.length) {
          this.messageError = "E-mail is required";
        } else if (!/.+@.+\..+/.test(data.email)) {
          this.messageError = "E-mail must be valid";
        } else if (!data.first_name || 0 === data.first_name.length) {
          this.messageError = "Firstname is required";
        } else if (!data.last_name || 0 === data.last_name.length) {
          this.messageError = "Lastname is required";
        } else {
          hasError = false;
        }
        if (data.password != undefined) {
          if (!data.password || 0 === data.password.length) {
            this.messageError = "Password is required";
          } else if (data.password.length < 8) {
            this.messageError = "Minimum password length is 8";
          } else if (data.password !== data.reconfirm_password) {
            this.messageError = "Verify Password failed";
          } else {
            hasError = false;
          }
        }
      } else {
        if (!data.email || 0 === data.email.length) {
          this.messageError = "E-mail is required";
        } else if (!/.+@.+\..+/.test(data.email)) {
          this.messageError = "E-mail must be valid";
        } else if (
          !data.password ||
          0 === data.password.length ||
          data.password === undefined
        ) {
          this.messageError = "Password is required";
        } else if (!data.first_name || 0 === data.first_name.length) {
          this.messageError = "Firstname is required";
        } else if (!data.last_name || 0 === data.last_name.length) {
          this.messageError = "Lastname is required";
        } else if (data.password.length < 8) {
          this.messageError = "Minimum password length is 8";
        } else if (data.password !== data.reconfirm_password) {
          this.messageError = "Password different with verify Password";
        } else {
          hasError = false;
        }
      }
      if (hasError == true) {
        return false;
      } else {
        return true;
      }
    },
  },
};
</script>

<style scoped>
.datetimepicker-dummy.is-primary:before,
.datetimepicker-dummy.is-primary::before {
  display: none !important;
}
</style>
