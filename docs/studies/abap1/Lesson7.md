# 🧭 Lesson 7 - ABAP Internal Table & **Data Modeling and Data Retrieval**

# 🔵 **Unit 1. Internal Table** 복습 ****

1. **Internal Table (내부 테이블)**
    1. 개념 정리
        1. Structure Type (구조 타입) 
            
            ```jsx
            = 설계도
            ts_flight
             ├─ carrid
             ├─ connid
             ├─ fldate
             ├─ seatsmax
             └─ seatsocc
            ```
            
            1. ts_flight - 학생 1명의 정보 설계도 (이름, 나이, 학번…)
        2. Structure Variable / Work Area (구조 변수 / 워크에어리어)
            
            ```jsx
            = 설계도로 만든 한 줄짜리 실제 공간
            [ gs_itab2 ]
             carrid:    ___
             connid:    ___
             fldate:    ___
             seatsmax:  ___
             seatsocc:  ___
            ```
            
            1. gs_itab2 - 학생 1명을 실제로 담는 **1줄짜리 공간**
        3. Internal Table Type(내부 테이블 타입)
            
            ```jsx
            여러 줄 저장할 테이블의 설계도
            = itab4
             ┌──────────────────────────┐
             │ row1: ts_flight 구조     │  
             ├──────────────────────────┤
             │ row2: ts_flight 구조     │  
             ├──────────────────────────┤
             │ row3: ts_flight 구조     │  
             └──────────────────────────┘
            ```
            
            1. itab4 - 학생 여러 명을 저장하는 **연속된 리스트(내부 테이블)**
        4. Internal Table (내부 테이블)
            1. 여러 줄 저장하는 실제 데이터 집합
            2. itab4 - 학생 여러 명을 저장하는 **연속된 리스트(내부 테이블)**
    2. 실습 코드 정리
        1. 코드
            
            ```jsx
            *&---------------------------------------------------------------------*
            *& Report ZABAP_15_G01
            *&---------------------------------------------------------------------*
            *&
            *&---------------------------------------------------------------------*
            REPORT ZABAP_15_G01.
            
            * Local Table type 선언.
            TYPES tt_flight TYPE STANDARD TABLE OF bc400_s_flight
                            WITH NON-UNIQUE KEY carrid connid fldate.
            
            * Local Structure data type 선언.
            TYPES: BEGIN OF ts_flight,
                     carrid     TYPE s_carr_id,
                     connid     TYPE s_conn_id,
                     fldate     TYPE s_date,
                     seatsmax   TYPE s_seatsmax,
                     seatsocc   TYPE s_seatsocc,
                     percentage TYPE p LENGTH 3 DECIMALS 2,
                   END OF ts_flight.
             
            * Internal Table 선언. - Global Table Type.
            DATA: itab1 TYPE bc400_t_flights,
            *     - local table type.
                  itab2 TYPE tt_flight,
            *     - global structure data type.
                  itab3 TYPE TABLE OF bc400_s_flight,
            *     - local structure data type.
                  itab4 TYPE TABLE OF ts_flight.
            
            * Structure variable (work area) 선언.
            * Global Structure data type.
            DATA: gs_itab1 TYPE bc400_s_flight,
            *     Local Structure data type.
                  gs_itab2 TYPE ts_flight,
            *     Gobal Table type.
                  gs_itab3 TYPE LINE OF bc400_t_flights,
            *     Local Table type.
                  gs_itab4 TYPE LINE OF tt_flight,
            *     Internal table.
                  gs_itab5 LIKE LINE OF itab1.
            
            * Internal Table 선언.
            * Structure variable.
            DATA: itabt Like TABLE OF gs_itab5.
            ```
            
        2. 개념
            1. Structure Type(구조 타입)
                
                ```
                TYPES: BEGIN OF ts_flight,
                         carrid     TYPE s_carr_id,
                         connid     TYPE s_conn_id,
                         fldate     TYPE s_date,
                       END OF ts_flight.
                
                ```
                
                - 데이터 모양(틀, 설계도)을 정의하는 것
                - 실제 값 저장 ❌
                - 단지 “이런 필드를 가진 구조체가 필요해!” 라는 선언
                - 구조 타입은 **설계도(blueprint)**
            2. Structure Variable = Work Area (워크에어리어)
                
                ```
                DATA gs_itab2 TYPE ts_flight.
                
                ```
                
                - Structure Type을 기반으로 만든 **실제 데이터 한 줄짜리 구조체**
                - 내부 테이블에 넣기 위해 “작업하는 공간”
                - 값을 읽고 쓰는 진짜 변수
                - Work Area = **구조 타입으로 만든 한 줄짜리 실제 데이터 공간**
            3. Internal Table Type(내부 테이블 타입)
                
                ```
                TYPES tt_flight TYPE STANDARD TABLE OF bc400_s_flight
                                WITH NON-UNIQUE KEY carrid connid fldate.
                
                ```
                
                - **내부 테이블의 모양을 정의**하는 타입
                - 필드 구조 + 키 정보 + 정렬 방식까지 포함 가능
                - 테이블 자체의 설계도
                - Internal Table Type = **여러 줄 저장하는 테이블의 설계도**
            4. Internal Table (내부 테이블)
                1. 선언 방법 4가지
                    
                    ### 1) **Global Table Type 사용**
                    
                    ```
                    DATA itab1 TYPE bc400_t_flights.
                    
                    ```
                    
                    ### 2) **Local Table Type 사용**
                    
                    ```
                    DATA itab2 TYPE tt_flight.
                    
                    ```
                    
                    ### 3) **구조 타입에서 직접 TABLE OF**
                    
                    ```
                    DATA itab3 TYPE TABLE OF bc400_s_flight.
                    
                    ```
                    
                    ### 4) **로컬 구조 타입 TABLE OF**
                    
                    ```
                    DATA itab4 TYPE TABLE OF ts_flight.
                    
                    ```
                    
                    📌 Internal Table = **같은 구조의 데이터 여러 줄(row)을 저장하는 집합**
                    

