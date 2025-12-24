# 🧭 Lesson 7 – **OO ALV Grid 화면 구성 & 기능 확장 (Screen 100 / Variant / Layout)**

---

## 목차

1. Unit 1) Dynpro 100 기반 Grid 출력 (ZABAP_31_G01 / ZBC405_G01_ALV)
2. Screen 100 만들기 체크리스트 (사진 대신 “클릭 순서” 텍스트로 완전 재현)
3. Unit 2) ALV Controls & Class(Objects) 핵심 개념
4. INIT_ALV 패턴: Container → Grid → Display
5. Variant / Layout 확장 (12/19 추가)
6. Layout 옵션 시각화(ASCII) + SEL_MODE 정리

---

# 🔵 Unit 1. ALV (Dynpro 100 + Container + ALV Grid)

## 1) 실습 프로그램: ZABAP_31_G01 (SBOOK 조회 → Screen 100 ALV 출력)

### 1-1. INCLUDE 선언 및 저장 (프로젝트 구조)

- 메인 프로그램에서 TOP Include 분리(보통)
    - `ZABAP_31_G01` (Main)
    - `ZABAP_31_G01_TOP` (전역 데이터/Selection Screen)
    - `ZABAP_31_G01_O01` (PBO 모듈)
    - `ZABAP_31_G01_I01` (PAI 모듈)
    - `ZABAP_31_G01_F01` (FORM 등)

> 노션 이미지가 잘리는 문제를 방지하려고, “어디에 뭘 넣는지”를 아래처럼 텍스트로 고정해둠.
> 

---

### 1-2. TOP Include: 데이터 선언 + Selection Screen

```abap
DATA: GT_DATA TYPE TABLE OF SBOOK,
      GS_DATA LIKE LINE OF GT_DATA.

SELECTION-SCREEN BEGIN OF BLOCK BLK1 WITH FRAME TITLE TEXT-T01.
  SELECT-OPTIONS: SO_CAR FOR GS_DATA-CARRID,
                  SO_CON FOR GS_DATA-CONNID,
                  SO_FDT FOR GS_DATA-FLDATE.
SELECTION-SCREEN END OF BLOCK BLK1.

```

**포인트**

- `GS_DATA`를 만든 이유: `SELECT-OPTIONS ... FOR GS_DATA-필드`로 타입 자동 상속
- SO_CAR / SO_CON / SO_FDT로 조회 조건 구성

---

### 1-3. Main Program: INITIALIZATION + START-OF-SELECTION

```abap
INITIALIZATION.
  SO_CAR-SIGN   = 'I'.
  SO_CAR-OPTION = 'BT'.
  SO_CAR-LOW    = 'AA'.
  SO_CAR-HIGH   = 'LH'.
  APPEND SO_CAR.

START-OF-SELECTION.
  SELECT *
    INTO TABLE GT_DATA
    FROM SBOOK
    WHERE CARRID IN SO_CAR
      AND CONNID IN SO_CON
      AND FLDATE IN SO_FDT.

  CALL SCREEN 100.

```

**포인트**

- 기본값(AA~LH) 자동 세팅
- 조회 후 Dynpro 100으로 이동 → 화면에 ALV 출력 준비

---

## 2) Screen 100 생성 (사진 없이 재현 가능한 “작업 순서”)

### 2-1. Screen 100 생성

1. SE80에서 프로그램 → **Screen 100 생성**
2. **Layout** 클릭

### 2-2. Custom Control 배치

1. Layout에서 **Custom Control** 선택 후 화면에 배치
2. 더블 클릭 → **Name을 `AREA` 로 설정**
3. 저장 후 닫기

> 여기서 AREA는 나중에 CL_GUI_CUSTOM_CONTAINER 생성할 때 CONTAINER_NAME = 'AREA'로 들어가는 핵심 값
> 

---

### 2-3. Element List에서 OK_CODE 생성

1. Screen 100 → **Element List**
2. `OK_CODE` 추가 (타입은 `SY-UCOMM`)

TOP에 선언도 반드시 필요:

```abap
DATA : OK_CODE TYPE SY-UCOMM.

```

---

### 2-4. PBO/PAI 모듈 연결 (Flow Logic)

### (1) PBO: STATUS 모듈 활성화

- Screen 100 → Flow Logic → PBO
- `MODULE STATUS_0100.` 주석 풀기 + 더블 클릭 생성

