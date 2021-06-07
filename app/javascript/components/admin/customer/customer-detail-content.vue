<template>
  <div id="panel tabs-with-content">
    {{datas}}
  </div>
</template>

<script>
import tableList from "../../shared/table-list.vue";
import Form from "./customer-form.vue";

export default {
  data: function () {
    return {
      datas:{}
    };
  },
  created() {
    
  },
  methods: {
    tabclick: function () {
      window.location = "/admin/customer";
    },
    setData: function (data) {
      this.datas = data;
    },
  },
  components: {
    "table-list": tableList,
    "customer-form": Form,
  },
};
</script>

<style scoped>
/* Let's get this party started */
::-webkit-scrollbar {
  width: 4px;
  height: 4px;
}

/* Track */
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 2px rgba(0, 0, 0, 0.3);
  -webkit-border-radius: 2px;
  border-radius: 2px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  -webkit-border-radius: 2px;
  border-radius: 2px;
  background: #dbdbdb;
  -webkit-box-shadow: inset 0 0 2px rgba(0, 0, 0, 0.5);
}
::-webkit-scrollbar-thumb:window-inactive {
  background: grey;
}

.tabs {
  border-bottom: 1px solid #dbdbdb;
}
.tab-content {
  display: none;
}
.tab-active {
  display: block;
}
</style>
