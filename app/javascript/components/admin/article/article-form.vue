<template>
  <div class="modal" :class="isShow ? 'is-active' : 'is-hidden'">
    <div class="modal-background"></div>
    <div class="modal-content fill-screen">
      <div class="modal-card fill-screen">
        <header class="modal-card-head no-radius">
          <p class="modal-card-title">{{ title }}</p>
          <button class="delete" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
          <div class="container is-5-desktop">
            <div class="column">
              <div class="field">
                <div class="is-normal">
                  <label class="label">Title</label>
                </div>
                <div class="field-body">
                  <div class="field">
                    <div class="controlx">
                      <input
                        class="input"
                        v-model="article.title"
                        :class="error.isTitleError ? 'is-danger' : ''"
                        type="text"
                        placeholder="Add Title here..."
                      />
                    </div>
                    <p v-if="error.isTitleError == true" class="help is-danger">
                      {{ error.messageError }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <tags-input
            :title="'Category'"
            :url="searchUrl"
            :token="getToken()"
            :items="article.categories"
            :isSearchAble="searchAble"
            @add-list="addCategoriesArticle"
            @remove-list="removeCategoriesArticle"
          ></tags-input>

          <editor ref="editor" :contentdata="article.content"></editor>

          <div class="container is-desktop">
            <div class="column">
              <div class="field is-grouped is-grouped-right">
                <button class="button is-primary" v-on:click="onSubmit">
                  Submit
                </button>
                <button class="button" v-on:click="onClickCancel">
                  Cancel
                </button>
              </div>
            </div>
          </div>
        </section>
      </div>
      <div class="is-desktop is-centered modal-card"></div>
      <!-- dad -->
    </div>
  </div>
</template>

<script>
import tagsInput from "./../../shared/tags-input.vue";
import editorTipTap from "./../../shared/editor/editor.vue";

export default {
  data: function () {
    return {
      isShow: false,
      messageError: "",
      showMessage: false,
      article: {
        content: `<figure class="image is-128x128">
                  <img src="https://bulma.io/images/placeholders/128x128.png">
                </figure>`,
        categories: [],
      },
      title: "",
      type: "",
      date: new Date(),
      error: {
        isTitleError: false,
        messageError: "",
      },
      options: [
        { text: "Active", value: "true" },
        { text: "InActive", value: "false" },
      ],
      searchUrl: "/api/v1/category/get_category_list",
      searchAble: true,
    };
  },
  computed: {
    showButtonSubmit() {
      if (this.type == "show") {
        return false;
      }
      return true;
    },
  },
  methods: {
    addCategoriesArticle(data) {
      console.log("emited add categories");
      if (this.article.categories == undefined) {
        this.article.categories = [];
      }
      if (!this.containsObject(this.article.categories, data)) {
        this.article.categories.push(data);
        this.article.content = this.$refs.editor.getContent();
      }
    },
    removeCategoriesArticle(index) {
      console.log("emited remove categories");
      this.article.categories.splice(index, 1);
      this.article.content = this.$refs.editor.getContent();
    },
    containsObject: function (obj, list) {
      var i;
      for (i = 0; i < list.length; i++) {
        if (list[i].id === obj.id) {
          return true;
        }
      }
      return false;
    },
    showForm(data, type, title) {
      this.article = data;
      this.type = type;
      this.title = title;
      this.isShow = true;
    },
    hideForm() {
      this.isShow = false;
      this.article = {};
      this.type = "";
      this.title = "";
    },
    onClickCancel: function () {
      this.hideForm();
    },
    onSubmit: function (event) {
      if (this.type == "edit") {
        if (!this.isFailedValidateArticleData()) {
          this.emitEvent("ON_EDIT_ARTICLE", this.article);
        }
      } else {
        if (!this.isFailedValidateArticleData()) {
          this.article.content = this.$refs.editor.getContent();
          this.emitEvent("ON_ADD_ARTICLE", this.article);
        }
      }
    },
    resetError() {
      this.error.isTitleError = false;
      this.error.messageError = "";
    },
    isFailedValidateArticleData() {
      this.resetError();
      let error = false;
      if (!this.article.title || 0 === this.article.title.length) {
        this.error.messageError = "Title is required";
        this.error.isTitleError = true;
        error = true;
      } else {
        this.resetError();
      }
      return error;
    },
  },
  components: {
    "tags-input": tagsInput,
    editor: editorTipTap,
  },
};
</script>

<style scoped>
.fill-screen {
  position: relative;
  top: 0;
  width: 100% !important;
  height: 100% !important;
  max-height: 100% !important;
}
.no-radius {
  border-radius: 0 !important;
}
</style>
