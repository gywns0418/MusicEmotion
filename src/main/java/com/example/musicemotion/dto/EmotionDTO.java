package com.example.musicemotion.dto;

public class EmotionDTO {
    private int emotion_id;
    private String emotion_name;
    private String description;
    private float danceability_min;
    private float danceability_max;
    private float energy_min;
    private float energy_max;
    private float loudness_min;
    private float loudness_max;
    private float tempo_min;
    private float tempo_max;
    private float valance_min;
    private float valance_max;

    // Getters and Setters
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
    public float getDanceability_min() {
        return danceability_min;
    }
    public void setDanceability_min(float danceability_min) {
        this.danceability_min = danceability_min;
    }
    public float getDanceability_max() {
        return danceability_max;
    }
    public void setDanceability_max(float danceability_max) {
        this.danceability_max = danceability_max;
    }
    public float getEnergy_min() {
        return energy_min;
    }
    public void setEnergy_min(float energy_min) {
        this.energy_min = energy_min;
    }
    public float getEnergy_max() {
        return energy_max;
    }
    public void setEnergy_max(float energy_max) {
        this.energy_max = energy_max;
    }
    public float getLoudness_min() {
        return loudness_min;
    }
    public void setLoudness_min(float loudness_min) {
        this.loudness_min = loudness_min;
    }
    public float getLoudness_max() {
        return loudness_max;
    }
    public void setLoudness_max(float loudness_max) {
        this.loudness_max = loudness_max;
    }
    public float getTempo_min() {
        return tempo_min;
    }
    public void setTempo_min(float tempo_min) {
        this.tempo_min = tempo_min;
    }
    public float getTempo_max() {
        return tempo_max;
    }
    public void setTempo_max(float tempo_max) {
        this.tempo_max = tempo_max;
    }
    public float getValance_min() {
        return valance_min;
    }
    public void setValance_min(float valance_min) {
        this.valance_min = valance_min;
    }
    public float getValance_max() {
        return valance_max;
    }
    public void setValance_max(float valance_max) {
        this.valance_max = valance_max;
    }
}
