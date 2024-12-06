package com.example.musicemotion.dto;

public class RecomendDTO {
	private int recomend_id;
	private String emotion;
	private String genres;
	private String song_id;
	
	public int getRecomend_id() {
		return recomend_id;
	}
	public void setRecomend_id(int recomend_id) {
		this.recomend_id = recomend_id;
	}
	public String getEmotion() {
		return emotion;
	}
	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}
	public String getGenres() {
		return genres;
	}
	public void setGenres(String genres) {
		this.genres = genres;
	}
	public String getSong_id() {
		return song_id;
	}
	public void setSong_id(String song_id) {
		this.song_id = song_id;
	}
	
	
}
