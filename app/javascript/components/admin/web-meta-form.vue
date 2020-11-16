<template>
  <div class="columns is-desktop is-centered">
    <div class="column is-5-tablet is-5-desktop is-5-widescreen">
      <div class="field is-centered">
        <p class="subtitle is-3">Web Meta Tag</p>
      </div>

      <div class="field">
        <div v-if="showMessage==true" class="field">
          <span class="tag is-danger is-light is-flex">{{messageError}}</span>
        </div>
      </div>

      <div class="field">
        <label for class="label">Title</label>
        <div class="control">
          <input
            v-model="data.title"
            type="text"
            maxlength="60"
            placeholder="your web title here.."
            class="input"
          />
          <p class="help">* max character is 60</p>
        </div>
      </div>
      <div class="field">
        <label for class="label">Webicon</label>
        <div class="control has-icons-left">
          <figure class="image is-32x32">
            <img class="image-meta" :src="getWebImageMetaTagIcon" />
          </figure>
          <p class="help">*max 32×32</p>
        </div>
        <label class="file-label margin-top">
          <input
            class="file-input"
            type="file"
            name="web-meta-image"
            v-on:change="onSelectedFileIcon"
          />
          <span class="file-cta">
            <span class="file-icon">
              <i class="fas fa-upload"></i>
            </span>
            <span class="file-label">Choose a file…</span>
          </span>
          <span class="file-name is-hundred-percent">{{iconFileName}}</span>
        </label>
      </div>
      <div class="field">
        <label for class="label">Image</label>
        <div class="control has-icons-left">
          <figure class="image is-3by1">
            <img class="image-meta" :src="getImageMetaTag" />
          </figure>
          <p class="help">* Recommend 1200×628</p>
        </div>
        <label class="file-label margin-top">
          <input class="file-input" type="file" name="web-meta-image" v-on:change="onSelectedFile" />
          <span class="file-cta">
            <span class="file-icon">
              <i class="fas fa-upload"></i>
            </span>
            <span class="file-label">Choose a file…</span>
          </span>
          <span class="file-name is-hundred-percent">{{filename}}</span>
        </label>
      </div>
      <div class="field">
        <label for class="label">Meta description</label>
        <div class="control has-icons-left">
          <textarea
            v-model="data.description"
            maxlength="160"
            class="textarea"
            placeholder="your web description here.."
          ></textarea>
          <p class="help">* max character is 160</p>
        </div>
      </div>
      <div class="field">
        <label for class="label">Keywords(comma separated)</label>
        <div class="control has-icons-left">
          <textarea
            v-model="data.keywords"
            maxlength="160"
            class="textarea"
            placeholder="your web description here.."
          ></textarea>
        </div>
      </div>
      <div class="field">
        <button class="button is-success" v-on:click="submit">Save</button>
      </div>
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
      data: {
        id: "",
        title: "",
        image_url: "",
        description: "",
        keywords: "",
        icon_image_url: "",
      },
      filename: "",
      iconFileName: "",
      defaultimageurl: "https://bulma.io/images/placeholders/720x240.png",
      defaultIconImageUrl: "https://bulma.io/images/placeholders/32x32.png",
    };
  },
  mounted: function () {
    this.data = this.getData();
  },
  computed: {
    getImageMetaTag: function () {
      if (!this.data.image_url || this.data.image_url.length === 0) {
        return this.defaultimageurl;
      }
      return this.data.image_url;
    },
    getWebImageMetaTagIcon: function () {
      if (!this.data.icon_image_url || this.data.icon_image_url.length === 0) {
        return this.defaultIconImageUrl;
      }
      return this.data.icon_image_url;
    },
  },
  methods: {
    uploadImage: function (type, imageFile, folder) {
      var self = this;
      let headers = {};
      headers["Authorization"] = "Bearer " + this.getJWT();
      headers["Content-Type"] = "multipart/form-data";
      let bodyFormData = new FormData();
      bodyFormData.append("imagefile", imageFile);
      bodyFormData.set("folder", folder);
      this.post(
        "/api/admin/web_meta/upload_image",
        bodyFormData,
        headers,
        function (response) {
          if (response.data.status === "success") {
            if (type == 0) {
              self.data.image_url = response.data.data.secure_url;
            } else {
              self.data.icon_image_url = response.data.data.secure_url;
            }
          } else {
            self.showSnackbar(response.data.message, "error");
          }
        },
        function (e) {
          self.showSnackbar(e, "error");
        }
      );
    },
    onSelectedFile: function (event) {
      this.filename = event.currentTarget.value;
      let file = event.currentTarget.files[0];
      let t = file.type.split("/").pop().toLowerCase();
      if (t != "jpeg" && t != "jpg" && t != "png" && t != "bmp") {
        this.showSnackbar("Please select a valid image file", "error");
        this.filename = "";
        return false;
      }
      this.uploadImage(0, file, "web_meta_tag_image");
    },
    onSelectedFileIcon: function (event) {
      this.iconFileName = event.currentTarget.value;
      let file = event.currentTarget.files[0];
      let t = file.type.split("/").pop().toLowerCase();
      if (t != "jpeg" && t != "jpg" && t != "png" && t != "bmp") {
        this.showSnackbar("Please select a valid image file", "error");
        this.iconFileName = "";
        return false;
      }
      this.uploadImage(1, file, "web_meta_tag_icon");
    },
    validateData: function () {
      if (!this.data.title || this.data.title === "") {
        this.messageError = "Title cannot be Empty";
        this.showMessage = true;
        return false;
      }
      if (!this.data.description || this.data.description === "") {
        this.messageError = "Description cannot be Empty";
        this.showMessage = true;
        return false;
      }
      if (!this.data.keywords || this.data.keywords === "") {
        this.messageError = "Keywords cannot be Empty";
        this.showMessage = true;
        return false;
      }
      return true;
    },
    submit: function (event) {
      var self = this;
      if (this.validateData()) {
        let bodyFormData = {};
        if (this.data.id != "") {
          bodyFormData = {
            id: this.data.id,
            title: this.data.title,
            description: this.data.description,
            keywords: this.data.keywords,
            image_url: this.data.image_url,
            icon_image_url: this.data.icon_image_url,
          };
        }else{
          bodyFormData = {
            title: this.data.title,
            description: this.data.description,
            keywords: this.data.keywords,
            image_url: this.data.image_url,
            icon_image_url: this.data.icon_image_url,
          };
        }

        let headers = {};
        headers["Authorization"] = "Bearer " + this.getJWT();
        if (this.data.id == "") {
          this.post(
            "/api/admin/web_meta/create_web_meta_data",
            bodyFormData,
            headers,
            function (response) {
              if (response.data.status === "success") {
                self.data = response.data.data;
              } else {
                self.showSnackbar(response.data.message, "error");
              }
            },
            function (e) {
              self.showSnackbar(e, "error");
            }
          );
        } else {
          this.put(
            "/api/admin/web_meta/update_web_meta_data",
            bodyFormData,
            headers,
            function (response) {
              if (response.data.status === "success") {
                self.data = response.data.data;
              } else {
                self.showSnackbar(response.data.message, "error");
              }
            },
            function (e) {
              self.showSnackbar(e, "error");
            }
          );
        }
      }
    },
    showSnackbar: function (message, type) {
      let data = {};
      data.message = message;
      data.type = type;
      EventBus.$emit("SNACKBAR_TRIGGERED", data);
    },
  },
};
</script>

<style scoped>
.margin-top {
  margin-top: 5px;
}
.is-hundred-percent {
  width: 100%;
}
</style>
