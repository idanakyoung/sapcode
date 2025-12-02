# 🧭 Lesson 12 -  **Views & Joins & View Cluster & Search Helps & Screen**

# 🔵 **Unit 1. Views & Joins Review**

1. **Views & Joins** 
    1. 성능 관점: OPEN SQL JOIN vs DB View
        
        → ABAP 프로그램에서 JOIN을 직접 작성하는 것보다, ABAP Dictionary(SE11)에서 정적으로 정의한 View를 사용하면 데이터베이스 옵티마이저가 더 효율적으로 처리할 수 있어 성능이 유리할 수 있다. 또한 View는 테이블처럼 바로 SELECT할 수 있어 코드가 단순해지고 재사용성이 높아진다.
        
    2. Maintenance View 생성하는 두 번째 방법
        1. 실습 진행 화면
            
            ![image.png](attachment:5fd23d95-e585-4eb7-b55a-a582b8b414d0:d00219ab-6c65-49d3-ad64-3afd5e8672f6.png)
            
            ![image.png](attachment:b4b6b586-fba5-492c-8623-66073058c8eb:image.png)
            
            ![image.png](attachment:c619ef15-c485-402c-b59e-68b92158765f:image.png)
            
            ![image.png](attachment:46eda21d-7287-41fa-845c-70711b3e2dd4:image.png)
            
            ![image.png](attachment:0074806f-d771-4104-8264-efe4e2062f58:image.png)
            
            ![image.png](attachment:474eac8c-d0d9-4d7e-8dbc-546684a5a1d2:image.png)
            
            ![image.png](attachment:cda8e6b5-9eab-480c-8463-85a9879d4179:image.png)
            
            ![image.png](attachment:8a9ad416-9a47-409c-b6a9-f1cafbf62b32:image.png)
            
            → 저장 버튼 클릭
            
            ![image.png](attachment:98aef3a9-99f1-4244-9dd8-201b5d87d798:image.png)
            
            → New Enties 클릭해서 display에서 새로운 데이터 추가 및 제거 등 수정 가능(저장 필수)
            
            ![image.png](attachment:41cd1710-e2e4-4a44-976d-2040c3922fe0:image.png)
            
            ![image.png](attachment:36b6ca06-d683-4443-9d56-c6f59243e956:image.png)
            
            → 생성 완료
            
        2. 오류 발생 시 : 패키지 내에 객체 안보일 때 클릭
            
            ![image.png](attachment:725de536-6278-4fd7-ae34-cadd1506c952:image.png)
            
        

# 🔵 **Unit 2. View Cluster**

1. View Cluster란?
    1. **View Cluster(트랜잭션: SE54)는 여러 개의 테이블/뷰를 ‘계층 구조’로 묶어서 한 화면에서 편집할 수 있게 해주는 유지보수(Maintenance) 오브젝트**이다. 예를 들어, **헤더 테이블 + 아이템 테이블**을 함께 관리해야 할 때 하나의 유지보수 화면으로 처리할 수 있게 해준다.
2. View Cluster 구성 요소
    1. View/테이블
    2. Hierarchy(계층 구조)
    3. Maintenance Dialog
    4. Events (Optional)
3. View Cluster의 두 가지 핵심 장점
    1. Navigation(네비게이션)
        1. View Cluster는 테이블 간 **부모–자식 관계를 계층 구조로 보여주기 때문에**, 사용자가 데이터를 탐색할 때 자연스럽게 이동할 수 있다. 예를 들어 SCARR(항공사) → SPFLI(노선) → SFLIGHT(비행편) 같은 구조를 한 화면에서 손쉽게 위아래로 이동하며 조회・수정할 수 있다.
    2. Consistency(일관성)
        1. View Cluster는 관련된 모든 테이블을 하나의 유지보수 프로세스에서 처리하므로, **데이터 간의 관계(Referential Integrity)와 입력 규칙이 일관되게 유지된다.** 헤더를 저장하면 아이템도 올바르게 종속되도록 관리되고, 잘못된 구조(헤더 없는 아이템 등)가 발생하지 않는다.

# 🔵 **Unit 3. Search Helps**

