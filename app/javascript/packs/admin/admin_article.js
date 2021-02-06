
import Vue from 'vue/dist/vue.js';
import AppPageLayout from '../../layout/admin/article/article-page-layout.vue';
import Mixin from '../../plugins/mixin.js';
import VueHighlightJS from 'vue-highlightjs'

// add mixin or global function
Vue.use(VueHighlightJS)
Vue.use(Mixin)
const app = new Vue({
    el: '#app-page-layout',
    components: {
        'page-layout': AppPageLayout
    }
});
