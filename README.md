# 🎵 M.E (Music Emotion)

감정 기반 음악 추천 웹 서비스 (졸업작품)

---

## 📌 프로젝트 개요

M.E (Music Emotion) 는 사용자의 감정과 음악 장르를 기반으로 개인화된 음악을 추천하는 웹 서비스입니다."Music Emotion"의 약자이자, '나(Me)'라는 의미를 함께 담아 음악을 통해 감정을 치유하고 회복할 수 있도록 돕는 것을 목표로 합니다.

---

## 🧩 기획 배경 및 목적

대학 재학 중 4년간 밴드 동아리 활동을 하며 음악이 사람의 감정에 큰 영향을 미친다는 점을 체감했습니다. 기존 음악 추천 서비스는 청취 이력이나 선호 장르를 중심으로 추천이 이루어지지만, 사용자의 현재 감정 상태를 직접적으로 반영하지 못한다는 한계가 있습니다.

본 프로젝트는 사용자가 느끼는 감정에 맞는 음악을 추천함으로써 정서적 안정과 만족도를 높이고, 감정 기반의 새로운 음악 경험을 제공하는 것을 목적으로 합니다.

---

## 🎯 프로젝트 목표

실제 음악 스트리밍 서비스와 커뮤니티 플랫폼의 사용자 흐름을 분석하고, 감정 선택부터 음악 추천, 커뮤니티 공유까지의 과정을 하나의 서비스로 구현하는 것을 목표로 했습니다. 이를 통해 웹 서비스 전반의 구조를 이해하고, 백엔드 중심의 개발 역량을 강화하고자 했습니다.

---

## 🔍 벤치마킹

| 서비스     | 주요 특징              | 반영 내용               |
| ------- | ------------------ | ------------------- |
| 큐오넷     | 음악 관련 정보 공유 커뮤니티   | 자유로운 소통이 가능한 게시판 구조 |
| inDJ    | 감정·상황 기반 음악 추천 서비스 | 감정 중심의 개인화 추천 로직    |
| Spotify | 대규모 음악 스트리밍 플랫폼    | 음악 검색 및 곡 정보 제공 방식  |

**벤치마킹 결과**
각 서비스의 강점을 분석하여 감정 기반 추천(inDJ), 커뮤니티 기능(큐오넷), 음악 정보 탐색 구조(Spotify)를 결합한 웹 서비스로 설계했습니다.

---

## 🧩 핵심 기능

* 감정 + 장르 기반 음악 추천
* 음악 검색 및 곡 정보 조회
* 플레이리스트 관리
* 최근 재생 목록 및 통계
* 좋아요 / 아티스트·앨범 팔로우
* 커뮤니티 게시판 및 댓글 기능

<img width="849" height="323" alt="image" src="https://github.com/user-attachments/assets/04ff976f-6158-4b7f-a5a1-74e668bee18e" />

---

## 📸 화면 구성 및 주요 기능 설명

### 1. 메인화면 및 감정 기반 음악 추천 화면

* 사용자가 현재 감정을 선택하고 선호 장르를 함께 선택
* 선택한 감정과 장르를 기준으로 음악 추천 결과 제공

<img width="949" height="795" alt="image" src="https://github.com/user-attachments/assets/b7ecbfad-8e09-4f38-82b8-16b7c94c66af" />
<img width="1076" height="744" alt="image" src="https://github.com/user-attachments/assets/5151e0da-d03a-4ea5-85ad-78ff61387865" />

---

### 2. 음악 검색 및 곡 정보 화면

* 키워드를 통한 음악 검색 기능 제공
* 곡 선택 시 아티스트, 앨범 등 상세 정보 확인 가능

음악 검색 목록
<img width="1258" height="737" alt="image" src="https://github.com/user-attachments/assets/588c2422-bab6-45f7-a9fc-246023fb00ea" />

음악 세부 정보
<img width="665" height="880" alt="image" src="https://github.com/user-attachments/assets/becc5aa3-f530-49ea-aeaa-2998cf8d4601" />

---

### 3. 마이페이지 / 플레이리스트

* 플레이리스트 생성·수정·삭제 기능
* 최근 재생 목록과 통계 정보 시각화

![마이페이지 화면](./images/mypage.png)

---

### 4. 커뮤니티 기능

* 음악 추천 및 정보 공유를 위한 게시판 제공
* 게시글 및 댓글 작성 기능

<img width="1557" height="832" alt="image" src="https://github.com/user-attachments/assets/d4230c01-5b36-4e67-bf69-f5590e40cd86" />


---

## 🧱 시스템 아키텍처

ERD (Entity Relationship Diagram)
<img width="940" height="373" alt="image" src="https://github.com/user-attachments/assets/81bc8b3a-1a11-4c12-8569-22c0e6bf2c9c" />
<img width="940" height="435" alt="image" src="https://github.com/user-attachments/assets/281cf5a6-5df9-4a1a-80be-c4f45710b1b4" />

DFD (Data Flow Diagram)
<img width="940" height="348" alt="image" src="https://github.com/user-attachments/assets/27a9df24-b6b0-4860-bc1c-7d8a37975556" />
<img width="940" height="341" alt="image" src="https://github.com/user-attachments/assets/68f214d9-66f0-460b-8876-d028d6611504" />

---

## 🛠 기술 스택

| 구분       | 내용                         |
| -------- | -------------------------- |
| Backend  | Java, Spring Boot          |
| Frontend | JSP, HTML, CSS, JavaScript |
| Database | Oracle DB                  |
| Tool     | Git / GitHub               |

---

## 🗂 데이터베이스

* Member, Emotion
* Playlist / Playlist_Songs
* Community / Notice / Comments
* Likes, Artist, Album
* Recent_Played, Recommend

---

## 👨‍💻 개발자

김효준 | 소프트웨어과

> 학부 졸업작품으로 진행한 감정 기반 음악 추천 웹 서비스입니다.
