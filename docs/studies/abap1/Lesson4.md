# 🧭 Lesson 4 - Modularization Techniques in ABAP (2)

# 🔵 Unit 1.  Subroutine Parameter Sol

1. Subroutine 응용 1
    1. 코드
        
        ```json
        PERFORM CALCU_PLUS USING PA_INT1
                                 PA_INT2
                        CHANGING GV_RESULT.
                        
                        ------------------
                        
        FORM CALCU_PLUS  USING  VALUE(PV_INT1) TYPE I
                                VALUE(PV_INT2) TYPE I
        *                " CHANGING VALUE : CALL_BY_VALUE_RESULT
                         CHANGING VALUE(CV_RESULT) TYPE TV_RESULT.
          CV_RESULT = PV_INT1 + PV_INT2.
        
        ENDFORM.
        ```
        
    2. 실행 화면
        
        ![image.png](attachment:25f48f4a-924f-4ac6-afca-1a48f6cc2a2c:image.png)
        
2. Subroutine 응용 2
    1. 코드
        
        ```json
        PERFORM CALCU_MINUS USING PA_INT1
                                  PA_INT2
                                  GV_RESULT.
        *                CHANGING GV_RESULT.
                        
                        ------------------
                        
        FORM CALCU_MINUS  USING   VALUE(PV_INT1) TYPE I
                                  VALUE(PV_INT2) TYPE I
        *                " CHANGING :  CALL_BY_REFERENCE
        *                  CHANGING CV_RESULT TYPE TV_RESULT.
                                  CV_RESULT TYPE TV_RESULT.
           CV_RESULT = PV_INT1 - PV_INT2.
        
        ENDFORM.
        ```
        
    2. 실행 화면
        
        ![image.png](attachment:98317316-a331-4398-a4e2-1f7c81e8ddb4:image.png)
        
    
3. **Generic Typing(제네릭 타입) vs Exact Typing(정확한 타입)** 차이
    1. 핵심 비교표
        
        
        | 구분 | Generic Typing (`TYPE ANY`) | Exact Typing (`TYPE i`, `TYPE p`, 구조 등) |
        | --- | --- | --- |
        | 타입 제약 | 거의 없음 (아무 타입이나 받음) | 명확한 타입만 허용 |
        | 안전성 | **낮음** – 타입 충돌·계산 오류 위험 있음 | **높음** – 컴파일 단계에서 안전하게 체크 |
        | FORM 파라미터 예 | `USING value(pv) TYPE ANY` | `USING value(pv_act) TYPE i` |
        | 계산 정확도 | 떨어짐 (정수 나눗셈 등 오류 가능) | 타입 기반으로 정확한 산술 처리 |
        | 유지보수 | 어려움 (문제가 어디서 터지는지 추적 힘듦) | 쉬움 (타입 명확) |
        | 런타임 오류 | 발생 가능 (문자, 내부테이블 등 들어와도 통과) | 사전 차단됨 |
        | 실무 사용 비율 | 거의 없음 | 표준적, 가장 많이 사용 |
    2. 실습
        1. 코드
            
            ```json
            * selection screen - 인풋/아웃풋 필드.
            PARAMETERS: PA_INT1 TYPE I,
                        PA_INT2 TYPE c LENGTH 10. 
                        -> 문자열도 인식하니 복제 시 유의 (위험한 방식)
                        
            =============================================================
            PERFORM CALCU_DIVIDE USING PA_INT1
                                       PA_INT2
                              CHANGING GV_RESULT.
            =============================================================
            1) FORM CALCU_DIVIDE  USING    PV_INT1 TYPE ANY
                                        PV_INT2 TYPE ANY
                             CHANGING CV_RESULT TYPE ANY.
            
             CV_RESULT = PV_INT1 / PV_INT2.
            
            ENDFORM.             
             -------------------------------------------------------------
            2) FORM CALCU_DIVIDE  USING    PV_INT1 TYPE i "ANY
                                        PV_INT2 TYPE i "ANY
                             CHANGING CV_RESULT TYPE TV_RESULLT "ANY.
            
             CV_RESULT = PV_INT1 / PV_INT2.
            
            ENDFORM.
            ```
            
        2. 실행 화면
            1. ANY
                
                ![image.png](attachment:7bbe68c9-6420-4c45-a85c-842b03bb5362:image.png)
                
            2. EXACT : 덤프 발생
                
                ![image.png](attachment:b83fe89b-820b-44d6-b3e6-96699cdf1bea:image.png)
                
    
