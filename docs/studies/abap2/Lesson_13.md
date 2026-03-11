# 🔵 **Unit 1. Screen Painter**

1. **Screen Painter** 
    1. **Screen Painter parameter 기본 실습**
        1. 스크린 프린터의 데이터 엘리멘트 크기 지정 
            
            ```text
            Screen Painter - Field Property 설정 화면

            ┌──────────────────────────────┐
            │ Field Attributes              │
            │ Data Element : BC400_xxxx    │
            │ Output Length : 10           │
            │ Visible Length : 10          │
            │                               │
            │ Screen Painter에서            │
            │ Data Element 크기를           │
            │ 조정하는 실습 화면            │
            └──────────────────────────────┘
            ```
            
        2. input parameter X (Only Output parameter)
            
            ```text
            Screen Field Attribute

            ┌──────────────────────────────┐
            │ Field Properties              │
            │                               │
            │ [ ] Input                     │
            │ [x] Output Only               │
            │                               │
            │ 입력 불가 필드 설정            │
            │ Display 전용 필드              │
            └──────────────────────────────┘
            ```
            
2. Module Pool의 **데이터 전송(Implement Data Transport)**
    1. 화면 필드 이름 = 프로그램 전역 변수 이름 이 둘이 같으면  PBO 때: 프로그램 값 → 화면 / PAI 때: 화면 값 → 프로그램 값 이 복사가 **자동으로** 일어난다.
    2. **프로그램 전역 변수 fr.gpt**
        
        ```abap
        DATA bc400_s_dynconn TYPE bc400_s_dynconn.   "전역 구조
        ```
        
    3. TABLES 문은 DDIC 구조를 가진 전역 변수 자동 생성 명령 → PBO/PAI에서 자동 Transport
        
        ```abap
        
        TABLES BC400_S_DYNCONN.
        ```
        
    4. 버튼 클릭 전 다른 스크린으로 넘어가기 전에 디스플레이에서 받은 값 (데이터)을 변수 할당하는 실습
        
        ```text
        Screen 100 입력 화면

        ┌──────────────────────────────┐
        │ Airline (CARRID) : ____      │
        │ Connection (CONNID) : ____   │
        │                              │
        │            [ GO ]            │
        └──────────────────────────────┘

        입력값 → BC400_S_DYNCONN 구조에 자동 저장
        ```
        
        1. `bc400_s_dynconn` : Screen Painter와 연결된 TABLES 변수
        2. `gs_connection` : 함수 모듈에 넘길 깨끗한 구조
            
            **→ 화면 입력 값을  로직 구조로 프로그램 내 변수에 복사하는 단계**
            
        3. 코드
            
            ```jsx
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
            
        4. 결과
            
            ```text
            Screen 200 결과 화면

            ┌──────────────────────────────┐
            │ Airline : LH                 │
            │ Connection : 0400            │
            │ Departure : Frankfurt        │
            │ Arrival   : New York         │
            │                              │
            │ [ BACK ]   [ EXIT ]          │
            └──────────────────────────────┘
            ```
            
            ```text
            프로그램 흐름

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
2. 컨테이너(Container) 객체를 위한 참조 변수(Reference Variables)
    1. Reference Variables의 필요성
        1. SAP ALV Grid Control을 화면에 표시하기 위해서는 여러 개의 객체(Object)를 생성해야 한다. 객체를 생성하려면 반드시 해당 객체를 가리킬 **참조 변수(Reference Variable)** 가 필요하다. 참조 변수는 말 그대로 “객체를 가리키는 포인터(주소)” 역할을 한다.
        2. ALV와 Container는 모두 **Object(객체)**이기 때문이다.  객체는 동적으로 메모리에 생성되며, 해당 객체를 사용하려면 그 메모리 주소를 담고 있을 참조 변수가 필요하다.
