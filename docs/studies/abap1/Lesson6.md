# 🧭 Lesson 6 - ABAP Internal Table

# 🔵 Unit 1. Internal Table

1. 내부 테이블이란? 
    1. 변수라고 생각하면 편함. 같은 구조(structure)를 여러 줄(row) 저장할 수 있는 메모리 공간.
    2. 데이터베이스 테이블과 혼돈하지 말기
    3. 엑셀 표, DB 테이블 한 덩어리를 ABAP 메모리에 올린 것과 같음. **행과 열을 가진 변수!**
    4. 내부 테이블을 선언하려면 **구조체 타입이 먼저 필요함.**
2. 내부 테이블의 구조
    1. Line type : 내부 테이블의 한 줄(Row)의 구조(Structure)
    2. Column :  Line Type(한 줄)이 가지고 있는 **각각의 필드(component)**
        
        ```json
        내부 테이블 = 여러 개의 행(row)
        행(row) = Line Type
        Line Type = 여러 개의 컬럼(column)
        컬럼 = 구조체의 컴포넌트(component)
        ```
        
3. Index Access 
    1. Index(인덱스)란? 내부 테이블의 각 행(Row)이 가지고 있는 번호
        1. STANDARD TABLE → 인덱스 항상 있음
        2. SORTED TABLE → 인덱스 있음 (정렬된 상태 유지)
        3. HASHED TABLE → ❌ 인덱스 없음
    2. Index Access (인덱스 접근)
        1. 행 번호로 읽기, 수정, 삭제하는 방식
    3. Attributes and Uses of Tables (ABAP Internal Tables)
        
        
        | **Attribute** | **STANDARD TABLE** | **SORTED TABLE** | **HASHED TABLE** |
        | --- | --- | --- | --- |
        | **Index Access** | ✔ 가능 | ✔ 가능 | ❌ 불가능 |
        | **Key Access** | ✔ 가능 (느림) | ✔ 가능 (빠름) | ✔ 가능 (가장 빠름) |
        | **Key Uniqueness** | NON-UNIQUE | UNIQUE / NON-UNIQUE | UNIQUE only |
        | **Use in** | Mainly **Index Access** situations | Mainly **Key Access** situations | **Only Key Access** situations |
