# 🧭 Lesson 8 – ALV Screen 활용

---

## SAP 시스템 필드 (SY-*) 정리

| 필드 | 의미 |
| --- | --- |
| SY-REPID | 현재 실행 중인 Report 이름 |
| SY-CPROG | 호출한 프로그램 이름 |
| SY-SUBRC | 실행 결과 코드 (0 = 성공) |
| SY-DATUM | 시스템 날짜 (YYYYMMDD) |
| SY-UZEIT | 시스템 시간 |
| SY-UNAME | 로그인 사용자 |
| SY-TABIX | 내부테이블 현재 인덱스 |
| SY-UCOMM | 버튼 / 메뉴 Function Code |
| SY-DBCNT | SELECT 결과 건수 |
| SY-DYNNR | 현재 Screen 번호 |
| SY-TCODE | 현재 Transaction Code |

---

# 🔵 Unit 1. ALV Design

## Exception Column – ZABAP_31_G01

### 목적

- ALV에서 **조건에 따라 아이콘(신호등)** 을 표시하기 위해 Exception Column 사용
- `LUGGWEIGHT` 값에 따라 EXCP 값 세팅

---

### 데이터 구조 변경 (TOP)

```abap
TYPES : BEGIN OF TS_DATA.
          INCLUDE TYPE SBOOK.
TYPES :   EXCP TYPE CHAR1,
        END OF TS_DATA.

DATA: GT_DATA TYPE TABLE OF TS_DATA,
      GS_DATA LIKE LINE OF GT_DATA.

```

- `SBOOK` 전체 필드 사용
- `EXCP` : ALV Exception Column용 필드

---

### 데이터 조회 + 가공 로직 (MAIN)

```abap
SELECT *
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM SBOOK
  WHERE CARRID IN SO_CAR
    AND CONNID IN SO_CON
    AND FLDATE IN SO_FDT.

LOOP AT GT_DATA INTO GS_DATA.
  IF GS_DATA-LUGGWEIGHT <= 10.
    GS_DATA-EXCP = '3'.
  ELSEIF GS_DATA-LUGGWEIGHT <= 20.
    GS_DATA-EXCP = '2'.
  ELSE.
    GS_DATA-EXCP = '1'.
  ENDIF.

  MODIFY GT_DATA FROM GS_DATA.
  CLEAR GS_DATA.
ENDLOOP.

```

- EXCP 값
    - `1` : Red
    - `2` : Yellow
    - `3` : Green

---

### Layout 설정 (중요)

```abap
GS_LAYOUT-EXCP_FNAME = 'EXCP'.
GS_LAYOUT-EXCP_LED   = 'X'.

```

- `EXCP_FNAME` : 신호등 값이 들어있는 필드명
- `EXCP_LED = 'X'` : 아이콘을 LED 스타일로 표시

---

## Sort Criteria – ZABAP_31_G01

### 목적

- ALV 출력 시 기본 정렬 조건 적용

---

### SORT 테이블 선언

```abap
DATA: GT_SORT TYPE LVC_T_SORT.

```

---

### 정렬 조건 구성 (F01)

```abap
DATA: LS_SORT LIKE LINE OF GT_SORT.

LS_SORT-FIELDNAME = 'FLDATE'.
LS_SORT-DOWN = 'X'.
APPEND LS_SORT TO GT_SORT.

CLEAR LS_SORT.
LS_SORT-FIELDNAME = 'CUSTOMID'.
LS_SORT-UP = 'X'.
APPEND LS_SORT TO GT_SORT.

```

- FLDATE : 내림차순
- CUSTOMID : 오름차순

---

### ALV 호출 시 적용

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  CHANGING
    IT_OUTTAB = GT_DATA
    IT_SORT   = GT_SORT.

```

---

## COLOR – ZABAP_31_G01

### ROW COLOR (행 색상)

### 구조 확장

```abap
TYPES: BEGIN OF TS_DATA.
         INCLUDE TYPE SBOOK.
TYPES:   COLOR TYPE C LENGTH 4,
         LIGHT TYPE C LENGTH 1,
       END OF TS_DATA.

```

---

### 로직

```abap
IF GS_DATA-SMOKER = 'X'.
  GS_DATA-COLOR = 'C610'.
ENDIF.

```

- `C610` : 빨간색 계열
- COLOR 필드는 행 전체 색상용

---

### Layout 설정

```abap
GS_LAYOUT-INFO_FNAME = 'COLOR'.

```

---

### CELL COLOR (셀 색상)

### 추가 구조

```abap
IT_FIELD_COLORS TYPE LVC_T_SCOL.

