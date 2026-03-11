# 🧭 Lesson 13 – Screen Painter / ALV / Web Dynpro ABAP

---

## 0) 전체 흐름(공통 뼈대)

```
전통 SAP 화면 개발 흐름
  1) Screen Painter에서 화면 생성
  2) PBO / PAI로 화면-프로그램 데이터 이동
  3) Module Pool에서 화면 전환 처리
  4) ALV를 Container 위에 출력
  5) Web Dynpro ABAP으로 웹 UI 구조 이해
```

---

## 1) Unit 1. Screen Painter

### 핵심

- Screen Painter는 Dynpro 화면을 만드는 도구이다.
- 화면 필드와 프로그램 전역 변수 이름이 같으면 **PBO/PAI에서 데이터 이동이 자동 처리**된다.
- Module Pool에서는 Screen Painter + Flow Logic + Include 구조를 함께 이해해야 한다.

---

## 1-1) Screen Painter 기본 실습

### 핵심

- 화면 필드 속성에서 출력 길이, 표시 길이, 입력 가능 여부 등을 조정할 수 있다.
- Data Element 기반으로 화면 필드 속성을 가져오되, Screen Painter에서 별도 조정 가능하다.

---

### 1) 데이터 엘리먼트 크기 지정

```
Field Attributes
Data Element : BC400_xxxx
Output Length : 10
Visible Length : 10
```

### 포인트

- `Output Length` = 실제 출력 길이
- `Visible Length` = 화면에 보이는 길이
- 같은 Data Element라도 화면별로 표시 길이를 다르게 줄 수 있음

---

### 2) Input 해제 (Output Only)

```
Field Properties

[ ] Input
[x] Output Only
```

### 포인트

- 입력 불가, 조회 전용 필드로 만들 때 사용
- 상세 화면이나 결과 화면에서 자주 사용

---

## 1-2) Module Pool의 데이터 전송 (Implement Data Transport)

### 핵심

- 화면 필드 이름과 프로그램 전역 변수 이름이 같으면 자동으로 데이터가 복사된다.
- 이 자동 복사는 PBO / PAI 시점에 각각 방향이 다르다.

### 자동 복사 규칙

```
PBO : 프로그램 변수 → 화면
PAI : 화면 값 → 프로그램 변수
```

### 포인트

- 별도 MOVE 없이도 자동 transport 가능
- Dynpro 개발의 가장 기본 개념 중 하나

---

## 1-3) 프로그램 전역 변수와 TABLES

### 전역 구조 선언 예시

```
DATA bc400_s_dynconn TYPE bc400_s_dynconn.
```

### TABLES 선언 예시

```
TABLES BC400_S_DYNCONN.
```

### 의미

- `TABLES` 문은 DDIC 구조 기반 전역 변수를 자동 생성하는 개념
- Screen Field와 이름이 맞으면 PBO/PAI에서 자동 transport에 활용됨

### 포인트

- 실습에서는 `TABLES`를 자주 보지만
- 현대 ABAP에서는 명시적 `DATA` 선언을 더 선호하는 경우도 많음
- 다만 Dynpro 학습에서는 `TABLES` 개념 이해가 중요함

---

## 1-4) 화면 입력값을 로직 구조에 넘기는 흐름

### 상황

- Screen 100에서 사용자가 `CARRID`, `CONNID` 입력
- GO 버튼 클릭
- 입력값은 `BC400_S_DYNCONN`에 자동 저장
- 이를 기반으로 Function Module 호출
- 결과는 `GS_CONNECTION`에 받음
- 이후 `MOVE-CORRESPONDING`으로 화면 구조에 복사
- Screen 200에서 출력

---

### 흐름 요약

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

## 1-5) 코드

```
*&---------------------------------------------------------------------*
*& Include          MZSCR_G01I01
*&---------------------------------------------------------------------*
*& PAI(Input) 모듈 처리부
*&---------------------------------------------------------------------*

MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'GO'.

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

## 1-6) 포인트 정리

### 핵심 포인트

- `OK_CODE`에는 버튼의 Function Code가 들어간다.
- 화면 입력값은 PAI 시작 시점에 전역 변수로 자동 반영된다.
- `MOVE-CORRESPONDING`은 같은 이름의 필드끼리 복사한다.
- `SET SCREEN 200`으로 다음 화면 이동
- `SET SCREEN 0`으로 호출 이전 화면/종료 복귀

### 주의

- 화면 필드명과 프로그램 변수명이 다르면 자동 transport가 안 된다.
- 결과 화면에 보여줄 필드는 PBO 시점에 프로그램 변수에 값이 채워져 있어야 한다.

---

## 2) Unit 2. SAP List Viewer (ALV)

### 핵심

- ALV는 내부 테이블을 표(Grid) 형태로 보여주는 SAP 표준 도구이다.
- ALV Grid는 화면에 바로 뜨는 것이 아니라 **Container 안에 붙어서 출력**된다.
- 화면에 Custom Control을 만들고, 프로그램에서 Container 객체와 Grid 객체를 생성한 뒤 데이터를 연결한다.

---

## 2-1) ALV란?

### 정의

- SAP에서 내부 테이블을 표 형태로 보여주는 도구
- 정렬, 필터, 합계, 레이아웃 기능 등을 쉽게 제공

### 포인트

- 단순 `WRITE` 출력보다 훨씬 실무적
- SAP GUI 화면 기반 리스트 출력의 핵심 도구

---

## 2-2) ALV 구조 이해

```
AREA = 빈 화면 공간
CUSTOM CONTAINER = AREA 안의 박스
CONTAINER INSTANCE = 프로그램에서 박스를 제어하는 객체
ALV GRID INSTANCE = 박스 안에 그려지는 ALV
```

### 포인트

- Screen Painter에서 만든 Custom Control 이름과
- ABAP에서 생성하는 Container 객체 이름이 연결되어야 한다

---

## 2-3) 전체 실행 흐름

```
① 스크린에서 Custom Control(AREA) 생성
          ↓
