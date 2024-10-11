package com.example.musicemotion.dto;

public class EmotionDTO {
    private int emotion_id;
    private String emotion_name;
    private String description;
    private double danceability_min;
    private double danceability_max;
    private double energy_min;
    private double energy_max;
    private double loudness_min;
    private double loudness_max;
    private double tempo_min;
    private double tempo_max;
    private double valance_min;
    private double valance_max;

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
    public double getDanceability_min() {
        return danceability_min;
    }
    public void setDanceability_min(double danceability_min) {
        this.danceability_min = danceability_min;
    }
    public double getDanceability_max() {
        return danceability_max;
    }
    public void setDanceability_max(double danceability_max) {
        this.danceability_max = danceability_max;
    }
    public double getEnergy_min() {
        return energy_min;
    }
    public void setEnergy_min(double energy_min) {
        this.energy_min = energy_min;
    }
    public double getEnergy_max() {
        return energy_max;
    }
    public void setEnergy_max(double energy_max) {
        this.energy_max = energy_max;
    }
    public double getLoudness_min() {
        return loudness_min;
    }
    public void setLoudness_min(double loudness_min) {
        this.loudness_min = loudness_min;
    }
    public double getLoudness_max() {
        return loudness_max;
    }
    public void setLoudness_max(double loudness_max) {
        this.loudness_max = loudness_max;
    }
    public double getTempo_min() {
        return tempo_min;
    }
    public void setTempo_min(double tempo_min) {
        this.tempo_min = tempo_min;
    }
    public double getTempo_max() {
        return tempo_max;
    }
    public void setTempo_max(double tempo_max) {
        this.tempo_max = tempo_max;
    }
    public double getValance_min() {
        return valance_min;
    }
    public void setValance_min(double valance_min) {
        this.valance_min = valance_min;
    }
    public double getValance_max() {
        return valance_max;
    }
    public void setValance_max(double valance_max) {
        this.valance_max = valance_max;
    }
}
