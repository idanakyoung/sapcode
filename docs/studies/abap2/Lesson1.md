# Lesson 1 – Screen Program / Dialog Programming 정리

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
```
---

## 2. Screen Attributes (스크린 속성)

모든 스크린에는 다음 5가지 범주의 속성이 있다.

| Category | 설명 | 예시 항목 |
| --- | --- | --- |
| Admin | 스크린의 정체성/ID | Program, Screen no., Status, Short desc., Screen group, Original lang. |
| Type | 화면 목적/종류 | Normal, Subscreen, Modal dialog box, Selection screen |
| Size | 크기 및 동적/정적 속성 | Static, Maintained, Occupied, Dynamic (Starting at / Size) |
| Sequence | 다음 화면 제어 | Next screen |
| Settings | UX/표시 관련 설정 | Cursor, Hold data, Compression, Context menu, Scroll position, Without application toolbar |

### 2-1. Screen Attributes ↔ PBO/PAI 연관

| Category | PBO 관련 | PAI 관련 | 비고 |
| --- | --- | --- | --- |
| Admin | O | O | 스크린 식별 및 플로우 실행 단위 |
| Type | O | O | Subscreen 구조가 PBO/PAI에 직접 영향 |
| Size | O O | - | 화면 렌더링(PBO)에서 처리 |
| Sequence | - | O O | PAI 종료 시 Next Screen 처리 |
| Settings | O | 일부 O | Hold Data만 PAI와도 관련 있음 |

---

## 3. Screen 생성 4단계 (Screen Creation Flow)

### Step 1. Screen Attributes 설정

- Screen 번호, 짧은 설명, Type, Next Screen 등 설정
- 예:
    - Screen no. `100`
    - Type: Normal
    - Next screen: `200`
- SAP는 이 번호를 기준으로
    - “100번 스크린의 PBO/PAI를 실행해야겠다” 라고 판단.

### Step 2. Screen Layout 디자인 (Layout Editor)

- 어떤 UI 요소를 배치할지 정의
    - Input Field
    - Text
    - Push Button
    - Checkbox
    - Radio Button
    - Group Box
- 이 레이아웃은 **PBO 실행 결과**로 사용자에게 보여짐

### Step 3. Element Attributes 설정

각 UI 요소에 대해:

- Name (ABAP 변수명과 연결)
- Data type / Length
- Input 가능 여부
- Output only
- Required (Mandatory)
- Invisible
- Search Help 등

### Step 4. Flow Logic 작성 (PBO/PAI)

기본 형태:

```abap
PROCESS BEFORE OUTPUT.
  MODULE init.       "PBO: 화면이 나타나기 전에 실행 (초기값, LOOP AT SCREEN 등)

PROCESS AFTER INPUT.
  MODULE read_100.   "PAI: 사용자가 Enter/버튼 눌렀을 때 실행

```

- PBO: 초기 데이터 세팅, 화면 속성 조정
- PAI: 입력값 검증, DB 처리, Next screen 이동

---

## 4. Screen / Layout 생성 및 DDIC 필드 연결

### 4-1. 스크린 생성 방법

1. **SE51 (Screen Painter)**
    - 직접 스크린 번호 입력 후 생성 (요즘은 잘 사용 X)
2. **SE80 (Object Navigator)**
    - 모듈 풀 프로그램 선택 후 `Screens` 노드에서 바로 생성

### 4-2. Layout 에서 필드 생성

- 스크린 번호(예: 100)를 더블 클릭 → Layout → Painter 진입
- Text Field 예:
    - Text: `Hello_Screen_Program`
    - Name: `TEX_F1` (필수 속성)

### 4-3. Dict./Program Fields – Table/Field Name에 올 수 있는 형태

| 카테고리 | 예시 | 설명 |
| --- | --- | --- |
| DB 테이블 | `SBOOK` | DDIC 테이블 전체 필드 목록 |
| DDIC 구조체 | `SFLIGHT` | 구조체 필드 목록 |
| 테이블-필드 | `SBOOK-CARRID` | 특정 필드만 선택 |
| 프로그램 변수 | `GV_NAME`, `GS_DATA-CARRID` | 모듈풀 내부 글로벌 변수/구조체 필드 |
- CHAR 1 타입 필드들은 체크박스, 라디오 버튼 등으로 표시 가능

---

## 5. Screen Painter(Layout) ↔ ABAP 변수 자동 MOVE (Identical Names)

### 5-1. Identical Names 개념

- **스크린 필드 이름(Dynpro Element Name)** 과
    
    **ABAP 변수/구조 필드 이름**이 **완전히 동일**하면
    
    PBO/PAI 시점에 SAP가 자동으로 값을 주고받는다.
    

예) TOP Include:

```abap
TABLES sdyn_conn.          " 또는 DATA sdyn_conn TYPE spfli.
DATA: ok_code TYPE sy-ucomm.

