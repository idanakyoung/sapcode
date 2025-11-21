# 🧭 Lesson 5 - Calling Function Module (2) & Describing Business Application Programming InterFaces (BAPIs)

# 🔵 Unit 1. Calling Function Module (2)

## 1. 나이 계산 함수 모듈 + 리포트 정리

### 1. 개요

- 생년월일(생일, DATS 형식)을 입력 받아:
    - 만 나이(법적 나이)
    - 세는 나이(한국식 나이)
        
        를 계산하는 **함수 모듈 Z_CALCU_AGE_G01** 과
        
        이를 호출하는 **리포트 프로그램 ZABAP_10_G01** 구성.
        

---

### 2. 함수 모듈: Z_CALCU_AGE_G01

### 2.1 인터페이스 정의

SE37에서 함수 모듈 `Z_CALCU_AGE_G01` 생성 후 인터페이스를 아래와 같이 설정.

- IMPORTING
    - `IV_BIRTH` TYPE `DATS` (생년월일: YYYYMMDD)
- EXPORTING
    - `EV_SAGE` TYPE `I` (세는 나이)
    - `EV_LAGE` TYPE `I` (만 나이)

---

### 2.2 함수 모듈 구현 코드

```abap
FUNCTION Z_CALCU_AGE_G01.
*"----------------------------------------------------------------------
*"*" Local Interface:
*"  IMPORTING
*"     VALUE(IV_BIRTH) TYPE DATS    " 생년월일 (YYYYMMDD 형식)
*"  EXPORTING
*"     VALUE(EV_SAGE)  TYPE I       " 세는 나이 (한국식 나이)
*"     VALUE(EV_LAGE)  TYPE I       " 만 나이 (법적 나이)
*"----------------------------------------------------------------------
*  이 함수는 입력된 생년월일(IV_BIRTH)을 기준으로
*  - EV_LAGE : 만 나이
*  - EV_SAGE : 세는 나이
*  를 계산해서 반환한다.
*-----------------------------------------------------------------------

  " 날짜를 연 / 월 / 일 단위로 나누어 담기 위한 로컬 변수 선언
  DATA: lv_birth_year  TYPE i,   " 출생 연도
        lv_birth_month TYPE i,   " 출생 월
        lv_birth_day   TYPE i,   " 출생 일
        lv_curr_year   TYPE i,   " 현재 연도 (SY-DATUM 기준)
        lv_curr_month  TYPE i,   " 현재 월
        lv_curr_day    TYPE i.   " 현재 일

  "------------------------------------------------------------
  " 1. 입력 생년월일(IV_BIRTH)에서 연 / 월 / 일을 잘라서 추출
  "    - DATS 타입은 'YYYYMMDD' 형식의 8자리 문자로 간주 가능
  "    - +offset(length) 방식으로 부분 문자열을 가져올 수 있음
  "------------------------------------------------------------
  lv_birth_year  = iv_birth+0(4). " 앞 4자리 : 연도
  lv_birth_month = iv_birth+4(2). " 5~6자리 : 월
  lv_birth_day   = iv_birth+6(2). " 7~8자리 : 일

  "------------------------------------------------------------
  " 2. 현재 날짜(SY-DATUM)에서도 연 / 월 / 일을 분리
  "------------------------------------------------------------
  lv_curr_year   = sy-datum+0(4). " 오늘 연도
  lv_curr_month  = sy-datum+4(2). " 오늘 월
  lv_curr_day    = sy-datum+6(2). " 오늘 일

  "------------------------------------------------------------
  " 3. 만 나이 계산
  "
  "    기본 계산식: 현재연도 - 출생연도
  "    단, 생일이 아직 지나지 않았다면 -1 해줘야 정확한 만 나이가 됨.
  "
  "    예)
  "      출생: 2000-10-15
  "      오늘: 2025-04-10
  "      기본: 2025 - 2000 = 25
  "      생일 안 지남 → 25 - 1 = 24세 (정답)
  "------------------------------------------------------------
  ev_lage = lv_curr_year - lv_birth_year. " 일단 연도 차이만 계산

  " 생일이 지났는지 여부 체크
  " - 현재 월이 출생 월보다 작으면 아직 생일 안 지난 것
  " - 월은 같지만, 오늘 일이 출생 일보다 작으면 역시 생일 안 지난 것
  IF ( lv_curr_month < lv_birth_month )
   OR ( lv_curr_month = lv_birth_month AND lv_curr_day < lv_birth_day ).
    ev_lage = ev_lage - 1. " 생일이 아직 안 지났으면 -1
  ENDIF.

  "------------------------------------------------------------
  " 4. 세는 나이(한국식 나이) 계산
  "
  "    공식 : 현재연도 - 출생연도 + 1
  "
  "    예)
  "      출생: 2000년
  "      올해: 2025년
  "      세는 나이 = 2025 - 2000 + 1 = 26
  "
  "    생일이 지났는지 여부와 관계없이 연도 기준만 사용.
  "------------------------------------------------------------
  ev_sage = lv_curr_year - lv_birth_year + 1.

ENDFUNCTION.

```

