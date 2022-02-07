Event.addBehavior({
  'body': function(){
    var link = $p($a({href:'',id:'add_color'},'Add color'));
    $('add_color').appendChild(link);
    $('submit_button').hide();
    cp1 = new Refresh.Web.ColorPicker('cp1',{startHex: 'ffcc00', startMode:'s'});
  },
  
  '#add_color:click': function(e){
    new Ajax.Request(path_prefix + '/javascripts/add_colors.js', 
      {asynchronous:true, evalScripts:true, parameters:Form.serialize(document.forms[0]) });
    e.stop();
    },
  
  '.hex_link:click': function(e){
    var color = $('cp1_Hex').value
    this.next().value = color;
    this.up().style.backgroundColor = '#' + color;
    e.stop();
  }
});