# 🔵 **Unit 2. Data Modeling and Data Retrieval : Open SQL**

1. ABAP Dictionary Basics
    1. ABAP Dictionary란
        1. SAP 시스템에서 데이터 구조(테이블/필드/뷰/타입)를 관리하는 중앙 저장소
        2. 역할
            1. 데이터 타입 관리 / 테이블 구조 관리 / 개발자/프로그램이 동일한 구조를 공유 / 자동으로 DB와 싱크 / 성능 관리(Buffering) 지원
    2. Domain (도메인) 
        1. **기술적 정의 (타입, 길이)**
    3. Data Element (데이터 요소) 
        1.  **의미 정의 (라벨, 텍스트)**
    4. Table (테이블)
        1.  **데이터 저장 구조**
            
            
            | 종류 | 설명 |
            | --- | --- |
            | **Transparent Table** | DB 테이블과 1:1 매칭(대부분 이거) |
            | Pooled Table | 여러 테이블이 한 DB 테이블에 모임 |
            | Cluster Table | 여러 테이블이 한 DB 클러스터에 저장 |
        2. 테이블 주요 구성 요소
            - **Fields**
            - **Primary Key**
            - **Foreign Key**
            - **Technical Settings** (Buffering 등)
            - **Indices**
            - **Search Help** 연결
    5. Views 
        1. **가상 테이블/조회 구조**
        2. 종류
            
            
            | 종류 | 설명 |
            | --- | --- |
            | **Database View** | SELECT-Join 기반 DB View |
            | **Projection View** | 일부 필드만 노출 |
            | **Maintenance View** | 하나 이상 테이블을 화면에서 유지보수 |
            | **Help View** | 검색헬프 전용 View |
2. Database Tables
    1. Transparent Table (투명 테이블)
        1. DB의 테이블 = SAP의 테이블 (1:1) 동일
        2. 특징
            - SAP Dictionary와 DB가 똑같이 매핑
            - Open SQL로 CRUD 가능
            - 표준/커스텀 테이블 대부분이 이 타입
            - S/4HANA에서는 사실상 이것만 중요
        3. Structure Type = 데이터 형식(틀, 설계도)과 유사하지만 다름
    2. Primary Key & Foreign Key
        1. Primary Key (기본키)
            
            테이블을 고유하게 식별하는 필드들.
            
            예: SFLIGHT
            
            ```
            CARRID  (항공사)
            CONNID  (항공편)
            FLDATE  (출발일자)
            ```
            
            →  이 세 개가 **PK(기본키)** → 한 줄(row)을 유일하게 보장
            
        2. Foreign Key (참조키)
            
            다른 테이블의 Primary Key를 참조하는 필드.
            
            예:
            
            ZBOOKING 테이블에
            
            ```
            CARRID  → SFLIGHT.CARRID
            CONNID  → SFLIGHT.CONNID
            ```
            
            → 이렇게 걸어두면, 데이터 무결성이 유지됨 (없는 항공사 예약 불가)
            