---

### 3. 리포트 프로그램: ZABAP_10_G01

### 3.1 리포트 설명

- 사용자가 생년월일을 입력하면
- 함수 모듈 `Z_CALCU_AGE_G01` 를 호출하여
    - 세는 나이
    - 만 나이
        
        를 계산 후 화면에 출력.
        

---

### 3.2 리포트 전체 코드

```abap
REPORT ZABAP_10_G01.

*---------------------------------------------------------------------*
* 데이터 선언부
*---------------------------------------------------------------------*
* 세는 나이와 만 나이를 저장할 변수
DATA: gv_sage TYPE i,    " 세는 나이 (한국식)
      gv_lage TYPE i.    " 만 나이 (법적 나이)

*---------------------------------------------------------------------*
* 파라미터 선언부
*---------------------------------------------------------------------*
* 사용자가 입력할 생년월일
* - 타입 DATS : 'YYYYMMDD' 형식 (예: 20000101)
PARAMETERS pa_birdt TYPE dats. " 생년월일 입력

*---------------------------------------------------------------------*
* 메인 처리부
*---------------------------------------------------------------------*
* 1. 나이 계산 함수 모듈 호출
*    - IV_BIRTH 에는 생년월일(DATS)을 넘긴다.
*    - EV_SAGE 에는 세는 나이, EV_LAGE 에는 만 나이가 돌아온다.
*---------------------------------------------------------------------*
CALL FUNCTION 'Z_CALCU_AGE_G01'
  EXPORTING
    iv_birth = pa_birdt      " 입력받은 생년월일
  IMPORTING
    ev_sage  = gv_sage       " 계산된 세는 나이
    ev_lage  = gv_lage.      " 계산된 만 나이

*---------------------------------------------------------------------*
* 2. 결과 출력
*---------------------------------------------------------------------*
* WRITE 문으로 각각의 나이를 화면에 출력
*---------------------------------------------------------------------*
WRITE: / '세는 나이 : ', gv_sage,
       / '만 나이  : ', gv_lage.

```

---

### 4. 실행 흐름 정리

1. 사용자가 리포트 `ZABAP_10_G01` 실행
2. `PA_BIRDT` 에 생년월일 입력 (예: 19991225)
3. `CALL FUNCTION 'Z_CALCU_AGE_G01'` 에서 생년월일을 함수로 전달
4. `Z_CALCU_AGE_G01` 내부에서:
    - 오늘 날짜(SY-DATUM)와 출생일 비교
    - 만 나이/세는 나이 계산
5. 계산된 값이 `GV_SAGE`, `GV_LAGE` 에 담겨 리포트로 돌아옴
6. 리포트에서 `WRITE` 로 두 나이를 출력

# 🔵 Unit 2. BAPIs

