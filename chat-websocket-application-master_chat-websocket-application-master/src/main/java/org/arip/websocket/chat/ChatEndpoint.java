//package org.arip.websocket.chat;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Set;
//import java.util.concurrent.CopyOnWriteArraySet;
//import java.util.logging.Logger;
//import javax.websocket.*;
//import javax.websocket.server.PathParam;
//import javax.websocket.server.ServerEndpoint;
//
///**
// *
// * @author Arip Hidayat
// */
//@ServerEndpoint(
//        value="/chat/{username}",
//        decoders = MessageDecoder.class,
//        encoders = MessageEncoder.class
//)
//public class ChatEndpoint {
//    private final Logger log = Logger.getLogger(getClass().getName());
//
//    private Session session;
//    private String username;
//    
//    private static final Set<ChatEndpoint> chatEndpoints = new CopyOnWriteArraySet<>();
//    private static HashMap<String,String> users = new HashMap<>();
//
//    @OnOpen
//    public void onOpen(Session session, @PathParam("username") String username) throws IOException, EncodeException {
//        log.info(session.getId() + " connected!");
//
//        this.session = session;
//        this.username = username;
//        chatEndpoints.add(this);
//        users.put(session.getId(), username);
//
//        Message message = new Message();
//        message.setFrom(username);
//        message.setProjectID("connected!");
//        broadcast(message);
//    }
//
//    @OnMessage
//    public void onMessage(Session session, Message message) throws IOException, EncodeException {
//        log.info(message.toString());
//        
//        message.setFrom(users.get(session.getId()));
//        sendMessageToOneUser(message);
//    }
//
//    @OnClose
//    public void onClose(Session session) throws IOException, EncodeException {
//        log.info(session.getId() + " disconnected!");
//
//        chatEndpoints.remove(this);
//        Message message = new Message();
//        message.setFrom(users.get(session.getId()));
//        message.setProjectName("disconnected!");
//        broadcast(message);
//    }
//
//    @OnError
//    public void onError(Session session, Throwable throwable) {
//        log.warning(throwable.toString());
//    }
//
//    private static void broadcast(Message message) throws IOException, EncodeException {
//        for (ChatEndpoint endpoint : chatEndpoints) {
//            synchronized(endpoint) {
//                endpoint.session.getBasicRemote().sendObject(message);
//            }
//        }
//    }
//
//    private static void sendMessageToOneUser(Message message) throws IOException, EncodeException {
//        for (ChatEndpoint endpoint : chatEndpoints) {
//            synchronized(endpoint) {
//            	System.out.println("got here");
//                if (endpoint.session.getId().equals(getSessionId(message.getTo()))) {
//                	
//                    endpoint.session.getBasicRemote().sendObject(message);
//                }
//            }
//        }
//    }
//
//    private static String getSessionId(String to) {
//        if (users.containsValue(to)) {
//            for (String sessionId: users.keySet()) {
//                if (users.get(sessionId).equals(to)) {
//                    return sessionId;
//                }
//            }
//        }
//        return null;
//    }
//}
package org.arip.websocket.chat;

import java.io.IOException;
import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Logger;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author Arip Hidayat
 */
@ServerEndpoint(
        value="/chat/{username}",
        decoders = MessageDecoder.class,
        encoders = MessageEncoder.class
)
public class ChatEndpoint {
    private final Logger log = Logger.getLogger(getClass().getName());

    private Session session;
    private String username;
    
    private static final Set<ChatEndpoint> chatEndpoints = new CopyOnWriteArraySet<>();
    private static HashMap<String,String> users = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) throws IOException, EncodeException {
        log.info(session.getId() + " connected!");
        
        this.session = session;
        this.username = username;
        chatEndpoints.add(this);
        users.put(session.getId(), username);

       
       // broadcast(message);
    }

    @OnMessage
    public void onMessage(Session session, Message message) throws IOException, EncodeException {
    		log.info("got herererere");
        log.info(message.toString());
        log.info(message.getProjetName());
        message.setFrom(users.get(session.getId()));
        if(message.getType()==1) {
        		notify(message);
        } else {  
        broadcast(message);
        }
    }

    @OnClose
    public void onClose(Session session) throws IOException, EncodeException {
        log.info(session.getId() + " disconnected!");

        chatEndpoints.remove(this);
        
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        log.warning(throwable.toString());
        throwable.printStackTrace();
    }

    private static void broadcast(Message message) throws IOException, EncodeException {
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized(endpoint) {
            	System.out.println("1");
                endpoint.session.getBasicRemote().sendObject(message);
            	
            }
        }
    }
    
    private static void notify(Message message) throws IOException, EncodeException {
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized(endpoint) {
            	if(message.getTo().equals(endpoint.username)) {
            	System.out.println("1");
                endpoint.session.getBasicRemote().sendObject(message);
            	}
            }
        }
    }

   

    private static String getSessionId(String to) {
        if (users.containsValue(to)) {
            for (String sessionId: users.keySet()) {
                if (users.get(sessionId).equals(to)) {
                    return sessionId;
                }
            }
        }
        return null;
    }
}