1. Search Help란?
    1. **Search Help는 사용자가 필드 값을 쉽게 찾도록 도와주는 검색 창(Popup) 기능**이다. 예: 고객 번호, 자재 코드, 공장 코드처럼 직접 기억하기 어려운 값을 리스트로 검색하여 선택하게 해주는 SAP 표준 UX 요소
    2. Search Help는 사용자가 필드 값을 쉽게 찾도록 도와주는 **표준 검색 팝업 기능**이며, Elementary/Collective 형태로 만들어 재사용할 수 있다. 데이터 요소에 연결하면 여러 프로그램에서 동일한 검색 UX를 적용할 수 있어 **입력 편의성과 데이터 정확성이 크게 향상**된다.
    3. 실습 화면
        
        ![image.png](attachment:1e936872-4797-4ec3-899f-43a73da09814:image.png)
        
    4. 스크린에서 레이아웃 ( Screen Painter )
        1. Screen Painter에 직접 Search Help 연결하는 방식 (비추천 ❌)
        
        그림 오른쪽의 Screen Painter는 Dynpro 화면을 의미합니다.
        
        - Screen Painter에서도 Search Help를 **직접 연결하는 기능은 있음**
        - 그러나 이 방식은 재사용성이 떨어지고, Dictionary 변경 시 동기화 문제가 생길 수 있어 **SAP에서 권장하지 않음**
        
        ![image.png](attachment:8ba6cf66-f162-491e-a213-8f9d755b23c6:image.png)
        
    5. Search Help를 연결할 수 있는 위치
        1. Data Element (데이터 요소) — 가장 권장 
            
            ![image.png](attachment:6a685f2d-1245-4a45-9ac9-2258a35f2604:image.png)
            
        2. Table 필드 / Structure 필드
            
            ![image.png](attachment:8fcc2d63-bae8-456b-aa36-52f031de4d9a:image.png)
            
        3. **Check Table(체크 테이블)**
2. Selection Method란?
    1. Search Help가 어떤 테이블 또는 View에서 데이터를 가져와서 F4 검색 팝업을 구성할지 결정하는 핵심 속성
    2. Selection Method의 역할
        1. F4 팝업에서 보여줄 데이터의 “출처” 결정
        2. Search Help Parameter(입력/출력 필드)의 기준이 됨
3. Search Help 생성 실습1
    1. 실습 진행 화면
        
        ![image.png](attachment:e6e8dad8-3c24-4ae7-9da2-608ec127acd4:image.png)
        
        ![image.png](attachment:ae77ffbc-8b74-4daa-be54-e7d84e99e490:image.png)
        
        1) 방법 1
        
        ![image.png](attachment:472207cb-cd7e-41dc-a309-05e860aca683:image.png)
        
        ![image.png](attachment:e186a08f-c39d-4296-8aa5-1ed9e9bdf4ec:image.png)
        
        → 생성 완료
        
        ![image.png](attachment:df0ca3f9-7e47-42f0-9a2c-09ae4c7c4ebb:image.png)
        
        → 생성 완료 후 Search Help 확인
        
        2) 방법 2
        
        ![image.png](attachment:98c63c71-485e-4eab-8317-8c13cffef448:image.png)
        
        ![image.png](attachment:20317a2c-2b62-48cf-be7a-4d7bb54296f5:image.png)
        
        3) 방법 3
        
        ![image.png](attachment:4d3fc0bf-a344-4723-a74c-981173da332b:image.png)
        
        ![image.png](attachment:4ec0512c-5137-4070-853a-0be016e72ebe:image.png)
        
        - List Position 숫자가 없다면 Display Ui는 ?
            
            ![image.png](attachment:7b991ac0-4dc1-4b83-8d9a-f9789c6700d3:image.png)
            
            ![image.png](attachment:2ca8fac0-6b8e-45f7-b570-23c9066f6e18:image.png)
            
        - List Position 숫자가 더 높아지면?
            
            ![image.png](attachment:eb00472f-1b7e-4959-9912-10a8642bae59:image.png)
            
            ![image.png](attachment:9a34970b-9674-4bdf-9e6a-7cb162665998:image.png)
            
        - Selection Position 숫자가 없다면 Display Ui는 ?
            
            ![image.png](attachment:36e4f149-6683-43a9-9e6c-40d30b1bd3be:image.png)
            
            ![image.png](attachment:a3512341-0ed2-4991-8f97-1f5531e85729:image.png)
            