1. BAPI란?
    1. BAPI(Business Application Programming Interface)는 SAP 비즈니스 객체(BO: Business Object)에서 제공하는 **표준화된 외부 인터페이스 , SAP 내부 데이터를 안전하게 읽고/쓰고/수정할 수 있는 공식 API** 
    2. BAPI 구조와 BAPI와 RFC의 실무 관점 차이
        
        ```json
        📌 BAPI 구조 
        [1] Business Object  (BUSXXXX)
            ↳ [2] BAPI Method  (Business Logic API)  
                  ↳ [3] Function Module (BAPI_*)
                        ↳ [4] DDIC Structure (입출력 구조)
                        ↳ [5] RETURN Structure (BAPIRET2)
                        ↳ [6] COMMIT/ROLLBACK BAPI
        
        📌 BAPI
        - 스크린/팝업 사용 ❌
        - MESSAGE S/I/W/E ❌
        - Function Module Exception ❌
        - COMMIT WORK 내부 호출 ❌
        - 상태 유지(Stateful) ❌
        - 오직 RETURN 테이블로만 메시지 전달 ⭕
        - GUI에 의존하는 로직 모두 금지 ⭕
        - 외부 인터페이스용으로 안정적 ⭕
        
        📌 RFC
        - 스크린/팝업 사용 가능 ⭕ (하지만 인터페이스용은 절대 비추천)
        - MESSAGE RAISING 가능 ⭕
        - Function Module Exception 사용 가능 ⭕
        - COMMIT WORK 내부에 넣어도 됨 ⭕
        - 설계 자유도 높음
        - 외부 연동용으로는 위험 요소 많음
        
        ```
        
        ![image.png](attachment:6c41afb0-348f-4fbc-8e2f-4a949fde6a25:image.png)
        
        → Tables 안 Return 활용 
        
2. ABAP 예제: BAPI_FLCUST_GETLIST 고객 조회 프로그램
    1. 개요
        1. 이 프로그램은 **BAPI_FLCUST_GETLIST** 를 사용해 고객 목록을 조회하고, 결과와 BAPI RETURN 메시지를 출력하는 예제 코드이다.
    2. **BAPI_FLCUST_GETLIST**
        - 고객(Customer) 정보를 조회하는 SAP Flight Model 데모용 BAPI
        - 주요 파라미터
            - **CUSTOMER_NAME**: 검색할 고객명(패턴 검색 가능)
            - **MAX_ROWS**: 가져올 최대 행(Row) 수
        - 주요 테이블
            - **CUSTOMER_LIST** (BAPISCUDAT) — 조회된 고객 리스트
            - **RETURN** (BAPIRET2) — 메시지 정보
    3. ABAP 코드
        
        ```abap
        *&---------------------------------------------------------------------*
        *& Report ZABAP_11_G01
        *&---------------------------------------------------------------------*
        REPORT ZABAP_11_G01.
        
        PARAMETERS : PA_CUST TYPE SCUSTOM-NAME,
                     PA_ROW  TYPE I.
        
        DATA : GT_CUSTLIST TYPE TABLE OF BAPISCUDAT,
               GT_RETURN   TYPE TABLE OF BAPIRET2.
        
        * BAPI 호출.
        CALL FUNCTION 'BAPI_FLCUST_GETLIST'
          EXPORTING
            customer_name = pa_cust
            max_rows      = pa_row
          TABLES
            customer_list = gt_custlist
            return        = gt_return.
        
        * 결과 출력
        CL_DEMO_OUTPUT=>display( gt_return ).
        
        ```
        
    4. 출력 결과
        1. GT_RETURN : BAPI 실행 결과 메시지(오류/경고/정보)를 포함하는 `BAPIRET2` 구조.
            
            
            | 필드 | 설명 |
            | --- | --- |
            | TYPE | 메시지 타입 (S/W/E/I/A) |
            | ID | 메시지 클래스 |
            | NUMBER | 메시지 번호 |
            | MESSAGE | 실제 메시지 |
    5. 참고 사항
        
        ### 1. `CL_DEMO_OUTPUT=>display()`
        
        - ABAP 7.4 이상에서 사용되는 Demo 용 클래스
        - ALV 형태처럼 테이블 데이터를 바로 출력해줌
        - 실무에서는 `CL_SALV_TABLE` 또는 `ALV Grid`를 사용하기도 함
    
    ### 2. RETURN 테이블 출력 이유
    
    - BAPI는 Exception을 던지지 않고
    - 모든 메시지를 **RETURN 테이블**에 담아 전달
        
        → BAPI 성공/실패 여부를 Return 테이블로 판단해야 함
        

# 🔵 Unit 3. Global Classes

1. Global Class란?
    1. 정의 ： SAP ABAP에서 SE24로 생성하는 전역 클래스, 재사용성·유지보수성
    2.  Local Class와의 차이
        1. Local Class: 프로그램 내부에서만 사용
        2. Global Class: Repository 전체에서 사용 가능
