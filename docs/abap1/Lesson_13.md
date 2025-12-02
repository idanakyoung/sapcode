# 🧭 Lesson 13 -  **Screen Painter & SAP List Viewer (ALV)**

# 🔵 **Unit 1. Screen Painter**

1. **Screen Painter** 
    1. **Screen Painter parameter 기본 실습**
        1. 스크린 프린터의 데이터 엘리멘트 크기 지정 
            
            ![image.png](attachment:f07f2643-b239-4d5f-b078-f01c13f521e8:image.png)
            
        2. input parameter X (Only Output parameter)
            
            ![image.png](attachment:09ba913e-0726-4e20-b6fa-b81a395b038e:image.png)
            
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
        
        ![image.png](attachment:20f461d3-f59e-4559-aa14-ecfb604ae8d0:image.png)
        
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
            
                  "---------------------------------------------------------------
                  " Function Module 호출
                  " - 사용자가 입력한 CARRID / CONNID 값을 기준으로
                  "   항공편 정보를 DB에서 조회하는 기능 제공
                  " - BC400_S_DYNCONN-* 에는 화면 입력값이 이미 들어와 있음
                  "---------------------------------------------------------------
                  CALL FUNCTION 'BC400_DDS_CONNECTION_GET'
                    EXPORTING
                      IV_CARRID     = BC400_S_DYNCONN-CARRID     " 입력 항공사 코드
                      IV_CONNID     = BC400_S_DYNCONN-CONNID     " 입력 항공편 번호
                    IMPORTING
                      ES_CONNECTION = GS_CONNECTION               " 조회된 실제 데이터
                    EXCEPTIONS
                      NO_DATA       = 1                           " 데이터 없음
                      OTHERS        = 2.
            
                  "---------------------------------------------------------------
                  " 조회 실패 처리 (데이터 없음)
                  " sy-subrc <> 0 → 예외 발생 → 메시지 출력 후 0100 유지
                  "---------------------------------------------------------------
                  IF SY-SUBRC <> 0.
                    MESSAGE E042(BC400)
                      WITH GS_CONNECTION-CARRID
                           GS_CONNECTION-CONNID.
            
                  ELSE.
            
                    "-------------------------------------------------------------
                    " 조회 성공
                    " GS_CONNECTION → BC400_S_DYNCONN 로 복사
                    " 화면 0200에서 출력될 값이므로 스크린 구조로 이동
                    "-------------------------------------------------------------
                    MOVE-CORRESPONDING GS_CONNECTION TO BC400_S_DYNCONN.
            
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
            MODULE USER_COMMAND_0200 INPUT.
            
              CASE OK_CODE.
            
                WHEN 'BACK'.
                  " 이전 화면(100)으로 되돌아가기
                  SET SCREEN 100.
            
                WHEN 'EXIT'.
                  " SET SCREEN 0 → 프로그램 시작 호출 지점으로 복귀 (= 종료)
                  SET SCREEN 0.
            
              ENDCASE.
            
            ENDMODULE.
            
            ```
            
        4. 결과
            
            ![image.png](attachment:ae97b3fe-6ce8-4e78-8571-32e1742cc218:image.png)
            
            ![image.png](attachment:2e8f1de0-0ade-4fc3-8750-67aac43fa15d:image.png)
            

# 🔵 **Unit 2. SAP List Viewer (ALV)**

1. SAP List Viewer (ALV)
    1. ALV(SAP List Viewer)란?
        1. SAP에서 내부 테이블을 표(Grid) 형태로 예쁘게 보여주는 도구
        2. ALV(Grid)는 그냥 프로그램 안에서 갑자기 나타나는 게 아니라, “컨테이너(Container)”라는 박스에 먼저 붙여져서 화면에 표시된다.
        3. 쉽게 말해서?
            
            ```jsx
            **AREA = 빈 화면 공간
            CUSTOM CONTAINER = AREA 안에 올린 박스
            CONTAINER INSTANCE = 프로그램에서 이 박스를 제어하는 객체
            ALV GRID INSTANCE = 이 박스 안에 그려지는 ALV 테이블**
            ```
            
    2. **전체 실행 흐름 요약**
        
        ```jsx
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
        
    3. 핵심 구성요소 3개
        1. Area (화면에 그리는 물리적 공간) : Screen Painter에서 **Custom Control** 을 배치할 위치
        2. Custom Container Control : Screen Painter에 실제로 배치된 UI 객체 → 이름(예: CC_ALV)을 가짐 → ABAP에서 이 이름으로 접근함
        3. **SAP Grid Control (CL_GUI_ALV_GRID) : ALV를 그리는 핵심 엔진**
    4. 전체 연결 구조 (도식화)
        
        ```jsx
        Area(빈 화면 칸)
           → Custom Container Control(CC_ALV)
              → Container Instance(CL_GUI_CUSTOM_CONTAINER)
                 → Grid Instance(CL_GUI_ALV_GRID)
                    → set_table_for_first_display
                       → ALV 화면 출력
        ----------------------------------------------------------------------
        
        STEP 1 - 화면에는 AREA(영역)만 존재 (도화지)
        ──────────────────────────────────────────
        ┌──────────────────────────────┐
        │        AREA (빈 영역)        │
        └──────────────────────────────┘
        
        STEP 2 - AREA에 Custom Container Control 배치됨
        (이게 Screen Painter에서 우리가 만드는 "Custom Control")
        ──────────────────────────────────────────
        ┌──────────────────────────────┐
        │   Custom Control: CC_ALV     │ 
        │   (Area 위에 올린 Container 
               위에 올린 UI 컨트롤)     │
        └──────────────────────────────┘
        
        STEP 3 - ABAP 프로그램에서 Container Instance 생성
        (Custom Control과 1:1 연결)
        ──────────────────────────────────────────
        ┌──────────────────────────────┐
        │   Custom Control: CC_ALV     │
        │     ↑                         │
        │     │ container_name = 'CC_ALV'
        │     │
        │   Container Instance          │  ← CL_GUI_CUSTOM_CONTAINER
        └──────────────────────────────┘
        
        STEP 4 - SAP Grid Control 인스턴스 생성 → Container에 탑승
        ──────────────────────────────────────────
        ┌──────────────────────────────┐
        │   Custom Control: CC_ALV     │
        │     ↑                         │
        │   Container Instance          │
        │     ↑                         │
        │   ALV Grid Instance           │  ← CL_GUI_ALV_GRID
        │   (i_parent = container)      │
        └──────────────────────────────┘
        
        STEP 5 - Grid Instance가 내부 테이블을 화면에 그림
        ──────────────────────────────────────────
        ┌──────────────────────────────┐
        │   [ ALV Table Display ]       │
        │   (사용자가 보는 화면)        │
        └──────────────────────────────┘
        
        ```
        
