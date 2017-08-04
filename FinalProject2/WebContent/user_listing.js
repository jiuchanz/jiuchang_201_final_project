 var ws;

function connect(username) {
	
	
	
	console.log(username);
    ws = new WebSocket("ws://" + document.location.host + "/chat-websocket-application/chat/" + username);
    
    ws.onmessage = function(event) {
    	
        console.log(event.data);
        var message = JSON.parse(event.data);
        if(message.type ==0){
        		var newHTML = document.getElementById('addition');
    	
        		newHTML.innerHTML+= ' \
        				\
    		<div class="features">                           \
			<article>                       \
				<a href="#" class="image"><img src="images/light2.jpg" "/></a> \
				<div class="inner">                    \
					<h4>'+message.projectName+'</h4>               \
					<p>'+message.projectBrief+'Project brief introduction</p>       \
				</div>                                      \
			</article>                                      \
					</div>\
		';
    	
        log.innerHTML += message.from + " : project#" + message.projectID + " "+message.projectName+"\n"+message.projectBrief+"\n"; }
        else {
        		add(message.from, message.projectBrief);
        		log.innerHTML += message.from + " : project#" + message.projectID + " "+message.projectName+"\n"+message.projectBrief+"\n";
        	
        }
        
    };
}

var modal = document.getElementById('id01');
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}

function add(sender, msg){
	var newHTML = document.getElementById('notify');
	newHTML.innerHTML+=' <h2>'+sender+' '+msg+'</h2>'
}