2. Global Class 구조
    1. PUBLIC
        1. API 역할 (외부 제공 인터페이스)
    2. PRIVATE 
        1. 클래스 내부에서만 접근
3. 클래스 내부 구조 -  아래와 같은 객체를 담을 수 있는 구조 
    
    ```json
    ┌───────────────────────────────────────────────┐
    │                ZCL_CAR CLASS                  │
    ├───────────────────────────────────────────────┤
    │ PUBLIC SECTION                                 │
    │   METHODS: constructor, start_engine           │
    ├───────────────────────────────────────────────┤
    │ PRIVATE SECTION                                │
    │   Attributes:                                   │
    │     mv_color  TYPE string                      │
    │     mo_engine TYPE REF TO ZCL_ENGINE           │
    │                                                 │
    │   Methods:                                      │
    │     validate_color()                            │
    └───────────────────────────────────────────────┘
    
    Instance Memory when created:
    ┌───────────────────────────────────────────────┐
    │               OBJECT (ZCL_CAR)                │
    ├───────────────────────────────────────────────┤
    │ mv_color   = 'Red'                             │
    │ mo_engine  = REF → ZCL_ENGINE OBJECT           │
    ├───────────────────────────────────────────────┤
    │ Methods (Pointer to Class Implementation)      │
    └───────────────────────────────────────────────┘
    
    ```
    
4. 실습 요약
    1. **Global Class 실습 요약 (Percentage 계산 + Global Class 호출)**
    
    ---
    
    ## 1. 📌 학습 목표
    
    - 기존 FORM / Function Module 로직을 **Global Class**로 전환
    - Static Method 활용
    - Report 프로그램에서 Global Class 호출
    - Exception 처리 적용
    
    ---
    
    ## 2. 📦 만든 Global Class: `ZCL_G01_COMPUTE`
    
    ### ✔ Static Method: `GET_PERCENTAGE`
    
    ```abap
    METHOD get_percentage.
    
      IF iv_max = 0.
    *    ev_percentage = 0.
        RAISE divison_by_zero.
      ELSE.
        ev_percentage = iv_act / iv_max * 100.
      ENDIF.
    
    ENDMETHOD.
    
    ```
    
    ### 📝 특징
    
    - 인스턴스 생성 없이 호출
        
        → `ZCL_G01_COMPUTE=>GET_PERCENTAGE( … )`
        
    - `iv_max = 0` 인 경우 **Exception(divison_by_zero)** 발생
    - 정상일 때는 퍼센트 계산 후 `ev_percentage`로 반환
    
    ---
    
    ## 3. 📘 Report 프로그램: `ZBC400_G01_GLOBAL_CLASS_2`
    
    ### ✔ 입력 파라미터
    
    - `PA_INT1`: 첫 번째 정수
    - `PA_OP`: 연산자 (+, -, *, /, %, P)
    - `PA_INT2`: 두 번째 정수
    
    ### ✔ 결과 변수
    
    ```abap
    DATA gv_result TYPE tv_result.
    
    ```
    
    ---
    
    ## 4. 🔢 연산 처리 흐름
    
    ### ✔ 1) 기본 연산 (+, -, *, /)
    
    ```abap
    CASE pa_op.
      WHEN '+'.
        gv_result = pa_int1 + pa_int2.
      WHEN '-'.
        gv_result = pa_int1 - pa_int2.
      WHEN '*'.
        gv_result = pa_int1 * pa_int2.
      WHEN '/'.
        gv_result = pa_int1 / pa_int2.
    
    ```
    
    ---
    
    ## 5. 🎯 Global Class 사용 (% 퍼센트 계산)
    
    ### ✔ Static Method 호출
    
    ```abap
    CALL METHOD zcl_g01_compute=>get_percentage
      EXPORTING
        iv_act        = pa_int1
        iv_max        = pa_int2
      IMPORTING
        ev_percentage = gv_result.
    
    ```
    
    ### ✔ 기능 설명
    
    - 기존 FORM `CALC_PERCENTAGE` 또는
    - 기존 Function Module `Z_BC400_G01_COMP_PERCENTAGE`
        
        을 대체하는 **Global Class 기반 로직**
        
    
    ---
    
    ## 6. ⚡ 파워 연산(P) + Exception Handling
    
    ### ✔ 표준 예제 클래스 호출
    
    ```abap
    TRY.
        CALL METHOD cl_bc400_compute=>get_power
          EXPORTING
            iv_base   = pa_int1
            iv_power  = pa_int2
          IMPORTING
            ev_result = gv_result.
      CATCH cx_bc400_power_too_high.
        WRITE 'Max value of Power is 4'.
      CATCH cx_bc400_result_too_high.
        WRITE 'Result value was too high'.
    ENDTRY.
    
    ```
    
    ### ✔ 특징
    
    - 파워가 너무 크거나
    - 결과값이 너무 큰 경우
        
        → Global Class Exception이 발생
        
    
    ---
    
    ## 7. 🚫 예외 처리 (Division by Zero / Invalid Operator)
    
    ### ✔ 1) 나누기 0 처리
    
    ```abap
    ELSEIF pa_op = '/' AND pa_int2 = 0.
      WRITE 'No division by zero!'.
    
    ```
    
    ### ✔ 2) 잘못된 연산자
    
    ```abap
    ELSE.
      WRITE 'Invalid operator!'.
    
    ```
    
    ---
    
    ## 8. 🧾 기존 FORM 비교 (구식 방식)
    
    ```abap
    FORM calc_percentage USING pv_act pv_max
                         CHANGING cv_result.
    
      IF pv_max = 0.
        cv_result = 0.
        WRITE 'Error in percentage calculation'.
      ELSE.
        cv_result = pv_act / pv_max * 100.
      ENDIF.
    
    ENDFORM.
    
    ```
    
    ➡️ 이 로직을 **Global Class Static Method로 대체**한 것이 이번 실습의 핵심.
    
    ---
    
    # 🎉 최종 정리
    
    | 항목 | 내용 |
    | --- | --- |
    | Global Class | `ZCL_G01_COMPUTE` |
    | Static Method | `GET_PERCENTAGE` |
    | 기능 | 퍼센트 계산, Exception 처리 |
    | 호출 방식 | `ZCL_G01_COMPUTE=>GET_PERCENTAGE` |
    | 기존 방식 | FORM → Function Module → Global Class 로 진화 |
    | Report 예제 | `ZBC400_G01_GLOBAL_CLASS_2` |