4. 내부 테이블 정의 방법 3가지
    1. 방법 1 – **Table Type** 을 그대로 사용하는 방법
        1. 문법
            
            ```abap
            DATA gt_itab TYPE <table_type>.
            ```
            
        2. 설명 표
            
            
            | 항목 | 내용 |
            | --- | --- |
            | 정의 위치 | DDIC(Global Type) 또는 Local `TYPES` 로 미리 정의된 **Table Type** |
            | 테이블 종류 | Table Type 정의에 이미 포함(STANDARD / SORTED / HASHED) |
            | 키 정의 | Table Type 정의에 이미 포함 (UNIQUE / NON-UNIQUE, Key 필드들) |
            | 장점 | 선언이 짧고 명확함, 여러 프로그램에서 같은 구조 재사용 가능 |
            | 단점 | Table Type을 먼저 만들어야 함 (SE11 또는 `TYPES`) |
        3. 예시 1 – DDIC 글로벌 Table Type 사용
        
        ```abap
        " DDIC에 BC400_T_FLIGHTS 라는 Table Type이 정의되어 있음
        " Line Type  : BC400_S_FLIGHT
        " Table Kind : STANDARD TABLE
        " Key        : NON-UNIQUE KEY carrid connid fldate
        
        DATA gt_flights TYPE bc400_t_flights.
        
        ```
        
    2. 방법 2 – **테이블 종류 + 키까지 전부 직접 지정**하는 방법
        1. 문법 
            
            ```abap
            DATA gt_itab TYPE
                  STANDARD TABLE OF <structure_type>
                  " 또는 SORTED TABLE OF ...
                  " 또는 HASHED  TABLE OF ...
                  WITH [ NON-UNIQUE | UNIQUE ] KEY <key_components>.
            ```
            
        2. 설명 표
            
            
            | 항목 | 내용 |
            | --- | --- |
            | 정의 위치 | 프로그램 안에서 바로 정의 (DATA 라인에서) |
            | 테이블 종류 선택 | `STANDARD` / `SORTED` / `HASHED` 전부 직접 지정 가능 |
            | 키 정의 | `WITH UNIQUE/NON-UNIQUE KEY …` 로 직접 지정 |
            | 장점 | 한 줄에서 **모든 속성(종류+키)** 를 통제 가능, DDIC 타입 없어도 바로 사용 |
            | 단점 | 문장이 길어짐, 반복해서 쓰면 가독성 떨어짐 → 보통 `TYPES` 로 한 번 감싸서 씀 |
        3. 예시 2 – 로컬 구조체 + FULL 문법
            
            ```abap
            " 1) Line Type (로컬 구조체) 정의
            TYPES: BEGIN OF ts_flight,
                     carrid   TYPE s_carr_id,
                     connid   TYPE s_conn_id,
                     fldate   TYPE s_date,
                     seatsmax TYPE s_seatsmax,
                     seatsocc TYPE s_seatsocc,
                     percentage TYPE s_percentage,
                   END OF ts_flight.
            
            " 2) Internal Table 정의 – SORTED TABLE + UNIQUE KEY
            DATA gt_flights TYPE SORTED TABLE OF ts_flight
                                WITH UNIQUE KEY carrid connid fldate.
            
            ```
            
        4. 예시 2-1 – STANDARD TABLE + NON-UNIQUE KEY
            
            ```abap
            DATA gt_flights TYPE STANDARD TABLE OF ts_flight
                                WITH NON-UNIQUE KEY carrid connid.
            
            ```
            
        5. 예시 2-2 – HASHED TABLE
            
            ```abap
            DATA gt_flights TYPE HASHED TABLE OF ts_flight
                                WITH UNIQUE KEY carrid connid fldate.
            
            ```
            
    3. 방법 3 – 축약형 **`TABLE OF <Structure Type>` → STANDARD TABLE 생략 가능**
        1. 문법
            
            ```abap
            DATA gt_itab TYPE TABLE OF <structure_type>.
            ```
            
            > Short form for definition of a STANDARD TABLE
            > 
            > 
            > with **non-unique default key**
            > 
        2. 설명 표
            
            
            | 항목 | 내용 |
            | --- | --- |
            | 테이블 종류 | 자동으로 **STANDARD TABLE** |
            | 키 | default key = 구조체의 “character-like 필드(CHAR, STRING, NUMC) + DATS + TIMS”
            numeric 타입(INT, DEC, FLOAT, P 등)은 포함되지 않음 |
            | 장점 | 제일 짧고 쓰기 편함, 교육·샘플 코드에서 자주 사용 |
            | 단점 | 키가 명확하지 않음(default key), 성능/의도 제어가 어려움 → 실무에서는 보통 키를 명시하는 편 |
        3. 왜 numeric 타입을 default key에서 제외할까?
            - INT / PACKED / FLOAT 값은
                
                정렬 기준이나 비교 시 의미가 복잡해짐
                
            - FLOAT는 오차가 생김
            - PACKED는 precision 문제
            - INT는 leading zero가 없어 key 안정성 떨어짐
            - 날짜/시간은 내부적으로 문자 기반 구조라 안전
        4. 예시 3 – 축약형 선언
            
            ```abap
            " Line Type
            TYPES: BEGIN OF ts_flight,
                     carrid   TYPE s_carr_id,
                     connid   TYPE s_conn_id,
                     fldate   TYPE s_date,
                     seatsmax TYPE s_seatsmax,
                     seatsocc TYPE s_seatsocc,
                     percentage TYPE s_percentage,
                   END OF ts_flight.
            
            " Internal Table – STANDARD TABLE + default key (NON-UNIQUE)
            DATA gt_flights TYPE TABLE OF ts_flight.
            
            ```
            
    4. 최종 비교 표 – 내부 테이블 정의 방법 3가지
        
        
        | 번호 | 정의 방법 | 기본 문법 | 테이블 종류 지정 | 키 직접 지정 | 사용 예 / 특징 |
        | --- | --- | --- | --- | --- | --- |
        | ① | **Table Type 사용** | `DATA gt TYPE <table_type>.` | Table Type에 이미 포함 | Table Type에 이미 포함 | DDIC 또는 `TYPES` 로 사전에 정의된 Table Type 재사용. 가장 깔끔하고 재사용성 높음. |
        | ② | **FULL 문법 (STANDARD/SORTED/HASHED + KEY)** | `DATA gt TYPE STANDARD/SORTED/HASHED TABLE OF <struct> WITH UNIQUE/NON-UNIQUE KEY ...` | ✔ 직접 지정 (STANDARD / SORTED / HASHED) | ✔ 직접 지정 (UNIQUE / NON-UNIQUE, key 필드들) | 테이블 성격을 한 줄에서 완전히 정의. 성능·키 설계까지 통제할 때 사용. |
        | ③ | **축약형 TABLE OF** | `DATA gt TYPE TABLE OF <struct>.` | STANDARD TABLE 고정 | NON-UNIQUE default key (명시 X) | 가장 단순한 교육용/샘플용 문법. 키/성능 설계가 중요하지 않을 때 사용. |
