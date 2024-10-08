package com.example.musicemotion.dto;

public class EmotionDTO {
    private int emotion_id;
    private String emotion_name;
    private String description;
	private int danceability;
	private int energy;
	private int loudness;
	private int tempo;
	private int valance;
	
	public int getEmotion_id() {
		return emotion_id;
	}
	public void setEmotion_id(int emotion_id) {
		this.emotion_id = emotion_id;
	}
	public String getEmotion_name() {
		return emotion_name;
	}
	public void setEmotion_name(String emotion_name) {
		this.emotion_name = emotion_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getDanceability() {
		return danceability;
	}
	public void setDanceability(int danceability) {
		this.danceability = danceability;
	}
	public int getEnergy() {
		return energy;
	}
	public void setEnergy(int energy) {
		this.energy = energy;
	}
	public int getLoudness() {
		return loudness;
	}
	public void setLoudness(int loudness) {
		this.loudness = loudness;
	}
	public int getTempo() {
		return tempo;
	}
	public void setTempo(int tempo) {
		this.tempo = tempo;
	}
	public int getValance() {
		return valance;
	}
	public void setValance(int valance) {
		this.valance = valance;
	}
	
	
}
