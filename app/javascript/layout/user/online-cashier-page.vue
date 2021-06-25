<template>
  <section class="section index-section">
    <div class="container">
      <snake-bar ref="snackbar"></snake-bar>
    </div>
    <div class="columns" id="online-cahier-app">
      <aside
        id="category"
        class="column is-3 aside hero is-fullheight is-hidden-mobile"
      >
        <div class="category-list">
          <div class="column">
            <p class="title">Categories</p>
          </div>
          <div v-for="item in category" :key="item.id" class="column">
            <div
              class="card"
              :id="item.id"
              v-on:click="searchByCategory(item.id)"
            >
              <div class="card-content">
                <div class="media">
                  <div class="media-content">
                    <p class="subtitle is-4">{{ item.name }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </aside>
      <aside
        id="item"
        class="column is-6 aside is-fullheight"
        style="background: #ecf0f3"
      >
        <div class="menu-search" id="menu-search">
          <div class="panel-block">
            <p class="control has-icons-left">
              <input
                class="input"
                type="text"
                placeholder="Search"
                v-on:keyup="search($event)"
              />
              <span class="icon is-left">
                <i class="fas fa-search" aria-hidden="true"></i>
              </span>
            </p>
          </div>
        </div>
        <div class="container">
          <div
            v-for="item in selected_product_data"
            :key="item.id"
            class="column"
          >
            <div class="card">
              <div class="container">
                <div class="columns card-content">
                  <div class="column">
                    <div class="card-image">
                      <figure class="image is-4by3">
                        <img
                          src="https://bulma.io/images/placeholders/1280x960.png"
                          alt="Placeholder image"
                        />
                      </figure>
                    </div>
                  </div>
                  <div class="column">
                    <p class="title">{{ item.name }}</p>
                    <div
                      class="price"
                      v-for="prices in item.price"
                      :key="prices.price_type_id"
                    >
                      <div
                        class="
                          button
                          bd-fat-button
                          is-primary is-light
                          bd-pagination-prev
                        "
                      >
                        {{ toUpperCase(prices.price_type_name) }} - Rp.
                        {{ prices.price }},00
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <footer class="card-footer">
                <div class="card-footer-item">
                  <div class="content">
                    <div class="field is-grouped centered">
                      <div class="control">
                        <div class="button is-white is-unselectable">
                          Amount
                        </div>
                      </div>
                      <div class="control">
                        <a class="button is-info"> - </a>
                      </div>
                      <div class="control">
                        <a class="button"> 1 </a>
                      </div>
                      <div class="control">
                        <a class="button is-info"> + </a>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  class="
                    card-footer-item
                    is-justify-content-flex-end is-align-content-flex-end
                  "
                >
                  <div class="control">
                    <a class="button is-info"> Add to Cart </a>
                  </div>
                </div>
              </footer>
            </div>
          </div>
          <div class="column">Second column</div>
          <div class="column">Third column</div>
        </div>
      </aside>
      <aside id="cart" class="column is-3 aside hero is-fullheight">
        asdasdasasdas asdasdasasdasasda asdasdasasdas
      </aside>
    </div>
  </section>
</template>


<script>
import snackbar from "../../components/shared/snackbar.vue";

export default {
  data: function () {
    return {
      category: [],
      list_product_data: [],
      selected_product_data: [],
    };
  },
  props: {
    _datas: {},
  },
  components: {
    "snake-bar": snackbar,
  },
  created() {
    var self = this;
    this.onEmitSnackBar(function (data) {
      self.$refs.snackbar.showSnackBar(data.message, data.type);
    });

    this.onShowSpinner(function () {
      self.$refs.spinner.showSpinner();
    });

    this.onHideSpinner(function () {
      self.$refs.spinner.hideSpinner();
    });
  },
  mounted: function () {
    if (
      this._datas !== null &&
      !(
        Object.keys(this._datas).length === 0 &&
        this._datas.constructor === Object
      )
    ) {
      this.category = this._datas.category;
      this.list_product_data = this._datas.product;
      this.selectDefaultMenu();
    }
    if (this.notif !== null && this.notif !== undefined) {
      this.$refs.snackbar.showSnackBar(this.notif.message, this.notif.status);
    }
  },
  methods: {
    selectDefaultMenu() {
      var data = this.category[0];
      if (data != {} || data != undefined) {
        var id = data.id;
        this.selected_product_data = this.list_product_data.filter(
          (x) => x.product_category_id == id
        );
        console.log(this.selected_product_data);
      } else {
        this.selected_product_data = [];
      }
    },

    searchByCategory(id) {
      this.selected_product_data = this.list_product_data.filter(
        (x) => x.product_category_id == id
      );
    },
    searchMenu(query) {
      this.selected_product_data = this.list_product_data.filter((x) =>
        x.name.toLowerCase().includes(query.toLowerCase())
      );
    },

    toUpperCase(string) {
      return string.toUpperCase();
    },

    search(event) {
      var query = event.srcElement.value;
      if (query.length > 2) {
        this.searchMenu(query);
      }
      if (query.length == 0) {
        this.selectDefaultMenu();
      }
    },
  },
};
</script>

