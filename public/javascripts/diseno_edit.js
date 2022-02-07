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
      new Ajax.Request(path_prefix + '/javascripts/edit_colores.js', 
        {asynchronous:true, evalScripts:true, parameters:'id=' + $('diseno_id').value });
      e.stop();
      },
  });
}
window.onload = select_colors;