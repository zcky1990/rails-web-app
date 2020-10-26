export default {
    install(Vue) {
        Vue.mixin({
            data: function () {
                return {}
            },
            created() {},
            mounted() {
                console.log("Mixin created");
            },
            methods: {
                getData() {
                    console.log("add mixin or global function")
                }
            }
        })
    }
}
