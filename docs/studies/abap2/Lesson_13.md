# 🔵 Unit 1. Screen Painter

## Screen Painter

### Screen Painter parameter 기본 실습

### 1. 스크린 프린터의 데이터 엘리멘트 크기 지정

```
Screen Painter - Field Property 설정 화면

┌──────────────────────────────┐
│ Field Attributes             │
│ Data Element : BC400_xxxx    │
│ Output Length : 10           │
│ Visible Length : 10          │
│                              │
│ Screen Painter에서           │
│ Data Element 크기를          │
│ 조정하는 실습 화면           │
└──────────────────────────────┘
```

### 2. input parameter X (Only Output parameter)

```
Screen Field Attribute

┌──────────────────────────────┐
│ Field Properties             │
│                              │
│ [ ] Input                    │
│ [x] Output Only              │
│                              │
│ 입력 불가 필드 설정          │
│ Display 전용 필드            │
└──────────────────────────────┘
```

---

## Module Pool의 데이터 전송 (Implement Data Transport)

화면 필드 이름 = 프로그램 전역 변수 이름 이 둘이 같으면

PBO 때: 프로그램 값 → 화면

PAI 때: 화면 값 → 프로그램 값

이 복사가 **자동으로** 일어난다.

---

### 프로그램 전역 변수 fr.gpt

```
DATA bc400_s_dynconn TYPE bc400_s_dynconn.   "전역 구조
```

---

### TABLES 문은 DDIC 구조를 가진 전역 변수 자동 생성 명령 → PBO/PAI에서 자동 Transport

```
TABLES BC400_S_DYNCONN.
```

---

### 버튼 클릭 전 다른 스크린으로 넘어가기 전에 디스플레이에서 받은 값 (데이터)을 변수 할당하는 실습

```
Screen 100 입력 화면

┌──────────────────────────────┐
│ CARRID  : ____               │
│ CONNID  : ____               │
│                              │
│            [ GO ]            │
└──────────────────────────────┘

입력값 → BC400_S_DYNCONN 구조에 자동 저장
```

bc400_s_dynconn : Screen Painter와 연결된 TABLES 변수

gs_connection : 함수 모듈에 넘길 깨끗한 구조

→ 화면 입력 값을 로직 구조로 프로그램 내 변수에 복사하는 단계

---

## 코드

```
*&---------------------------------------------------------------------*
*& Include          MZSCR_G01I01
*&---------------------------------------------------------------------*
*& PAI(Input) 모듈 처리부
*& 화면에서 사용자가 버튼/Enter 등을 눌렀을 때 실행되는 로직
*& - USER_COMMAND_0100 : 화면 0100에서 발생한 사용자 명령 처리
*& - USER_COMMAND_0200 : 화면 0200에서 발생한 사용자 명령 처리
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*& 화면 0100의 사용자 요청(버튼/Function Code)을 처리하는 모듈
*& 화면의 입력 필드 값은 PAI 단계 시작 시
*& BC400_S_DYNCONN 구조 안에 자동으로 매핑되어 있음
*&---------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  " OK_CODE : 화면에서 누른 버튼의 Function Code가 자동으로 세팅됨
  CASE OK_CODE.

    WHEN 'GO'.          " 사용자가 GO 버튼을 눌렀을 때

      "---------------------------------------------------------------
      " Function Module 호출
      " - 사용자가 입력한 CARRID / CONNID 값을 기준으로
      "   항공편 정보를 DB에서 조회하는 기능 제공
      " - BC400_S_DYNCONN-* 에는 화면 입력값이 이미 들어와 있음
      "---------------------------------------------------------------
      CALL FUNCTION 'BC400_DDS_CONNECTION_GET'
        EXPORTING
          IV_CARRID     = BC400_S_DYNCONN-CARRID
          IV_CONNID     = BC400_S_DYNCONN-CONNID
        IMPORTING
          ES_CONNECTION = GS_CONNECTION
        EXCEPTIONS
          NO_DATA       = 1
          OTHERS        = 2.

      IF SY-SUBRC <> 0.
        MESSAGE E042(BC400)
          WITH GS_CONNECTION-CARRID
               GS_CONNECTION-CONNID.

      ELSE.

        MOVE-CORRESPONDING GS_CONNECTION TO BC400_S_DYNCONN.

        SET SCREEN 200.

      ENDIF.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'BACK'.
      SET SCREEN 100.

    WHEN 'EXIT'.
      SET SCREEN 0.

  ENDCASE.

ENDMODULE.
```

---

## 결과

```
Screen 200 결과 화면

┌──────────────────────────────┐
│ Airline : LH                 │
│ Connection : 0400            │
│ Flight 정보 표시              │
│                              │
│ [ BACK ]   [ EXIT ]          │
└──────────────────────────────┘
```

프로그램 실행 흐름

```
Screen 100
   ↓
GO 버튼 클릭
   ↓
Function Module 호출
   ↓
GS_CONNECTION 데이터 수신
   ↓
MOVE-CORRESPONDING
   ↓
Screen 200 출력
```

---

# 🔵 Unit 2. SAP List Viewer (ALV)

## SAP List Viewer (ALV)

### ALV(SAP List Viewer)란?

SAP에서 내부 테이블을 **표(Grid) 형태로 보여주는 도구**

ALV(Grid)는 그냥 프로그램 안에서 갑자기 나타나는 게 아니라

**Container라는 박스에 붙어서 화면에 표시된다**

---

### 쉽게 말해서