5. 내부 테이블 기본 동작 비교 표 (최종판)
    1. 삽입 (Insert)
        
        
        | 기능 | 문법 | 설명 |
        | --- | --- | --- |
        | 맨 뒤에 추가 | `APPEND wa TO itab.` | STANDARD/SORTED/HASHED 모두 사용 |
        | 특정 위치 삽입 | `INSERT wa INTO itab INDEX n.` | STANDARD/SORTED에서만 가능 (HASHED 불가) |
        | 키 기반 삽입 | `INSERT wa INTO TABLE itab.` | 키 충돌 시 오류(UNIQUE) |
    2. 읽기 (Read)
        
        
        | 기능 | 문법 | 설명 |
        | --- | --- | --- |
        | 전체 LOOP | `LOOP AT itab INTO wa.` | 가장 기본적인 방식 |
        | 인덱스로 읽기 | `READ TABLE itab INTO wa INDEX n.` | HASHED TABLE은 불가 |
        | 키로 읽기 | `READ TABLE itab INTO wa WITH KEY field = value.` | STANDARD = O(n) / SORTED = O(log n) / HASHED = O(1) |
        | 신 문법 | `wa = itab[ keycomp = value ].` | 못 찾으면 예외 발생 |
    3. 변경 (Modify / Update)
        
        
        | 기능 | 문법 | 설명 |
        | --- | --- | --- |
        | 인덱스 변경 | `MODIFY itab FROM wa INDEX n.` | 위치를 정확히 알고 있을 때 |
        | 키로 변경 | `MODIFY itab FROM wa.` | 키 일치하는 첫 행만 변경 |
        | 특정 필드만 변경 | `MODIFY itab FROM wa TRANSPORTING field1 field2.` | 부분 업데이트 가능 |
    4. 삭제 (Delete)
        
        
        | 기능 | 문법 | 설명 |
        | --- | --- | --- |
        | 인덱스 삭제 | `DELETE itab INDEX n.` | HASHED TABLE은 불가 |
        | 조건 삭제 | `DELETE itab WHERE field = value.` | 여러 행 삭제 가능 |
        | LOOP 중 삭제 | `DELETE itab INDEX sy-tabix.` | sy-tabix 사용 |
    5. 초기화 / 기타
        
        
        | 기능 | 문법 | 설명 |
        | --- | --- | --- |
        | 테이블 비우기 | `CLEAR itab.` / `REFRESH itab.` | 둘 다 전체 삭제 |
        | 구조체 초기화 | `CLEAR wa.` | 구조체 내부 모든 필드 초기화 |
        | 행 개수 | `DESCRIBE TABLE itab LINES lv_cnt.` | 내부 테이블 크기 읽기 |
    6. 정리
        
        ```
        APPEND → 끝에 추가
        INSERT → 위치 지정 추가
        READ INDEX → 순서로 읽기
        READ KEY → 조건으로 읽기
        MODIFY → 기존 행 갱신
        DELETE → 행 삭제
        CLEAR/REFRESH → 초기화
        ```
        
6. Internal Table  예제 1

---

