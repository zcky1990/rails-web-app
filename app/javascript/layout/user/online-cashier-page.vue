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
          <div class="column">
            <div class="card">
              <div class="card-content">
                <div class="media">
                  <div class="media-left">
                    <figure class="image is-48x48">
                      <img
                        src="https://bulma.io/images/placeholders/96x96.png"
                        alt="Placeholder image"
                      />
                    </figure>
                  </div>
                  <div class="media-content">
                    <p class="title is-4">John Smith</p>
                    <p class="subtitle is-6">@johnsmith</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="column">
            <div class="card">
              <div class="card-content">
                <div class="media">
                  <div class="media-left">
                    <figure class="image is-48x48">
                      <img
                        src="https://bulma.io/images/placeholders/96x96.png"
                        alt="Placeholder image"
                      />
                    </figure>
                  </div>
                  <div class="media-content">
                    <p class="title is-4">John Smith</p>
                    <p class="subtitle is-6">@johnsmith</p>
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
              <input class="input" type="text" placeholder="Search" />
              <span class="icon is-left">
                <i class="fas fa-search" aria-hidden="true"></i>
              </span>
            </p>
          </div>
        </div>
        <div class="container">
          <div class="column">
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
                    <p class="title">Ikan Gurame Asam Manis</p>
                    <p class="subtitle">Rp. 130000</p>
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
      data: {
        message: "",
      },
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
      console.log(this._datas);
    }
    if (this.notif !== null && this.notif !== undefined) {
      this.$refs.snackbar.showSnackBar(this.notif.message, this.notif.status);
    }
  },
};
</script>