4. ABAP Debugger Step Keys
    1. ABAP 디버거 단축키 요약
        
        
        | 단축키 | 이름 | 동작 설명 | 언제 쓰는가(예시) |
        | --- | --- | --- | --- |
        | **F5** | **Step Into** | 현재 실행 줄로 들어감 → **FORM, Function, Method 내부로 진입** | 서브루틴 내부 로직을 자세히 보고 싶을 때 |
        | **F6** | **Step Over** | 한 줄 실행하지만 **서브루틴 안으로 들어가지 않음** | 내부 로직이 길고, 그냥 결과만 보고 싶을 때 |
        | **F7** | **Step Out** | 현재 FORM/Function/Method **빠져나옴** | 이미 깊이 들어왔는데 빨리 밖으로 나오고 싶을 때 |
        | **F8** | **Continue / Run** | 다음 Breakpoint 또는 프로그램 끝까지 실행 | 다음 멈춤점까지 한 번에 실행하고 싶을 때 |
        
        | 단축키 | 비유 |
        | --- | --- |
        | **F5** | 문 안으로 들어가서 방 구석구석 구경함 |
        | **F6** | 문 앞을 통과하며 방은 안 들어가고 건너뜀 |
        | **F7** | 방 안에 너무 깊게 들어왔는데 밖으로 한 번에 나감 |
        | **F8** | 집 끝까지 빠르게 걸어감 (다음 멈춤점까지 직진) |
    
    ---
    

# 🔵 Unit 2.  Calling Function Module

1. Function Moduled의 정의
    1. **SAP에서 공용으로 쓰는 ‘정식 함수’,** FORM은 그냥 프로그램 안에서만 쓰는 “동네 함수” Function Module은 시스템 전체에서 쓸 수 있는 “공식 함수”
2. Function Module 인터페이스 구조
    1. Function Module 파라미터 유형 비교표 (IMPORT / EXPORT / CHANGING / TABLES)
    
    | 파라미터 | 방향(Direction) | 용도 | 내부 동작 방식 | 원본 값 변경 여부 | 특징 |
    | --- | --- | --- | --- | --- | --- |
    | **IMPORT** | 입력(Input) | FM에서 **읽기만** 할 값 | CALL FUNCTION 시 전달된 값이 FM 내부로 복사됨 (copy-in) | ❌ 변경 불가 | FORM의 USING과 유사 |
    | **EXPORT** | 출력(Output) | FM에서 계산 후 **돌려줄 값** | FM 내부 값이 호출자에게 복사됨 (copy-out) | ⭕ 호출자 변수에 결과 덮어씀 | FORM의 CHANGING VALUE(…)에서 값 반환만 담당 |
    | **CHANGING** | 입력 + 출력(In/Out) | 값을 받고, 수정해서 돌려줄 때 | copy-in + copy-out | ⭕ 변경됨 | FORM의 CHANGING과 유사 |
    | **TABLES** | 테이블 전달 | 내부 테이블을 넣고 빼는 전통적인 방식 | 참조 전달 (reference) | ⭕ 바로 원본 변경됨 | 구버전 문법 → 요즘은 CHANGING 사용하는 것을 권장 |