2. 컨테이너(Container) 객체를 위한 참조 변수(Reference Variables)
    1. Reference Variables의 필요성
        1. SAP ALV Grid Control을 화면에 표시하기 위해서는 여러 개의 객체(Object)를 생성해야 한다. 객체를 생성하려면 반드시 해당 객체를 가리킬 **참조 변수(Reference Variable)** 가 필요하다. 참조 변수는 말 그대로 “객체를 가리키는 포인터(주소)” 역할을 한다.
        2. ALV와 Container는 모두 **Object(객체)**이기 때문이다.  객체는 동적으로 메모리에 생성되며, 해당 객체를 사용하려면 그 메모리 주소를 담고 있을 참조 변수가 필요하다.
3. SAP List Viewer (ALV) 실습
    1. 실습 진행 화면
        1. 스크린 200번 Layout →  속성 값 가로 세로 ? r?머시기 2개 체크
            
            ![image.png](attachment:52029a41-4e21-4377-b64a-c861f6f47dfa:image.png)
            
        2. Top Include에서 Reference Variable이랑Container Control Variable 변수 선언하고,  본 프로그램 와서 pbo활성화를 위한 주석 풀고 해당 주석에 잇는 Include클릭해서 저장하고 Active → 본 프로그램 Active →  새로운 Include MZSCR_G01O01 생김 
            
            ```jsx
            * Reference Variable 선언.
            * Container Control Variable.
            DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
                   GO_AVL  TYPE REF TO CL_GUI_ALV_GRID.
            ```
            
        3.   MZSCR_G01O01  내에 GO_CONT( Reference Variable ) 를 통해 Container와 Grid Controld 객체를 만들어야 함.
            
            ![image.png](attachment:c207d85b-2ca7-495f-9f45-9402d1559bb3:image.png)
            
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
            
            "----------------------------------------------------------------------
            " OK_CODE : 스크린에서 버튼을 눌렀을 때 전달되는 Function Code 저장 변수
            " - SY-UCOMM 타입 사용
            " - PAI(User Command) 모듈에서 버튼 이벤트를 이 변수로 받아 처리함
            "----------------------------------------------------------------------
            DATA : OK_CODE TYPE SY-UCOMM.
            
            * Reference Variable 선언.
            * Container Control Variable.
            DATA : GO_CONT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
                   GO_ALV  TYPE REF TO CL_GUI_ALV_GRID.
            
            * Grid control에 표시할 데이터를 할당할 변수(internal table).
            DATA : GT_FLIGHTS TYPE BC400_T_FLIGHTS.
            ```
            
        6. Funtion Module  호출하여 Flight data 가져옴
            
            ![image.png](attachment:f5b34edf-62fb-4370-acba-f9d00de4bf4c:image.png)
            
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
                    i_structure_name = 'SFLIGHT'   "또는 사용 중인 DDIC 구조 이름
                  CHANGING
                    it_outtab        = gt_flights. "ALV에 표시할 내부 테이블
                ```
                
            2. 현재 실습 메소드 호출
                
                ![image.png](attachment:984c5d71-93da-4481-943d-6b755c33daee:image.png)
                
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
                
                ![image.png](attachment:601f6b06-3f98-4657-ab18-31e71de820c3:image.png)
                
                → 지금까지 실습 완료 후 실행 화면 
                
        8. 이후 데이터 변경을 화면에 반영 (오류 개선)
            
            → ALV를 처음 표시한 후, 내부 테이블 데이터가 변경되었을 때 다시 전체를 생성할 필요 없이 화면만 새로 고치는 역할을 한다.
            
            ```jsx
              ELSE.
                CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY
                  EXCEPTIONS
                    FINISHED = 1.
                IF SY-SUBRC <> 0.
            
                ENDIF.
            ```
            
        9. `set_table_for_first_display` 메서드 내에서 `I_STRUCTURE_NAME` 과 `IT_OUTTAB` 에 올 수 있는 값 요약
            
            
            | 항목 | 적용 조건 | 사용 가능 값 | 사용 불가 값 |
            | --- | --- | --- | --- |
            | **I_STRUCTURE_NAME** | DDIC Structure 이름이어야 함IT_OUTTAB 라인트 타입과 동일해야 함 | `SFLIGHT`, `SCARR`, `BC400_S_FLIGHT`, `ZSTRUCT_*` | 내부테이블명, 변수명, 구조 인스턴스, string |
            | **IT_OUTTAB** | Internal Table이어야 함라인타입 구조가 I_STRUCTURE_NAME과 같아야 함 | `TABLE OF sflight`, `TABLE OF bc400_s_flight` | 구조 하나(TYPE sflight), char10 테이블, ANY |

