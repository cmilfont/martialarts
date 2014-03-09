Ext.define("MartialArts.view.technique.Form", {
  extend: "Ext.form.Panel",
  alias: "widget.techniqueform",
  frame: true,
  
  loadData: function() {
    var form = this.getForm();
    var link = form.findField("link").getValue();
    if( Ext.form.VTypes.url(link) ) {
      Ext.createByAlias("store.youtube")
         .load({ 
           callback: function(data){
             form.loadRecord( data[0] );
             this.down("fieldset").expand();
           },
           scope: this
         });
    } else {
      form.markInvalid([
        {id: 'link', msg: 'Preencha com um link válido!'}
      ]);
    }
  },
  
  initComponent: function() {
    this.items = [
      {
          xtype: 'fieldcontainer',
          fieldLabel: 'Link',
          labelWidth: 50,
          labelAlign: "right",  
          layout: 'hbox',
          items: [{
            name: "link",
            value: "http://www.youtube.com/watch?v=mwY2WhwJsiM#t=48",
            allowBlank: false,
            width: 420,
            xtype: "textfield"
          }, {
              xtype: 'splitter'
          }, {
              xtype: 'button',
              text: "load",
              handler: this.loadData,
              scope: this,
              flex: 1
          }]
      },
      
      {
          xtype:'fieldset',
          title: 'Details',
          collapsible: true,
          collapsed: true,
          items :[
            {
              layout: "column",
              frame: true,
              bodyStyle: {
                border: 0
              },
              style: {
                border: 0
              },
              items: [
                {
                  columnWidth: 0.5,
                  frame: true,
                  style: {
                    border: 0
                  },
                  defaults: {
                    labelAlign: "right", 
                    labelWidth: 80,
                    allowBlank: false,
                    width: 330
                  },
                  items: [
                    {
                        fieldLabel: 'Name',
                        name: 'name',
                        xtype: 'textfield'
                    }, {
                        fieldLabel: 'Description',
                        name: 'description',
                        xtype: "textarea"
                    }, {
                      xtype: 'combo',
                      fieldLabel: 'Martial Arts',
                      multiSelect: true,
                      name: "martialarts",
                      displayField: 'name',
                      valueField: 'id',
                      store: {
                        model: "MartialArts.model.Martialart"
                      }
                    }
                  ]
                },
                {
                  columnWidth: 0.3,
                  frame: true,
                  items: [
                    { 
                      frame: true, xtype: "thumbnail", name: "thumbnail", width: 120, height: 90
                    }
                  ]
                }
              ]
            }
          ]
      }
    ];
    
    this.callParent();
  }
});
  