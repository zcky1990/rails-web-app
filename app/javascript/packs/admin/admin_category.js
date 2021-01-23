
import Vue from 'vue/dist/vue.js';
import AppPageLayout from '../../layout/admin/category/category-page-layout.vue';
import Mixin from '../../plugins/mixin.js';

// add mixin or global function
Vue.use(Mixin)
const app = new Vue({
    el: '#app-page-layout',
    components: {
        'page-layout': AppPageLayout
    }
});
