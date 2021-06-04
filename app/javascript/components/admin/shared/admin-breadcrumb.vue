<template>
  <nav
    class="breadcrumb"
    :class="[
      position === 'right' ? 'is-right' : '',
      position === 'left' ? 'is-left' : '',
      position === 'center' ? 'is-centered' : '',
      separator === 'dot' ? ' has-dot-separator' : '',
      size === 'big' ? 'is-large' : '',
      size === 'medium' ? 'is-medium' : '',
      size === 'small' ? 'is-small' : '',
    ]"
    aria-label="breadcrumbs"
  >
    <ul>
      <li v-for="(item, index) in breadCrumbLink" :key="item.name">
        <a
          v-if="index === breadCrumbLink.length - 1"
          :href="`${item.url}`"
          aria-current="page"
          >{{ item.name }}
        </a>
        <a v-else :href="`${item.url}`">{{ item.name }} </a>
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  props: {
    position: String,
    separator: String,
    size: String,
  },
  data: function () {
    return {
      breadCrumbLink: [],
    };
  },
  created() {
    var pathUrl = document.URL.split("?")[0];
    var splitterUrl = pathUrl.split("/");
    this.breadCrumbLink = [];
    var urlData = "";
    for (var i = 3; i < splitterUrl.length; i++) {
      urlData = urlData + "/" + splitterUrl[i];
      this.breadCrumbLink.push({
        name: this.titleCase(splitterUrl[i]),
        url: urlData,
      });
    }
  },
  methods: {
    titleCase: function (str) {
      var splitStr = str.toLowerCase().split(" ");
      for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] =
          splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
      }
      return splitStr.join(" ");
    },
  },
};
</script>