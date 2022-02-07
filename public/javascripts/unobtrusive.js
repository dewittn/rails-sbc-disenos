// Replace these examples with your own code.
Ajax.Responders.register({
  onCreate: function() {
    if($('busy') && Ajax.activeRequestCount > 0)
      Effect.Appear('busy',{duration:0.5,queue:'end'});
  },
  
  onComplete: function() {
    if($('busy') && Ajax.activeRequestCount == 0)
      Effect.Fade('busy',{duration:1.0,queue:'end'});
  }    
});

Event.addBehavior({
  'body': function(){
      var busy = $div({id:'busy',style: "display:none;"}, "Carcando...");
      var search = $div({id:'top-search'},'Search:',$input({id: 'search', name:'search', type:'text'}), $div({id:'results'}));
      document.body.appendChild(busy);
      document.body.appendChild(search);
  },
  
  '#search': function(e){
    new Form.Element.Observer('search', 0.5, function(element, value){
      new Ajax.Updater('results', path_prefix + '/disenos.js', {
        asynchronous:true, evalScripts:true, method:'get', parameters:'search=' + element.value
        })
      })
    },
});