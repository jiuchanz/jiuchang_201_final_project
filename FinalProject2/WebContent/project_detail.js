 var ws;

 function connect(username) {

		console.log(username);
	    ws = new WebSocket("ws://" + document.location.host + "/chat-websocket-application/chat/" + username);
	
}

 
 function loop_it(form,proID){

	 for (var i = 0; i < form.elements.length; i++ ) {
	        if (form.elements[i].type == 'checkbox') {
	            if (form.elements[i].checked == true) {
	               var u_name = form.elements[i].value;
	               send(u_name,proID);
	            }
	        }
	 }
	 
	 
 }
 
 
 
 function send(u_name,proID){
	
	    var projectID = null;
	    var projectName="notification";
	    var projectBrief="sent you an invitation to join project "+proID;
	    var to = u_name;
	    var type = 1;
	   
	    var json = JSON.stringify({
	        "to":to,
	        "projectID":projectID,
	        "projectName": proID,
	        "projectBrief": projectBrief,
	        "proID": proID,
	        "type": type
	    });
	    console.log(json);
	    ws.send(json);
	    
	    
	    
	   
 }