```abap
*&---------------------------------------------------------------------*
*& Report ZABAP_14_G01
*&---------------------------------------------------------------------*
*& Internal Table 기본 CRUD 연습
*&---------------------------------------------------------------------*
REPORT ZABAP_14_G01.

*---------------------------------------------------------------------*
* 1. Internal Table & Work Area 선언
*    - GT_FLIGHTS : BC400_T_FLIGHTS (Standard Table, Non-unique key)
*    - GS_FLIGHT  : BC400_S_FLIGHT (Structure)
*---------------------------------------------------------------------*
DATA: GT_FLIGHTS TYPE BC400_T_FLIGHTS,
      GS_FLIGHT  TYPE BC400_S_FLIGHT.

*---------------------------------------------------------------------*
* 2. Work Area 에 값 넣기 (1차 데이터)
*---------------------------------------------------------------------*
GS_FLIGHT-CARRID     = 'AA'.
GS_FLIGHT-CONNID     = '0017'.
GS_FLIGHT-FLDATE     = '20251105'.
GS_FLIGHT-SEATSMAX   = 300.
GS_FLIGHT-SEATSOCC   = 150.
GS_FLIGHT-PERCENTAGE = 50.         " SEATSOCC / SEATSMAX * 100

* Internal Table 맨 뒤에 데이터 추가
APPEND GS_FLIGHT TO GT_FLIGHTS.

*---------------------------------------------------------------------*
* 3. Work Area 에 값 넣기 (2차 데이터)
*---------------------------------------------------------------------*
GS_FLIGHT-CARRID     = 'LH'.
GS_FLIGHT-CONNID     = '0400'.
GS_FLIGHT-FLDATE     = '20251115'.
GS_FLIGHT-SEATSMAX   = 300.
GS_FLIGHT-SEATSOCC   = 250.
GS_FLIGHT-PERCENTAGE = GS_FLIGHT-SEATSOCC * 100 / GS_FLIGHT-SEATSMAX.

* Internal Table 맨 뒤에 데이터 추가
APPEND GS_FLIGHT TO GT_FLIGHTS.

*---------------------------------------------------------------------*
* 4. INSERT 예제
*    - INSERT … INDEX : 특정 위치에 삽입
*    - INSERT … INTO TABLE : 키 기반 삽입
*---------------------------------------------------------------------*
GS_FLIGHT-SEATSMAX   = 300.
GS_FLIGHT-SEATSOCC   = 100.
GS_FLIGHT-PERCENTAGE = GS_FLIGHT-SEATSOCC * 100 / GS_FLIGHT-SEATSMAX.

* (1) INDEX 사용 → Internal Table 맨 앞에 삽입
INSERT GS_FLIGHT INTO GT_FLIGHTS INDEX 1.

* (2) INTO TABLE 사용 → 테이블 맨 뒤에 삽입 (키 중복 허용됨)
INSERT GS_FLIGHT INTO TABLE GT_FLIGHTS.

*---------------------------------------------------------------------*
* 5. 최종 출력 (팝업)
*---------------------------------------------------------------------*
CL_DEMO_OUTPUT=>DISPLAY( GT_FLIGHTS ).

```

---

- 기능별 요약

| 기능 | 문법 | 설명 |
| --- | --- | --- |
| Work Area 값 입력 | `GS_FLIGHT-필드 = 값.` | 구조체 한 줄(Row) 준비 |
| 맨 뒤 추가 | `APPEND GS_FLIGHT TO GT_FLIGHTS.` | Standard Table 기본 추가 방식 |
| 맨 앞(특정 위치) 삽입 | `INSERT GS_FLIGHT INTO GT_FLIGHTS INDEX 1.` | 원하는 위치에 추가 |
| 키 기반 삽입 | `INSERT GS_FLIGHT INTO TABLE GT_FLIGHTS.` | Non-unique key → 중복 허용 |
| 출력 | `CL_DEMO_OUTPUT=>DISPLAY( GT_FLIGHTS ).` | Internal Table 전체 출력 |

---

- 추가 설명

- **APPEND**
    
    → 항상 마지막(Row 추가)
    
- **INSERT INDEX n**
    
    → `n번째 위치에 삽입`
    
    (STANDARD TABLE에서만 가능)
    
