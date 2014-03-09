Ext.define("MartialArts.store.Youtube", {
  extend: 'Ext.data.Store',
  alias: 'store.youtube',
  proxy: {
    url: "https://gdata.youtube.com/feeds/api/videos/mwY2WhwJsiM?v=2&alt=json",
    type: "jsonp"
  },
  fields: [
    {name: 'name', mapping: 'entry.title.$t' },
    {name: 'description', mapping: 'entry.media$group.media$description.$t' },
    {name: 'thumbnails', mapping: 'entry.media$group.media$thumbnail' },
    {name: 'thumbnail', convert: function(values, record) {
      return (record.get('thumbnails').length > 0) ? record.get('thumbnails')[0].url : "";
    }}
  ]
});