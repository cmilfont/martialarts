function Video(technique_id) {
  
  var $links = $(".esq .quadro");
  var controller = new VideosController;
  
  var inserir = function(video) {

    $('<iframe />', {
        src: video.link,
        height: "344",
        width: "565",
        allowfullscreen: true, 
        content: "Caso esse video n&amp;amp;atilde;o seja visualizado acesso o <a href=" + video.link + ">link diretamente</a>"
    }).prependTo($links);

  };
  
  var error = function(errors) {
    if(errors.status == 422) {
      $(".error").html("Precisa estar logado para inserir um vídeo nessa técnica");
    } else {
      $(".error").html( errors.join(", ") );
    }
  };
  
  var tratar_link = {
    youtube: function(link) {
      var video_id = link.split('v=')[1];
      var ampersandPosition = video_id.indexOf('&');
      if(ampersandPosition != -1) {
        video_id = video_id.substring(0, ampersandPosition);
      }
      return "http://www.youtube.com/embed/" + video_id + "?html5=1";
    },
    vimeo: function(link) {
      var video_id = link.split('http://vimeo.com/')[1];
      return "http://player.vimeo.com/video/" + video_id;
    }
  };
  
  var _cadastrar = function() {
    var origem = $("[name='origem']").val();
    var link = $("#add").val();
    
    if(link.length === 0) {
      error(["Link não pode ser vazio."]);
      return false;
    }
    
    if(!/^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|www\.)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/.test(link)){
      error(["Url está no formato errado."]);
      return false;
    }
        
    var json = {
      technique_id: technique_id,
      link: tratar_link[origem]( link )
    };
    controller.create(json, inserir, error);
    return false;
  };
  
  this.cadastrar = _cadastrar;
  
};