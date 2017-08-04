package org.arip.websocket.chat;

/**
 * Created by Arip Hidayat on 21/02/2016.
 */
public class Message {

    private String from;
    private String to;
    private String projectID;
    private String projectName;
    private String projectBrief;
    private int proID;
    private int type;

    @Override
    public String toString() {
        return super.toString();
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getProjectID() {
        return projectID;
    }

    public void setProjectID(String projectID) {
        this.projectID = projectID;
    }
    public String getProjetName() {return projectName;}
    public void setProjectName(String projectName) {this.projectName= projectName;}
    public String getProjectBrief() {return projectBrief;}
    public void setProjectBrief(String projectBrief) {this.projectBrief= projectBrief;}
    public int getType() {return this.type;}
    public int getProID() {return this.proID;}
}
