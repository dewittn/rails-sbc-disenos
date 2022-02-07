Event.addBehavior({
  'body': function(){
    var link = $p($a({href:'',id:'add_color'},'Add color'));
    $('add_color').appendChild(link);
    $('submit_button').hide();
  },
  
  '#add_color:click': function(e){
    new Ajax.Request(path_prefix + '/javascripts/add_colors.js', 
      {asynchronous:true, evalScripts:true, parameters:Form.serialize(document.forms[0]) });
    e.stop();
    },
});