<template>
  <div class="editor container is-desktop">
    <div id="file-uploader"></div>
    <editor-menu-bubble
      :editor="editor"
      :keep-in-bounds="keepInBounds"
      @hide="hideLinkMenu"
      v-slot="{ commands, isActive, getMarkAttrs, menu }"
    >
      <div
        class="menububble"
        :class="{ 'is-active': menu.isActive }"
        :style="`left: ${menu.left}px; bottom: ${menu.bottom}px;`"
      >
        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.bold() }"
          @click="commands.bold"
        >
          <span class="icon is-medium">
            <format-bold></format-bold>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.italic() }"
          @click="commands.italic"
        >
          <span class="icon">
            <format-italic></format-italic>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.strike() }"
          @click="commands.strike"
        >
          <span class="icon">
            <format-strikethrough></format-strikethrough>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.underline() }"
          @click="commands.underline"
        >
          <span class="icon">
            <format-underline></format-underline>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.paragraph() }"
          @click="commands.paragraph"
        >
          <span class="icon">
            <format-paragraph></format-paragraph>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.heading({ level: 1 }) }"
          @click="commands.heading({ level: 1 })"
        >
          <span class="icon">
            <format-header-1></format-header-1>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.heading({ level: 2 }) }"
          @click="commands.heading({ level: 2 })"
        >
          <span class="icon">
            <format-header-2></format-header-2>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.heading({ level: 3 }) }"
          @click="commands.heading({ level: 3 })"
        >
          <span class="icon">
            <format-header-3></format-header-3>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.code() }"
          @click="commands.code"
        >
          <span class="icon">
            <code-tags></code-tags>
          </span>
        </button>

        <form
          class="menububble__form"
          v-if="linkMenuIsActive == true"
          @submit.prevent="setLinkUrl(commands.link, linkUrl)"
        >
          <input
            class="menububble__input"
            type="text"
            v-model="linkUrl"
            placeholder="https://"
            ref="linkInput"
            @keydown.esc="hideLinkMenu"
          />
          <button
            class="menububble__button"
            @click="setLinkUrl(commands.link, null)"
            type="button"
          >
            <span class="icon">
              <i class="fas fa-trash-alt"></i>
            </span>
          </button>
        </form>

        <template v-else>
          <button
            class="menububble__button"
            @click="showLinkMenu(getMarkAttrs('link'))"
            :class="{ 'is-active': isActive.link() }"
          >
            <span class="icon">
              <link-variant></link-variant>
            </span>
          </button>
        </template>

        <button
          class="menububble__button"
          @click="showImagePrompt(commands.image)"
        >
          <image-icon></image-icon>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.bullet_list() }"
          @click="commands.bullet_list"
        >
          <span class="icon">
            <format-list-bulleted></format-list-bulleted>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.ordered_list() }"
          @click="commands.ordered_list"
        >
          <span class="icon">
            <format-list-numbers></format-list-numbers>
          </span>
        </button>

        <button
          class="menububble__button"
          :class="{ 'is-active': isActive.blockquote() }"
          @click="commands.blockquote"
        >
          <span class="icon">
            <format-quote></format-quote>
          </span>
        </button>

        <button
          class="menububble__button"
          @click="
            commands.createTable({
              rowsCount: 3,
              colsCount: 3,
              withHeaderRow: false,
            })
          "
        >
          <span class="icon">
            <table-icon></table-icon>
          </span>
        </button>

        <div class="table-menu-button" v-if="isActive.table()">
          <button class="menububble__button" @click="commands.deleteTable">
            <span class="icon">
              <table-cancel-icon></table-cancel-icon>
            </span>
          </button>
          <button class="menububble__button" @click="commands.addColumnBefore">
            <span class="icon">
              <table-column-plus-before></table-column-plus-before>
            </span>
          </button>
          <button class="menububble__button" @click="commands.addColumnAfter">
            <span class="icon">
              <table-column-plus-after></table-column-plus-after>
            </span>
          </button>
          <button class="menububble__button" @click="commands.deleteColumn">
            <span class="icon">
              <table-column-remove></table-column-remove>
            </span>
          </button>
          <button class="menububble__button" @click="commands.addRowBefore">
            <span class="icon">
              <table-row-plus-before></table-row-plus-before>
            </span>
          </button>
          <button class="menububble__button" @click="commands.addRowAfter">
            <span class="icon">
              <table-row-plus-after></table-row-plus-after>
            </span>
          </button>
          <button class="menububble__button" @click="commands.deleteRow">
            <span class="icon">
              <table-row-remove></table-row-remove>
            </span>
          </button>
          <button class="menububble__button" @click="commands.toggleCellMerge">
            <span class="icon">
              <table-merge-cells></table-merge-cells>
            </span>
          </button>
        </div>

        <button class="menububble__button" @click="commands.horizontal_rule">
          <span class="icon">
            <minus></minus>
          </span>
        </button>

        <button class="menububble__button" @click="commands.undo">
          <span class="icon">
            <undo></undo>
          </span>
        </button>

        <button class="menububble__button" @click="commands.redo">
          <span class="icon">
            <redo></redo>
          </span>
        </button>
      </div>
    </editor-menu-bubble>
    <div class="column">
      <editor-content class="content editor__content" :editor="editor" />
    </div>
  </div>