```

- `SDYN_CONN` 구조(또는 테이블)
- `OK_CODE` : 화면 Function Code(버튼, 메뉴 등)를 받는 변수

### 5-2. Layout 에서 필드 배치

Dict./Program Fields에서 `SDYN_CONN` 선택 후 필드를 올리면:

```
SDYN_CONN-CONNID
SDYN_CONN-CARRID
...
OK_CODE

```

와 같은 Element 이름이 자동 생성된다.

(= ABAP 변수 이름과 동일)

### 5-3. 자동 MOVE 타이밍

### PBO: ABAP → Screen

```abap
MODULE pbo_0100 OUTPUT.
  sdyn_conn-carrid = 'LH'.
  sdyn_conn-connid = '0402'.
ENDMODULE.

```

- PBO 끝나기 직전
    
    `sdyn_conn-*` 값이 **같은 이름의 화면 필드**로 자동 복사된다.
    

### PAI: Screen → ABAP

```abap
MODULE pai_0100 INPUT.
  CASE ok_code.
    WHEN 'BOOK'.
      " 여기서 sdyn_conn-* 값은 이미 화면에서 입력된 내용
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

```

- PAI 시작 직전에
    
    화면의 `SDYN_CONN-*`, `OK_CODE` 값이
    
    ABAP 변수 `sdyn_conn-*`, `ok_code` 에 자동 복사된다.
    

---

## 6. Screen Program Module 생성 과정 정리

1. Screen Painter에서 Layout 완성 및 필드 속성 설정
    - 필요 시 Dic > SET/GET Parameter 체크
        - SET Parameter : 저장
        - GET Parameter : 저장된 값을 나중에 불러오기
    - Input Required / Output Only 설정
2. SE80에서 **Include(TOP)로 이동** 후 전역 변수 선언

예: `MZSCREEN_G01TOP`

```abap
*&---------------------------------------------------------------------*
*& Include MZSCREEN_G01TOP                  - Module Pool SAPMZSCREEN_G01
*&---------------------------------------------------------------------*
PROGRAM SAPMZSCREEN_G01.

* Screen의 screen element와 연결된 변수.
TABLES: SDYN_CONN.

* DB table data 할당할 변수.
DATA: WA_SPFLI TYPE SPFLI.

* Screen element - input field 연결할 변수.
DATA: GV_COMMAND TYPE C LENGTH 1.

```

1. Layout에서 버튼 등 UI 추가 후, 동일한 이름으로 필드명/Function Code 지정
2. Flow Logic에서 MODULE 작성

```abap
PROCESS BEFORE OUTPUT.
  MODULE TRANS_TO_SCREEN.

PROCESS AFTER INPUT.
  MODULE GET_DATA_CONNECTION.
  MODULE USER_COMMAND_0100.

```

1. MODULE 이름 더블 클릭 → Include 선택(I01/O01 등) → 코드 뼈대 생성 → 로직 작성 → Activate

---

## 7. 예제: PAI 모듈 – 뒤로가기 버튼

### PAI Include (예: `MZSCREEN_G01I01`)

```abap
*&---------------------------------------------------------------------*
*& Include          MZSCREEN_G01I01
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  CASE gv_command.
    WHEN 'X'.
*     Go Back.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

```

- 화면에서 `gv_command` 에 `'X'` 가 들어오면 → 이전 화면으로 복귀

---

## 8. Transaction 생성 (스크린 실행용)

1. SE93 – Transaction 생성
2. Dialog Transaction 선택 (Screen/Dynpro 프로그램이므로)
3. Program: `SAPMZSCREEN_G01` (모듈 풀 이름 전체)
4. Screen number: 실행할 메인 스크린 번호(예: 100)
5. GUI support: 필요한 옵션 체크 후 저장/활성화

F8 대신, 생성한 트랜잭션 코드로 실행.

---

## 9. 예제: DB Read 모듈 / 전체 Flow

PAI Include:

```abap
MODULE GET_DATA_CONNECTION INPUT.

* DB Table SPFLI에서 데이터 read.
  SELECT SINGLE *
     INTO WA_SPFLI
     FROM SPFLI
     WHERE CARRID = SDYN_CONN-CARRID
       AND CONNID = SDYN_CONN-CONNID.

  IF SY-SUBRC <> 0.
    CLEAR WA_SPFLI.
  ENDIF.

ENDMODULE.

MODULE USER_COMMAND_0100 INPUT.
  CASE gv_command.
    WHEN 'X'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

```

Flow Logic 예:

```abap
PROCESS BEFORE OUTPUT.
  MODULE TRANS_TO_SCREEN.

PROCESS AFTER INPUT.
  MODULE GET_DATA_CONNECTION.
  MODULE USER_COMMAND_0100.

