<template>
  <div id="panel tabs-with-content">
    <div class="tabs">
      <div class="menu" v-on:click="tabclick">
        <div class="menu-icon">
          <span class="subtitle is-4 algolia-lvl1">Customer</span>
        </div>
      </div>
    </div>
    <div class="tab-content-container">
      <section class="tab-content admin tab-active">
        <customer-form ref="customerForm"></customer-form>
        <table-list
          :headers="headers"
          :dataTable="table"
          :options="options"
          :paginationOptions="paginationOptions"
          :keyEvent="keyEvent"
          :searchUrl="searchUrl"
          :removeUrl="removeUrl"
        ></table-list>
      </section>
    </div>
  </div>
</template>

<script>
import tableList from "../../shared/table-list.vue";
import Form from "./customer-form.vue";

export default {
  data: function () {
    return {
      table: [],
      headers: [
        "Id",
        "First Name",
        "Lastname",
        "Phone",
        "Address",
        "Email",
        "Point",
        "Join Date",
        "Is Active",
        "Moderated By",
        "Updated Date",
      ],
      options: {
        showPaginate: true,
        isShowActionColumn: true,
        type: "customer",
        maxRow: 10,
        tableListUrl: "",
        hiddenColumn: [],
        searchType: ["id", "name", "email", "phone"],
      },
      paginationOptions: {
        totalPage: 1,
        totalData: 1,
        page: 1,
      },
      keyEvent: "CUSTOMER",
      searchUrl: "/admin/customer",
      removeUrl: "/admin/customer/remove-customer",
    };
  },
  created() {
    var self = this;
    this.onEmitEvent("CUSTOMER_SHOW", function (data) {
      console.log(data)
      var id = data.data.id
      window.location = "/admin/customer/detail/"+id;
      // self.$refs.customerForm.showForm(data.data, "show", "View customer");
    });

    this.onEmitEvent("CUSTOMER_ADD", function (data) {
      self.$refs.customerForm.showForm({is_active: false}, "add", "Add New customer");
    });

    this.onEmitEvent("CUSTOMER_EDIT", function (data) {
      self.$refs.customerForm.showForm(data.data, "edit", "Edit customer Data");
    });
  },
  methods: {
    tabclick: function () {
      window.location = "/admin/customer";
    },
    setData: function (data) {
      this.table = data.tabelData;
      this.paginationOptions = data.pagination_options;
      this.keyEvent = "CUSTOMER";
      this.options.type = data.type;
      this.options.tableListUrl = "/admin/customer";
      if (window.location.href.includes("?typeSearch")) {
        this.options.showPaginate = false;
      }else if(this.table.length == 0){
        this.options.showPaginate = false;
      }
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
