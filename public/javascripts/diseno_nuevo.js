function select_colors(){
  Event.addBehavior({
    '.marca:change': function(e){
        marcaSelected(this)
      },
  
    '.color': function(){
      this.hide();
    }
  });
}
window.onload = select_colors;