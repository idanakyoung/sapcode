# Lesson 14 – Screen Program / Dialog Programming 정리

## 0. ABAP Program 타입 복습

1. **Executable Program (Type: 1)**  
   - `REPORT`로 시작하는 일반 리포트 프로그램  
   - 트랜잭션 코드로 실행 가능  
   - Selection Screen 사용 가능  

2. **Include Program (Type: I)**  
   - 다른 프로그램 내부에서 `INCLUDE` 로 불러서 사용하는 재사용용 코드 조각  
   - 보통 이름 규칙 예: `MZSCR_G01TOP`, `MZSCR_G01O01`, `MZSCR_G01I01` 등  

3. **Module Pool Program (Type: M)**  
   - Dialog Program, Screen 기반 프로그램  
   - 화면(스크린)과 PBO/PAI 플로우 로직을 함께 사용  
   - 프로그램 이름 규칙 예:
     - 메인 프로그램: `SAPMZSCR_G01`
     - Include: `MZSCR_G01TOP`, `MZSCR_G01O01`, `MZSCR_G01I01` …

4. **Function Group (Type: F)**  
   - Function Module들의 집합

5. **Class Pool (Type: K)**  
   - 글로벌 클래스 정의용 프로그램 타입

---

## 1. Screen Program 기초

### 1-1. Screen Program / Include 구조

- **Screen Program 이름 규칙**
  - `SAPMZ...` 로 시작 (`SAPMZSCREEN_G01` 등)
- **Include Program 이름 규칙**
  - 메인 프로그램명에서 `SAP` 제거 후 뒤에 구분자 추가
  - 예:
    - 메인: `SAPMZSCREEN_G01`
    - TOP include: `MZSCREEN_G01TOP`
    - PBO include: `MZSCREEN_G01O01`
    - PAI include: `MZSCREEN_G01I01`

메인 모듈 풀의 전형적인 구조:

```abap
*& Module Pool      SAPMZSCREEN_G01
*&---------------------------------------------------------------------*

INCLUDE MZSCREEN_G01TOP.    " Global Data
INCLUDE MZSCREEN_G01O01.    " PBO-Modules
INCLUDE MZSCREEN_G01I01.    " PAI-Modules
* INCLUDE MZSCREEN_G01F01.  " FORM-Routines (필요 시)