② ABAP에서 Container 객체 생성
          ↓
③ Grid 객체 생성
          ↓
④ 내부 테이블 준비
          ↓
⑤ SET_TABLE_FOR_FIRST_DISPLAY 호출
          ↓
⑥ 화면에 ALV 출력
```

---

## 2-4) Screen 200 Layout 설정

### 핵심

- Screen 200에 Custom Control 영역 생성
- 가로/세로 자동 확장 옵션 체크

```
Custom Control : AREA
[x] Horizontal Resize
[x] Vertical Resize
```

### 포인트

- 화면 크기 조정 시 ALV도 함께 늘어나게 하려면 resize 옵션이 중요함

---

## 2-5) Top Include 선언

```
DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.
```

### 의미

- `GO_CONT` : Container 객체 참조변수
- `GO_ALV` : ALV Grid 객체 참조변수

---

## 2-6) Container 객체 생성

```
CREATE OBJECT GO_CONT
  EXPORTING
    CONTAINER_NAME = 'AREA'.
```

### 포인트

- `'AREA'` 는 Screen Painter에서 만든 Custom Control 이름과 정확히 같아야 함

---

## 2-7) Grid 객체 생성

```
CREATE OBJECT GO_ALV
  EXPORTING
    I_PARENT = GO_CONT.
```

### 포인트

- ALV Grid는 부모 Container 위에 생성됨
- Container 없이 Grid만 생성할 수 없음

---

## 2-8) Flight 데이터 조회

```
CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
  EXPORTING
    IV_CARRID  = BC400_S_DYNCONN-CARRID
    IV_CONNID  = BC400_S_DYNCONN-CONNID
  IMPORTING
    ET_FLIGHTS = GT_FLIGHTS.
```

### 포인트

- Screen 100에서 입력한 항공사/연결편 값을 사용
- 조회 결과는 내부 테이블 `GT_FLIGHTS`에 저장

---

## 2-9) ALV 최초 출력

```
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    I_STRUCTURE_NAME = 'BC400_S_FLIGHT'
  CHANGING
    IT_OUTTAB        = GT_FLIGHTS.
```

### 의미

- `I_STRUCTURE_NAME`으로 컬럼 자동 생성
- `IT_OUTTAB`에 실제 출력할 내부 테이블 전달

### 포인트

- Lesson 10의 ALV 기본형과 연결되는 부분
- 구조명만 넘기면 빠르게 ALV 출력 가능

---

## 2-10) ALV 결과

```
CARRID | CONNID | FLDATE | PRICE
LH     | 0400   | ...    | ...
LH     | 0401   | ...    | ...
LH     | 0402   | ...    | ...
```

### 포인트

- 리스트 출력이 아니라 Grid 형태로 표시됨
- 이후 Field Catalog, Layout, Event 등으로 확장 가능

---

## 3) Unit 3. Web Dynpro ABAP

### 핵심

- Web Dynpro ABAP는 SAP GUI가 아니라 **웹 브라우저에서 동작하는 UI 프레임워크**
- Component, View, Window, Controller, Context 구조를 이해하는 것이 핵심
- 전통 Dynpro와 달리 웹 기반 MVC 스타일에 가깝다

---

## 3-1) Web Dynpro ABAP란?

### 정의

- 브라우저에서 실행되는 SAP UI 기술
- SAP GUI 없이 웹 화면 구성 가능

### 포인트

- Dynpro는 SAP GUI 중심
- Web Dynpro는 웹 기반
- 둘 다 SAP UI 기술이지만 구조와 개발 방식이 다름

---

## 3-2) Web Dynpro Component 구조

```
COMPONENT
  ├─ Component Controller
  ├─ Views
  │   └─ MAIN_VIEW
  ├─ Windows
  │   └─ MAIN_WINDOW
  └─ Context
