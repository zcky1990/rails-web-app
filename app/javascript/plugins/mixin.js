import axios from 'axios'
import { EventBus } from '../plugins/eventbus.js'

export default {
    install(Vue) {
        Vue.mixin({
            data: function () {
                return { 
                    axios: '',
                    EventBus: ''
                }
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

                delete: function (url, headers, callbackSuccess, callbackFailed) {
                    this.axios.delete(url, {headers}).then(response => {
                        callbackSuccess(response)
                    }).catch(e => {
                        callbackFailed(e);
                    });
                },
                getData() {
                    console.log("add mixin or global function")
                },
                showSnackBar: function (message, type) {
                    let data = {};
                    data.message = message;
                    data.type = type;
                    this.EventBus.$emit("SNACKBAR_TRIGGERED", data);
                },
                onEmitSnackBar(trigger,callback){
                    this.EventBus.$on(trigger, (val) => {
                        callback(val)
                      });
                }
            }
        })
    }
}
