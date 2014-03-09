Ext.define("MartialArts.view.technique.Thumbnail", {
  extend: "Ext.view.View",
  alias: "widget.thumbnail",
  mixins: {
    innerField: "Ext.form.field.Field"
  },
  tpl: [
  "<tpl for=\".\">",
    "<div class=\"thumbnail\">",
      "<img src=\"{url}\">",
    "</div>",
  "</tpl>"
  ],
  emptyText: 'No Thumb',
  itemSelector: 'div.thumbnail',
  setValue: function(value) {
    this.store.add({url: value});
  },
  store: {
    fields: ["url"],
    data: []
  }
});
