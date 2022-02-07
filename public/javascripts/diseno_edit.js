function select_colors(){
  var link = $p($a({href:'',id:'add_hilo'},'Add Hilo'));
  $('hilos').appendChild(link);
  Event.addBehavior({
    '.marca:change': function(e){
        marcaSelected(this)
      },
  
    '.color': function(){
      if (this.value == "")
        { this.hide(); }
      },

    '#add_hilo:click': function(e){
      new Ajax.Request(path_prefix + '/javascripts/add_hilos.js', 
        {asynchronous:true, evalScripts:true, parameters:Form.serialize(document.forms[0]) });
      e.stop();
      },
  });
}
window.onload = select_colors;