# 🔵 Unit 4. Local Classes

1. Local Class란?
    1. ABAP 프로그램(Report/Include) 내부에만 존재하는 클래스
    2. Global Class와 달리 **해당 프로그램 내부에서만 사용 가능**
    3. SE24(Repository)에 저장되지 않음
2. Local Class 문법 구조
    
    ```json
    CLASS lcl_<name> DEFINITION.
      " 선언부
    ENDCLASS.
    
    CLASS lcl_<name> IMPLEMENTATION.
      " 구현부
    ENDCLASS.
    ```
    
3. 로컬 클래스 구조 이해
    
    ```json
    REPORT ZDEMO.
    
    ┌────────────────────────────────────────┐
    │ Local Class Definition (정의부)        │
    │  CLASS lcl_calc DEFINITION.            │
    │    PUBLIC SECTION.                     │
    │      METHODS add.                      │
    │    PRIVATE SECTION.                    │
    │      DATA mv_value.                    │
    │  ENDCLASS.                             │
    ├────────────────────────────────────────┤
    │ Local Class Implementation (구현부)    │
    │                                        │
    │  METHOD add.                           │
    │     mv_value = ...                     │
    │  ENDMETHOD.                            │
    └────────────────────────────────────────┘
    
    ┌────────────────────────────────────────┐
    │ Report Main Logic                      │
    │  DATA lo_calc = NEW lcl_calc( ).       │
    │  lo_calc->add( ).                      │
    └────────────────────────────────────────┘
    ```
    
4. Local Class 안에서 또 다른 Local Class 생성 가능
    
    ```json
    CLASS lcl_controller DEFINITION.
      PRIVATE SECTION.
        DATA mo_service TYPE REF TO lcl_service.
      PUBLIC SECTION.
        METHODS constructor,
                run.
    ENDCLASS.
    ```
    