1. IMPORT 파라미터
    
    ![image.png](attachment:56582d36-5258-4eec-ab31-bfcca8d8a379:image.png)
    
    1. Function Module로 값을 “가져오는(입력하는)” 파라미터 = copy-in 방식
    2. ABAP 메인 프로그램과 Function Module 코드의 작용 구조
        
        ```json
        " FM 호출
        CALL FUNCTION 'Z_FM_IMPORT_DEMO'
          IMPORTING                " FM으로 값을 전달하는 구문(입력)
            iv_num1 = pa_num1      " pa_num1 값이 FM의 iv_num1으로 copy-in
            iv_num2 = pa_num2      " pa_num2 값이 FM의 iv_num2으로 copy-in
          EXPORTING                " FM에서 계산 결과 받기
            ev_sum  = gv_result.
        
        WRITE: / 'NUM1  :', pa_num1,
               / 'NUM2  :', pa_num2,
               / 'SUM   :', gv_result.
        ```
        

1. Function module  실습
    1. P 연산자 실습
        1. 코드
            
            ```json
            *&---------------------------------------------------------------------*
            *& Report ZBC400_G01_COMPUTE
            *&---------------------------------------------------------------------*
            *&
            *&---------------------------------------------------------------------*
            REPORT ZBC400_G01_FUNCTION_MODULE.
            
            * Local Data Type 선언.
            TYPES TV_RESULT TYPE P LENGTH 16 DECIMALS 2.
            
            PARAMETERS PA_INT1 TYPE I.
            PARAMETERS PA_OP TYPE C LENGTH 1.
            PARAMETERS PA_INT2 TYPE I.
            
            DATA GV_RESULT TYPE TV_RESULT.
            
            IF ( PA_OP = '+' OR
                 PA_OP = '-' OR
                 PA_OP = '*' OR
                 PA_OP = '/' AND PA_INT2 <> 0 OR
                 PA_OP = '%' OR
                 PA_OP = 'P').
            
              CASE PA_OP.
                WHEN '+'.
                  GV_RESULT = PA_INT1 + PA_INT2.
                WHEN '-'.
                  GV_RESULT = PA_INT1 - PA_INT2.
                WHEN '*'.
                  GV_RESULT = PA_INT1 * PA_INT2.
                WHEN '/'.
                  GV_RESULT = PA_INT1 / PA_INT2.
                WHEN '%'.
                  PERFORM CALC_PERCENTAGE USING PA_INT1
                                                PA_INT2
                                       CHANGING GV_RESULT.
                WHEN 'P'.
                  CALL FUNCTION 'BC400_MOS_POWER'
                    EXPORTING
                     IV_BASE                     = PA_INT1
                     IV_POWER                    = PA_INT2
                   IMPORTING
                     EV_RESULT                   = GV_RESULT
                   EXCEPTIONS
                     POWER_VALUE_TOO_HIGH        = 1
                     RESULT_VALUE_TOO_HIGH       = 2
                     OTHERS                      = 3.
            
                    CASE sy-subrc.
            *         no action needed
                      WHEN 1.
                        WRITE 'Max value of power is 4'.
                      WHEN 2.
                        WRITE 'Result value too high'.
                      WHEN 3.
                         WRITE 'Unknown error'(uer).
                    ENDCASE.
            
              ENDCASE.
            
              WRITE : 'Result:', GV_RESULT.
            
            ELSEIF PA_OP = '/' AND PA_INT2 = 0.
              WRITE 'No division by zero!'.
            ELSE.
              WRITE 'Invalid operator!'.
            ENDIF.
            *&---------------------------------------------------------------------*
            *& Form CALC_PERCENTAGE
            *&---------------------------------------------------------------------*
            *& text
            *&---------------------------------------------------------------------*
            *&      --> PA_INT1
            *&      --> PA_INT2
            *&      <-- GV_RESULT
            *&---------------------------------------------------------------------*
            FORM CALC_PERCENTAGE  USING PV_ACT TYPE I
                                        PV_MAX TYPE I
                               CHANGING CV_RESULT TYPE TV_RESULT.
            
              IF PV_MAX = 0.
                CV_RESULT = 0.
                WRITE : 'Error in percentage calculation'.
              ELSE.
                CV_RESULT = PV_ACT / PV_MAX * 100.
              ENDIF.
            
            ENDFORM.
            ```
            
        2. 실행 화면
            
            ![image.png](attachment:42d29a98-d64e-4e53-bdd7-2a4a9edeae0c:image.png)
            
            ![image.png](attachment:c8277428-a5be-4dc6-a5c8-2f14c360cbb3:image.png)
            
    2. RH_GET_DATE_DAYNAME 실습
        1. 코드
            
            ```json
            *&---------------------------------------------------------------------*
            *& Report ZABAP_09_G01
            *&---------------------------------------------------------------------*
            *&
            *&---------------------------------------------------------------------*
            REPORT ZABAP_09_G01.
            
            * Function Module 호출 후  Export 파라미터 값을 받을 변수.
            DATA : GV_DAYNR  TYPE HRVSCHED-DAYNR,
                   GV_DAYTXT TYPE HRVSCHED-DAYTXT.
            
            * parameter
            PARAMETERS PA_DATE TYPE DATS.
            
            * Function module 호출.
            CALL FUNCTION 'RH_GET_DATE_DAYNAME'
              EXPORTING
                LANGU               = SY-LANGU
                DATE                = PA_DATE
              IMPORTING
                DAYNR               = GV_DAYNR
                DAYTXT              = GV_DAYTXT
              EXCEPTIONS
                NO_LANGU            = 1
                NO_DATE             = 2
                NO_DAYTXT_FOR_LANGU = 3
                INVALID_DATE        = 4
                OTHERS              = 5.
            IF SY-SUBRC <> 0.
            * Implement suitable error handling here
              CASE SY-SUBRC.
                WHEN 1 OR 3.
                  WRITE '언어를 잘못 입력하였습니다.'.
                WHEN 2 OR 4.
                  WRITE '날짜를 잘못 입력하였습니다.'.
                WHEN OTHERS.
              ENDCASE.
            
            ELSE.
              WRITE:/ '요일 숫자 : ' , GV_DAYNR,
                    / '요일 텍스트 : ', GV_DAYTXT.
            ENDIF.
            ```
            
        2. 실행 화면
            
            ![image.png](attachment:f66e2717-0ada-437f-ba36-f8085cdc6ac1:image.png)
            
            ![image.png](attachment:2b325c3e-d5cb-46fe-868a-2336c843f689:image.png)
            
        3. 요약 및 정리
            1. Function Module: RH_GET_DATE_DAYNAME 요약
                
                `RH_GET_DATE_DAYNAME` 은 **날짜(Date)** 를 입력하면
                
                ➡ 요일 번호(DAYNR)
                
                ➡ 요일 텍스트(DAYTXT)
                
                를 SAP 표준 방식으로 돌려주는 Function Module이다.
                
                언어는 **SY-LANGU**(현재 사용자 로그인 언어)에 따라 자동 결정됨.
                
            2. ABAP 코드 (정리 버전)
                
                ```abap
                REPORT zabap_09_g01.
                
                " Function Module에서 가져올 결과 변수
                DATA: gv_daynr  TYPE hrvsched-daynr,
                      gv_daytxt TYPE hrvsched-daytxt.
                
                " 날짜 입력 파라미터
                PARAMETERS pa_date TYPE dats.
                
                " FM 호출
                CALL FUNCTION 'RH_GET_DATE_DAYNAME'
                  EXPORTING
                    langu = sy-langu       " 로그인 언어 자동 적용
                    date  = pa_date
                  IMPORTING
                    daynr = gv_daynr
                    daytxt = gv_daytxt
                  EXCEPTIONS
                    no_langu             = 1
                    no_date              = 2
                    no_daytxt_for_langu = 3
                    invalid_date         = 4
                    others               = 5.
                
                " 오류 처리
                IF sy-subrc <> 0.
                
                  CASE sy-subrc.
                    WHEN 1 OR 3.
                      WRITE '언어를 잘못 입력하였습니다.'.
                    WHEN 2 OR 4.
                      WRITE '날짜를 잘못 입력하였습니다.'.
                    WHEN OTHERS.
                      WRITE '알 수 없는 오류가 발생했습니다.'.
                  ENDCASE.
                
                " 정상 처리
                ELSE.
                  WRITE: / '요일 숫자 : ', gv_daynr,
                         / '요일 텍스트 : ', gv_daytxt.
                ENDIF.
                
                ```
                
            3. 파라미터 설명
                1.  EXPORTING (입력값)
                    
                    
                    | 파라미터 | 설명 |
                    | --- | --- |
                    | LANGU | `SY-LANGU`: 현재 로그인한 SAP 사용자 언어 |
                    | DATE | 조회할 날짜(YYYYMMDD) |
                2. IMPORTING (출력값)
                    
                    
                    | 파라미터 | 의미 |
                    | --- | --- |
                    | DAYNR | 요일 번호 (1=월요일 … 7=일요일) |
                    | DAYTXT | 요일 텍스트 (언어에 따라 자동 변환) |
            4. Exception 처리
                
                
                | SY-SUBRC | 오류 의미 | 출력 메시지 |
                | --- | --- | --- |
                | 1 | 언어(language) 오류 | 언어를 잘못 입력하였습니다. |
                | 2 | 날짜(date) 오류 | 날짜를 잘못 입력하였습니다. |
                | 3 | 해당 언어에 대한 요일 텍스트 없음 | 언어를 잘못 입력하였습니다. |
                | 4 | 잘못된 날짜 형식 | 날짜를 잘못 입력하였습니다. |
                | 5 | 기타 오류 | 알 수 없는 오류 발생 |
    3. FIMA_DAYS_AND_MONTHS_AND_YEARS 실습
        1. 코드
            
            ```json
            *&---------------------------------------------------------------------*
            *& Report ZABAP_10_G01
            *&---------------------------------------------------------------------*
            *&
            *&---------------------------------------------------------------------*
            REPORT ZABAP_10_G01.
            
            DATA : GV_DAYS   TYPE VTBBEWE-ATAGE,
                   GV_MONTHS TYPE VTBBEWE-ATAGE,
                   GV_YEARS  TYPE VTBBEWE-ATAGE.
            
            PARAMETERS PA_BIRDT TYPE DATS. "생년월일 입력.
            
            CALL FUNCTION 'FIMA_DAYS_AND_MONTHS_AND_YEARS'
              EXPORTING
                I_DATE_FROM = PA_BIRDT
                I_DATE_TO   = SY-DATUM
                I_FLG_ROUND_UP       = 'X' "반올림 처리 여부 X하면 반올림 처리됨.
              IMPORTING
                E_DAYS      = GV_DAYS
                E_MONTHS    = GV_MONTHS
                E_YEARS     = GV_YEARS.
            
            WRITE: '나이 : ',GV_YEARS.
            ```
            
        2. 실행 화면
            
            ![image.png](attachment:e982458c-1110-4cad-8d75-9383fdd1491e:image.png)
            
            ![image.png](attachment:c742bd2a-7153-4821-a92a-8a44f991cdfe:image.png)
            
        3. 요약 및 정리
            1. 요약
                1. **생년월일 → 나이 계산하는 Function Module**이 FM은 두 날짜 사이의 **일수(DAYS), 개월(MONTHS), 년수(YEARS)**를 계산해주는 SAP 표준 기능이다.
                2. 생년월일(PA_BIRDT)부터 오늘(SY-DATUM)까지의 년/월/일 차이를 돌려주므로이를 이용해 *나이 계산 프로그램*을 만들 수 있다.
            2.  ABAP 코드 (정리 버전)
                
                ```abap
                REPORT zabap_10_g01.
                
                " FM 결과 담을 변수들
                DATA: gv_days   TYPE vtbb ewe-atage,
                      gv_months TYPE vtbb ewe-atage,
                      gv_years  TYPE vtbb ewe-atage.
                
                " 생년월일 입력
                PARAMETERS pa_birth TYPE dats.
                
                " FM 호출
                CALL FUNCTION 'FIMA_DAYS_AND_MONTHS_AND_YEARS'
                  EXPORTING
                    i_date_from   = pa_birth          " 시작 날짜(생년월일)
                    i_date_to     = sy-datum          " 끝 날짜(오늘)
                    i_flg_round_up = 'X'              " 반올림 사용
                  IMPORTING
                    e_days   = gv_days
                    e_months = gv_months
                    e_years  = gv_years.
                
                " 나이 출력
                WRITE: '나이 : ', gv_years.
                
                ```
                
            3. 파라미터 설명
                1. EXPORTING (입력 파라미터)
                    
                    
                    | 파라미터 | 설명 |
                    | --- | --- |
                    | I_DATE_FROM | 시작 날짜 → **생년월일** |
                    | I_DATE_TO | 끝 날짜 → **오늘 날짜(SY-DATUM)** |
                    | I_FLG_ROUND_UP | `'X'` = 반올림 처리`' '` = 반올림 없음 |
                2.  IMPORTING (출력 파라미터)
                    
                    
                    | 파라미터 | 의미 |
                    | --- | --- |
                    | E_DAYS | 두 날짜 사이의 총 일수 |
                    | E_MONTHS | 총 개월 수 |
                    | E_YEARS | 총 년 수 = **나이(years)** |
