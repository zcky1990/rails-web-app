import axios from 'axios'

export default {
  install (Vue) {
      Vue.mixin({
        data: function () {
          return {
            AXIOS:'',
          }
        },
        created() {
            this.AXIOS = axios;
        },
        mounted() {
          console.log("Mixin created");
        },
        methods : {
          /* AJAX FUNCTION USING AXIOSS */
          post: function (url , model,  headers, callbackSuccess, callbackFailed){
            this.AXIOS.post(url, model, { headers })
            .then(response => {
              callbackSuccess(response)
            })
            .catch(e => {
              callbackFailed(e);
            });
          },

          put: function (url , model,  headers, callbackSuccess, callbackFailed){
            this.AXIOS.put(url, model, { headers })
            .then(response => {
              callbackSuccess(response)
            })
            .catch(e => {
              callbackFailed(e);
            });
          },

          get: function (url , headers, callbackSuccess, callbackFailed){
            this.AXIOS.get(url, { headers })
            .then(response => {
              callbackSuccess(response)
            })
            .catch(e => {
              callbackFailed(e);
            });
          },

          delete: function (url , headers, callbackSuccess, callbackFailed){
            this.AXIOS.delete(url, { headers })
            .then(response => {
              callbackSuccess(response)
            })
            .catch(e => {
              callbackFailed(e);
            });
          },
          //can add more function here
          getData(){
            const metas = document.getElementsByTagName('meta');
            for (let i = 0; i < metas.length; i++) {
              if (metas[i].getAttribute('name') === "data") {
                return JSON.parse(metas[i].getAttribute('content'));
              }
            }
            return {};
          },
          getJWT(){
            const metas = document.getElementsByTagName('meta');
            for (let i = 0; i < metas.length; i++) {
              if (metas[i].getAttribute('name') === "jwt") {
                return metas[i].getAttribute('content');
              }
            }
            return '';
          },
          getCsrfToken(){
            return document.head.querySelector("meta[name='csrf-token']").content;
          }
        }
     })
  }
}