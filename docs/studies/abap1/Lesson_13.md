# 🧭 Lesson 13 - Screen Painter & SAP List Viewer (ALV)

---

# 🔵 Unit 1. Screen Painter

## 1. Screen Painter

### 1) Screen Painter parameter 기본 실습

### (1) 스크린 프린터의 데이터 엘리멘트 크기 지정

- Screen Painter에서 필드 배치 후, 해당 필드의 속성에서
    
    “Length”, “Output length” 등을 데이터 엘리먼트 기준으로 조정.
    
- 데이터 엘리먼트를 참조하는 경우:
    - DDIC에서 정의한 길이와 형식(CHAR, NUMC, DATS 등)을 기반으로 자동 세팅.
- 필드 길이를 조정하면, 실제 화면에서 입력/출력 가능한 글자 수가 결정됨.

도식:

```
[DDIC Data Element]  --->  [Screen Field Length]
   (도메인, 길이)             (Input/Output 길이)

```

### (2) input parameter X (Only Output parameter)

- 필드 속성 중 “Input” / “Output only” 플래그 사용
- “Output only” (입력 불가, 출력 전용) 체크 시:
    - 화면에서는 값만 보여주고 사용자가 수정할 수 없음.
- 예: 결과값 표시, 메시지 출력용 필드 등

도식:

```
[Screen Field]
   ├─ Input = X, Output = X   → 입력 + 출력 가능
   └─ Input = ' ', Output = X → 출력 전용 (Only Output)

```

---

## 2. Module Pool의 데이터 전송 (Implement Data Transport)

### 2-1) 기본 개념

- **화면 필드 이름 = 프로그램 전역 변수 이름**
    
    이 둘이 같으면 PBO/PAI에서 값이 자동으로 복사된다.
    
- PBO(출력 직전):
    - 프로그램 변수 값 → 화면 필드로 자동 전송
- PAI(입력 후):
    - 화면 필드 값 → 프로그램 변수로 자동 전송

도식:

```
PBO: Program Variable  →  Screen Field
PAI: Screen Field      →  Program Variable
(이름이 같으면 자동 Transport)

```

### 2-2) 프로그램 전역 변수 예시

```abap
DATA bc400_s_dynconn TYPE bc400_s_dynconn.   "전역 구조

```

- DDIC 구조 `BC400_S_DYNCONN` 를 타입으로 가지는 전역 Work Area

### 2-3) TABLES 문 = DDIC 구조를 가진 전역 변수 자동 생성

```abap
TABLES bc400_s_dynconn.

```

- 위 한 줄은 아래와 유사한 역할:

```abap
DATA bc400_s_dynconn TYPE bc400_s_dynconn.

```

- Module Pool에서 `TABLES` 문을 많이 사용하는 이유:
    - Screen Painter에서 `BC400_S_DYNCONN-CARRID` 같은 이름으로 필드를 선언하면
        
        PBO/PAI에서 **자동으로** 값이 왔다 갔다 함.
        

### 2-4) 버튼 클릭 후 다른 스크린으로 넘어가기 전, 화면에서 받은 값을 변수에 할당하는 실습

개념 도식:

```
[Screen 0100]
  입력 필드: BC400_S_DYNCONN-CARRID
  입력 필드: BC400_S_DYNCONN-CONNID
       ↓ (PAI, OK_CODE = 'GO')
[USER_COMMAND_0100]
  1) 화면 값 → BC400_S_DYNCONN-* 에 이미 자동 세팅
  2) 이 값을 이용해 FM 호출
  3) 결과를 구조 GS_CONNECTION에 받음
  4) GS_CONNECTION → BC400_S_DYNCONN 으로 복사 (MOVE-CORRESPONDING)
  5) SET SCREEN 200 으로 200번 화면 이동
[Screen 0200]
  BC400_S_DYNCONN-* 값이 화면에 표시됨 (PBO 자동 Transport)

```

### 주요 변수 역할

1. `BC400_S_DYNCONN` : Screen Painter와 연결된 TABLES 전역 구조 (입력/출력용)
2. `GS_CONNECTION` : Function Module 결과를 받는 로컬/전역 구조
    
    → “로직 처리용 구조체”
    

**즉: 화면 입력값을 `GS_CONNECTION` 등의 로직용 구조로 옮기거나, 그 반대로 옮기는 단계**

### 2-5) PAI 모듈 코드 예시

