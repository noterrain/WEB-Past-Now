$(document).ready(function(){
    //var $item = $('.reply, .submit');
    $('#newthoughts').click(function(){
        //$item.fadeOut(1000);
        $("#show-form").hide();
        $("#newthoughts").hide();
        $("#hidden-form").show();
    });
    
    $('#back').click(function(){
         $("#hidden-form").hide();
        $("#show-form").show();
        $("#newthoughts").show();
    });
});

var someAudio = document.getElementById('some_audio');
var playMusic = function(e){
    console.log('there was a click!', e);
    if(someAudio.paused === true){
       someAudio.play(); 
       div.innerHTML = "Pause";
       div.classList.add('playing');
    } else {
        someAudio.pause();
        div.innerHTML = "Play";
        div.classList.remove('playing');
    }
    
}

div.addEventListener('click', playMusic, false);