```

Next Dynpro를 `0` 으로 놓으면,

해당 스크린에서 `LEAVE TO SCREEN 0` 수행 시 바로 이전 화면(또는 종료)로 돌아간다.

---

## 10. Screen Runtime – SCREEN 시스템 테이블 (동적 속성 제어)

### 10-1. SCREEN 시스템 테이블 개념

- **PBO 시작 시점**에 현재 스크린의 모든 요소 정보를 시스템 테이블 `SCREEN` 에 초기화
- 필드명, 그룹, INPUT 가능 여부, VISIBLE, REQUIRED 등 속성 포함

대표 필드:

- `SCREEN-NAME`
- `SCREEN-GROUP1` ~ `SCREEN-GROUP4`
- `SCREEN-INPUT`
- `SCREEN-INVISIBLE`
- `SCREEN-REQUIRED`
- `SCREEN-ACTIVE`

### 10-2. 기본 패턴

```abap
MODULE MODIFY_SCREEN OUTPUT.
  LOOP AT SCREEN.
    "조건에 맞는 필드 선택
    IF SCREEN-GROUP1 = 'COD'.
      SCREEN-INPUT = gv_status.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDMODULE.

```

- PBO에서만 사용 (OUTPUT MODULE)
- `gv_status` 값(0 또는 1)에 따라 입력 가능 여부가 달라짐

### 10-3. Modification Group (GROUP1~4)

- Layout의 Element Attributes 에서 Group1, Group2 등에 문자값 설정
    - 예: `COD`
- 해당 그룹을 기준으로 여러 필드를 한 번에 제어 가능

```abap
IF SCREEN-GROUP1 = 'COD'.
  SCREEN-INPUT = gv_status.
ENDIF.

```

### 10-4. 버튼 Function Code와 OK_CODE

- 버튼의 Function Code 예: `CHG`
- 화면에서 버튼 클릭 시 → `OK_CODE` 변수에 `CHG` 값 세팅
- PAI에서 처리:

```abap
DATA: gv_command TYPE c LENGTH 1,
      ok_code    TYPE sy-ucomm,
      gv_status  TYPE i.

...

CASE ok_code.
  WHEN 'CHG'.
    IF gv_status IS INITIAL.
      gv_status = 1.
    ELSE.
      CLEAR gv_status.
    ENDIF.
ENDCASE.

```

---

## 11. Exercise 2 (SFLIGHT 예제) 핵심 코드 요약

### 11-1. 메인 프로그램

```abap
*& Module Pool      SAPMZBC410_SOLUTION_G01
*&---------------------------------------------------------------------*

INCLUDE MZBC410_SOLUTION_G01TOP.    " Global Data
INCLUDE MZBC410_SOLUTION_G01O01.    " PBO-Modules
INCLUDE MZBC410_SOLUTION_G01I01.    " PAI-Modules
* INCLUDE MZBC410_SOLUTION_G01F01.  " FORM-Routines

```

### 11-2. TOP Include

```abap
*& Include MZBC410_SOLUTION_G01TOP      - Module Pool SAPMZBC410_SOLUTION_G01
*&---------------------------------------------------------------------*
PROGRAM SAPMZBC410_SOLUTION_G01.

* Screen의 screen element와 연결된 변수.
TABLES: SDYN_CONN.

* DB table data 할당할 변수.
DATA: WA_SFLIGHT TYPE SFLIGHT,
      io_command.

```

### 11-3. PAI Include

```abap
*& Include          MZBC410_SOLUTION_G01I01
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
MODULE CHECK_SFLIGHT INPUT.

  SELECT SINGLE *
    INTO WA_SFLIGHT
    FROM SFLIGHT
    WHERE CARRID = SDYN_CONN-CARRID
      AND CONNID = SDYN_CONN-CONNID
      AND FLDATE = SDYN_CONN-FLDATE.

  IF SY-SUBRC <> 0.
    CLEAR WA_SFLIGHT.
    MESSAGE i007(ZMSG_G01).    " 또는 i007(BC410) 등 사용 가능
  ENDIF.

ENDMODULE.

*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  CASE io_command.
    WHEN 'X'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

```

### 11-4. PBO Include

```abap
*& Include          MZBC410_SOLUTION_G01O01
*&---------------------------------------------------------------------*
*& Module MOVE_TO_DYNP OUTPUT
*&---------------------------------------------------------------------*
MODULE MOVE_TO_DYNP OUTPUT.
  MOVE-CORRESPONDING WA_SFLIGHT TO SDYN_CONN.
ENDMODULE.

```

### 11-5. Layout 주의사항

- **Mandatory(필수) 필드 3개**
    - Airline (CARRID)
    - Flight Number (CONNID)
    - Date (FLDATE)
    - → Program Attributes에서 `Input Required` 설정
- 나머지 출력용 필드들은 `Input field` 체크 해제 (Output only)

---

## 12. 작업 순서 정리 (중요)

1. **메인 프로그램**에서 INCLUDE 주석 해제
2. **TOP Include** 에서 필요한 테이블/전역 변수 선언
3. 해당 **스크린(예: 100번)** 으로 이동하여 Flow Logic에 MODULE 작성
4. MODULE 이름 더블 클릭 → Include(I/O1 등) 생성 → 코드 작성 → Activate
5. 스크린 Activate
6. Layout에서 `Dic./Program Fields` → 필드 선택 → 드래그 앤 드롭 → 저장/Activate
7. 메인 프로그램 Activate 후 실행 (또는 Dialog Transaction 생성 후 실행)
