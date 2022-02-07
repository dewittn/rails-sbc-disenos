Event.addBehavior({
  '#email_form': Remote.Form,
  
  'body': function(){
    var link = $p({},$a({href:'',id:'email_image'},'Email Image'));
    if ( $('image_div') != null )
      {$('image_div').appendChild(link);}
  },
  
  '#email_image:click': function(e){
    $('notice').innerHTML = ''
    $('error').innerHTML = ''
    $('email').show();
    $('email_cancel').show();
    $('email_submit').show();
    $('email_subject').disabled = false;
    $('email_body').disabled = false;
    $('email_to').disabled = false;
    if ( $('email_subject').value == '' )
      { $('email_subject').value = t.email.subject_text }
    if ($('email_body').value == '' ) 
      { $('email_body').value = t.email.body }
    e.stop();
    },
    
  '#email_submit:click': function(e){
    this.hide();
    $('email_cancel').hide();
  },
  
  '#email_cancel:click': function(e){
    $('email').hide();
    e.stop();
  }
});