```abap
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
MODULE user_command_0100 INPUT.

  " OK_CODE : 화면에서 누른 버튼의 Function Code가 자동으로 세팅됨
  CASE ok_code.

    WHEN 'GO'.          " 사용자가 GO 버튼을 눌렀을 때

      "---------------------------------------------------------------
      " Function Module 호출
      " - 사용자가 입력한 CARRID / CONNID 값을 기준으로
      "   항공편 정보를 DB에서 조회하는 기능 제공
      " - BC400_S_DYNCONN-* 에는 화면 입력값이 이미 들어와 있음
      "---------------------------------------------------------------
      CALL FUNCTION 'BC400_DDS_CONNECTION_GET'
        EXPORTING
          iv_carrid     = bc400_s_dynconn-carrid     " 입력 항공사 코드
          iv_connid     = bc400_s_dynconn-connid     " 입력 항공편 번호
        IMPORTING
          es_connection = gs_connection              " 조회된 실제 데이터
        EXCEPTIONS
          no_data       = 1                          " 데이터 없음
          OTHERS        = 2.

      "---------------------------------------------------------------
      " 조회 실패 처리 (데이터 없음)
      " sy-subrc <> 0 → 예외 발생 → 메시지 출력 후 0100 유지
      "---------------------------------------------------------------
      IF sy-subrc <> 0.
        MESSAGE e042(bc400)
          WITH gs_connection-carrid
               gs_connection-connid.

      ELSE.

        "-------------------------------------------------------------
        " 조회 성공
        " GS_CONNECTION → BC400_S_DYNCONN 로 복사
        " 화면 0200에서 출력될 값이므로 스크린 구조로 이동
        "-------------------------------------------------------------
        MOVE-CORRESPONDING gs_connection TO bc400_s_dynconn.

        "-------------------------------------------------------------
        " 화면 전환
        " SET SCREEN 200 → 다음 PBO(0200) 를 수행하며 화면 이동
        "-------------------------------------------------------------
        SET SCREEN 200.

      ENDIF.

  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*& 화면 0200에서 발생한 사용자 요청 처리
*& BACK → 100번 화면으로 돌아가기
*& EXIT → 프로그램 종료
*&---------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE ok_code.

    WHEN 'BACK'.
      " 이전 화면(100)으로 되돌아가기
      SET SCREEN 100.

    WHEN 'EXIT'.
      " SET SCREEN 0 → 프로그램 시작 호출 지점으로 복귀 (= 종료)
      SET SCREEN 0.

  ENDCASE.

ENDMODULE.

```

---

# 🔵 Unit 2. SAP List Viewer (ALV)

## 1. SAP List Viewer (ALV)

### 1) ALV(SAP List Viewer)란?

- SAP에서 **내부 테이블**을 표(Grid) 형태로 표시해주는 표준 도구
- 정렬, 필터, 합계, 다운로드, 레이아웃 저장 기능 등을 자동 제공
- **ALV Grid Control (CL_GUI_ALV_GRID)** 를 이용하여 구현

추상적으로 보면:

```
[Internal Table] → [ALV Grid] → [사용자 화면]

```

### 2) ALV Grid가 화면에 표시되는 전체 실행 흐름

```
1) 스크린에서 Custom Control(CC_ALV) 생성
      ↓
2) ABAP에서 Container 객체 생성 (CL_GUI_CUSTOM_CONTAINER)
      ↓
3) Grid 객체 생성 (CL_GUI_ALV_GRID), Container에 부착
      ↓
4) 내부 테이블 준비 (SELECT ... INTO TABLE ...)
      ↓
5) go_alv->set_table_for_first_display( ... ) 호출
      ↓
6) ALV 그리드가 화면에 표시됨

```

### 3) 핵심 구성요소 3개

1. **Area (빈 화면 영역)**
    - Screen Painter에서 Custom Control을 배치할 물리적인 공간
2. **Custom Container Control**
    - Screen Painter에 실제로 배치하는 컨트롤
    - 이름(예: `AREA`, `CC_ALV`)를 가짐
    - ABAP에서 이 이름으로 컨테이너 객체와 연결
3. **SAP Grid Control (CL_GUI_ALV_GRID)**
    - 실제 ALV 테이블을 그려주는 클래스(엔진)

### 4) 전체 연결 구조 도식화

```
Area (빈 화면 칸)
   → Custom Container Control (예: 'AREA')
      → Container Instance (CL_GUI_CUSTOM_CONTAINER, go_cont)
         → Grid Instance (CL_GUI_ALV_GRID, go_alv)
            → set_table_for_first_display(...)
               → ALV 화면 출력

```