```
AREA = 빈 화면 공간
CUSTOM CONTAINER = AREA 안에 올린 박스
CONTAINER INSTANCE = 프로그램에서 이 박스를 제어하는 객체
ALV GRID INSTANCE = 이 박스 안에 그려지는 ALV 테이블
```

---

### 전체 실행 흐름 요약

```
① 스크린에서 Custom Control(CC_ALV) 생성
          ↓
② ABAP에서 Container 객체 생성
          ↓
③ Grid 객체 생성 (Container 안에 넣음)
          ↓
④ 내부 테이블 준비
          ↓
⑤ Grid->set_table_for_first_display 호출
          ↓
⑥ ALV 그리드가 화면에 표시됨
```

---

# SAP List Viewer (ALV) 실습

### 스크린 200번 Layout → 속성 값 가로 세로 옵션 체크

```
Screen 200 Layout 설정

┌──────────────────────────────┐
│ Custom Control : AREA        │
│                              │
│ [x] Horizontal Resize        │
│ [x] Vertical Resize          │
│                              │
│ ALV 출력 영역 자동 확장       │
└──────────────────────────────┘
```

---

### Top Include에서 Reference Variable 선언

```
DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GO_AVL  TYPE REF TO CL_GUI_ALV_GRID.
```

---

### Container 객체 생성

```
PBO Include - Container 생성

┌──────────────────────────────┐
│ CREATE OBJECT GO_CONT        │
│ CONTAINER_NAME = 'AREA'      │
│                              │
│ Screen Painter의 AREA와 연결 │
└──────────────────────────────┘
```

```
CONTAINER_NAME = 'AREA'
```

---

### Container 위에 Grid 생성

```
CREATE OBJECT GO_ALV
  EXPORTING
    I_PARENT = GO_CONT.
```

---

### Flight 데이터 조회

```
Function Module 실행

┌──────────────────────────────┐
│ BC400_DDS_FLIGHTLIST_GET     │
│                              │
│ Input : CARRID / CONNID      │
│ Output : GT_FLIGHTS          │
│                              │
│ 항공편 목록 조회             │
└──────────────────────────────┘
```

```
CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
  EXPORTING
    IV_CARRID  = BC400_S_DYNCONN-CARRID
    IV_CONNID  = BC400_S_DYNCONN-CONNID
  IMPORTING
    ET_FLIGHTS = GT_FLIGHTS.
```

---

### ALV 최초 출력

```
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    I_STRUCTURE_NAME = 'BC400_S_FLIGHT'
  CHANGING
    IT_OUTTAB        = GT_FLIGHTS.
```

```
ALV 실행 화면

┌─────────────────────────────────────┐
│ CARRID | CONNID | FLDATE | PRICE    │
├─────────────────────────────────────┤
│ LH     | 0400   | ...    | ...      │
│ LH     | 0401   | ...    | ...      │
│ LH     | 0402   | ...    | ...      │
└─────────────────────────────────────┘
```

---

# 🔵 Unit 3. Web Dynpro ABAP

## Web Dynpro ABAP란?

웹 브라우저에서 동작하는 SAP의 **UI 프레임워크**

SAP GUI 대신 **웹 화면을 만드는 기술**

---

### Web Dynpro Component 생성 화면

```
┌──────────────────────────────────────┐
│ Web Dynpro Explorer                   │
│                                       │
│ Component : ZWD_FLIGHT                │
│                                       │
│  ├─ Component Controller              │
│  ├─ Views                             │
│  │   └─ MAIN_VIEW                     │
│  ├─ Windows                           │
│  │   └─ MAIN_WINDOW                   │
│  └─ Context                           │
└──────────────────────────────────────┘
```

---

### Web Dynpro 기본 구조

```
┌────────────────────────────────────────────────────┐
│                    COMPONENT                       │
│                                                    │
│  ┌──────────────────────────────────────────────┐  │
│  │          COMPONENT CONTROLLER                │  │
│  │  - 전역 Context (모든 View가 공유)           │  │
│  └──────────────────────────────────────────────┘  │
│                                                    │
│  ┌──────────────────────────────────────────────┐  │
│  │                    WINDOW                    │  │
│  │                                              │  │
│  │   ┌──────────────┐   ┌──────────────┐        │  │
│  │   │    VIEW_A    │   │    VIEW_B    │        │  │
│  │   │  (UI 화면)   │   │  (UI 화면)   │        │  │
│  │   └──────────────┘   └──────────────┘        │  │
│  └──────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────┘
```

---

### Web Dynpro 실습

```
View Layout

┌──────────────────────────────┐
│ CARRID : [____]              │
│ CONNID : [____]              │
│                              │
│        [ SEARCH ]            │
│                              │
│ Flight Table                 │
└──────────────────────────────┘
```

---

### 메소드 추가

```
METHOD GET_FLIGHTS .
SELECT *
  INTO CORRESPONDING FIELDS OF TABLE LT_NT_DATA
  FROM SFLIGHT
  WHERE CARRID = LS_NS_COND-CARRID
    AND CONNID = LS_NS_COND-CONNID.
ENDMETHOD.
```

---

### 메소드 활성화

```
METHOD ONACTIONSEARCH .

  WD_COMP_CONTROLLER->GET_FLIGHTS( ).

ENDMETHOD.
```

---

### 실행 결과

```
Web Dynpro 실행 화면

┌──────────────────────────────────┐
│ CARRID : LH                      │
│ CONNID : 0400                    │
│                                  │
│ [ SEARCH ]                       │
│                                  │
│ LH | 0400 | 2024-01-01 | ...     │
│ LH | 0400 | 2024-01-02 | ...     │
└──────────────────────────────────┘
```

→ 실습 완료 화면