5. Local Class 특징 요약
    
    
    | 항목 | Local Class | Global Class |
    | --- | --- | --- |
    | 위치 | Report 내부 | Repository(SE24) |
    | 재사용성 | ❌ 없음 (해당 프로그램 한정) | ✔ 모든 프로그램에서 |
    | 호출 | NEW lcl_xxx | NEW zcl_xxx |
    | 접근제어자 | O (PUBLIC/PRIVATE/PROTECTED) | O |
    | 상속 | O | O |
    | 용도 | 간단한 기능, 일회성 로직 | 전체 비즈니스 로직, API |
6. 로컬 클래스 메서드의 파라미터 
    1. 요약
        
        
        | 파라미터 종류 | 개수 | 용도 |
        | --- | --- | --- |
        | IMPORTING | 여러 개 | 입력값 |
        | EXPORTING | 여러 개 | 출력값 |
        | CHANGING | 여러 개 | 참조로 입력 → 수정해서 반환 |
        | RETURNING | **1개만 가능** | 함수의 단일 반환값 |
    2. RETURNING 파라미터는 왜 1개만 가능할까?
    
    ```json
    RETURNING = 리턴값 → 1개만 허용
    EXPORTING = 출력값 → 여러 개 가능
    CHANGING  = 참조를 수정 → 여러 개 가능
    IMPORTING = 입력 파라미터 → 여러 개 가능
    
    --> ABAP 메서드의 RETURNING 파라미터는 함수 리턴값이기 때문에 
    VALUE(rv_x) 형태의 단일 값만 허용되며, 함수 설계상 1개만 반환 
    가능하므로 EXPORTING·CHANGING과 함께 사용할 수 없다.
    ```
    
7. 실습 요약
    1. ABAP Local Class – Percentage 계산 프로그램
        - **Report: ZABAP_12_G00**
        - Local Class + Static Method + Exception Handling 예제
    
    ---
    
    ## 🔷 1. 프로그램 개요
    
    - Local Class `LCL_COMPUTE` 생성
    - Static Method `GET_PERCENTAGE` 사용
    - 나누기 0일 경우 EXCEPTION `DIVISON_BY_ZERO` 발생
    - Report에서 메서드 호출하고 결과 출력
    
    ---
    
    ## 🔷 2. Local Class 정의부
    
    ```abap
    CLASS lcl_compute DEFINITION.
      PUBLIC SECTION.
        CLASS-METHODS get_percentage
          IMPORTING  iv_act        TYPE bc400_act
                     iv_max        TYPE bc400_max
          EXPORTING  ev_percentage TYPE bc400_perc
          EXCEPTIONS divison_by_zero.
    ENDCLASS.
    
    ```
    
    ---
    
    ## 🔷 3. Local Class 구현부
    
    ```abap
    CLASS lcl_compute IMPLEMENTATION.
      METHOD get_percentage.
        IF iv_max = 0.
          RAISE divison_by_zero.
        ELSE.
          ev_percentage = iv_act * 100 / iv_max.
        ENDIF.
      ENDMETHOD.
    ENDCLASS.
    
    ```
    
    ---
    
    ## 🔷 4. 메인 프로그램 변수 선언
    
    ```abap
    DATA: gv_result TYPE bc400_perc.
    
    ```
    
    ---
    
    ## 🔷 5. Selection Screen
    
    ```abap
    PARAMETERS: pa_act TYPE bc400_act,
                pa_max TYPE bc400_max.
    
    ```
    
    ---
    
    ## 🔷 6. START-OF-SELECTION – Static Method 호출
    
    ```abap
    START-OF-SELECTION.
    
      CALL METHOD lcl_compute=>get_percentage
        EXPORTING
          iv_act          = pa_act
          iv_max          = pa_max
        IMPORTING
          ev_percentage   = gv_result
        EXCEPTIONS
          divison_by_zero = 1
          others          = 2.
    
      IF sy-subrc <> 0.
    * MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
    *   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
    
      WRITE: 'Result : ', gv_result.
    
    ```
    
    ---
    
    ## 🔷 7. 실행 흐름 요약
    
    1. 사용자가 `PA_ACT`, `PA_MAX` 입력
    2. Static Method 호출:
        
        ```
        lcl_compute=>get_percentage( )
        
        ```
        
    3. `IV_MAX = 0` → EXCEPTION
    4. 정상일 때 → 퍼센트 계산 후 `GV_RESULT` 반환
    5. WRITE로 결과 출력
    
    ---
    
    ## 🔷 8. 핵심 포인트
    
    - Local Class는 **Report 안에서만 사용됨**
    - Static Method는 **객체 생성 없이 호출**
    - EXCEPTIONS 절을 사용해 **SAP 전통 방식 예외 처리**
    - RETURNING이 아닌 EXPORTING 사용 → 여러 값 전달 가능