3. SAP List Viewer (ALV) 실습
    1. 실습 진행 화면
        1. 스크린 200번 Layout →  속성 값 가로 세로 ? r?머시기 2개 체크
            
            ```text
            Screen 200 Layout 설정

            ┌──────────────────────────────┐
            │ Screen Attributes             │
            │                                │
            │ [x] Resizable Horizontally     │
            │ [x] Resizable Vertically       │
            │                                │
            │ Custom Control : AREA          │
            │                                │
            │ ALV 출력 영역 크기 자동 확장     │
            └──────────────────────────────┘
            ```
            
        2. Top Include에서 Reference Variable이랑Container Control Variable 변수 선언하고,  본 프로그램 와서 pbo활성화를 위한 주석 풀고 해당 주석에 잇는 Include클릭해서 저장하고 Active → 본 프로그램 Active →  새로운 Include MZSCR_G01O01 생김 
            
            ```jsx
            * Reference Variable 선언.
            * Container Control Variable.
            DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
                   GO_AVL  TYPE REF TO CL_GUI_ALV_GRID.
            ```
            
        3.   MZSCR_G01O01  내에 GO_CONT( Reference Variable ) 를 통해 Container와 Grid Controld 객체를 만들어야 함.
            
            ```text
            PBO Include (MZSCR_G01O01)

            Container 객체 생성 위치

            ┌──────────────────────────────┐
            │ CREATE OBJECT GO_CONT         │
            │ EXPORTING                     │
            │   CONTAINER_NAME = 'AREA'     │
            │                                │
            │ Screen Painter의               │
            │ Custom Control AREA와 연결     │
            └──────────────────────────────┘
            ```
            
            → Container 객체 먼저 생성 → Screen Painter에서 지정한 객체 이름인 ‘AREA’를 해당 객체 생성 내부  CONTAINER_NAME  이름도 변수 명 할당해서 활성화
            
            ```jsx
             CONTAINER_NAME = 'AREA'
            ```
            
        4. 생성된 객체 Container 위에 Grid Control 생성 (Container 연결)
            
            ```jsx
                CREATE OBJECT GO_ALV
                  EXPORTING
                    I_PARENT          = GO_CONT
                  EXCEPTIONS
                    ERROR_CNTL_CREATE = 1
                    ERROR_CNTL_INIT   = 2
                    ERROR_CNTL_LINK   = 3
                    ERROR_DP_CREATE   = 4
                    OTHERS            = 5.
                IF SY-SUBRC <> 0.
            *     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
            *                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
                ENDIF.
            ```
            
        5. 현재 시점에서 TOP Include 수정
            
            ```jsx
            *&---------------------------------------------------------------------*
            *& Include MZSCR_G01TOP                             - Module Pool SAPMZSCR_G01
            *&---------------------------------------------------------------------*
            *& TOP Include
            *& - 프로그램 전체에서 사용할 전역 변수(Global Data) 선언부
            *& - 모든 Include(PBO/PAI/FORMS)에서 접근 가능
            *&---------------------------------------------------------------------*
            
            PROGRAM SAPMZSCR_G01.
            
            * Screen Painter에서 받은 필드 이름과 똑같은 이름으로 변수 선언.
            TABLES BC400_S_DYNCONN.
            
            * Function Module 호출 후 결과값을 받은 변수.
            DATA GS_CONNECTION TYPE BC400_S_CONNECTION.
            
            DATA : OK_CODE TYPE SY-UCOMM.
            
            DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
                   GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.
            
            DATA : GT_FLIGHTS TYPE BC400_T_FLIGHTS.
            ```
            
        6. Funtion Module  호출하여 Flight data 가져옴
            
            ```text
            Debug / 코드 작성 화면

            ┌──────────────────────────────┐
            │ CALL FUNCTION                 │
            │ 'BC400_DDS_FLIGHTLIST_GET'   │
            │                                │
            │ Input : CARRID / CONNID       │
            │ Output : GT_FLIGHTS           │
            │                                │
            │ Flight 리스트 조회             │
            └──────────────────────────────┘
            ```
            
            ```jsx
                  * MZSCR_G01I01 Include내에 작성 *
                   
                    " Funtion Module  호출하여 Flight data 가져옴.
                    CALL FUNCTION 'BC400_DDS_FLIGHTLIST_GET'
                      EXPORTING
                        IV_CARRID  = BC400_S_DYNCONN-CARRID
                        IV_CONNID  = BC400_S_DYNCONN-CONNID
                      IMPORTING
                        ET_FLIGHTS = GT_FLIGHTS
                      EXCEPTIONS
                        NO_DATA    = 1
                        OTHERS     = 2.
                    IF SY-SUBRC <> 0.
                      CLEAR GT_FLIGHTS.
                    ENDIF.
            
                    " Function Code = 'GO' → 200번 화면으로 이동.
                    SET SCREEN 200.
                  ENDIF.
            ```
            
        7. 최초 ALV 화면 그리기
            1. SET_TABLE_FOR_FIRST_DISPLAY : 내부 테이블과 필드 정보를 넘겨주면 그걸 보고 ALV Grid 화면(컬럼, 데이터, 툴바, 정렬/필터 기능 등)을 한 번에 만들어 주는 초기화 메서드
                
                ```jsx
                CALL METHOD go_alv_grid->set_table_for_first_display
                  EXPORTING
                    i_structure_name = 'SFLIGHT'
                  CHANGING
                    it_outtab        = gt_flights.
                ```
                
            2. 현재 실습 메소드 호출
                
                ```text
                ALV Grid 초기화

                ┌──────────────────────────────┐
                │ GO_ALV->SET_TABLE_FOR_FIRST  │
                │ DISPLAY                      │
                │                               │
                │ Structure : BC400_S_FLIGHT    │
                │ Data      : GT_FLIGHTS        │
                │                               │
                │ ALV Grid 생성                 │
                └──────────────────────────────┘
                ```
                
                ```jsx
                    CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
                      EXPORTING
                        I_STRUCTURE_NAME              = 'BC400_S_FLIGHT'
                      CHANGING
                        IT_OUTTAB                     = GT_FLIGHTS
                      EXCEPTIONS
                        INVALID_PARAMETER_COMBINATION = 1
                        PROGRAM_ERROR                 = 2
                        TOO_MANY_LINES                = 3
                        OTHERS                        = 4.
                    IF SY-SUBRC <> 0.
                * Implement suitable error handling here
                    ENDIF.
                ```
                
                ```text
                ALV 실행 화면

                ┌─────────────────────────────────────┐
                │ CARRID | CONNID | FLDATE | PRICE    │
                ├─────────────────────────────────────┤
                │ LH     | 0400   | ...    | ...      │
                │ LH     | 0401   | ...    | ...      │
                │ LH     | 0402   | ...    | ...      │
                └─────────────────────────────────────┘
                ```
                
                → 지금까지 실습 완료 후 실행 화면

