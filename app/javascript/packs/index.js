import Vue from 'vue/dist/vue.js';
import AppPageLayout from '../components/layout/home/index-page-layout.vue'

 const app = new Vue({
    el: '#app-page-layout',
    components: {
        'page-layout': AppPageLayout
    }
});