- **INSERT INTO TABLE**
    
    → 키 기반 삽입
    
    → BC400_T_FLIGHTS는 **NON-UNIQUE KEY** 
    
    삽입해도 중복 오류 없음
    

1. Internal Table  예제 1 - 실습 추가 변경 사항
    
    1. APPEND / INSERT 차이
    
    | 문법 | 의미 |
    | --- | --- |
    | `APPEND wa TO itab.` | 테이블 **마지막**에 추가 |
    | `INSERT wa INTO itab INDEX n.` | **지정한 위치(n)** 에 삽입 |
    | `INSERT wa INTO TABLE itab.` | 키 기반 삽입(Non-unique → 중복 OK) |
    
    ---
    
    2. READ TABLE 종류 요약
    
    | 구분 | 문법 | 특징 |
    | --- | --- | --- |
    | Index Access | `READ TABLE itab INTO wa INDEX n.` | n번째 레코드 읽기 |
    | Key Access (PRIMARY KEY) | `READ TABLE itab INTO wa WITH TABLE KEY ...` | 테이블의 Key Component 전부 사용해야 함 |
    | Key Access (일반 필드) | `READ TABLE itab INTO wa WITH KEY field = value.` | 키 컴포넌트가 아니어도 가능 (STANDARD TABLE → 선형 검색) |
    
    ---
    
     3. MODIFY 종류 요약
    
    | 문법 | 설명 |
    | --- | --- |
    | `MODIFY itab FROM wa INDEX n.` | n번째 Row 전체를 덮어쓰기 |
    | `MODIFY itab FROM wa TRANSPORTING field1 field2.` | 해당 필드만 업데이트 |
    | `SY-TABIX` | 마지막 READ/LOOP 등에서 읽힌 **현재 Index** |
    
    ---
    
     4. DELETE 종류 요약
    
    | 문법 | 설명 |
    | --- | --- |
    | `DELETE itab INDEX n.` | 특정 위치 삭제 |
    | `DELETE itab WHERE 조건.` | 조건에 맞는 행 전체 삭제 |
    
    ---
    
    5. 전체 코드 (주석 정리 완료 – 노션 전용)
    
    ```abap
    *&---------------------------------------------------------------------*
    *& Report ZABAP_14_G01
    *&---------------------------------------------------------------------*
    REPORT ZABAP_14_G01.
    
    * Internal Table & Work area 선언
    DATA: GT_FLIGHTS TYPE BC400_T_FLIGHTS,
          GS_FLIGHT  TYPE BC400_S_FLIGHT.
    
    *---------------------------------------------------------------------*
    * 1) Work Area → Internal Table (APPEND, INSERT)
    *---------------------------------------------------------------------*
    GS_FLIGHT-CARRID = 'AA'.
    GS_FLIGHT-CONNID = '0017'.
    GS_FLIGHT-FLDATE = '20251105'.
    GS_FLIGHT-SEATSMAX = 300.
    GS_FLIGHT-SEATSOCC = 150.
    GS_FLIGHT-PERCENTAGE = 50.
    
    APPEND GS_FLIGHT TO GT_FLIGHTS.     "맨 뒤 추가
    
    GS_FLIGHT-CARRID = 'LH'.
    GS_FLIGHT-CONNID = '0400'.
    GS_FLIGHT-FLDATE = '20251115'.
    GS_FLIGHT-SEATSMAX = 300.
    GS_FLIGHT-SEATSOCC = 250.
    GS_FLIGHT-PERCENTAGE = GS_FLIGHT-SEATSOCC * 100 / GS_FLIGHT-SEATSMAX.
    
    APPEND GS_FLIGHT TO GT_FLIGHTS.     "맨 뒤 추가
    
    * 추가 테스트용 데이터
    GS_FLIGHT-SEATSMAX   = 300.
    GS_FLIGHT-SEATSOCC   = 100.
    GS_FLIGHT-PERCENTAGE = GS_FLIGHT-SEATSOCC * 100 / GS_FLIGHT-SEATSMAX.
    
    INSERT GS_FLIGHT INTO GT_FLIGHTS INDEX 1.   "맨 앞 삽입
    INSERT GS_FLIGHT INTO TABLE GT_FLIGHTS.     "맨 뒤 삽입
    
    *---------------------------------------------------------------------*
    * 2) READ TABLE – Index Access / Key Access
    *---------------------------------------------------------------------*
    READ TABLE GT_FLIGHTS INTO GS_FLIGHT INDEX 2.   "Index access
    
    * PRIMARY KEY 사용 시: 테이블 키 구성요소 모두 필요함
    *READ TABLE GT_FLIGHTS INTO GS_FLIGHT
    *  WITH TABLE KEY CARRID = 'LH'
    *                 CONNID = '0400'
    *                 FLDATE = '20251115'.
    
    * KEY Access (일반 필드) – 키 컴포넌트 아니어도 OK (STANDARD TABLE → 선형 검색)
    READ TABLE GT_FLIGHTS INTO GS_FLIGHT
         WITH KEY PERCENTAGE = '50.00'.
    
    *---------------------------------------------------------------------*
    * 3) MODIFY – Index 기반 변경
    *---------------------------------------------------------------------*
    GS_FLIGHT-FLDATE = '20251107'.
    GS_FLIGHT-SEATSOCC = 220.
    GS_FLIGHT-PERCENTAGE = GS_FLIGHT-SEATSOCC * 100 / GS_FLIGHT-SEATSMAX.
    
    MODIFY GT_FLIGHTS FROM GS_FLIGHT INDEX SY-TABIX.
    " SY-TABIX = 바로 직전에 READ TABLE로 읽힌 index 값
    
    * 특정 필드만 변경할 때 (TRANSPORTING)
    MODIFY GT_FLIGHTS FROM GS_FLIGHT INDEX SY-TABIX
           TRANSPORTING FLDATE SEATSOCC PERCENTAGE.
    
    *---------------------------------------------------------------------*
    * 4) DELETE – Index 또는 조건 기반 삭제
    *---------------------------------------------------------------------*
    *DELETE GT_FLIGHTS INDEX 2.
    
    DELETE GT_FLIGHTS
      WHERE CARRID = 'AA'
        AND CONNID = '0017'
        AND FLDATE = '20251107'.
    
    *---------------------------------------------------------------------*
    * 5) Popup 출력
    *---------------------------------------------------------------------*
    CL_DEMO_OUTPUT=>DISPLAY( GT_FLIGHTS ).
    
    ```
    
    ---
    
     노션용 핵심 요약 (완전 단축판)
    
    ```
    APPEND wa TO itab.                  → 맨 뒤 추가
    INSERT wa INTO itab INDEX n.        → 특정 위치 추가
    INSERT wa INTO TABLE itab.          → 키 기반 추가
    
    READ TABLE itab INTO wa INDEX n.    → Index 검색
    READ TABLE itab INTO wa WITH KEY x. → Key 검색(키 컴포넌트 아니어도 가능)
    
    MODIFY itab FROM wa INDEX n.        → 행 전체 변경
    MODIFY itab ... TRANSPORTING f1 f2. → 특정 필드만 변경
    
    DELETE itab INDEX n.                → Index 삭제
    DELETE itab WHERE 조건.             → 조건 삭제
    
    ```
    