# 🔵 **Unit 3. Web Dynpro ABAP**

1. Web Dynpro ABAP란?
    1. 웹 브라우저에서 동작하는 SAP의 UI 프레임 워크 SAP GUI 화면 대신 **웹 화면**을 만드는 기술
    2. Web Dynpro 기본 구성
        
        ```text
        Web Dynpro Component 생성 화면

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
        │                                       │
        │ Web Dynpro 기본 구조 생성 화면         │
        └──────────────────────────────────────┘
        ```
        
        ```text
        Web Dynpro 개발 화면 구조

        ┌──────────────────────────────────────┐
        │ Component Structure                  │
        │                                      │
        │ Component                            │
        │   ├─ Component Controller            │
        │   ├─ Window                          │
        │   │   └─ View                        │
        │   │       ├─ Layout                  │
        │   │       ├─ Context                 │
        │   │       └─ Methods                 │
        │                                      │
        │ SAP Web Dynpro 개발 트리 구조         │
        └──────────────────────────────────────┘
        ```
        
        ```jsx
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
        │  │   ┌──────────────┐   ┌──────────────┐        │  │ -> View 내부
        │  │   │    VIEW_A    │   │    VIEW_B    │   ...  │  │
        │  │   │  (UI 화면)   │   │  (UI 화면)   │        │  │
        │  │   └──────────────┘   └──────────────┘        │  │
        │  │                                              │  │
        │  │  - 여러 View 포함 가능                       │  │
        │  │  - Plugs(입·출력) 연결로 Navigation 구현      │  │
        │  └──────────────────────────────────────────────┘  │
        │                                                    │
        └────────────────────────────────────────────────────┘
        
        --------------------------------------------------------------
        
        ┌──────────────┐
        │     VIEW     │   ← 실제로 화면에 보이는 버튼/입력필드
        └──────┬───────┘
               │ (UI Binding)
               ↓
        ┌──────────────┐
        │ VIEW CONTROLLER │ ← 화면 로직 처리 (버튼 이벤트, 초기화 등)
        └──────┬────────┘
               │ (Context API)
               ↓
        ┌──────────────┐
        │    CONTEXT    │ ← 데이터 저장 위치(구조체 + 필드)
        └──────────────┘
        ```
        
