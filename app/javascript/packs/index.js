require("@rails/ujs").start()
require("turbolinks").start()
require("channels")

import Vue from 'vue/dist/vue.js';
import AppPageLayout from '../layout/home/index-page-layout.vue';
import Mixin from '../plugins/mixin.js';

//add mixin or global function
Vue.use(Mixin)
const app = new Vue({
    el: '#app-page-layout',
    components: {
        'page-layout': AppPageLayout
    }
});