2. Creating Function Group & Modules
    1. 경로
        
        ![image.png](attachment:e60cc252-2e40-4a6f-ac60-45861d6a606f:image.png)
        
    2. LZFUNC_GRP_G01TOP
        
        ```json
        FUNCTION-POOL ZFUNC_GRP_G01.                "MESSAGE-ID ..
        
        * INCLUDE LZFUNC_GRP_G01D...                 " Local class definition
        
        CONSTANTS gc_pi TYPE p LENGTH 3 DECIMALS 2 VALUE '3.14'.
        ```
        
    3. Z_CALCU_CIRCLE_G01
        
        ```json
        FUNCTION Z_CALCU_CIRCLE_G01.
        *"----------------------------------------------------------------------
        *"*"Local Interface:
        *"  IMPORTING
        *"     REFERENCE(IV_RADI) TYPE  I
        *"     REFERENCE(IV_TYPE) TYPE  CHAR1
        *"  EXPORTING
        *"     REFERENCE(EV_RESULT) TYPE  BC400_PERC
        *"  EXCEPTIONS
        *"      INVALID_TYPE
        *"----------------------------------------------------------------------
        
        * 로컬 상수 선언.
        CONSTANTS lc_pi TYPE p LENGTH 3 DECIMALS 3 VALUE '3.14'.
        
        * iv_type 파라미터의 값이 S 또는 R 일 경우.
          IF IV_TYPE = 'S' OR IV_TYPE = 'R'.
            CASE IV_TYPE.
              WHEN 'S'.
                EV_RESULT = GC_PI * IV_RADI ** 2.
              WHEN 'R'.
                EV_RESULT = LC_PI * IV_RADI * 2.
            ENDCASE.
        
        * 아닐 경우 Exception 발생.
          ELSE.
        * Exception 발생.
            RAISE INVALID_TYPE.
        
          ENDIF.
        
        ENDFUNCTION.
        ```
        