# 🔵 Unit 5. Structured Data Object

1. Structure(구조체) :  
ABAP에서 Structure는 **여러 필드를 묶은 데이터 타입**.
    
    ![image.png](attachment:785008b4-e041-4462-84c3-b1768e8ff953:image.png)
    
2. 구조체(Structure) 생성하는 두 가지 방식
    1. TYPE으로 구조 정의하고 DATA로 생성
        1. 코드
            
            ```json
            TYPES: BEGIN OF ty_person,
                     name  TYPE string, -> 각 컴포넌트들 
                     age   TYPE i,
                     city  TYPE string,
                   END OF ty_person.
            
            DATA ls_person TYPE ty_person. ->  컴포넌트 4개 발생
            ```
            
    2. DDIC 구조 사용 (SFLIGHT, SCUSTOM 등)
        1.  코드 
            
            ```json
            DATA ls_flight TYPE sflight.
            ```
            
    3. 컴포넌트(Component)란  Structure(구조체) 안에 들어 있는 **각 필드**를 말함.
        1. Structure 컴포넌트 Access 기본 문법
            1. 구조체-컴포넌트 접근
            
            ```abap
            ls_person-name
            
            ```
            
        2. 값 읽기 / 쓰기 (기본)
            1. 값 넣기
            
            ```abap
            ls_person-name = 'Kim'.
            ls_person-age  = 30.
            
            ```
            
            1. 값 읽기
            
            ```abap
            WRITE: / ls_person-name.
            ```
            

1. MOVE-CORRESPONDING
    1. MOVE-CORRESPONDING 이란?
        1. 두 구조체(structure) 또는 구조체 ↔ 내부 테이블 간에 **이름이 같은 컴포넌트만 자동 매핑해서 복사** 하는 명령어
        2. 특징
            1. 이름이 같은 필드만 복사됨
            2. 타입이 달라도 자동 변환됨 (가능할 때)
            3. 없는 필드는 무시됨
            4.  중첩 구조체 지원됨
        3. Before / After 비교
            1. 기존 방식 (하나씩 맵핑)
                
                ```abap
                ls_dst-name = ls_src-name.
                ls_dst-age  = ls_src-age.
                ```
                
            2. MOVE-CORRESPONDING 방식
                
                ```abap
                MOVE-CORRESPONDING ls_src TO ls_dst.
                ```
                
                → 필드 이름이 10개, 50개여도 자동으로 복사됨
                
        