조금 더 단계별로:

```
STEP 1 - 화면에는 AREA(영역)만 존재 (도화지)
┌──────────────────────────────┐
│        AREA (빈 영역)        │
└──────────────────────────────┘

STEP 2 - AREA에 Custom Container Control 배치
┌──────────────────────────────┐
│   Custom Control: 'AREA'     │
│   (화면에 올려진 UI 컨트롤)  │
└──────────────────────────────┘

STEP 3 - ABAP에서 Container Instance 생성
┌──────────────────────────────┐
│   Custom Control: 'AREA'     │
│     ↑                         │
│     │ container_name = 'AREA' │
│     │                         │
│   go_cont (CL_GUI_CUSTOM_CONTAINER)  │
└──────────────────────────────┘

STEP 4 - Grid Instance 생성 → Container에 연결
┌──────────────────────────────┐
│   Custom Control: 'AREA'     │
│     ↑                         │
│   go_cont                     │
│     ↑                         │
│   go_alv (CL_GUI_ALV_GRID)    │
│   i_parent = go_cont          │
└──────────────────────────────┘

STEP 5 - Grid가 내부 테이블 데이터를 화면에 그림
┌──────────────────────────────┐
│   [ ALV Table Display ]      │
│   (사용자가 보는 화면)       │
└──────────────────────────────┘

```

---

## 2. 컨테이너(Container) 객체를 위한 참조 변수(Reference Variable)

### 2-1) Reference Variables의 필요성

- ALV Grid Control, Custom Container 모두 **객체(Object)** 이다.
- 객체는 동적으로 메모리에 생성되며,
    
    이 객체를 조작하려면 해당 객체를 가리키는 **참조 변수(Reference Variable)** 가 필요하다.
    
- 참조 변수는 “객체의 주소”를 담는 포인터 역할.

도식:

```
[참조 변수] --가리킴--> [객체(Instance)]

```

예시:

```abap
DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA go_alv  TYPE REF TO cl_gui_alv_grid.

```

---

## 3. SAP List Viewer (ALV) 실습 흐름 정리

### 3-1) 스크린 200번 Layout 설정

- Screen 200 → Layout
    - “레이아웃” 속성에서
        - 행/열 조정 옵션 체크 (예: 행/열 크기 조정, 스크롤바 등)
    - Custom Control을 배치하고 이름을 부여 (예: `AREA`)

도식:

```
[Screen 0200]
   └─ Custom Control: 'AREA'

```

### 3-2) TOP Include에서 참조 변수/컨테이너 변수 선언

```abap
* Reference Variable 선언.
* Container Control Variable.
DATA: go_cont TYPE REF TO cl_gui_custom_container,
      go_alv  TYPE REF TO cl_gui_alv_grid.

```

- 이 변수들을 사용하여 PBO에서 실제 객체를 생성한다.

### 3-3) PBO Include(MZSCR_G01O01)에서 컨테이너 및 Grid 생성

도식:

```
1) go_cont 생성 → 'AREA' Custom Control과 연결
2) go_alv 생성 → go_cont를 부모로 지정
3) 내부 테이블 GT_FLIGHTS 를 ALV에 연결

```

컨테이너 생성 코드 예시:

```abap
CREATE OBJECT go_cont
  EXPORTING
    container_name = 'AREA'
  EXCEPTIONS
    others         = 1.

```

Grid Control 생성 코드 예시:

```abap
CREATE OBJECT go_alv
  EXPORTING
    i_parent          = go_cont
  EXCEPTIONS
    error_cntl_create = 1
    error_cntl_init   = 2
    error_cntl_link   = 3
    error_dp_create   = 4
    OTHERS            = 5.

IF sy-subrc <> 0.
*   오류 처리 로직
ENDIF.

```

### 3-4) TOP Include 전체 예시

```abap
*&---------------------------------------------------------------------*
*& Include MZSCR_G01TOP - Module Pool SAPMZSCR_G01
*&---------------------------------------------------------------------*
*& TOP Include
*& - 프로그램 전체에서 사용할 전역 변수(Global Data) 선언부
*& - 모든 Include(PBO/PAI/FORMS)에서 접근 가능
*&---------------------------------------------------------------------*

PROGRAM sapmzscr_g01.

* Screen Painter에서 받은 필드 이름과 똑같은 이름으로 변수 선언.
TABLES bc400_s_dynconn.

* Function Module 호출 후 결과값을 받을 구조.
DATA gs_connection TYPE bc400_s_connection.

"----------------------------------------------------------------------
" OK_CODE : 스크린에서 버튼을 눌렀을 때 전달되는 Function Code 저장 변수
"----------------------------------------------------------------------
DATA ok_code TYPE sy-ucomm.

* Reference Variable 선언.
* Container Control Variable.
DATA: go_cont TYPE REF TO cl_gui_custom_container,
      go_alv  TYPE REF TO cl_gui_alv_grid.

* Grid control에 표시할 데이터를 할당할 변수(internal table).
DATA gt_flights TYPE bc400_t_flights.

```