```abap
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.

```

### (2) PF-STATUS ‘S100’ 생성

- `'S100'` 더블클릭 → GUI Status 생성
- **Function code** 입력 후 저장/Activate
    - (예: BACK, CANCEL, EXIT 같은 코드)

### (3) TITLEBAR ‘T100’ 생성

- `'T100'` 더블클릭 → Title 생성
- All Title 유지 후 저장

---

### 2-5. PBO에 OK_CODE 초기화 모듈 추가

```abap
MODULE CLEAR_OK_CODE OUTPUT.
  CLEAR OK_CODE.
ENDMODULE.

```

**왜 필요?**

- PAI에서 눌린 값이 다음 PBO에서도 남으면 “버튼이 계속 눌린 것처럼” 오동작 가능
- 그래서 **PBO에서 매번 CLEAR**하는 패턴이 자주 사용됨

---

### 2-6. PAI 모듈: 사용자 커맨드 처리

```abap
MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

```

---

## 3) 예제: ZBC405_G01_ALV (기본 틀)

### 3-1. 데이터/Selection Screen

```abap
DATA: GT_FLIGHTS TYPE TABLE OF SFLIGHT,
      GS_FLIGHT LIKE LINE OF GT_FLIGHTS.
DATA : OK_CODE LIKE SY-UCOMM.

SELECTION-SCREEN BEGIN OF BLOCK BLK1 WITH FRAME.
  SELECT-OPTIONS: SO_CAR FOR GS_FLIGHT-CARRID,
                  SO_CON FOR GS_FLIGHT-CONNID.
SELECTION-SCREEN END OF BLOCK BLK1.

```

### 3-2. START-OF-SELECTION

```abap
START-OF-SELECTION.
  SELECT *
    FROM SFLIGHT
    INTO TABLE GT_FLIGHTS
    WHERE CARRID IN SO_CAR
      AND CONNID IN SO_CON.

  CALL SCREEN 100.

```

### 3-3. Module 기본 세트

```abap
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100'.
ENDMODULE.

MODULE CLEAR_OK_CODE OUTPUT.
  CLEAR OK_CODE.
ENDMODULE.

MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK' OR 'CANCEL' OR 'EXIT'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.

```

---

# 🔵 Unit 2. ALV CONTROLS & CLASS(OBJECTS)

## 1) OO ALV 핵심 2개 클래스

### (1) Container: 어디에 올릴지(그릇)

- `CL_GUI_CUSTOM_CONTAINER`

### (2) ALV Grid: 표 자체를 그림

- `CL_GUI_ALV_GRID`

---

## 2) 전형적인 전역 선언 셋업

```abap
DATA: GO_CONT   TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_ALV    TYPE REF TO CL_GUI_ALV_GRID,
      GT_DATA   TYPE TABLE OF SCARR,
      GT_FCAT   TYPE LVC_T_FCAT,
      GS_LAYOUT TYPE LVC_S_LAYO.

```

---

## 3) 실행 흐름(필수 다이어그램)

```
START-OF-SELECTION
  |
  v
SELECT ... INTO GT_DATA
  |
  v
CALL SCREEN 100
  |
  v
PBO (OUTPUT)
  |
  +--> STATUS_0100  : PF-STATUS / TITLE
  |
  +--> CLEAR_OK_CODE: OK_CODE 초기화
  |
  +--> INIT_ALV     : (딱 1번만) 객체 생성 + ALV 출력
          |
          +-- CREATE CONTAINER (AREA)
          +-- CREATE ALV GRID (parent = container)
          +-- set_table_for_first_display (IT_OUTTAB = GT_DATA ...)
  |
  v
PAI (INPUT)
  |
  +--> USER_COMMAND_0100 : BACK/CANCEL/EXIT 처리

```

**왜 컨테이너 생성 위치(PBO)가 중요?**

- Screen 100이 뜰 때 화면 요소(AREA)가 존재해야 컨테이너가 붙는다.
- 그래서 보통 `IF go_cont IS INITIAL.`로 “첫 PBO에서만” 생성.

---

## 4) set_table_for_first_display 핵심 구조

```abap
go_alv->set_table_for_first_display(
  EXPORTING
*   i_structure_name = 'SCARR'     "자동 필드카탈로그(DDIC/구조 기반)
*   is_variant       = gs_variant  "Variant 사용 시
*   i_save           = 'A'         "Variant 저장 허용
    is_layout        = gs_layout
  CHANGING
    it_outtab        = gt_outtab   "필수: 화면에 보여줄 내부테이블
*   it_fieldcatalog  = gt_fcat     "직접 FCAT 구성 시
).

```