3. Creating Function Group & Modules 실습
    1. ABAP 프로그램 정리 – ZBC400_G01_FUNCTION_MODULE_2
    
    ### 1. 개요
    
    이 프로그램은 두 개의 숫자 입력과 연산자를 받아 계산을 수행하는 간단한 계산기 형태의 ABAP Report 프로그램이다.
    
    기본 연산(+, -, *, /) 뿐 아니라 `%`(백분율 계산), `P`(제곱 계산) 연산을 위해 함수 모듈도 호출한다.
    
    ---
    
    ### 2. Local Type 선언
    
    ```abap
    TYPES TV_RESULT TYPE P LENGTH 16 DECIMALS 2.
    ```
    
    - 계산 결과를 저장하기 위한 PACKED 형식 데이터 타입.
    
    ---
    
    ### 3. 파라미터 정의
    
    ```abap
    PARAMETERS PA_INT1 TYPE I.
    PARAMETERS PA_OP TYPE C LENGTH 1.
    PARAMETERS PA_INT2 TYPE I.
    ```
    
    - `PA_INT1`: 첫 번째 정수 입력
    - `PA_OP`: 연산자 (+, -, *, /, %, P)
    - `PA_INT2`: 두 번째 정수 입력
    
    ---
    
    ### 4. 주요 변수
    
    ```abap
    DATA GV_RESULT TYPE TV_RESULT.
    ```
    
    - 계산 결과 저장 변수
    
    ---
    
    ### 5. 연산자 검증 및 CASE 문
    
    연산자가 유효한지 확인한 뒤, CASE 구문으로 각각의 연산 처리.
    
    지원되는 연산자
    
    - `+` : 덧셈
    - : 뺄셈
    - : 곱셈
    - `/` : 나눗셈 (0 나누기 처리 포함)
    - `%` : 백분율 계산 (커스텀 함수 호출)
    - `P` : 제곱 계산 (표준 함수 모듈 호출)
    
    ---
    
    ### 6. 연산 처리 상세
    
    6.1 기본 연산
    
    ```abap
    WHEN '+'.
      GV_RESULT = PA_INT1 + PA_INT2.
    WHEN '-'.
      GV_RESULT = PA_INT1 - PA_INT2.
    WHEN '*'.
      GV_RESULT = PA_INT1 * PA_INT2.
    WHEN '/'.
      GV_RESULT = PA_INT1 / PA_INT2.
    ```
    
    ---
    
    ### 7. 백분율 계산 (%)
    
    함수 모듈 호출 방식
    
    ```abap
    CALL FUNCTION 'Z_BC400_G01_COMP_PERCENTAGE'
      EXPORTING
        IV_ACT     = PA_INT1
        IV_MAX     = PA_INT2
      IMPORTING
        EV_PERCENTAGE = GV_RESULT
      EXCEPTIONS
        DIVISION_BY_ZERO = 1
        OTHERS           = 2.
    ```
    
    - 나눗셈 0 처리 포함
    - 정상 실행 시 `GV_RESULT`에 결과 저장
    
    ---
    
    ### 8. 제곱 계산 (P)
    
    표준 함수 모듈 호출
    
    ```abap
    CALL FUNCTION 'BC400_MOS_POWER'
      EXPORTING
        IV_BASE  = PA_INT1
        IV_POWER = PA_INT2
      IMPORTING
        EV_RESULT = GV_RESULT
      EXCEPTIONS
        POWER_VALUE_TOO_HIGH = 1
        RESULT_VALUE_TOO_HIGH = 2
        OTHERS = 3.
    ```
    
    예외 처리
    
    - `POWER_VALUE_TOO_HIGH`: 최대 제곱값 4 초과
    - `RESULT_VALUE_TOO_HIGH`: 결과 값 범위 초과
    - 기타 오류
    
    ---
    
    ### 9. 결과 출력
    
    ```abap
    WRITE: 'Result:', GV_RESULT.
    ```
    
    ---
    
    ### 10. 에러 상황
    
    1) 0으로 나누려고 할 때
    
    ```abap
    ELSEIF PA_OP = '/' AND PA_INT2 = 0.
      WRITE 'No division by zero!'.
    ```
    
    2) 지원되지 않는 연산자
    
    ```abap
    ELSE.
      WRITE 'Invalid operator!'.
    ```
    
    ---
    
    ### 11. FORM 루틴 – CALC_PERCENTAGE
    
    백분율을 계산하는 로직(현재는 함수 모듈로 대체됨).
   ```abap
    FORM CALC_PERCENTAGE USING PV_ACT PV_MAX
                     CHANGING CV_RESULT TYPE TV_RESULT.

    IF PV_MAX = 0.
      CV_RESULT = 0.
    WRITE: 'Error in percentage calculation'.
    ELSE.
      CV_RESULT = PV_ACT / PV_MAX * 100.
    ENDIF.

    ENDFORM.
  ```
