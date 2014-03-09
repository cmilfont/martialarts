Ext.define("MartialArts.model.Martialart", {
  extend: "Ext.data.Model",
  fields: [
    "name", 
    "description",
    { name: "created_at", type: 'date' },
    { name: "updated_at", type: 'date' }
  ],
  
  proxy: {
		type: 'rest',
		url: "/martialarts"
	}
	
});