</template>

<script>
import javascript from "highlight.js/lib/languages/javascript";
import css from "highlight.js/lib/languages/css";
import { Editor, EditorContent, EditorMenuBubble } from "tiptap";
// import {BulmaTitle} from "./nodes/Title.js"
// import {BulmaImage} from "./nodes/BulmaImage.js"
import {
  Blockquote,
  CodeBlock,
  HardBreak,
  HorizontalRule,
  OrderedList,
  BulletList,
  ListItem,
  TodoItem,
  TodoList,
  Bold,
  Code,
  Italic,
  Link,
  Strike,
  Underline,
  History,
  Image,
  TrailingNode,
  Table,
  TableHeader,
  TableCell,
  TableRow,
  CodeBlockHighlight,
  Heading,
} from "tiptap-extensions";
import TableIcon from "vue-material-design-icons/Table.vue";
import TableCancel from "vue-material-design-icons/TableCancel.vue";
import TableColumnPlusBefore from "vue-material-design-icons/TableColumnPlusBefore.vue";
import TableColumnPlusAfter from "vue-material-design-icons/TableColumnPlusAfter.vue";
import TableColumnRemove from "vue-material-design-icons/TableColumnRemove.vue";
import TableMergeCells from "vue-material-design-icons/TableMergeCells.vue";
import TableRowPlusAfter from "vue-material-design-icons/TableRowPlusAfter.vue";
import TableRowPlusBefore from "vue-material-design-icons/TableRowPlusBefore.vue";
import TableRowRemove from "vue-material-design-icons/TableRowRemove.vue";
import FormatBold from "vue-material-design-icons/FormatBold.vue";
import FormatItalic from "vue-material-design-icons/FormatItalic.vue";
import FormatParagraph from "vue-material-design-icons/FormatParagraph.vue";
import FormatUnderline from "vue-material-design-icons/FormatUnderline.vue";
import FormatStrikethrough from "vue-material-design-icons/FormatStrikethrough.vue";
import FormatHeader1 from "vue-material-design-icons/FormatHeader1.vue";
import FormatHeader2 from "vue-material-design-icons/FormatHeader2.vue";
import FormatHeader3 from "vue-material-design-icons/FormatHeader3.vue";
import CodeTags from "vue-material-design-icons/CodeTags.vue";
import LinkVariant from "vue-material-design-icons/LinkVariant.vue";
import FormatListBulleted from "vue-material-design-icons/FormatListBulleted.vue";
import FormatListNumbered from "vue-material-design-icons/FormatListNumbered.vue";
import FormatQuote from "vue-material-design-icons/FormatQuoteClose.vue";
import Minus from "vue-material-design-icons/Minus.vue";
import Undo from "vue-material-design-icons/Undo.vue";
import Redo from "vue-material-design-icons/Redo.vue";
import ImageIcon from "vue-material-design-icons/Image.vue";

