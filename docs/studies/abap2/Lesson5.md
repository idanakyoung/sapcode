# 🧭 Lesson 5 - 프로그래밍 전용 리포트 개발

---

## 🔵 Unit 1. Programs & Includes

### 1. Programs & Includes 개념

* REPORT 프로그램에서 INCLUDE를 사용하여 소스를 분리
* INCLUDE는 **자동 생성되지 않음**
* 주석 처리해도 자동 포함되지 않음

```abap
REPORT ZBC405_G01_SOL.

INCLUDE ZBC405_G01_SOL_TOP.
INCLUDE ZBC405_G01_SOL_E01.
```

---

### 2. 기존 리포트 vs 프로그래밍 전용 리포트

| 구분   | 기존(Classic) | 프로그래밍 전용   |
| ---- | ----------- | ---------- |
| 로직   | FORM 위주     | CLASS 위주   |
| 구조   | 단일 프로그램     | INCLUDE 분리 |
| 유지보수 | 어려움         | 쉬움         |
| 확장성  | 낮음          | 높음         |

---

### 3. 전용 리포트 역할 분담

* REPORT : 전체 흐름 제어
* TOP INCLUDE : 전역 데이터 선언
* CLS INCLUDE : 모든 로직 처리
* SCR INCLUDE : Selection Screen 담당

---

### 4. INCLUDE 사용 흐름

1. TOP INCLUDE에서 전역 변수 선언
2. EVENT INCLUDE에서 SELECT 및 로직 처리

---

## 🔵 Unit 2. SELECTION SCREENS

## 1. PARAMETERS 옵션 정리

| 옵션          | 사용 위치                       | 의미        | 특징                   |
| ----------- | --------------------------- | --------- | -------------------- |
| OBLIGATORY  | PARAMETERS                  | 필수 입력     | 미입력 시 실행 불가          |
| AS CHECKBOX | PARAMETERS                  | 체크박스      | X / SPACE            |
| DEFAULT     | PARAMETERS / SELECT-OPTIONS | 기본값       | 사용자가 변경 가능           |
| MEMORY ID   | PARAMETERS                  | 이전 입력값 기억 | DEFAULT 값은 저장 안 됨    |
| VALUE CHECK | PARAMETERS                  | 유효성 검사    | SELECT-OPTIONS 사용 불가 |

```abap
PARAMETERS p_carr TYPE s_carr_id OBLIGATORY.
PARAMETERS p_flag AS CHECKBOX.
PARAMETERS p_carr TYPE s_carr_id DEFAULT 'LH'.
PARAMETERS p_carr TYPE s_carr_id MEMORY ID car.
PARAMETERS p_carr TYPE s_carr_id VALUE CHECK.
```

---

## 2. Select-Options 개념

### SIGN

| 값 | 의미           |
| - | ------------ |
| I | Include (포함) |
| E | Exclude (제외) |

### OPTION

| 값  | 의미    |
| -- | ----- |
| EQ | 같다    |
| NE | 같지 않다 |
| GT | 초과    |
| GE | 이상    |
| LT | 미만    |
| LE | 이하    |
| BT | 범위    |
| CP | 패턴 포함 |

```abap
SELECT-OPTIONS so_id FOR gs_customer-id DEFAULT 1 TO 100.
```

---

### MEMORY ID 주의사항

* MEMORY ID는 **사용자가 직접 입력한 값만 저장**
* DEFAULT 값은 MEMORY ID에 저장되지 않음

```abap
SELECT-OPTIONS so_id FOR gs_customer-id MEMORY ID id.
```

---

### NO-EXTENSION / NO INTERVALS

```abap
SELECT-OPTIONS so_id FOR gs_customer-id NO-EXTENSION.
SELECT-OPTIONS so_id FOR gs_customer-id NO INTERVALS.
```

* NO-EXTENSION : 다중 조건 버튼 제거
* NO INTERVALS : BT(범위) 입력 불가

---

### INITIALIZATION에서 Select-Options 제어

```abap
INITIALIZATION.

  so_id-sign = 'I'.
  so_id-option = 'BT'.
  so_id-low = 1.
  so_id-high = 100.
  APPEND so_id.

  CLEAR so_id.
  so_id-sign = 'I'.
  so_id-option = 'EQ'.
  so_id-low = 500.
  APPEND so_id.

  CLEAR so_id.
  so_id-sign = 'E'.
  so_id-option = 'EQ'.
  so_id-low = 50.
  APPEND so_id.

  CLEAR so_id.
  so_id-sign = 'E'.
  so_id-option = 'BT'.
  so_id-low = 81.
  so_id-high = 90.
  APPEND so_id.
```

### 결과 범위

```
(1~49), (51~80), (91~100), 500
```

---

## 3. SELECTION BLOCK

* Selection Screen을 논리적으로 그룹화
* 가독성 및 유지보수 향상

```abap
SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE text-t01.
  PARAMETERS pa_car TYPE sbook-carrid OBLIGATORY MEMORY ID car.
SELECTION-SCREEN END OF BLOCK blk1.
```

---

### COMMENT & LINE

```abap
SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 1(20) text-c01.
SELECTION-SCREEN END OF LINE.
```

* 1 : 시작 컬럼
* 20 : 길이

---

### RADIO BUTTON UI 구성

```abap
SELECTION-SCREEN COMMENT pos_low(5) text-c02 FOR FIELD pa_all.
PARAMETERS pa_all RADIOBUTTON GROUP rb1 DEFAULT 'X'.

SELECTION-SCREEN COMMENT pos_high(10) text-c03.
PARAMETERS pa_icon RADIOBUTTON GROUP rb1.
```

* FOR FIELD 사용 시 텍스트 클릭 → 라디오 버튼 선택

---

## 🔵 실습 프로그램 정리

### ZBC405_G01_SOL 목표

* Selection Screen 조건과 Radio Button에 따라

  * 전체 / 국내선 / 국제선 항공편 조회

---

### ZQUIZ_15_G01 목표

* 최대 좌석 수(SEATSMAX)와 예약 좌석 수(SEATSOCC)를 비교
* 만석 항공편 조회

```abap
WHERE seatsmax - seatsocc = 0.
```

---

### ZQUIZ_16_G01 목표

* SBOOK + SCUSTOM JOIN
* Airline / Flight Date 조건
* 고객 구분 (전체 / 흡연 / 비흡연)

```abap
FROM sbook
INNER JOIN scustom
  ON sbook~customid = scustom~id
```

출력 필드:

* CARRID, CONNID, FLDATE, BOOKID, CUSTOMID, NAME, SMOKER

---
