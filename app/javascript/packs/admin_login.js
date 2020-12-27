
import Vue from 'vue/dist/vue.js';
import AppPageLayout from '../layout/admin/login/login-page-layout.vue';
import Mixin from '../plugins/mixin.js';
import axios from 'axios'

Vue.prototype.$http = axios
// add mixin or global function
Vue.use(Mixin)
const app = new Vue({
    el: '#app-page-layout',
    components: {
        'page-layout': AppPageLayout
    }
});