2. Web Dynpro 실습
    
    ```text
    Web Dynpro Component 생성 단계

    ┌──────────────────────────────┐
    │ SE80 → Create → Web Dynpro   │
    │                               │
    │ Component Name : ZWD_FLIGHT  │
    │                               │
    │ 생성 후 자동 구조              │
    │ Component Controller          │
    │ View                          │
    │ Window                        │
    └──────────────────────────────┘
    ```
    
    ```text
    View Layout Editor

    ┌──────────────────────────────┐
    │ Layout                       │
    │                              │
    │ InputField : CARRID          │
    │ InputField : CONNID          │
    │ Button : SEARCH              │
    │ Table : Flight Data          │
    └──────────────────────────────┘
    ```
    
    ```text
    Context Node 생성

    ┌──────────────────────────────┐
    │ Context                      │
    │                              │
    │ NS_COND                      │
    │   ├─ CARRID                  │
    │   └─ CONNID                  │
    │                              │
    │ NT_DATA                      │
    │   ├─ CARRID                  │
    │   ├─ CONNID                  │
    │   ├─ FLDATE                  │
    │   └─ PRICE                   │
    └──────────────────────────────┘
    ```
    
    ```text
    Context Mapping

    Component Controller Context
             │
             ▼
    View Context

    Data Element Share 기능
    ```
    
    → Context Mapping (Data Element Share 기능) : Context Mapping은 **View ↔ Component Controller** 사이에 데이터를 자동으로 동기화 시키는 기능이다.
    
    ```text
    Context Mapping 설정 화면

    ┌──────────────────────────────┐
    │ Component Controller Context │
    │          │                   │
    │          ▼                   │
    │        View Context          │
    │                              │
    │ Drag & Drop Mapping          │
    └──────────────────────────────┘
    ```
    
    → Web Dynpro Application 생성
    
    ```text
    Web Dynpro Application 생성

    ┌──────────────────────────────┐
    │ Create Application           │
    │                              │
    │ Name : ZWD_FLIGHT_APP        │
    │ Component : ZWD_FLIGHT       │
    │ Interface View : MAIN_VIEW   │
    └──────────────────────────────┘
    ```
    
    ```text
    Application 실행 설정

    ┌──────────────────────────────┐
    │ Web Dynpro Application       │
    │                              │
    │ Execute → Browser Launch     │
    │                              │
    │ URL 생성 후 실행              │
    └──────────────────────────────┘
    ```
    
    ```text
    View UI Layout

    ┌──────────────────────────────────┐
    │ CARRID : [____]                  │
    │ CONNID : [____]                  │
    │                                  │
    │           [ SEARCH ]              │
    │                                  │
    │ Flight Table                      │
    └──────────────────────────────────┘
    ```
    
    → Content 눌러서 저장
    
    ```text
    Layout Save

    ┌──────────────────────────────┐
    │ Layout Editor                │
    │                              │
    │ [Save]                       │
    │ [Activate]                   │
    └──────────────────────────────┘
    ```
    
    → 메소드 추가 
    
    ```jsx
    METHOD GET_FLIGHTS .
      DATA LO_ND_NS_COND TYPE REF TO IF_WD_CONTEXT_NODE.
    
      DATA LO_EL_NS_COND TYPE REF TO IF_WD_CONTEXT_ELEMENT.
      DATA LS_NS_COND TYPE WD_THIS->ELEMENT_NS_COND.
    
    *   navigate from <CONTEXT> to <NS_COND> via lead selection
      LO_ND_NS_COND = WD_CONTEXT->GET_CHILD_NODE( NAME = WD_THIS->WDCTX_NS_COND ).
    
    *   @TODO handle non existant child
    *   IF lo_nd_ns_cond IS INITIAL.
    *   ENDIF.
    
    *   get element via lead selection
      LO_EL_NS_COND = LO_ND_NS_COND->GET_ELEMENT( ).
    *   @TODO handle not set lead selection
      IF LO_EL_NS_COND IS INITIAL.
      ENDIF.
    
    *   get all declared attributes
      LO_EL_NS_COND->GET_STATIC_ATTRIBUTES(
        IMPORTING
          STATIC_ATTRIBUTES = LS_NS_COND ).
    
      DATA LO_ND_NT_DATA TYPE REF TO IF_WD_CONTEXT_NODE.
    
      DATA LT_NT_DATA TYPE WD_THIS->ELEMENTS_NT_DATA.
    
    *     navigate from <CONTEXT> to <NT_DATA> via lead selection
      LO_ND_NT_DATA = WD_CONTEXT->GET_CHILD_NODE( NAME = WD_THIS->WDCTX_NT_DATA ).
    
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE LT_NT_DATA
        FROM SFLIGHT
        WHERE CARRID = LS_NS_COND-CARRID
          AND CONNID = LS_NS_COND-CONNID.
    
      LO_ND_NT_DATA->BIND_TABLE( NEW_ITEMS = LT_NT_DATA SET_INITIAL_ELEMENTS = ABAP_TRUE ).
    
    ENDMETHOD.
    ```
    
    ```jsx
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE LT_NT_DATA
        FROM SFLIGHT
        WHERE CARRID = LS_NS_COND-CARRID
          AND CONNID = LS_NS_COND-CONNID. *추가*
    ```
    
    ```text
    Method Editor

    ┌──────────────────────────────┐
    │ Method : GET_FLIGHTS         │
    │                              │
    │ SELECT SFLIGHT               │
    │ INTO LT_NT_DATA              │
    │                              │
    │ Context Binding              │
    └──────────────────────────────┘
    ```
    
    → 메소드 활성화
    
    ```jsx
    METHOD ONACTIONSEARCH .
    
      WD_COMP_CONTROLLER->GET_FLIGHTS( ).
    
    ENDMETHOD.
    ```
    
    ```text
    실행 결과

    ┌──────────────────────────────────┐
    │ CARRID : LH                      │
    │ CONNID : 0400                    │
    │                                  │
    │ [ SEARCH ]                       │
    │                                  │
    │ Flight Table                     │
    │ LH | 0400 | 2024-01-01 | ...     │
    │ LH | 0400 | 2024-01-02 | ...     │
    └──────────────────────────────────┘
    ```
    
    → 실습 완료 화면