export default {
  props: {
    contentData: "",
  },
  components: {
    EditorContent,
    EditorMenuBubble,
    "table-icon": TableIcon,
    "table-cancel-icon": TableCancel,
    "table-column-plus-before": TableColumnPlusBefore,
    "table-column-plus-after": TableColumnPlusAfter,
    "table-column-remove": TableColumnRemove,
    "table-merge-cells": TableMergeCells,
    "table-row-plus-before": TableRowPlusBefore,
    "table-row-plus-after": TableRowPlusAfter,
    "table-row-remove": TableRowRemove,
    "format-bold": FormatBold,
    "format-italic": FormatItalic,
    "format-underline": FormatUnderline,
    "format-strikethrough": FormatStrikethrough,
    "format-header-1": FormatHeader1,
    "format-header-2": FormatHeader2,
    "format-header-3": FormatHeader3,
    "format-paragraph": FormatParagraph,
    "code-tags": CodeTags,
    "link-variant": LinkVariant,
    "format-list-numbers": FormatListNumbered,
    "format-list-bulleted": FormatListBulleted,
    "format-quote": FormatQuote,
    minus: Minus,
    undo: Undo,
    redo: Redo,
    "image-icon": ImageIcon,
  },
  data() {
    return {
      autoFocus: true,
      linkUrl: null,
      linkMenuIsActive: false,
      keepInBounds: true,
      editor: new Editor({
        extensions: [
          new CodeBlockHighlight({
            languages: {
              javascript,
              css,
            },
          }),
          new Blockquote(),
          new BulletList(),
          new CodeBlock(),
          new HardBreak(),
          // new BulmaTitle({ levels: [1, 2, 3] }),
          new Heading({ levels: [1, 2, 3] }),
          new ListItem(),
          new OrderedList(),
          new TodoItem(),
          new TodoList(),
          new Link(),
          new Bold(),
          new Code(),
          new Italic(),
          new Strike(),
          new Underline(),
          new History(),
          new Image(),
          new HorizontalRule(),
          new TrailingNode({
            node: "paragraph",
            notAfter: ["paragraph"],
          }),
          new Table({
            resizable: true,
          }),
          new TableHeader(),
          new TableCell(),
          new TableRow(),
        ],
        content: this.contentData,
      }),
    };
  },
  beforeDestroy() {
    this.editor.destroy();
  },
  methods: {
    showLinkMenu(attrs) {
      this.linkUrl = attrs.href;
      this.linkMenuIsActive = true;
      this.$nextTick(() => {
        this.$refs.linkInput.focus();
      });
    },
    hideLinkMenu() {
      this.linkUrl = null;
      this.linkMenuIsActive = false;
    },
    setLinkUrl(command, url) {
      this.hideLinkMenu();
      command({ href: url });
    },
    showImagePrompt(command) {
      var self = this;
      var f = document.createElement("input");
      f.style.display = "none";
      f.type = "file";
      f.name = "file";
      document.getElementById("file-uploader").appendChild(f);
      f.click();

      f.onchange = function () {
        let token = self.getToken();
        let file = this.files[0];
        let data = new FormData();
        data.append("image", file);
        let headers = {
          Authorization: "Bearer " + token,
          "Content-Type": `multipart/form-data; boundary=${data._boundary}`,
        };

        console.log(headers);
        console.log(file.name);
        self.post(
          "/api/admin/image_uploader/upload",
          data,
          headers,
          function (response) {
            if (response.data.status == "success") {
              const src = response.data.data.secure_url;
              console.log(response.data.data);
              if (src !== null) {
                command({ src });
              }
            }
          },
          function (response) {
            console.log("failed");
          }
        );
        f.remove();
      };
    },
  },
  mounted() {
    console.log(javascript);
  },
};
</script>


<style lang="scss">
$color-black: #000000;
$color-white: #ffffff;
$color-grey: #dddddd;
.ProseMirror:focus {
  outline: none !important;
}

.table-menu-button {
  display: inline-flex;
}

.table-button {
}

.menububble {
  position: absolute;
  display: block;
  z-index: 20;
  background: $color-black;
  border-radius: 5px;
  // padding: 0.3rem;
  // margin-bottom: 0.5rem;
  transform: translateX(-50%);
  visibility: hidden;
  opacity: 0;
  transition: opacity 0.2s, visibility 0.2s;
  max-width: 1300px;

  &.is-active {
    opacity: 1;
    visibility: visible;
  }

  &__button {
    display: inline-flex;
    background: transparent;
    border: 0;
    color: $color-white;
    padding: 0.2rem 0.5rem;
    margin-right: 0.2rem;
    border-radius: 3px;
    cursor: pointer;

    &:last-child {
      margin-right: 0;
    }

    &:hover {
      background-color: rgba($color-white, 0.1);
    }

    &.is-active {
      background-color: rgba($color-white, 0.2);
    }
  }

  &__form {
    display: flex;
    align-items: center;
  }

  &__input {
    font: inherit;
    border: none;
    background: transparent;
    color: $color-white;
  }
}
.ProseMirror {
  outline: none !important;
}
.ProseMirror-focused {
  outline: none !important;
}
.has-focus {
  border-radius: 3px;
  box-shadow: 0 0 0 3px #3ea4ffe6;
}
</style>
