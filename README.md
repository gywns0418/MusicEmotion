# M.E (Music Emotion)
감정 기반 음악 추천 웹 서비스 (졸업작품)

---

## 프로젝트 개요

M.E (Music Emotion)는 사용자의 감정과 음악 장르를 기반으로 개인화된 음악을 추천하는 웹 서비스입니다.  
“Music Emotion”의 약자이자 ‘나(Me)’라는 의미를 함께 담아,  
음악을 통해 감정을 치유하고 회복할 수 있도록 돕는 것을 목표로 합니다.

---

## 기획 배경 및 목적

대학 재학 중 4년간 밴드 동아리 활동을 하며  
음악이 사람의 감정에 큰 영향을 미친다는 점을 체감했습니다.

기존 음악 추천 서비스는 청취 이력이나 선호 장르를 중심으로 추천이 이루어지지만,  
사용자의 **현재 감정 상태를 직접적으로 반영하지 못한다는 한계**가 있습니다.

본 프로젝트는 감정 선택을 기반으로 음악을 추천함으로써  
정서적 안정과 만족도를 높이고,  
감정 중심의 새로운 음악 경험을 제공하는 것을 목적으로 합니다.

---

## 프로젝트 목표

- 실제 음악 스트리밍 서비스와 커뮤니티 플랫폼의 사용자 흐름 분석
- 감정 선택 → 음악 추천 → 커뮤니티 공유 흐름의 서비스 구현
- 백엔드 중심 웹 서비스 구조 설계 역량 강화

---

## 벤치마킹

| 서비스 | 주요 특징 | 반영 내용 |
|---|---|---|
| 큐오넷 | 음악 정보 공유 커뮤니티 | 게시판 및 댓글 구조 |
| inDJ | 감정·상황 기반 추천 | 감정 중심 추천 로직 |
| Spotify | 음악 스트리밍 플랫폼 | 검색 및 곡 정보 제공 방식 |

감정 기반 추천, 커뮤니티, 음악 탐색 구조를 결합한  
통합 음악 웹 서비스로 설계했습니다.

---

## 핵심 기능

- 감정 + 장르 기반 음악 추천
- 음악 검색 및 곡 정보 조회
- 플레이리스트 관리
- 최근 재생 목록 및 통계
- 좋아요 / 아티스트·앨범 팔로우
- 커뮤니티 게시판 및 댓글 기능

<p align="center">
  <img width="940" height="430" src="https://github.com/user-attachments/assets/aa172460-c442-42c5-bc48-9381c53b86d0" />
</p>

---

## 화면 구성 및 주요 기능

### 메인화면 · 감정 기반 추천

- 감정 및 선호 장르 선택
- 선택 정보 기반 음악 추천 결과 제공

<p align="center">
  <img width="949" height="795" src="https://github.com/user-attachments/assets/b7ecbfad-8e09-4f38-82b8-16b7c94c66af" />
</p>

<p align="center">
  <img width="1076" height="744" src="https://github.com/user-attachments/assets/5151e0da-d03a-4ea5-85ad-78ff61387865" />
</p>

---

### 음악 검색 · 곡 정보

- 키워드 기반 음악 검색
- 아티스트, 앨범 등 상세 정보 제공

<p align="center">
  <img width="1258" height="737" src="https://github.com/user-attachments/assets/588c2422-bab6-45f7-a9fc-246023fb00ea" />
</p>

<p align="center">
  <img width="665" height="880" src="https://github.com/user-attachments/assets/becc5aa3-f530-49ea-aeaa-2998cf8d4601" />
</p>

---

### 마이페이지 · 플레이리스트

- 플레이리스트 생성, 수정, 삭제
- 최근 재생 기록 및 청취 통계 시각화

<p align="center">
  <img width="937" height="819" src="https://github.com/user-attachments/assets/2237dc8e-e280-4469-a80c-6aedc79cbd53" />
</p>

<p align="center">
  <img width="721" height="571" src="https://github.com/user-attachments/assets/da93f672-7add-4164-a660-52be55c17bba" />
</p>

---

### 커뮤니티

- 음악 추천 및 정보 공유 게시판
- 게시글 및 댓글 작성 기능

<p align="center">
  <img width="1557" height="832" src="https://github.com/user-attachments/assets/d4230c01-5b36-4e67-bf69-f5590e40cd86" />
</p>

---

## 시스템 설계

### ERD
<p align="center">
  <img width="940" height="373" src="https://github.com/user-attachments/assets/81bc8b3a-1a11-4c12-8569-22c0e6bf2c9c" />
</p>

### DFD
<p align="center">
  <img width="940" height="348" src="https://github.com/user-attachments/assets/27a9df24-b6b0-4860-bc1c-7d8a37975556" />
</p>

---

## 기술 스택

| 구분 | 내용 |
|---|---|
| Backend | Java, Spring Boot |
| Frontend | JSP, HTML, CSS, JavaScript |
| Database | Oracle DB |
| Tool | Git, GitHub |

---

## 개발자

김효준  
소프트웨어과 학부 졸업작품

감정 기반 추천이라는 주제를 통해  
사용자 중심 서비스 설계와 백엔드 개발 역량을 강화한 프로젝트입니다.
