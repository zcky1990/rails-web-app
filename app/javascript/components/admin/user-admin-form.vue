<template>
<div class="columns is-desktop is-centered">
    <form class="form-horizontal" >
<fieldset>

<!-- Form Name -->
<legend>Add new Admin</legend>

<!-- Text input-->
<div class="field">
  <label class="label" for="first-name">Firstname</label>
  <div class="control">
    <input id="first-name" name="first-name" type="text" placeholder="first name" class="input is-small" required="">
    
  </div>
</div>

<!-- Text input-->
<div class="field">
  <label class="label" for="lastname">Lastname</label>
  <div class="control">
    <input id="lastname" name="lastname" type="text" placeholder="last name" class="input is-small" required="">
    
  </div>
</div>

<!-- Text input-->
<div class="field">
  <label class="label" for="email">Email</label>
  <div class="control">
    <input id="email" name="email" type="text" placeholder="email@email.com" class="input is-small" required="">
    
  </div>
</div>

<!-- Password input-->
<div class="field">
  <label class="label" for="password">Password</label>
  <div class="control">
    <input id="password" name="password" type="password" placeholder="input your password" class="input is-small" required="">
    
  </div>
</div>

<!-- Button -->
<div class="field">
  <label class="label" for="submit"></label>
  <div class="control">
    <button id="submit" name="submit" class="button is-primary">Submit</button>
  </div>
</div>

</fieldset>
</form>
</div>
</template>

<script>
export default {
    data: function () {
        return {
            messageError: "",
            showMessage: false,
            email: "",
            password: ""
        };
    },
    methods: {
        submit: function (event) {
            var self = this;
            if (this.validate(this.email, this.password)) {
                let postbody = {
                    "email": this.email,
                    "password": this.password
                }
                let headers = {};
                this.post("/api/admin/sessions/admin_login", postbody, headers, function (response) {
                        if (response.data.status === 'success') {
                            window.location.href = "/admin/dashboard";
                        } else {
                            self.showSnackBar(response, "error")
                        }
                    },
                    function (e) {
                        self.showSnackBar(e.message, "error")
                    });
            }
        },
        validate: function (email, password) {
            let hasError = true;
            if (!email || 0 === email.length) {
                this.messageError = "E-mail is required"
            } else if (!(/.+@.+\..+/.test(email))) {
                this.messageError = "E-mail must be valid"
            } else if (!password || 0 === password.length) {
                this.messageError = "Password is required"
            } else if (password.length < 8) {
                this.messageError = "Minimum password length is 8"
            } else {
                hasError = false;
            }
            if (hasError == true) {
                this.showMessage = true
                return false
            } else {
                return true
            }
        }
    }
};
</script>

<style scoped>
</style>
