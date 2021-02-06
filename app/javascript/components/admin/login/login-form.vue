<template>
<div class="columns is-desktop is-centered">
    <div class="column is-5-tablet is-5-desktop is-5-widescreen">
        <div class="field  is-centered">
            <p class="subtitle is-3">Login</p>
        </div>
        <div class="field">
            <label for="" class="label">Email</label>
            <div class="control has-icons-left">
                <input v-model="email" type="email" placeholder="e.g. bobsmith@gmail.com" class="input">
                <span class="icon is-small is-left">
                    <i class="fa fa-envelope"></i>
                </span>
            </div>
        </div>
        <div class="field">
            <label for="" class="label">Password</label>
            <div class="control has-icons-left">
                <input v-model="password" type="password" placeholder="*******" class="input">
                <span class="icon is-small is-left">
                    <i class="fa fa-lock"></i>
                </span>
            </div>
        </div>
        <div class="field">
            <label for="" class="checkbox">
                <input type="checkbox">
                Remember me
            </label>
        </div>
        <div v-if="showMessage==true" class="field">
            <span class="tag is-danger is-light is-flex">
                {{messageError}}
            </span>
        </div>
        <div class="field">
            <button class="button is-success" v-on:click="submit">
                Login
            </button>
        </div>
    </div>
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
                            window.location.href = "/admin";
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
