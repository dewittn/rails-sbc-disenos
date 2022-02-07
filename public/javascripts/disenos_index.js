Event.addBehavior({
  '#search': function(e){
    new Form.Element.Observer('search', 0.5, function(element, value){
      new Ajax.Updater('results', path_prefix + '/disenos.js', {
        asynchronous:true, evalScripts:true, method:'get', parameters:'search=' + element.value
        })
      })
    },
  
  'input[type=submit]': function(){
    this.hide();
  },
});