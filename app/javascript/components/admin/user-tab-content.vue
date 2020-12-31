<template>
    <div id="tabs-with-content">
        <div class="tabs is-centered is-boxed">
            <ul>
                <li class="tab admin is-active" v-on:click="tabOnClick">
                    <a>
                        <span class="icon is-small"><i class="fas fa-user" aria-hidden="true"></i></span>
                        <span>Admin</span>
                    </a>
                </li>
                <li class="tab user" v-on:click="tabOnClick">
                    <a>
                        <span class="icon is-small"><i class="fas fa-user" aria-hidden="true"></i></span>
                        <span>User</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab-content-container">
            <section class="tab-content admin tab-active">Pictures content</section>
            <section class="tab-content user ">Music content</section>
        </div>
    </div>
</template>

<script>
import { EventBus } from "../../plugins/eventbus.js";

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
        tabOnClick: function(event){
            var currentEl = event.currentTarget
            var prevActiveTab = document.querySelector(".is-active")
            prevActiveTab.classList.remove('is-active');
            currentEl.classList.add("is-active");
            var currSection = ""
           if (currentEl.classList.contains("user")){
                currSection = "user"
           } else {
                currSection = "admin"
           }
           var prevActiveContent = document.querySelector(".tab-active")
           prevActiveContent.classList.remove("tab-active");
           var currentActiveContent = document.querySelector(".tab-content"+"."+currSection)
           currentActiveContent.classList.add("tab-active");

        },
        setData: function(data){
        }
    }
};
</script>

<style scoped>
.tab-content {
    display: none;
}
.tab-active {
    display: block;
}
</style>