3. Open SQL(Data Retrieval)
    1. SELECT 기본 구조
        1. 구조
            
            ```jsx
            SELECT <필드 리스트>
              FROM <테이블/뷰>
              WHERE <조건>
              INTO [TABLE] <저장할 대상>
              ORDER BY <필드>.
            
            -----------------------------
            
            ┌──────────────────────────────────────────┐
            │ SELECT carrid connid fldate seatsocc     │  ← 가져올 필드들
            ├──────────────────────────────────────────┤
            │ FROM sflight                             │  ← 어떤 테이블에서?
            ├──────────────────────────────────────────┤
            │ WHERE carrid = 'AA'                      │  ← 조건
            ├──────────────────────────────────────────┤
            │ INTO TABLE lt_flight                     │  ← 저장할 곳
            ├──────────────────────────────────────────┤
            │ ORDER BY fldate                          │  ← 정렬
            └──────────────────────────────────────────┘
            ```
            
        2. 상세 구조 설명
            1. SELECT <필드 리스트>
                1. DB에서 어떤 컬럼 가져올지 지정하는 부분
                    
                    예:
                    
                    ```
                    SELECT carrid connid fldate seatsocc
                    ```
                    
                2. 절대 SELECT * 쓰지 않기
                    - 성능 저하
                    - 네트워크/메모리 낭비
                    
                    필요한 필드만 SELECT 하는 것이 **Open SQL Best Practice 1번 규칙**
                    
            2. FROM <테이블명 / 뷰>
                1. 어디서 데이터를 가져올지 지정
                    
                    예:
                    
                    ```
                    FROM sflight
                    ```
                    
                    또는 JOIN도 여기서 지정:
                    
                    ```
                    FROM sflight AS a
                    JOIN scarr   AS b
                      ON a~carrid = b~carrid
                    ```
                    
            3. WHERE <조건>
                1. DB에서 가져올 데이터를 필터링하는 핵심 부분.
                    
                    예:
                    
                    ```
                    WHERE carrid = 'AA'
                      AND seatsocc > 100
                    ```
                    
                    지원 연산자:
                    
                    - =, <>, <, >, <=, >=
                    - BETWEEN
                    - LIKE
                    - IN (값 리스트)
                    - IS NULL
                    
                    → WHERE 절이 강할수록 성능이 좋아짐
                    
            4. INTO <저장할 곳>
                1. SELECT 결과를 **ABAP 변수나 내부 테이블에 저장**하는 부분.
                
                ① INTO 구조체 (한 줄씩)
                
                ```
                INTO ls_flight
                ```
                
                ② INTO TABLE 내부테이블 (여러 줄)
                
                ```
                INTO TABLE lt_flight
                ```
                
                → 이게 가장 많이 쓰는 패턴
                
            5. ORDER BY <정렬>
                1. 결과를 정렬하려면 ORDER BY 사용.
                
                ```
                ORDER BY carrid connid fldate
                ```
                
                - 정렬 기준이 없으면 DB가 임의 순서로 보내서 실행마다 순서 다를 수 있음.
    2. “ABAP 프로그램 ↔ Transparent Table ↔ 데이터베이스” 상호작용 원리
        1. 구조 및 순서 : ABAP 코드(SELECT) → SAP Open SQL 엔진 → DB SQL로 변환 → DB 실제 조회 → ABAP로 결과 반환
            
            ```jsx
            [1] ABAP SELECT 작성
                   │
                   ▼
            [2] SAP Open SQL 엔진
               - 테이블 구조 확인
               - 인덱스 최적화
               - SQL 변환 준비
                   │
                   ▼
            [3] Native SQL로 변환
               (HANA / Oracle / MSSQL SQL)
                   │
                   ▼
            [4] DB에서 실제 데이터 조회
                   │
                   ▼
            [5] 결과를 SAP 내부 테이블로 전달
                   │
                   ▼
            [6] ABAP에서 LOOP, 처리, 출력
            
            ```
            
        2. ABAP 프로그램은 DB를 직접 건드리는 게 아니라, Open SQL을 통해 SAP가 DB를 조정하고 결과만 개발자에게 준다.
    3. 실습 1
        1. Function Module 생성 (Z_GET_CARRIER_G01)
            
            ![image.png](attachment:d626ecbd-7901-44f8-912f-966afbd944fd:image.png)
            
        2. 인터페이스 정의
            
            ![image.png](attachment:1063edf5-6938-4e6c-a349-8dec9f121641:image.png)
            
            ![image.png](attachment:04596124-70a5-4b1b-86ea-1e4bd55a1e73:image.png)
            
            ![image.png](attachment:06e2852a-6ce3-4762-80c8-1bc304272624:image.png)
            
        3. 함수 모듈 안에 SQL 작성하기
            
            ![image.png](attachment:561574a0-9450-4b73-badc-de5899dd5e8e:image.png)
            
        4. 코드
            
            ```jsx
            FUNCTION Z_GET_CARRIER_G01.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  SCARR-CARRID
            *"  EXPORTING
            *"     REFERENCE(ES_CARRIER) TYPE  SCARR
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
            
            * DB Table에서 데이터 읽기. 1건의 데이터.
            *  SELECT SINGLE *
              SELECT SINGLE CURRCODE URL
                  FROM SCARR
            *    INTO ES_CARRIER "이렇게 하면 필드명이랑 안맞는 데이터가 들어감.
                  INTO CORRESPONDING FIELDS OF ES_CARRIER " 그래서 이렇게 해야 동일명 필드와 데이터가 할당됨.
                  WHERE CARRID = IV_CARRID.
            
              IF SY-SUBRC <> 0.
                RAISE NO_DATA.
              ENDIF.
            
            ENDFUNCTION.
            ```
            
    4. 실습 2
        1. 프로그램 생성
            
            ![image.png](attachment:205d7f0a-4dd0-4cef-a319-1d8794c221b9:image.png)
            
        2. 코드
            
            ```jsx
            *&---------------------------------------------------------------------*
            *& Report ZABAP_16_G01
            *&---------------------------------------------------------------------*
            *&
            *&---------------------------------------------------------------------*
            REPORT ZABAP_16_G01.
            
            * DB Table에서 읽어온 데이터 할당할 변수 선언.
            DATA GS_CARRIER TYPE SCARR.
            
            * Selection Screen
            PARAMETERS PA_CAR TYPE SCARR-CARRID.
            
            * DB Table에서 데이터 read.
            SELECT SINGLE CARRID CARRNAME
                          CURRCODE URL
            INTO CORRESPONDING FIELDS OF GS_CARRIER
            FROM SCARR
            WHERE CARRID = PA_CAR.
            
            * DB Table에서 읽어온 데이터 화면에 표시.
            WRITE: GS_CARRIER-CARRID,
                   GS_CARRIER-CARRNAME,
                   GS_CARRIER-CURRCODE.
            ```
            
        3. 참고 사항
            1. Fron 절이랑 Into 절 순서 바뀌어도 상관없음
    5. 실습 3 - p.309 Exercise 16
        1. Function Group(zbc400_g##) 만들고 Function Module(Z_bc400_CONNECTION_GET_) 만들기 
            
            ![image.png](attachment:1e4f19d8-d004-4974-a7ba-4cb7f81f68b6:image.png)
            
        2. 인터페이스 정의
            
            ![image.png](attachment:acffa4ef-f2f7-49ee-a718-d3d229a81c4e:image.png)
            
            ![image.png](attachment:3f4c759a-3bba-44fb-8bcb-4bf4c11add2c:image.png)
            
            ![image.png](attachment:b9065606-a1f4-4c82-bfc7-75aeb0843e9b:image.png)
            
        3. 함수 모듈 안에 SQL 작성하기
            
            ![image.png](attachment:46aa0145-3110-468d-b8fd-a98ab725dd6a:image.png)
            
        4. 코드
            
            ```jsx
            FUNCTION Z_BC400_G01_CONNECTION_GET.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
            *"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
            *"  EXPORTING
            *"     REFERENCE(ES_CONNECTION) TYPE  BC400_S_CONNECTION
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
              SELECT SINGLE CARRID CONNID CITYFROM AIRPFROM
                            CITYTO AIRPTO FLTIME DEPTIME ARRTIME "방법1
            * SELECT SINGLE *    "방법2
            
                FROM SPFLI
                INTO ES_CONNECTION "방법1
            *   INTO CORRESPONDING FIELDS OF ES_CONNECTION  "방법2
                WHERE CARRID = IV_CARRID
                  AND CONNID = IV_CONNID.
            
              IF SY-SUBRC <> 0.
                RAISE NO_DATA.
              ENDIF.
            
            ENDFUNCTION.
            ```
            
    6. 실습 4
        1. Function Group(zfunc_grp_g01)안에서 Function Module(Z_GET_FLIGHT_G01) 만들기 
        2. 인터페이스 정의
            
            ![image.png](attachment:19dbc132-add0-4ee1-86d7-b7fa144bc978:image.png)
            
            ![image.png](attachment:82c03025-cb24-467b-8c48-cb0e5b15e61d:image.png)
            
            ![image.png](attachment:bbb2aba4-9d9a-456b-aaeb-b90832a24099:image.png)
            
        3. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            FUNCTION Z_GET_FLIGHT_G01.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  S_CARRID
            *"  EXPORTING
            *"     REFERENCE(ET_LIST) TYPE  BC400_T_CONNECTIONS
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
            
            * Work Area (Structure Variable) 선언. "방법 3가지
              DATA LS_LIST LIKE LINE OF ET_LIST. "방법 1
            * DATA ls_list TYPE LINE OF BC400_t_connections. "방법 2
            * DATA ls_list TYPE BC400_s_connections. "방법 3
            
            *  SELECT
            *    INTO CORRESPONDING FIELDS OF LS_LIST
            *    FROM SPFLI
            *    WHERE CARRID = IV_CARRID.
            *
            *    APPEND LS_LIST TO ET_LIST.
            *
            *  ENDSELECT.
            
            * Array fetch
              SELECT *
                INTO CORRESPONDING FIELDS OF TABLE ET_LIST
                FROM SPFLI
                WHERE CARRID = IV_CARRID.
            
            ENDFUNCTION.
            ```
            
        4. 결과 
            
            ![image.png](attachment:32ca94f8-f41f-42e7-9b36-5b6e92058107:image.png)
            
    7. 실습 5 - p.317 Exercise 17
        1. Function Group(zfunc_grp_g01)안에서 Function Module(Z_BC400_G01_FLIGHTLIST_GET) 만들기 
        2. 인터페이스 정의
            
            ![image.png](attachment:c9765b3c-558c-436f-b8d6-919d67271523:image.png)
            
            ![image.png](attachment:fcb2d2be-c21b-43cf-bad2-1992baedaccb:image.png)
            
            ![image.png](attachment:2a0a935c-21c6-41c1-9554-c5a17881cd8e:image.png)
            
        3. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            FUNCTION Z_BC400_G01_FLIGHTLIST_GET.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  BC400_S_FLIGHT-CARRID
            *"     REFERENCE(IV_CONNID) TYPE  BC400_S_FLIGHT-CONNID
            *"  EXPORTING
            *"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
            
              DATA LS_FLIGHT TYPE BC400_S_FLIGHT.
            
              REFRESH ET_FLIGHTS.
            
            * DB Table에서 데이터 read.
              SELECT CARRID CONNID FLDATE SEATSMAX SEATSOCC
                FROM SFLIGHT
                INTO LS_FLIGHT
                WHERE CARRID = IV_CARRID
                  AND CONNID = IV_CONNID.
                LS_FLIGHT-PERCENTAGE = LS_FLIGHT-SEATSOCC / LS_FLIGHT-SEATSMAX * 100.
                APPEND LS_FLIGHT TO ET_FLIGHTS.
              ENDSELECT.
            
              IF SY-SUBRC <> 0.
                RAISE NO_DATA.
              ELSE.
                SORT ET_FLIGHTS BY PERCENTAGE DESCENDING.
              ENDIF.
            
            ENDFUNCTION.
            ```
            
    8. 실습 6 - p.325 Exercise 18
        1. Module(Z_BC400_G01_FLIGHTLIST_GET) 모듈 복사해서 Module(Z_BC400_G01_FLIGHTLIST_GET_OPT) 만들기 
        2. 인터페이스 정의 → copy 라 넘어가기 
        3. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            FUNCTION Z_BC400_G01_FLIGHTLIST_GET_OPT.
            *"--------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  BC400_S_FLIGHT-CARRID
            *"     REFERENCE(IV_CONNID) TYPE  BC400_S_FLIGHT-CONNID
            *"  EXPORTING
            *"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
            *"  EXCEPTIONS
            *"      NO_DATA
            *"--------------------------------------------------------------------
            
              DATA LS_FLIGHT TYPE BC400_S_FLIGHT.
            
            * DB Table에서 데이터 read.
            *  SELECT CARRID CONNID FLDATE SEATSMAX SEATSOCC
            *    FROM SFLIGHT
            *    INTO LS_FLIGHT
            *    WHERE CARRID = IV_CARRID
            *      AND CONNID = IV_CONNID.
            *
            *    LS_FLIGHT-PERCENTAGE = LS_FLIGHT-SEATSOCC / LS_FLIGHT-SEATSMAX * 100.
            *
            *    APPEND LS_FLIGHT TO ET_FLIGHTS.
            *  ENDSELECT.
            
              SELECT CARRID CONNID FLDATE SEATSMAX SEATSOCC
                FROM SFLIGHT
                INTO TABLE ET_FLIGHTS
                WHERE CARRID = IV_CARRID
                  AND CONNID = IV_CONNID.
            
              IF SY-SUBRC <> 0.
                RAISE NO_DATA.
              ELSE.
            
                LOOP AT ET_FLIGHTS INTO LS_FLIGHT.
                  LS_FLIGHT-PERCENTAGE =
                  LS_FLIGHT-SEATSOCC / LS_FLIGHT-SEATSMAX * 100.
                  MODIFY ET_FLIGHTS
                  FROM LS_FLIGHT
                  INDEX SY-TABIX
                  TRANSPORTING PERCENTAGE.
                ENDLOOP.
            
                SORT ET_FLIGHTS BY PERCENTAGE DESCENDING.
            
              ENDIF.
            
            ENDFUNCTION.
            ```
            
    9. 실습 7 - Z_GET_FREESEATS_G01
        1. Module(Z_GET_FREESEATS_G01) 모듈 만들기 
        2. 인터페이스 정의 
            
            ![image.png](attachment:7f1c9797-944c-4ef2-8f56-138d4df844ad:image.png)
            
            ![image.png](attachment:d25d2aa1-73ca-4093-bfb6-be574595a654:image.png)
            
            ![image.png](attachment:1fdf675f-2f9e-4fe9-910d-5f2570617d0c:image.png)
            
        3. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            FUNCTION Z_GET_FREESEATS_G01.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  ZBC400_S_SEATS-CARRID
            *"     REFERENCE(IV_CONNID) TYPE  ZBC400_S_SEATS-CONNID
            *"  EXPORTING
            *"     REFERENCE(ET_SEATS) TYPE  ZBC400_T_SEATS
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
            
              DATA LS_SEAT TYPE ZBC400_S_SEATS.
            
              REFRESH ET_SEATS.
            
            *  "row-by-row 방식.
            *  SELECT CARRID CONNID FLDATE SEATSMAX SEATSOCC
            *    FROM SFLIGHT
            *    INTO LS_SEAT
            *    WHERE CARRID = IV_CARRID
            *      AND CONNID = IV_CONNID.
            *    LS_SEAT-SEATSFREE = LS_SEAT-SEATSMAX - LS_SEAT-SEATSOCC.
            *    APPEND LS_SEAT TO ET_SEATS.
            *  ENDSELECT.
            *
            *  IF SY-SUBRC <> 0.
            *    RAISE NO_DATA.
            *  ELSE.
            *    SORT ET_SEATS BY SEATSFREE DESCENDING.
            *  ENDIF.
            *
            
              "array fetch 방식.
              " 1) Array Fetch : 조건에 맞는 데이터를 한 번에 테이블로 가져오기
              SELECT carrid connid fldate seatsmax seatsocc
                FROM sflight
                INTO CORRESPONDING FIELDS OF TABLE et_seats
                WHERE carrid = iv_carrid
                  AND connid = iv_connid.
            
              " 데이터가 없으면 예외
              IF sy-subrc <> 0 OR et_seats IS INITIAL.
                RAISE no_data.
                RETURN.
              ENDIF.
            
              " 2) ABAP 메모리에서 남은 좌석 수 계산
              LOOP AT et_seats INTO ls_seat.
                ls_seat-seatsfree = ls_seat-seatsmax - ls_seat-seatsocc.
            
                MODIFY et_seats
                  FROM ls_seat
                  INDEX sy-tabix
                  TRANSPORTING seatsfree.
              ENDLOOP.
            
              " 3) 남은 좌석 많은 순으로 정렬
              SORT et_seats BY seatsfree DESCENDING.
            
            ENDFUNCTION. 
            ```
            
    10. 실습 8  - Z_GET_TOT_FREESEATS_G01
        1. Module(Z_GET_TOT_FREESEATS_G01) 모듈 만들기 
        2. 인터페이스 정의 
            
            ![image.png](attachment:7f1c9797-944c-4ef2-8f56-138d4df844ad:image.png)
            
            ![image.png](attachment:d25d2aa1-73ca-4093-bfb6-be574595a654:image.png)
            
            ![image.png](attachment:1fdf675f-2f9e-4fe9-910d-5f2570617d0c:image.png)
            
        3. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            FUNCTION Z_GET_TOT_FREESEATS_G01.
            *"----------------------------------------------------------------------
            *"*"Local Interface:
            *"  IMPORTING
            *"     REFERENCE(IV_CARRID) TYPE  ZBC400_S_SEATS-CARRID
            *"     REFERENCE(IV_CONNID) TYPE  ZBC400_S_SEATS-CONNID
            *"  EXPORTING
            *"     REFERENCE(ET_SEATS) TYPE  ZBC400_T_SEATS
            *"  EXCEPTIONS
            *"      NO_DATA
            *"----------------------------------------------------------------------
            
            * local structure data type.
              TYPES: BEGIN OF TS_FLIGHT,
                       CARRID     TYPE SFLIGHT-CARRID,
                       CONNID     TYPE SFLIGHT-CONNID,
                       FLDATE     TYPE SFLIGHT-FLDATE,
                       SEATSMAX   TYPE SFLIGHT-SEATSMAX,
                       SEATSOCC   TYPE SFLIGHT-SEATSOCC,
                       SEATSMAX_B TYPE SFLIGHT-SEATSMAX_B,
                       SEATSOCC_B TYPE SFLIGHT-SEATSOCC_B,
                       SEATSMAX_F TYPE SFLIGHT-SEATSMAX_F,
                       SEATSOCC_F TYPE SFLIGHT-SEATSOCC_F,
                     END OF TS_FLIGHT.
            
            * work area.
              DATA: LS_FLIGHT TYPE TS_FLIGHT,
                    LS_SEATS  LIKE LINE OF ET_SEATS.
            
            *  select.. endselect loop.
              SELECT *
                INTO CORRESPONDING FIELDS OF LS_FLIGHT
                FROM SFLIGHT
                WHERE CARRID = IV_CARRID
                  AND CONNID = IV_CONNID.
            
                MOVE-CORRESPONDING LS_FLIGHT TO LS_SEATS.
            
                LS_SEATS-SEATSMAX = LS_FLIGHT-SEATSMAX +
                                     LS_FLIGHT-SEATSMAX_B +
                                     LS_FLIGHT-SEATSMAX_F.
            
                LS_SEATS-SEATSOCC = LS_FLIGHT-SEATSOCC +
                                    LS_FLIGHT-SEATSOCC_B +
                                    LS_FLIGHT-SEATSOCC_F.
            
                LS_SEATS-SEATSFREE = LS_SEATS-SEATSMAX - LS_SEATS-SEATSOCC.
            
                APPEND LS_SEATS TO ET_SEATS.
              ENDSELECT.
            
            ENDFUNCTION.
            ```
            
    11. 실습 9  - Z_GET_SMOKER_G01
        1. Module( Z_GET_SMOKER_G01) 모듈 만들기 
        2. 인터페이스 정의 
        
        ![image.png](attachment:b06f0303-5ad9-4d4e-895b-dda76d9c333f:image.png)
        
        ![image.png](attachment:f4fd471c-a31c-4724-b54b-d62999536e39:image.png)
        
        ![image.png](attachment:6b59db3a-7c5f-4b7a-b2b3-5d1a17b10a12:image.png)
        
        1. 소스 코드 작성 칸에 가서 코드 작성하기
            
            ```jsx
            내일 오전까지 ! 
            ```