### 3-5) Function Module 호출로 Flight data 가져오기 (PAI 내)

```abap
" MZSCR_G01I01 Include 내에 작성

" Function Module 호출하여 Flight data 가져옴.
CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
  EXPORTING
    iv_carrid  = bc400_s_dynconn-carrid
    iv_connid  = bc400_s_dynconn-connid
  IMPORTING
    et_flights = gt_flights
  EXCEPTIONS
    no_data    = 1
    OTHERS     = 2.

IF sy-subrc <> 0.
  CLEAR gt_flights.
ENDIF.

" Function Code = 'GO' → 200번 화면으로 이동.
SET SCREEN 200.

```

### 3-6) 최초 ALV 화면 그리기 – `set_table_for_first_display`

**핵심 메서드:**

내부 테이블과 DDIC 구조 이름을 넘겨주면

ALV Grid 화면(컬럼, 데이터, 툴바, 정렬/필터 기능 등)을 한 번에 초기화하여 그린다.

기본 예시:

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    i_structure_name = 'SFLIGHT'
  CHANGING
    it_outtab        = gt_flights.

```

실습 코드:

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    i_structure_name              = 'BC400_S_FLIGHT'
  CHANGING
    it_outtab                     = gt_flights
  EXCEPTIONS
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    OTHERS                        = 4.

IF sy-subrc <> 0.
  " 오류 처리 로직 추가 가능
ENDIF.

```

### 3-7) 이후 데이터 변경을 화면에 반영 – `refresh_table_display`

- ALV를 한 번 그린 후, 내부 테이블 `gt_flights` 내용이 변경되면
    
    전체를 다시 `set_table_for_first_display`로 만들 필요 없이
    
    `refresh_table_display`만 호출하면 된다.
    

```abap
ELSE.
  CALL METHOD go_alv->refresh_table_display
    EXCEPTIONS
      finished = 1.

  IF sy-subrc <> 0.
    " 오류 처리 로직
  ENDIF.
ENDIF.

```

### 3-8) `set_table_for_first_display` 내에서 `I_STRUCTURE_NAME` / `IT_OUTTAB` 조건 요약

| 항목 | 적용 조건 | 사용 가능 값 | 사용 불가 값 |
| --- | --- | --- | --- |
| **I_STRUCTURE_NAME** | DDIC Structure 이름이어야 함IT_OUTTAB 라인 타입과 동일해야 함 | `SFLIGHT`, `SCARR`, `BC400_S_FLIGHT`, `ZSTRUCT_*` | 내부 테이블명, 변수명, 구조 인스턴스, string |
| **IT_OUTTAB** | Internal Table이어야 함라인 타입 구조가 I_STRUCTURE_NAME과 같아야 함 | `TABLE OF sflight`, `TABLE OF bc400_s_flight` | 구조 하나(`TYPE sflight`), char10 테이블, ANY |

---

# 🔵 Unit 3. Web Dynpro ABAP

## 1. Web Dynpro ABAP란?

1. 웹 브라우저에서 동작하는 SAP의 UI 프레임워크
    - SAP GUI 화면 대신 **웹 화면** 구현
    - MVC 구조 기반
2. Web Dynpro 기본 구성 (Component 내 구조)

도식 1:

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
│  │   │    VIEW_A    │   │    VIEW_B    │  ...   │  │
│  │   │  (UI 화면)   │   │  (UI 화면)   │        │  │
│  │   └──────────────┘   └──────────────┘        │  │
│  │                                              │  │
│  │  - 여러 View 포함 가능                       │  │
│  │  - Plugs(입·출력) 연결로 Navigation 구현      │  │
│  └──────────────────────────────────────────────┘  │
│                                                    │
└────────────────────────────────────────────────────┘

```

도식 2 (View 내부 구조):

```
┌──────────────┐
│     VIEW     │   ← 실제로 화면에 보이는 버튼/입력필드
└──────┬───────┘
       │ (UI Binding)
       ↓