✅ **중요 규칙**

- `I_STRUCTURE_NAME` 또는 `IT_FIELDCATALOG` **둘 중 하나는 반드시 필요(대부분의 케이스)**
- `IT_OUTTAB`은 **무조건 필요** (ALV가 읽을 데이터 원본)

---

# 🔵 Unit 2-실습: ALV GRID 생성 (INIT_ALV)

## 1) 전역 참조 변수 선언

TOP에 선언:

```abap
DATA: GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.

```

---

## 2) Screen 100 PBO에 INIT_ALV 모듈 생성

Flow Logic PBO에:

```abap
MODULE INIT_ALV OUTPUT.

```

---

## 3) INIT_ALV 내부 핵심 코드 (패턴)

### 3-1. Container 생성 (AREA에 붙이기)

```abap
IF GO_CONT IS INITIAL.

  CREATE OBJECT GO_CONT
    EXPORTING
      CONTAINER_NAME = 'AREA'
    EXCEPTIONS
      CNTL_ERROR                  = 1
      CNTL_SYSTEM_ERROR           = 2
      CREATE_ERROR                = 3
      LIFETIME_ERROR              = 4
      LIFETIME_DYNPRO_DYNPRO_LINK = 5
      OTHERS                      = 6.

```

### 3-2. ALV Grid 생성

```abap
  CREATE OBJECT GO_ALV
    EXPORTING
      I_PARENT          = GO_CONT
    EXCEPTIONS
      ERROR_CNTL_CREATE = 1
      ERROR_CNTL_INIT   = 2
      ERROR_CNTL_LINK   = 3
      ERROR_DP_CREATE   = 4
      OTHERS            = 5.

```

### 3-3. ALV 출력 호출

```abap
  CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME = 'SBOOK'
    CHANGING
      IT_OUTTAB        = GT_DATA
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
ENDIF.

```

---

# ✅ 12/19 추가 내용 – Variant / Layout 확장 (사진 없이 재현)

## A) Variant 사용(레이아웃 저장/불러오기)

### 1) TOP에 변수 추가

```abap
DATA: GS_VARIANT TYPE DISVARIANT.

```

(선택) 저장 권한 변수

```abap
DATA: GV_SAVE TYPE CHAR1.

```

---

### 2) PBO에서 Variant에 Report 연결(필수)

`INIT_ALV`에서 메소드 호출 전에:

```abap
GS_VARIANT-REPORT = SY-CPROG.

```

> 이거 안 넣으면 Variant 저장/불러오기 메뉴가 제대로 동작 안 하거나 제한됨
> 

---

### 3) set_table_for_first_display에 Variant 넘기기

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    I_STRUCTURE_NAME = 'SBOOK'
    IS_VARIANT       = GS_VARIANT
    I_SAVE           = 'A'
  CHANGING
    IT_OUTTAB        = GT_DATA.

```

### I_SAVE 값 의미(실무에서 자주 씀)

- `'A'` : 사용자 전체 저장 허용(가장 흔한 실습값)
- 시스템/정책에 따라 `'U'` 등으로 제한하는 케이스도 있음

---

### 4) “레이아웃 이름 파라미터로 시작부터 적용” 패턴

TOP에 파라미터 추가(예: 사용자가 레이아웃 이름 입력)

```abap
PARAMETERS: P_LAYO TYPE DISVARIANT-VARIANT.

```

PBO에서:

```abap
IF P_LAYO IS NOT INITIAL.
  GS_VARIANT-VARIANT = P_LAYO.
ENDIF.

```

이렇게 하면:

- 사용자가 `P_LAYO`에 레이아웃명 입력
- 실행 시 해당 Variant로 바로 표시

---

## B) Layout 설정 (GS_LAYOUT : LVC_S_LAYO)

### 1) TOP에 Layout 변수 선언

```abap
DATA: GS_LAYOUT TYPE LVC_S_LAYO.

```

### 2) (권장) FORM으로 레이아웃 구성

```abap
PERFORM SET_LAYOUT2.