4. Search Help 생성 실습 2
    1. 실습 진행 화면
        
        ![image.png](attachment:d4a749be-d8cb-4517-8906-5af60769717a:image.png)
        
        → 구조체 만들기 (ZSEMPLOY_G01)
        
        ![image.png](attachment:b0795666-665a-40b3-a16b-59688c370dc8:image.png)
        
        ![image.png](attachment:a473214b-d2e0-424f-9a03-1bda589b9b83:image.png)
        
        → Search Help 버튼 누르고 저장
        
        ```abap
        REPORT ZABAP_22_G01.
        
        PARAMETERS: PA_CLS TYPE S_CLASS VALUE CHECK.
        
        PARAMETERS PA_CAR TYPE BC400_S_FLIGHT-CARRID.
        PARAMETERS PA_EMP TYPE ZEMPLOYG01-EMP_NUM.
        PARAMETERS PA_EMP2 TYPE ZSEMPLOY_G01-EMP_NUM.
        PARAMETERS PA_ID TYPE ZSCUSTOMER_G01-ID
            MATCHCODE OBJECT ZSHCUSTOM_G01.
        PARAMETERS PA_EMP3 TYPE ZEMPNUMG01.
        
        WRITE: 'Class : ', PA_CLS.
        ```
        
        → 프로그램 내 코드
        
        ![image.png](attachment:f8c59d6c-2ded-41b3-97ed-cdc5d5c03141:image.png)
        
        → 결과
        
5. SAP HANA 이후에 추가된 *고급 검색 기능*
    1. Autosuggest in Input Fields
        
        **: 입력창에 글자를 치는 순간 즉시 제안 목록이 자동으로 뜨는 기능**
        
    2. Multi-column full text search (database-specific)
        
        **: 서치헬프의 여러 필드(컬럼) 전체를 “풀 텍스트 검색”하는 기능**
        
        ![image.png](attachment:4cf63f8b-4e9b-44df-8b5a-a0b629fa24e1:image.png)
        
        ![image.png](attachment:f73331b6-0f19-4118-b155-170f7959333d:image.png)
        

# 🔵 **Unit 4. Screen**

1. Screens and Program Types
    1. Executable program (Report)
        1. REPORT 타입 프로그램에서도 스크린을 사용할 수 있다.
        - 용도
            - 리스트 대신(또는 리스트 위에) 별도의 스크린을 띄워 데이터를 보여주거나
            - 리스트의 일부를 더 상세히 보여주기 위해 스크린을 사용할 수 있다.
        - 하지만 재사용성과 캡슐화를 위해, SAP에서는
            - 리포트에서 직접 스크린을 많이 만드는 것보다
            - 스크린은 따로 Function Group에 두고, 리포트에서 그 스크린을 사용하는 방식을 더 권장한다.
    2. Function group
        1. Function group 안에는 Function module들과 이들과 연결된 screens / screen sequence를 함께 넣을 수 있다. 스크린은 Dialog Transaction을 통해 접근할 수 있고, Function module 코드 안에서 `CALL SCREEN` 문으로 시작할 수도 있다.
        - SAP 권장사항
            - 재사용성과 캡슐화를 위해 스크린과 스크린 시퀀스를 Function Group에 만들어두고,
            - 필요할 때마다 다양한 프로그램/트랜잭션에서 기능모듈을 통해 재사용하는 방식이 좋다고 한다.
    3. Module pool
        1. Module pool 프로그램도 Dialog Transaction에서만 호출된다.
        2. 이름은 SAPMZ 또는 SAPMY로 시작
            - Function group과 달리,
                - Module pool 안의 스크린은 “외부 인터페이스”가 잘 정리된 형태로 사용되기 어렵다.
                - 스크린들을 별도의 기능 모듈로 캡슐화하는 구조가 아니기 때문
            - 그래서 SAP는 새로운 스크린 개발 시 직접 module pool을 늘리기보다는, Function group을 활용해 재사용 가능한 스크린 시퀀스를 만드는 것을 좀 더 선호한다고 설명한다
    4. Screens 가능 Program Type 비교 표
    
    | Program Type | 스크린 사용 가능 여부 | 특징 요약 | SAP 권장도 |
    | --- | --- | --- | --- |
    | **Executable Program (REPORT)** | 가능하지만 제한적 | 리스트 출력 기반 프로그램에서 스크린을 띄울 수 있음. `CALL SCREEN` 사용 가능. 하지만 직접 스크린을 넣으면 재사용성이 떨어짐. | ⚠️ 권장하지 않음 |
    | **Function Group (FG)** | 가능 (권장) | Function Module + Screen + Screen Sequence를 하나로 묶어 캡슐화 가능. 재사용성이 매우 높고 화면 로직을 기능 모듈로 감싸는 구조가 명확함. | ✅ SAP 권장 |
    | **Module Pool (Type M)** | 가능 | 이름은 SAPMZ 또는 SAPMY로 시작 | ⚠️ 완전 비추천은 아니나 FG보다 낮음 |
    | **기타(Include, Class Pool 등)** | 불가 | UI 적용 목적 아님. 스크린 생성 불가. | ❌ 해당 없음 |
