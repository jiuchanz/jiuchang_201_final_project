 var ws;

function connect() {
    var username = document.getElementById("username").value;
    ws = new WebSocket("ws://" + document.location.host + "/FinalProject/src/org/arip/websocket/chat/" + username);


    ws.onmessage = function(event) {
    	var log = document.getElementById("log");
        console.log(event.data);
        var message = JSON.parse(event.data);
        log.innerHTML += message.from + " : project#" + message.projectID + " "+message.projectName+"\n"+message.projectBrief+"\n";
    };
}

function send() {
    var projectID = document.getElementById("projectID").value;
    var projectName=document.getElementById("projectName").value;
    var projectBrief=document.getElementById("projectBrief").value;
    var to = document.getElementById("to").value;
    var json = JSON.stringify({
        "to":to,
        "projectID":projectID,
        "projectName": projectName,
        "projectBrief": projectBrief
    });

    ws.send(json);
    console.log(json);
    document.getElementById("log").innerHTML
    log.innerHTML += "Me : " + projectName + "\n";
}