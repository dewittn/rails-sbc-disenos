function select_colors(){
  Event.addBehavior({
    '.marca:change': function(e){
        marcaSelected(this)
      },
  
    '.color': function(){
      if (this.value == "")
        { this.hide(); }
      },
    
    '#diseno_cantidad_del_colores:change': function(){
      new Ajax.Request('path_prefix + /javascripts/colores.js', 
        {asynchronous:true, evalScripts:true, parameters:'cantidad=' + encodeURIComponent(this.value) });
      },
  });
}
window.onload = select_colors;