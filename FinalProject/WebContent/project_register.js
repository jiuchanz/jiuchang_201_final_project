 var ws;

 function connect(username) {
		
		
		
		console.log(username);
	    ws = new WebSocket("ws://" + document.location.host + "/chat-websocket-application/chat/" + username);
}

function send() {
    var projectID = null
    var projectName=document.getElementById("pname").value;
    var projectBrief=document.getElementById("abstract").value;
    var to = "";
    var json = JSON.stringify({
        "to":to,
        "projectID":projectID,
        "projectName": projectName,
        "projectBrief": projectBrief
    });

    ws.send(json);
    console.log(json);
    
}