```

---

### 셀 색상 로직

```abap
GS_FIELD_COLOR-FNAME = 'SMOKER'.
GS_FIELD_COLOR-COLOR-COL = COL_NEGATIVE.
GS_FIELD_COLOR-COLOR-INT = 1.
GS_FIELD_COLOR-COLOR-INV = 0.
APPEND GS_FIELD_COLOR TO GS_DATA-IT_FIELD_COLORS.

```

---

### Layout 연결

```abap
GS_LAYOUT-CTAB_FNAME = 'IT_FIELD_COLORS'.

```

---

## Hidden Functions – ZABAP_31_G01

### 목적

- ALV 툴바에서 **특정 기능 버튼 숨기기**

---

### 변수 선언

```abap
DATA: GT_UIEXCLUDE TYPE UI_FUNCTIONS.

```

---

### 숨길 버튼 설정

```abap
APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_COPY TO GT_UIEXCLUDE.
APPEND CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO GT_UIEXCLUDE.

```

---

### ALV 호출 시 적용

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    IT_TOOLBAR_EXCLUDING = GT_UIEXCLUDE.

```

---

### 전체 툴바 숨김 vs 버튼만 숨김

| 방식 | 의미 |
| --- | --- |
| GS_LAYOUT-NO_TOOLBAR = 'X' | 툴바 영역 자체 제거 |
| UIEXCLUDE | 영역은 유지, 버튼만 제거 |

---

# 🔵 ZBC405_G01_ALV – COLOR 종합

### 출력 구조

```abap
TYPES: BEGIN OF TS_DATA.
         INCLUDE TYPE SFLIGHT.
TYPES:   COLOR           TYPE C LENGTH 4,
         LIGHT           TYPE C LENGTH 1,
         IT_FIELD_COLORS TYPE LVC_T_SCOL,
       END OF TS_DATA.

```

---

### 데이터 가공

```abap
IF GS_FLIGHT-FLDATE(6) = SY-DATUM(6).
  GS_FLIGHT-COLOR = 'C610'.
ENDIF.

IF GS_FLIGHT-SEATSOCC = 0.
  GS_FLIGHT-LIGHT = 1.
ELSEIF GS_FLIGHT-SEATSOCC < 50.
  GS_FLIGHT-LIGHT = 2.
ELSE.
  GS_FLIGHT-LIGHT = 3.
ENDIF.

```

---

### Layout 설정

```abap
GS_LAYOUT-INFO_FNAME = 'COLOR'.
GS_LAYOUT-CTAB_FNAME = 'IT_FIELD_COLORS'.
GS_LAYOUT-EXCP_FNAME = 'LIGHT'.
GS_LAYOUT-SEL_MODE   = 'A'.

```

---

# 🔵 ZQUIZ_17_G01

## 목표

- DB: SFLIGHT
- Selection Screen
    - CARRID
    - CONNID
    - FLDATE (이번 달 1일 ~ 오늘 자동)
- Output
    - CARRID / CONNID / FLDATE
    - SEATSMAX / SEATSOCC
    - PERCENTAGE (예약율)

---

## 예약율 계산

```abap
IF GS_FLIGHT-SEATSMAX = 0.
  GS_FLIGHT-PERCENTAGE = 0.
ELSE.
  GS_FLIGHT-PERCENTAGE =
    ( GS_FLIGHT-SEATSOCC * 100 ) / GS_FLIGHT-SEATSMAX.
ENDIF.

```

---

## 신호등 규칙

| 예약율 | LIGHT |
| --- | --- |
| < 60 | 1 |
| < 90 | 2 |
| ≥ 90 | 3 |

---

## 셀 색상 조건

```abap
IF GS_FLIGHT-PERCENTAGE = 100.
  GS_FIELD_COLOR-FNAME = 'PERCENTAGE'.
  GS_FIELD_COLOR-COLOR-COL = COL_NEGATIVE.
  APPEND GS_FIELD_COLOR TO GS_FLIGHT-IT_FIELD_COLORS.
ENDIF.

```

---

## ALV 호출 핵심

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    IS_VARIANT = GS_VARIANT
    IS_LAYOUT  = GS_LAYOUT
  CHANGING
    IT_OUTTAB       = GT_FLIGHTS
    IT_FIELDCATALOG = GT_FCAT.

```

---

## Screen 0100 Flow Logic

```abap
PROCESS BEFORE OUTPUT.
  MODULE STATUS_0100.
  MODULE CLEAR_OK_CODE.
  MODULE INIT_ALV.

PROCESS AFTER INPUT.
  MODULE USER_COMMAND_0100.

```

---

## 최종 체크 포인트

- IT_OUTTAB / IT_FIELDCATALOG 혼동 ❌
- 색상: INFO_FNAME / CTAB_FNAME 정확히 연결
- 신호등: EXCP_FNAME + 값(1/2/3)
- Variant: GS_VARIANT-REPORT = SY-CPROG 필수
