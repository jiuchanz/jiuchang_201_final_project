 var ws;

function connect(username) {
	
	
	
	console.log(username);
    ws = new WebSocket("ws://" + document.location.host + "/chat-websocket-application/chat/" + username);
    
    ws.onmessage = function(event) {
    	
        console.log(event.data);
        var message = JSON.parse(event.data);
    	var newHTML = document.getElementById('addition');
    	
    	newHTML.innerHTML+= ' \
    		<b><h3>Project 1</h3></b>\
    		<div class="features">                           \
			<article>                       \
				<a href="#" class="image"><img src="images/miller.jpg" "/></a> \
				<div class="inner">                    \
					<h4>'+message.projectName+'</h4>               \
					<p>'+message.projectBrief+'</p>       \
				</div>                                      \
			</article>                                      \
					</div>\
		';
    	
    };
}

