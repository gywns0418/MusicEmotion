package com.example.musicemotion.dto;

public class Recent_PlayedDTO {
	private String user_id;
	private String song_id;
	private String played_at;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSong_id() {
		return song_id;
	}
	public void setSong_id(String song_id) {
		this.song_id = song_id;
	}
	public String getPlayed_at() {
		return played_at;
	}
	public void setPlayed_at(String played_at) {
		this.played_at = played_at;
	}
	
}
