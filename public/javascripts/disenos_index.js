Event.addBehavior({
  'body': function(){
    new Ajax.Request(path_prefix + '/javascripts/timeline', {evalScripts:true});
  },
});