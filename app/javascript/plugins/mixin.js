import axios from 'axios'
import {EventBus} from '../plugins/eventbus.js'

export default {
    install(Vue) {
        Vue.mixin({
            data: function () {
                return {axios: '', EventBus: ''}
            },
            created() {
                this.axios = axios;
                this.EventBus = EventBus;
            },
            mounted() {
                console.log("Mixin created");
            },
            methods: {
                post: function (url, model, headers, callbackSuccess, callbackFailed) {
                    this.axios.post(url, model, {headers}).then(response => {
                        callbackSuccess(response)
                    }).catch(e => {
                        callbackFailed(e);
                    });
                },

                put: function (url, model, headers, callbackSuccess, callbackFailed) {
                    this.axios.put(url, model, {headers}).then(response => {
                        callbackSuccess(response)
                    }).catch(e => {
                        callbackFailed(e);
                    });
                },

                get: function (url, headers, callbackSuccess, callbackFailed) {
                    this.axios.get(url, {headers}).then(response => {
                        callbackSuccess(response)
                    }).catch(e => {
                        callbackFailed(e);
                    });
                },

                delete: function (url, model, headers, callbackSuccess, callbackFailed) {
                    this.axios.delete(url, model, {headers}).then(response => {
                        callbackSuccess(response)
                    }).catch(e => {
                        callbackFailed(e);
                    });
                },
                getJsonHeaders: function () {
                    let headers = {};
                    headers["Authorization"] = "Bearer " + this.getToken();
                    headers["Content-Type"] = "application/json";
                    return headers;
                },
                getData() {
                    console.log("add mixin or global function")
                },
                emitEvent(key, data) {
                    this.EventBus.$emit(key, data);
                },
                onEmitEvent(key, callback) {
                    this.EventBus.$on(key, (data) => {
                        callback(data)
                    });
                },
                showSnackBar: function (message, type) {
                    let data = {};
                    data.message = message;
                    data.type = type;
                    this.EventBus.$emit("SNACKBAR_TRIGGERED", data);
                },
                onEmitSnackBar(callback) {
                    this.EventBus.$on("SNACKBAR_TRIGGERED", (val) => {
                        callback(val)
                    });
                },
                showSpinner: function () {
                    this.EventBus.$emit("SHOW_SPINNER", {});
                },
                hideSpinner: function () {
                    this.EventBus.$emit("HIDE_SPINNER", {});
                },
                onShowSpinner(callback) {
                    this.EventBus.$on("SHOW_SPINNER", () => {
                        callback()
                    });
                },
                onHideSpinner(callback) {
                    this.EventBus.$on("HIDE_SPINNER", () => {
                        callback()
                    });
                },
                getToken() {
                    const metas = document.getElementsByTagName('meta');
                    for (let i = 0; i < metas.length; i++) {
                        if (metas[i].getAttribute('name') === "token") {
                            return metas[i].getAttribute('content');
                        }
                    }
                    return '';
                },
                getCsrfToken() {
                    const metas = document.getElementsByTagName('meta');
                    for (let i = 0; i < metas.length; i++) {
                        if (metas[i].getAttribute('name') === "csrf-token") {
                            return metas[i].getAttribute('content');
                        }
                    }
                    return '';
                },
                submitForm: function (path, params, method) {
                    const form = document.createElement("form");
                    form.method = method;
                    form.action = path;

                    const hiddenField = document.createElement("input");
                    hiddenField.type = "hidden";
                    hiddenField.name = "authenticity_token";
                    hiddenField.value = this.getCsrfToken();
                    form.appendChild(hiddenField);

                    for (const key in params) {
                        if (params.hasOwnProperty(key)) {
                            const hiddenField = document.createElement("input");
                            hiddenField.type = "hidden";
                            hiddenField.name = key;
                            hiddenField.value = params[key];
                            form.appendChild(hiddenField);
                        }
                    }
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        })
    }
}