2. Structured Data Object  실습
    1. ABAP – 구조체 & MOVE-CORRESPONDING 예제
        
        **Report: `ZABAP_13_G00`**
        
        1. 프로그램 개요
            - **주제**:
                - Global 구조체(`BC400_S_CONNECTION`)와 Local 구조체(`TS_INFO`) 사용
                - `MOVE-CORRESPONDING`으로 구조체 간 필드 자동 매핑
                - FORM을 이용한 구조체 출력
            - **기능 요약**:
                1. 사용자가 CARRID, CONNID 입력
                2. `CL_BC400_FLIGHTMODEL=>GET_CONNECTION` 으로 항공편 데이터 조회
                3. 결과를 Global 구조체 → Local 구조체로 매핑
                4. 두 가지 다른 FORM으로 출력
        2. Local Structure 타입 정의 (`TS_INFO`)
            
            ```abap
            TYPES: BEGIN OF ts_info,
                     carrid   TYPE s_carr_id,
                     carrname TYPE s_carrname,
                     currcode TYPE s_currcode,
                     connid   TYPE s_conn_id,
                     cityfrom TYPE s_from_cit,
                     cityto   TYPE s_to_city,
                     airpfrom TYPE s_fromairp,
                     airpto   TYPE s_toairp,
                   END OF ts_info.
            
            ```
            
            - Local 용 구조체 타입
            - 항공사, 노선, 공항 정보 등을 한 번에 담기 위한 구조
        3. Structure 변수 선언
            
            ```abap
            DATA: gs_info    TYPE ts_info,              " Local 구조체
                  gs_connect TYPE bc400_s_connection.   " Global 구조체(DDIC)
            ```
            
            - `GS_CONNECT` : SAP가 제공하는 Global 구조체 타입
            - `GS_INFO` : 우리가 정의한 Local 구조체 타입
        4. Selection Screen (입력 필드)
            
            ```abap
            PARAMETERS: pa_car TYPE bc400_s_connection-carrid,
                        pa_con TYPE bc400_s_connection-connid.
            ```
            
            - 사용자가 입력하는 값:
                - `PA_CAR` : 항공사 ID
                - `PA_CON` : 항공편 번호
            
            구조체의 컴포넌트 타입을 그대로 사용한 형태.
            
        5.  메인 로직 – Method 호출 & MOVE-CORRESPONDING
            
            ```abap
            TRY.
                CALL METHOD cl_bc400_flightmodel=>get_connection
                  EXPORTING
                    iv_carrid     = pa_car
                    iv_connid     = pa_con
                  IMPORTING
                    es_connection = gs_connect.
            
            * gs_connect 구조체와 필드명이 같은 gs_info 구조체에 매핑
                MOVE-CORRESPONDING gs_connect TO gs_info.
            
                PERFORM write_connection USING gs_connect.
            
                PERFORM write_info USING gs_info.
            
              CATCH cx_bc400_no_data.
              CATCH cx_bc400_no_auth.
            ENDTRY.
            ```
            
            ### 포인트
            
            - `GET_CONNECTION` → DB/Flight Model에서 연결 정보 조회
            - 결과는 **Global 구조체** `GS_CONNECT` 에 저장
            - `MOVE-CORRESPONDING` 으로
                - **동일한 필드 이름만 자동 복사 → `GS_INFO` 에 매핑**
            - 이후:
                - `WRITE_CONNECTION` → Global 구조체 기준 출력
                - `WRITE_INFO` → Local 구조체 기준 출력
        6. FORM `WRITE_CONNECTION` – Global 구조체 출력
            
            ```abap
            FORM write_connection  USING ps_connect TYPE bc400_s_connection.
            
              WRITE: ps_connect-carrid,
                     ps_connect-connid,
                     ps_connect-cityfrom,
                     ps_connect-airpfrom,
                     ps_connect-cityto,
                     ps_connect-airpto,
                     ps_connect-fltime,
                     ps_connect-deptime,
                     ps_connect-arrtime.
            
            ENDFORM.
            
            ```
            
            - 파라미터 타입: `BC400_S_CONNECTION`
            - SAP 표준 구조체 그대로 출력
            - 상세한 시간/출발/도착 정보 포함
        7. FORM `WRITE_INFO` – Local 구조체 출력
            
            ```abap
            FORM write_info  USING ps_info TYPE ts_info.
              ULINE.
              WRITE:/ ps_info-carrid,
                      ps_info-carrname,
                      ps_info-currcode,
                      ps_info-connid,
                      ps_info-cityfrom,
                      ps_info-cityto,
                      ps_info-airpfrom,
                      ps_info-airpto.
            ENDFORM.
            
            ```
            
            - 파라미터 타입: `TS_INFO` (로컬 타입)
            - `MOVE-CORRESPONDING`으로 매핑된 값 사용
            - 항공사명, 통화코드 등 Local 구조체에 맞는 필드 출력
        8. 핵심 개념 정리
            1. **Local Structure 타입 정의**
                - `TYPES: BEGIN OF ts_info ... END OF ts_info.`
                - 프로그램 내에서만 사용하는 구조 정의
            2. **Global Structure 사용**
                - `BC400_S_CONNECTION` 은 DDIC에 정의된 글로벌 타입
                - BAPI/클래스에서 결과를 받을 때 자주 사용
            3. **MOVE-CORRESPONDING**
                - `MOVE-CORRESPONDING gs_connect TO gs_info.`
                - 이름이 같은 필드만 자동으로 매핑
                - Global 구조체 → Local 구조체 변환 시 매우 유용
            4. **STRUCTURE Component Access**
                - `ps_connect-carrid`, `ps_info-carrname` 처럼  로 필드 접근
                - Global/Local 상관 없이 동일 문법
    
    ##