2. Screen Painter란?
    1. Screen Painter는 SAP GUI에서 **Dynpro(Screen)** 을 만들고 편집하기 위한 UI 개발 도구이다. SE51 또는 프로그램 내부의 Screen Editing 기능을 통해 접근한다. (SAP 전통 UI 개발 도구)
    2. Screen Painter의 주요 구성
        1. Properties (스크린 속성)
        2. Layout Editor (그래픽 레이아웃 화면)
        3. Element List
        4. Flow Logic
    3. 프로그램 includes(예: TOP, O01, I01)에 MODULE 구현
3. Components of a Screen (스크린 구성 요소)
4. Graphical Layout Editor
5. **Module Pool** 실습
    1. **Module Pool 은 TOP Include 해야 함**
        1. 실습 진행 화면
            
            ![image.png](attachment:57b6b215-826c-42f2-a0a2-27066f6417fa:image.png)
            
            → 명명 규칙 : 실습코드에서 SAP 글자만 지우고 뒤 붙여 넣기 + TOP
            
            ![image.png](attachment:782374b9-8724-48d3-88a4-8820c25899e2:image.png)
            
            ![image.png](attachment:b307303f-95fd-45cf-a492-e049887b0400:image.png)
            
            ![image.png](attachment:45425a34-3836-4947-90ec-3673912ca2fa:image.png)
            
            ![image.png](attachment:5b80b386-4b12-4118-b75c-1ab41dff3c00:image.png)
            
            ![image.png](attachment:300b95c9-4245-4b9b-b793-e1f4ddbdcce1:image.png)
            
            ![image.png](attachment:562d2ef5-50f6-4a84-b7bc-4157191ca3c8:image.png)
            
            → 번호 200의 스크린도 만들기
            
            ![image.png](attachment:f07797d6-cf61-4fcc-bd37-84f0aeb5ae2d:image.png)
            
            ```abap
            *&---------------------------------------------------------------------*
            *& Include          MZSCR_G01I01
            *&---------------------------------------------------------------------*
            *&---------------------------------------------------------------------*
            *&      Module  USER_COMMAND_0100  INPUT
            *&---------------------------------------------------------------------*
            *       text
            *----------------------------------------------------------------------*
            MODULE USER_COMMAND_0100 INPUT.
            * 버튼 클릭시 버튼에 설정된 Function code가
            * ok_code에 전달됨.
              CASE OK_CODE.
                WHEN 'GO'.
            * Function Code가 GO이면 200번 스크린으로 이동.
                  SET SCREEN 200.
              ENDCASE.
            ENDMODULE.
            *&---------------------------------------------------------------------*
            *&      Module  USER_COMMAND_0200  INPUT
            *&---------------------------------------------------------------------*
            *       text
            *----------------------------------------------------------------------*
            MODULE USER_COMMAND_0200 INPUT.
            * 버튼 클릭시 버튼에 설정된 Function code가
            * ok_code에 전달됨.
              CASE OK_CODE.
                WHEN 'BACK'.
            * Function Code가 BACK이면 100번 스크린으로 이동.
                  SET SCREEN 100.
                WHEN 'EXIT'.
            * Function Code가 BACK이면 프로그램 시작한 곳으로 이동.
                  SET SCREEN 0.
              ENDCASE.
            ENDMODULE.
            ```
            
            ![image.png](attachment:207d8726-b720-45d8-b134-5f76fe691b75:image.png)
            
            ![image.png](attachment:2ed180ee-3840-4d2c-ad07-68c44267b121:image.png)
            
            → 실행 화면