```

### 3) 레이아웃 옵션 예시(네 노션 내용 그대로 + 설명 시각화)

```abap
GS_LAYOUT-GRID_TITLE = 'Booking data'.
GS_LAYOUT-ZEBRA      = 'X'.
GS_LAYOUT-CWIDTH_OPT = 'X'.
*GS_LAYOUT-NO_HEADERS = 'X'.
*GS_LAYOUT-NO_TOOLBAR = 'X'.
*GS_LAYOUT-NO_VGRIDLN = 'X'.
*GS_LAYOUT-NO_HGRIDLN = 'X'.
GS_LAYOUT-TOTALS_BEF  = 'X'.
GS_LAYOUT-SEL_MODE    = 'A'.

```

---

## C) Layout 옵션 “그림 없이도 보이게” ASCII 시각화

### 1) GRID_TITLE

```
┌───────────────────────────────┐
│ Booking data                  │  ← GRID_TITLE
├───────────────────────────────┤
│ ... ALV rows ...              │
└───────────────────────────────┘

```

### 2) ZEBRA

```
row1 ██████████████████████
row2 ░░░░░░░░░░░░░░░░░░░░░░
row3 ██████████████████████

```

### 3) CWIDTH_OPT (컬럼 폭 자동)

```
┌────┬──────────────────┬───────┐
│ ID │ NAME             │ PRICE │
└────┴──────────────────┴───────┘

```

### 4) NO_HEADERS (헤더 숨김)

```
(헤더 라인 없음)
001  KIM   100
002  LEE   200

```

### 5) NO_TOOLBAR (툴바 숨김)

```
[정렬/필터/엑셀다운 버튼 영역이 사라짐]

```

### 6) NO_VGRIDLN / NO_HGRIDLN (그리드 선 숨김)

- V: 세로 구분선 제거
- H: 가로 구분선 제거

### 7) TOTALS_BEF (합계 라인을 위로)

```
합계: ...
---------------------------
데이터 row1
데이터 row2

```

---

## D) SEL_MODE 정리 (행/열/셀 선택 정책)

> 네 노션에 “C일 경우 여러 개의 행과 열 선택 가능”, “D는 여러 개의 셀 + 여러 개의 열과 행” 메모가 있었고
> 
> 
> 실습/버전에 따라 표현이 조금 다르게 보일 수 있어. 여기서는 **실습에서 체감되는 기준으로 정리**한다.
> 

### SEL_MODE 체감 기준

- `'A'` : 선택 기능 활성(일반적인 선택 가능 모드로 많이 사용)
- `'C'` : 여러 행 선택/컬럼 단위 선택이 더 유연하게 느껴짐(실습에서 “여러 행/열”로 설명되는 경우)
- `'D'` : 셀 단위로 더 “세밀하게” 선택되는 느낌(여러 셀/행/열 조합)

> 시스템 버전/GUI 설정에 따라 세부 동작이 다를 수 있으니, 실습 시스템에서 직접 눌러보며 확인하는 게 정확함.
> 

---

## E) set_table_for_first_display에 Layout 적용

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    I_STRUCTURE_NAME = 'SBOOK'
    IS_LAYOUT        = GS_LAYOUT
    IS_VARIANT       = GS_VARIANT
    I_SAVE           = 'A'
  CHANGING
    IT_OUTTAB        = GT_DATA.

```

---

# 최종 실무형 체크리스트

## Screen 100에서 반드시 확인할 것

- [ ]  Layout에 Custom Control이 있고 이름이 **AREA**
- [ ]  Element List에 **OK_CODE** 존재
- [ ]  PBO에 `STATUS_0100`, `CLEAR_OK_CODE`, `INIT_ALV` 연결
- [ ]  PAI에 `USER_COMMAND_0100` 연결
- [ ]  GUI Status `S100`에 BACK/CANCEL/EXIT Function Code 존재
- [ ]  Title `T100` 존재

## INIT_ALV에서 반드시 확인할 것

- [ ]  `IF go_cont IS INITIAL.` 로 1회 생성
- [ ]  `CREATE OBJECT go_cont ... CONTAINER_NAME = 'AREA'`
- [ ]  `CREATE OBJECT go_alv ... I_PARENT = go_cont`
- [ ]  `set_table_for_first_display`에 `IT_OUTTAB` 전달
- [ ]  필드카탈로그 자동이면 `I_STRUCTURE_NAME` 전달
- [ ]  Variant 쓰면 `gs_variant-report = sy-cprog`
