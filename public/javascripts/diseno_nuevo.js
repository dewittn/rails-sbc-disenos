function select_colors(){
  Event.addBehavior({
    '.test:change': function(){
      new Ajax.Request(path_prefix + '/javascripts/colores.js', 
        {asynchronous:true, evalScripts:true, parameters:'cantidad=' + encodeURIComponent(this.value) });
      },
      
    '.marca:change': function(e){
        marcaSelected(this)
      },
  
    '.color': function(){
      if (this.value == "")
        { this.hide(); }
      },
  });
}
window.onload = select_colors;