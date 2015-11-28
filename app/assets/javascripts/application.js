// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./application
//= require_self


$('.auto-submit').jt_autosubmit({

    onLoading: function(){
        $('.loader').removeClass('hidden');
        $('.results').html('');
    },
    onComplete: function(){
        $('.loader').addClass('hidden');
    }

});

function Room(url){
	this.lastMessageId = null;
	this._url = url;
}

Room.prototype.update = function (){
	var room = this;

	$.ajax({
		url: this._url,
		data: {
			last_message_id: this.lastMessageId
		}
	}).always(function(){
		setTimeout(function() {
			room.update();
		}, 1000);
	});
};

Room.prototype.canUpdateMessages = function (lastMessageId) {
	return (lastMessageId == this.lastMessageId);
}

window.currentRoom = null;