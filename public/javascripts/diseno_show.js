Event.addBehavior({
  'body': function(){
    var link = $p({},$a({href:'',id:'email_image'},'Email Image'));
    $('image_div').appendChild(link);
  },
  
  '#email_image:click': function(e){
    $('email').show();
    e.stop();
    },
});