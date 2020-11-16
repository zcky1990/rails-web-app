<template>
<div class="snackbar is-overlay in-front" v-show="showMessage==true">
    <div class="columns is-mobile is-vcentered is-centered">
        <div class="column is-11-mobile is-6-desktop ">
            <div v-if=" type == 'success'" class="notification is-primary">
                <button class="delete is-btn-center" v-on:click="close"></button>
                {{message}}
            </div>
            <div v-if=" type == 'error'" class="notification is-danger is-light">
                <button class="delete is-btn-center" v-on:click="close"></button>
                {{message}}
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    data: function () {
        return {
            type: 'error',
            showMessage: false,
            message: "your message here...",
            timeOut: 2500
        };
    },
    methods: {
        close: function () {
            this.showMessage = false;
        },
        showSnackBar(message, type){
            this.message = message;
            this.type = type;
            this.showMessage = true;
        }
    },
    watch: {
        showMessage: function (val) {
            if (val == true) {
                setTimeout(this.close, this.timeOut);
            }
        }
    }
};
</script>

<style scoped>
.snackbar {
    position: fixed !important;
    margin-top: 4%;
}
.in-front {
    z-index: 999;
}

.is-btn-center {
    right: 0.5rem;
    position: absolute !important;
    top: 1.3rem !important;
}
</style>