1. Internal Table  예제 2
    1. ZQUIZ_07_G01 — GET_CONNECTIONS + GET_CARRIERS JOIN 프로그램
        
        ### **①  노선 정보 (Connections)**
        
        - 테이블: `BC400_T_CONNECTIONS`
        - 구조: `BC400_S_CONNECTION`
        
        | 필드 | 설명 |
        | --- | --- |
        | CARRID | 항공사 코드 |
        | CONNID | 노선 ID |
        | CITYFROM | 출발 도시 |
        | CITYTO | 도착 도시 |
        | DEPTIME | 출발 시간 |
        | ARRTIME | 도착 시간 |
        | … | 기타 필드 |
        
        ---
        
        ### **②  항공사 정보 (Carriers)**
        
        - 테이블: `BC400_T_CARRIERS`
        - 구조: `BC400_S_CARRIER`
        
        | 필드 | 설명 |
        | --- | --- |
        | CARRID | 항공사 코드 |
        | CARRNAME | 항공사 이름 |
        
        ---
        
        ### **③  최종 출력 구조 (ts_conn_out)**
        
        두 데이터를 합친 **JOIN 결과 구조**
        
        | 필드 | 설명 |
        | --- | --- |
        | CARRID | 항공사 코드 |
        | CARRNAME | 항공사 이름 |
        | CONNID | 노선 번호 |
        | CITYFROM | 출발 도시 |
        | CITYTO | 도착 도시 |
        | DEPTIME | 출발 |
        | ARRTIME | 도착 |
        
        프로그램 전체 흐름 (Flow)
        
        ```
        [GET_CONNECTIONS]  →  GT_CONNECTIONS
               |
               V
        [GET_CARRIERS]     →  GT_CARRIERS
               |
               V
        [SORT GT_CARRIERS BY CARRID]
               |
               V
        LOOP GT_CONNECTIONS
               |
               |-- READ TABLE GT_CARRIERS
               |      (CARRID 기준)
               |
               |-- MATCH 성공 → gs_conn_out 생성
               |
               --> APPEND to GT_CONN_OUT
        
        LOOP GT_CONN_OUT → WRITE OUTPUT
        ```
        
    2. 실습 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_07_G01
        *&---------------------------------------------------------------------*
        *&   GET_CONNECTIONS + GET_CARRIERS 메소드 사용 예제
        *&   - 노선 정보 + 항공사 이름 JOIN하여 출력하는 프로그램
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_07_G01.
        방법1.
        "------------------------------------------------------------
        " 내부 테이블 및 워크 에리아 선언
        "------------------------------------------------------------
        DATA: GT_CONNECTIONS TYPE BC400_T_CONNECTIONS,   " 노선 리스트
              GS_CONNECTION  TYPE BC400_S_CONNECTION,    " 노선 한 줄
              GT_CARRIERS    TYPE BC400_T_CARRIERS,      " 항공사 리스트
              GS_CARRIER     TYPE BC400_S_CARRIER.       " 항공사 한 줄
        
        "------------------------------------------------------------
        " 출력 테이블용 구조 정의 (노선 + 항공사 이름 JOIN 결과)
        "------------------------------------------------------------
        TYPES: BEGIN OF ts_conn_out,
                 carrid    TYPE s_carr_id,      " 항공사 코드
                 carrname  TYPE s_carrname,     " 항공사 이름
                 connid    TYPE s_conn_id,      " 노선 ID
                 cityfrom  TYPE s_from_cit,     " 출발 도시
                 airpfrom  TYPE s_fromairp,     " 출발 공항
                 cityto    TYPE s_to_city,      " 도착 도시
                 airpto    TYPE s_toairp,       " 도착 공항
                 fltime    TYPE s_fltime,       " 비행 시간
                 deptime   TYPE s_dep_time,     " 출발 시간
                 arrtime   TYPE s_arr_time,     " 도착 시간
               END OF ts_conn_out.
        
        DATA: gt_conn_out TYPE STANDARD TABLE OF ts_conn_out,  " 출력용 내부 테이블
              gs_conn_out TYPE ts_conn_out.                    " 출력용 워크에리아
        
        "------------------------------------------------------------
        " 데이터 읽기 (노선 / 항공사 정보)
        "------------------------------------------------------------
        TRY.
            " 노선 정보 조회
            CALL METHOD cl_bc400_flightmodel=>get_connections
              EXPORTING
                iv_carrid      = space              " 전체 항공사 조회
              IMPORTING
                et_connections = gt_connections.
        
            " 항공사 정보 조회
            CALL METHOD cl_bc400_flightmodel=>get_carriers
              IMPORTING
                et_carriers = gt_carriers.
        
          CATCH cx_bc400_no_data.
            WRITE: / 'No Data Found'.
            LEAVE PROGRAM.
        ENDTRY.
        
        "------------------------------------------------------------
        " 항공사 테이블은 carrid 기준으로 정렬해야 BINARY SEARCH 가능
        "------------------------------------------------------------
        SORT gt_carriers BY carrid.
        
        "------------------------------------------------------------
        " 노선 LOOP 돌면서 항공사 이름 매칭 (JOIN과 동일)
        "------------------------------------------------------------
        LOOP AT gt_connections INTO gs_connection.
        
          " 노선(CARRID) 기준으로 항공사 테이블에서 검색
          READ TABLE gt_carriers INTO gs_carrier
               WITH KEY carrid = gs_connection-carrid
               BINARY SEARCH.
        
          IF sy-subrc = 0.   " 검색 성공 시
            CLEAR gs_conn_out.
        
            " 노선 정보 공통 필드 복사
            MOVE-CORRESPONDING gs_connection TO gs_conn_out.
        
            " 항공사 코드 및 이름 추가
            gs_conn_out-carrid   = gs_connection-carrid.
            gs_conn_out-carrname = gs_carrier-carrname.
        
            " 출력 테이블에 결과 삽입
            APPEND gs_conn_out TO gt_conn_out.
            " 또는 INSERT gs_conn_out INTO TABLE gt_conn_out. (둘 다 가능)
          ENDIF.
        
        ENDLOOP.
        
        "------------------------------------------------------------
        " 결과 출력 LOOP
        "------------------------------------------------------------
        LOOP AT gt_conn_out INTO gs_conn_out.
          WRITE: / gs_conn_out-carrid,
                   gs_conn_out-carrname,
                   gs_conn_out-connid,
                   gs_conn_out-cityfrom,
                   gs_conn_out-airpfrom,
                   gs_conn_out-cityto,
                   gs_conn_out-airpto,
                   gs_conn_out-fltime,
                   gs_conn_out-deptime,
                   gs_conn_out-arrtime.
        ENDLOOP.
        
        방법2.
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_07_G01
        *&---------------------------------------------------------------------*
        *&   GET_CONNECTIONS + GET_CARRIERS 활용하여
        *&   노선 + 항공사 이름을 JOIN하여 출력하는 간단 버전
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_07_G01.
        
        "---------------------------------------------------------
        " 내부 테이블 및 구조 선언
        "---------------------------------------------------------
        DATA: gt_connections TYPE bc400_t_connections,   " 노선 목록
              gs_connection  TYPE bc400_s_connection,    " 노선 한 줄
              gt_carriers    TYPE bc400_t_carriers,      " 항공사 목록
              gs_carrier     TYPE bc400_s_carrier.       " 항공사 한 줄
        
        "---------------------------------------------------------
        " 데이터 조회 (노선 / 항공사)
        "---------------------------------------------------------
        TRY.
            " 전체 항공편 목록 조회
            CALL METHOD cl_bc400_flightmodel=>get_connections
              IMPORTING
                et_connections = gt_connections.
        
            " 전체 항공사 목록 조회
            CALL METHOD cl_bc400_flightmodel=>get_carriers
              IMPORTING
                et_carriers = gt_carriers.
        
          CATCH cx_bc400_no_data.  " 데이터 없을 때 예외 처리
            WRITE '데이터 없다!!@!@!@!'.
        ENDTRY.
        
        "---------------------------------------------------------
        " 노선 데이터를 출발시간(DEPTIME) 기준으로 정렬
        "---------------------------------------------------------
        SORT gt_connections ASCENDING BY deptime.
        
        "---------------------------------------------------------
        " LOOP 돌면서 노선 + 항공사 JOIN 수행
        "---------------------------------------------------------
        LOOP AT gt_connections INTO gs_connection.
        
          " 노선의 CARRID로 항공사 데이터 찾기
          READ TABLE gt_carriers INTO gs_carrier
                WITH TABLE KEY carrid = gs_connection-carrid.
        
          "-------------------------------------------------------
          " 화면 출력 (노선 + 항공사 정보 같이 출력)
          "-------------------------------------------------------
          WRITE: / gs_connection-carrid,     " 항공사 코드
                   gs_carrier-carrname,      " 항공사 이름
                   gs_carrier-currcode,      " 통화 코드
                   gs_connection-connid,     " 노선 ID
                   gs_connection-cityfrom,   " 출발 도시
                   gs_connection-airpfrom,   " 출발 공항
                   gs_connection-cityto,     " 도착 도시
                   gs_connection-airpto.     " 도착 공항
        
        ENDLOOP.
        
        ```