```

### 의미

- **Component** : 전체 단위
- **Component Controller** : 전역 로직/전역 Context
- **View** : 실제 화면 UI
- **Window** : View를 담는 창
- **Context** : 데이터 바인딩 구조

---

## 3-3) Web Dynpro 기본 구조

```
COMPONENT
  ├─ COMPONENT CONTROLLER
  │    - 전역 Context
  │
  └─ WINDOW
        ├─ VIEW_A
        └─ VIEW_B
```

### 포인트

- 여러 View가 하나의 Window / Component 안에서 동작할 수 있음
- Controller와 Context 개념이 중요함

---

## 3-4) 실습 화면 예시

```
CARRID : [____]
CONNID : [____]

[ SEARCH ]

Flight Table
```

### 포인트

- 입력 필드 + 버튼 + 결과 테이블 구조
- 전통 Dynpro보다 웹 UI처럼 구성됨

---

## 3-5) 데이터 조회 메소드

```
METHOD GET_FLIGHTS.
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE LT_NT_DATA
    FROM SFLIGHT
    WHERE CARRID = LS_NS_COND-CARRID
      AND CONNID = LS_NS_COND-CONNID.
ENDMETHOD.
```

### 의미

- Context의 조건값(`LS_NS_COND`)을 기준으로
- `SFLIGHT`에서 데이터 조회
- 결과를 테이블 노드에 채움

### 포인트

- Web Dynpro에서는 조회 로직을 메소드로 분리하는 패턴이 자주 나옴
- 조건 Context와 결과 Context를 나눠 이해하면 편함

---

## 3-6) 버튼 액션 메소드

```
METHOD ONACTIONSEARCH.

  WD_COMP_CONTROLLER->GET_FLIGHTS( ).

ENDMETHOD.
```

### 의미

- 사용자가 SEARCH 버튼 클릭
- Action Method 실행
- Component Controller의 조회 메소드 호출

### 포인트

- Dynpro의 `OK_CODE` 방식과 달리
- Web Dynpro는 **Action/Event 방식**으로 동작

---

## 3-7) 실행 결과

```
CARRID : LH
CONNID : 0400

[ SEARCH ]

LH | 0400 | 2024-01-01 | ...
LH | 0400 | 2024-01-02 | ...
```

### 포인트

- 입력값 기준으로 결과 테이블이 웹 화면에 출력
- SAP GUI Screen보다 웹 애플리케이션처럼 보임

---

## 4) Unit 1 / 2 / 3 비교(한 눈에)

| 항목 | Screen Painter / Module Pool | ALV | Web Dynpro ABAP |
| --- | --- | --- | --- |
| 목적 | 전통 SAP GUI 화면 개발 | 표 형태 리스트 출력 | 웹 기반 SAP UI 개발 |
| 핵심 개념 | PBO / PAI / OK_CODE | Container / Grid / Internal Table | Component / View / Controller / Context |
| 데이터 전달 | 화면필드 ↔ 전역변수 자동 transport | 내부테이블 → Grid 출력 | Context 바인딩 |
| 이벤트 처리 | Function Code | ALV Method/Event | Action Method |
| 화면 기술 | Dynpro | Dynpro 위 Grid | Browser UI |

---

## 5) 시험 포인트 / 실무 포인트

### 5-1) 시험 포인트

- **PBO / PAI 데이터 이동 방향**
- **화면 필드명 = 프로그램 전역 변수명일 때 자동 transport**
- **TABLES 문 의미**
- **OK_CODE / SET SCREEN / MOVE-CORRESPONDING**
- **ALV는 Container 위에 출력된다는 점**
- **CL_GUI_CUSTOM_CONTAINER / CL_GUI_ALV_GRID 역할**
- **SET_TABLE_FOR_FIRST_DISPLAY 사용법**
- **Web Dynpro의 Component / View / Window / Controller 구조**
- **Dynpro와 Web Dynpro의 이벤트 처리 방식 차이**

### 5-2) 실무 포인트

- 전통 화면에서는 변수명 일치가 중요함
- ALV는 실무에서 거의 기본 출력 도구처럼 사용됨
- 화면 출력과 조회 로직을 분리해야 유지보수가 편함
- Web Dynpro는 SAP GUI와 다른 UI 철학으로 이해해야 함

---

## 6) Lesson 13에서 제일 중요한 결론

- **Screen Painter는 Dynpro 화면의 기본이며, PBO/PAI 자동 데이터 이동이 핵심이다**
- **Module Pool에서는 OK_CODE, SET SCREEN, MOVE-CORRESPONDING 흐름을 확실히 알아야 한다**
- **ALV는 Container 안에 Grid를 생성해서 내부 테이블을 출력하는 구조다**
- **Web Dynpro ABAP는 웹 기반 UI 기술로, Component / View / Controller / Context 구조가 핵심이다**
- **Lesson 13은 ‘전통 화면 → ALV → 웹 UI’로 SAP 화면 기술 흐름을 이해하는 단원이다**
