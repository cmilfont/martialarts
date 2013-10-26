// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require djr
//= require jquery.autocomplete.min
//= require_tree .


function ELJS(template){
  this.pattern = /\$\{([^}]+)\}/g;
  this.compiled = false;
  this.mapa = {};

  this.compile = function() {
    var self = this;
    this.compiled_template = template.replace(this.pattern, 
      function(group, value, index){
        var _parser = new Function("return " + value + ";");
        self.mapa[index] = _parser;
        return "${" + index + "}";
      }
    );
    this.compiled = true;
    return this;
  };

  var _transform = function(json){

    if(!this.compiled) this.compile();

       var self = this;
       return this.compiled_template.replace(this.pattern, function(group, value){
         return self.mapa[value].call(json);
       });

  };

  this.parse = _transform;
  this.render = _transform;
}


Object.defineProperty(Object.prototype, "merge", { 
  value: function(base){

    (function merge(merged, source){
      for(var propriedade in source){
        if( typeof source[propriedade] === 'object' && 
            typeof merged[propriedade] !== 'undefined' ) {
          merge(merged[propriedade], source[propriedade]); 
        } else {
            merged[propriedade] = source[propriedade];
        }
      }
    })(this, base);

    return this;

  }
});

var prototypeDefault = {
  'trying': function(property) {
    return property.split(".").reduce(function(object, name){
      if(object && name) return object[name];
    }, this);          
  }
}

if(Object.defineProperty) {
  for(var method in prototypeDefault) {
    Object.defineProperty(Object.prototype, method, {
      enumerable: false, value: prototypeDefault[method]
    });
  }
}

/*

var controller = new TechniquesController;
var template = '<h2><span><a href="/techniques/${this.id}">${this.name}</a></span> (1 Video)</h2><p>${this.description}</p>';
var engine = new ELJS(template);

controller.create( $("form").getJSON() , function(technique){

    $("#conteudo .container").append(engine.render(technique));
  
});

*/

;(function($){

  $.fn.extend({
    
    populate: function(json){
      $(this).find("input,select,textarea").each(function(index, el){
        console.log( $(el) );
        var $el = $(el);
        if($el.attr("id")) {
          var name = $el.attr("id").split("_");
          name.shift();
          $el.val( json.trying(name.join(".")) );
        }
      });
      return this;
    },
    
    getJSON: function(){
      var result = {};
      $(this).find("input,select,textarea").each(function(index, el){

        var id = $(el).attr('id');
        var value = $(el).val();
        var json = {};
        if(id) {
          json = id.split("_").reduceRight(function(objeto, propriedade){
            return Object.defineProperty({}, propriedade, { 
                     value: (objeto)? objeto: value,
                     writable : true,
                     configurable : true,
                     enumerable : true 
                   });
          }, null);
 
        }

        result.merge( json );
      });
      return result;
    }
  });

})(jQuery);




(function($){
  $.fn.extend({
    workflowEdit: function(config){
      $(this).click(function(){
        $("#novo").show();
        config.controller.show({id: 6}, function(json){
          $(config.form).populate(json)
                        .submit(function(){

            config.controller.update( $(this).getJSON() , function(result){
              $(config.area).append(config.engine.render(result));
              $("#novo").hide();
            });
            return false;

          });

        });
        return false;
      })
    }
  });
})(jQuery);
 
var template = '<h2><span><a href="/techniques/${this.id}">${this.name}</a></span> (1 Video)</h2><p>${this.description}</p>';
 
$("a:contains('Edit')").workflow({ 
  form: ".new_martialart", 
  area: "#conteudo .container",
  controller:  new MartialartsController,
  engine: new ELJS(template)
});