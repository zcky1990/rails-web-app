import {Node} from 'tiptap'

export default class Figcaption extends Node {

  get name() {
    return "figcaption"
  }

  get schema() {
    return {
      content: "inline*",
      group: "figure",
      // TO-DO: get image alt if figcaption not found using prosemirror-model
      parseDOM: [{tag: "figcaption"}],
      toDOM: node => ["figcaption", 0],
    }
  }
}