# 🔵 **Unit 3. Web Dynpro ABAP**

1. Web Dynpro ABAP란?
    1. 웹 브라우저에서 동작하는 SAP의 UI 프레임 워크 SAP GUI 화면 대신 **웹 화면**을 만드는 기술
    2. Web Dynpro 기본 구성
        
        ![image.png](attachment:892e6ec4-8e01-403d-bcc2-71c4c3bbf21a:image.png)
        
        ![image.png](attachment:9558840d-73b3-4169-8a14-c439f8faef83:image.png)
        
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
    
    ![image.png](attachment:d3252b08-e33b-4dfc-a966-8a39944475de:image.png)
    
    ![image.png](attachment:6f5acc68-3283-4dd3-bab5-5d3ee7e2df76:image.png)
    
    ![image.png](attachment:6dda22ad-91e6-46b4-849e-8bada2796ae9:image.png)
    
    ![image.png](attachment:b5e9b03d-8201-475a-8406-219cb5a1543a:image.png)
    
    → Context Mapping (Data Element Share 기능) : Context Mapping은 **View ↔ Component Controller** 사이에 데이터를 자동으로 동기화 시키는 기능이다.
    
    ![image.png](attachment:aa3823ea-9b75-454d-b25b-bcab5589435b:image.png)
    
    → Web Dynpro Application 생성
    
    ![image.png](attachment:900d1186-89cc-40a5-a93c-9a04a85e38ff:image.png)
    
    ![image.png](attachment:ddd92732-340c-4f9c-ba89-5d9987047372:image.png)
    
    ![image.png](attachment:56d788e8-221d-4954-b029-4f47ffe99b06:image.png)
    
    ![image.png](attachment:3ae82648-0b88-494a-a906-0eaa8e27c7d8:image.png)
    
    ![image.png](attachment:818f564f-7c9c-4969-8ee6-520cc9ec7d98:image.png)
    
    ![image.png](attachment:a64b88e5-6586-4617-aa4f-30bc55fe9092:image.png)
    
    ![image.png](attachment:61bb830f-46ed-4ac2-a786-9e00cf6753aa:image.png)
    
    ![image.png](attachment:0810b707-3a71-401e-b4f7-094f99f3ac37:image.png)
    
    → Content 눌러서 저장
    
    ![image.png](attachment:48ecd57c-c557-4ce5-9aff-26448597239a:image.png)
    
    ![image.png](attachment:3a72f99b-1cbc-4285-bac5-f46752953db1:image.png)
    
    ![image.png](attachment:5d6d62e4-fe0f-407f-b154-61468e341eb6:image.png)
    
    ![image.png](attachment:f02d68cd-5bb8-4089-abf0-677f0db94d35:image.png)
    
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
    
    *     @TODO handle non existant child
    *     IF lo_nd_nt_data IS INITIAL.
    *     ENDIF.
    
    *    * @TODO compute values
    *    * e.g. call a model function
    *
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
    
    ![image.png](attachment:3fadb684-48e1-44a0-813a-c0e70a1c6a78:image.png)
    
    → 메소드 활성화
    
    ```jsx
    METHOD ONACTIONSEARCH .
    
      WD_COMP_CONTROLLER->GET_FLIGHTS( ).
    
    ENDMETHOD.
    ```
    
    ![image.png](attachment:8ec0b89e-a21a-4f4d-bc90-414082f20934:image.png)
    
    → 실습 완료 화면 
    

- for git
