Ext.define("MartialArts.view.technique.Window", {
  extend: "Ext.window.Window",
  title: "Add Technique",
  modal: true,
  save: function(){
    var form = this.down("form").getForm();
    if(form.isValid()) {
      console.log( form.getValues() );
    }
  },
  
  createItems: function() {
    this.items = [
      {
        xtype: "techniqueform"
      }
    ];
  },
  
  initComponent: function() {
    this.createItems();
    this.buttons = [
      { text: "Save", handler: this.save, scope: this }
    ];
    this.callParent();
  }
});
    
//    Ext.create("MartialArts.view.technique.Window", {}).show();