┌────────────────┐
│ VIEW CONTROLLER│ ← 화면 로직 (버튼 이벤트, 초기화 등)
└──────┬─────────┘
       │ (Context API)
       ↓
┌──────────────┐
│   CONTEXT    │ ← 데이터 저장 위치(구조체 + 필드)
└──────────────┘

```

- View: UI 요소 (버튼, 입력필드, 테이블 등)
- View Controller: 이벤트 처리 및 초기 로직
- Context: View에서 사용하는 데이터 저장소

---

## 2. Web Dynpro 실습 개요

전체 실습 흐름:

1. Component 생성
2. Component Controller에서 Context 구성 (예: 조건 NS_COND, 결과리스트 NT_DATA)
3. View에 Context Mapping
4. UI 요소(Input, Table)와 Context 바인딩
5. Search 버튼 액션 → Component Controller의 메서드(GET_FLIGHTS) 호출
6. GET_FLIGHTS 메서드에서 SFLIGHT 데이터를 읽어 Context에 바인딩
7. Web Dynpro Application 생성 → 실행하여 결과 확인

### Context Mapping (Data Element 공유 기능)

- Context Mapping은 **View ↔ Component Controller** 사이에 데이터를 자동 동기화하는 기능
- View에서 입력한 값 → Component Controller Context에 자동 반영
- 다른 View에서도 같은 Context를 이용해 데이터를 공유 가능

도식:

```
View Context  ←→  Component Controller Context  ←→  다른 View Context

```

### Web Dynpro Application 생성

- Component를 웹에서 실행할 수 있도록 Application 생성
- Application 이름, Component 이름 지정 후 저장/활성화
- 브라우저 또는 SAP GUI 내에서 실행

---

## 3. Component Controller 메서드 예시: `GET_FLIGHTS`

```abap
METHOD get_flights.

  DATA lo_nd_ns_cond TYPE REF TO if_wd_context_node.
  DATA lo_el_ns_cond TYPE REF TO if_wd_context_element.
  DATA ls_ns_cond    TYPE wd_this->element_ns_cond.

* navigate from <CONTEXT> to <NS_COND> via lead selection
  lo_nd_ns_cond = wd_context->get_child_node( name = wd_this->wdctx_ns_cond ).

* get element via lead selection
  lo_el_ns_cond = lo_nd_ns_cond->get_element( ).
  IF lo_el_ns_cond IS INITIAL.
    " TODO: handle not set lead selection
  ENDIF.

* get all declared attributes (CARRID, CONNID 등 가져오기)
  lo_el_ns_cond->get_static_attributes(
    IMPORTING
      static_attributes = ls_ns_cond ).

  DATA lo_nd_nt_data TYPE REF TO if_wd_context_node.
  DATA lt_nt_data    TYPE wd_this->elements_nt_data.

* navigate from <CONTEXT> to <NT_DATA> node
  lo_nd_nt_data = wd_context->get_child_node( name = wd_this->wdctx_nt_data ).

* 실제 데이터 조회 (Model 호출 역할)
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE lt_nt_data
    FROM sflight
    WHERE carrid = ls_ns_cond-carrid
      AND connid = ls_ns_cond-connid.

* 조회된 데이터를 Table Node에 바인딩
  lo_nd_nt_data->bind_table(
    new_items            = lt_nt_data
    set_initial_elements = abap_true ).

ENDMETHOD.

```

핵심 요약:

- `NS_COND` Node에서 검색 조건(CARRID, CONNID)을 가져옴
- SFLIGHT 테이블을 SELECT해서 `NT_DATA` Table Node 형식과 동일한 내부 테이블에 담음
- `BIND_TABLE`로 NT_DATA Node에 바인딩 → View Table UI에 자동 표시

### 메서드 추가 시 추가한 부분

```abap
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE lt_nt_data
    FROM sflight
    WHERE carrid = ls_ns_cond-carrid
      AND connid = ls_ns_cond-connid.

```

→ 이 SELECT 문을 통해 실제로 DB에서 데이터를 읽어온다.

### View 액션에서 메서드 호출 `ONACTIONSEARCH`

```abap
METHOD onactionsearch.

  wd_comp_controller->get_flights( ).

ENDMETHOD.

```

- Search 버튼을 누르면 Component Controller의 메서드 `GET_FLIGHTS` 호출
- Context에 데이터가 채워지고, Table UI와 바인딩되어 있으므로 자동 표시
