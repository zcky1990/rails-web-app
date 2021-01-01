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
            <fieldset>
              <div class="field is-hidden">
                <label class="label" for="id">id</label>
                <div class="control">
                  <input
                    v-model="userData.id"
                    id="id"
                    name="id"
                    type="text"
                    class="input is-small"
                  />
                </div>
              </div>
              <div class="field">
                <label class="label" for="email">Email</label>
                <div class="control">
                  <input
                    v-model="userData.email"
                    id="email"
                    name="email"
                    type="text"
                    placeholder="email@email.com"
                    class="input is-small"
                  />
                </div>
              </div>
              <div class="field">
                <label class="label" for="password">Password</label>
                <div class="control">
                  <input
                    v-model="userData.password"
                    id="password"
                    name="password"
                    type="password"
                    placeholder="input your password"
                    class="input is-small"
                  />
                </div>
              </div>
              <div class="field">
                <label class="label" for="password">Verify Password</label>
                <div class="control">
                  <input
                    v-model="userData.reconfirm_password"
                    id="new-password"
                    name="new-password"
                    type="password"
                    placeholder="input your password"
                    class="input is-small"
                  />
                </div>
              </div>
              <div class="field">
                <label class="label" for="firstname">Firstname</label>
                <div class="control">
                  <input
                    v-model="userData.first_name"
                    id="first-name"
                    name="first-name"
                    type="text"
                    placeholder="first name"
                    class="input is-small"
                  />
                </div>
              </div>
              <div class="field">
                <label class="label" for="lastname">Lastname</label>
                <div class="control">
                  <input
                    v-model="userData.last_name"
                    id="lastname"
                    name="lastname"
                    type="text"
                    placeholder="last name"
                    class="input is-small"
                  />
                </div>
              </div>
            </fieldset>
          </form>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-info" v-on:click="onSubmit">Submit</button>
          <button class="button" v-on:click="onClickCancel">Cancel</button>
        </footer>
      </div>
      <div class="is-desktop is-centered modal-card"></div>
      <!-- dad -->
    </div>
    <button class="modal-close is-large" aria-label="close"></button>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      isShow: false,
      messageError: "",
      showMessage: false,
      userData: {},
      title: "",
      type: "",
    };
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
    },
    onClickCancel: function () {
      this.hideForm();
    },
    onSubmit: function (event) {
      var self = this;
      if (this.validate(this.userData)) {
        console.log(this.userData);
        if (this.type == "edit") {
          this.emitEvent("ON_EDIT_ADMIN", this.userData);
        } else {
          this.emitEvent("ON_ADD_ADMIN", this.userData);
        }
      } else {
        console.log(this.messageError);
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
</style>
