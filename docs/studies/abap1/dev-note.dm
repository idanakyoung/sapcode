## 템플릿

- 타입 & 데이터 선언 만능 템플릿 1 - STANDARD TABLE
    
    ```abap
    " 1) 화면/리포트에 보여줄 최종 구조 정의
    TYPES: BEGIN OF ty_output,
             key1      TYPE tab1-key1,
             key2      TYPE tab2-key2,
             calc_sum  TYPE p LENGTH 16 DECIMALS 2,
             calc_avg  TYPE p LENGTH 16 DECIMALS 2,
             text_info TYPE string,
           END OF ty_output.
    
    DATA: gt_output TYPE TABLE OF ty_output,
          gs_output TYPE ty_output.
          
    ************************************************************ 
    (A) TYPES 방식 – 타입을 정의하고 그걸 기반으로 변수 생성
    TYPES: BEGIN OF ts_cnt,
             customid TYPE sbook-customid,
             bookcnt  TYPE i,
           END OF ts_cnt.
    
    DATA: gs_cnt TYPE ts_cnt,
          gt_cnt TYPE TABLE OF ts_cnt.
    
    (B) DATA 방식 – 변수 선언하면서 구조를 바로 만드는 방식
    DATA: BEGIN OF gs_cnt,
            customid TYPE sbook-customid,
            bookcnt  TYPE i,
          END OF gs_cnt,
          gt_cnt LIKE TABLE OF gs_cnt.
    
    ```
    
- 타입 & 데이터 선언 만능 템플릿 2 - SORTED TABLE WITH UNIQUE KEY
    
    ```abap
    " 키별 합계/건수 집계에 최적화된 구조
    TYPES: BEGIN OF ty_agg,
             key1 TYPE tab-field1,
             key2 TYPE tab-field2,
             sum  TYPE p LENGTH 16 DECIMALS 2,
             cnt  TYPE i,
           END OF ty_agg.
    
    DATA: gt_agg TYPE SORTED TABLE OF ty_agg
                   WITH UNIQUE KEY key1 key2,
          gs_agg TYPE ty_agg.
    
    ```
    
- PARAMETERS 템플릿
    
    ```abap
    PARAMETERS: p_key   TYPE tab-key OBLIGATORY,
                p_from  TYPE dats,
                p_to    TYPE dats.
    
    AT SELECTION-SCREEN.
      IF p_from IS INITIAL OR p_to IS INITIAL.
        MESSAGE '기간을 입력하세요.' TYPE 'E'.
      ENDIF.
    
    ```
    
- SELECT-OPTIONS 템플릿 (INITIALIZATION, AT SELECTION-SCREEN 포함)
    
    ```abap
    SELECT-OPTIONS: so_key   FOR tab-key,
                    so_date  FOR tab-date.
    
    INITIALIZATION.
      so_date-sign   = 'I'.
      so_date-option = 'BT'.
      so_date-low    = sy-datum - 30. "최근 30일
      so_date-high   = sy-datum.
      APPEND so_date.
    
    AT SELECTION-SCREEN.
    
      READ TABLE so_date INDEX 1.
      IF sy-subrc <> 0.
        MESSAGE '조회기간을 입력하세요.' TYPE 'E'.
      ENDIF.
      
      IF p_jikwi < 1 OR p_jikwi > 7.
        MESSAGE '직위 코드는 1~7 사이여야 합니다.' TYPE 'E'.
      ENDIF.
    
      IF p_dob > sy-datum.
        MESSAGE '생년월일이 올바르지 않습니다.' TYPE 'E'.
      ENDIF.
    ```
    
- SELECT ... INTO CORRESPONDING FIELDS OF TABLE 템플릿
    
    ```abap
    TYPES: BEGIN OF ty_out,
             id    TYPE tab-id,
             name  TYPE tab-name,
             ...,
           END OF ty_out.
    
    DATA: gt_out TYPE TABLE OF ty_out.
    
    SELECT field1 field2 ...
      INTO CORRESPONDING FIELDS OF TABLE gt_out
      FROM tab
      WHERE ....
    ```
    
- JOIN 패턴 템플릿
    
    ```abap
    SELECT a~key1
           a~field1
           b~field2
           c~field3
      INTO CORRESPONDING FIELDS OF TABLE gt_join
      FROM tab_a AS a
      INNER JOIN tab_b AS b ON b~key = a~key
      INNER JOIN tab_c AS c ON c~key = b~key2
      WHERE a~cond1 = ...
        AND b~cond2 = ...
        AND c~cond3 = ....
    ```
    
- COLLECT 패턴 템플릿
    
    ```abap
    TYPES: BEGIN OF ty_count,
             key1    TYPE tab-key1,
             key2    TYPE tab-key2,
             cnt     TYPE i,
           END OF ty_count.
    
    DATA: gt_count TYPE SORTED TABLE OF ty_count
                     WITH UNIQUE KEY key1 key2,
          gs_count TYPE ty_count.
    
    LOOP AT gt_source INTO DATA(gs_src).
      CLEAR gs_count.
      gs_count-key1 = gs_src-key1.
      gs_count-key2 = gs_src-key2.
      gs_count-cnt  = 1.
      COLLECT gs_count INTO gt_count.
    ENDLOOP.
    ```
    
- Subroutine (FORM / PERFORM) 템플릿
    
    ```abap
    PERFORM sub_xxx USING    var1 var2
                    CHANGING var3.
    
    FORM sub_xxx
      USING    pv_1 TYPE type1
               pv_2 TYPE type2
      CHANGING cv_3 TYPE type3.
      ...
    ENDFORM.
    ```
    
- 1) 결과 구조 + 집계 구조 템플릿
    
    ```abap
    " 최종 출력 구조
    TYPES: BEGIN OF ty_output,
             key1       TYPE tab1-key1,
             key2       TYPE tab2-key2,
             sum_value  TYPE p LENGTH 16 DECIMALS 2,
             avg_value  TYPE p LENGTH 16 DECIMALS 2,
             text_info  TYPE string,
           END OF ty_output.
    
    DATA: gt_output TYPE TABLE OF ty_output,
          gs_output TYPE ty_output.
    
    " 1차 집계 구조 (SUM + CNT)
    TYPES: BEGIN OF ty_agg,
             key1      TYPE tab1-key1,
             key2      TYPE tab2-key2,
             sum_value TYPE p LENGTH 16 DECIMALS 2,
             cnt       TYPE i,
           END OF ty_agg.
    
    DATA: gt_agg TYPE TABLE OF ty_agg,
          gs_agg TYPE ty_agg.
    
    ```
    
- 2) Selection Screen + 기본값 + 검증 템플릿
    
    ```abap
    PARAMETERS: p_year TYPE n LENGTH 4 OBLIGATORY.
    SELECT-OPTIONS: so_key   FOR tab-key,
                    so_date  FOR tab-date.
    
    INITIALIZATION.
      IF p_year IS INITIAL.
        p_year = sy-datum+0(4).
      ENDIF.
    
      so_date-sign   = 'I'.
      so_date-option = 'BT'.
      so_date-low    = p_year && '0101'.
      so_date-high   = p_year && '1231'.
      APPEND so_date.
    
    AT SELECTION-SCREEN.
      IF p_year IS INITIAL.
        MESSAGE '년도를 입력하세요.' TYPE 'E'.
      ENDIF.
    
      READ TABLE so_date INDEX 1.
      IF sy-subrc <> 0.
        MESSAGE '기간을 입력하세요.' TYPE 'E'.
      ENDIF.
    
    ```
    
- 3) DB SUM + GROUP BY 집계 템플릿
    
    ```abap
    TYPES: BEGIN OF ty_sum,
             key1  TYPE tab-key1,
             key2  TYPE tab-key2,
             total TYPE p LENGTH 16 DECIMALS 2,
           END OF ty_sum.
    
    DATA: gt_sum TYPE TABLE OF ty_sum.
    
    SELECT key1,
           key2,
           SUM( amount ) AS total
      INTO TABLE @gt_sum
      FROM tab
      WHERE key1 IN @so_key
        AND date IN @so_date
      GROUP BY key1, key2.
    
    ```
    
- 4) COLLECT를 이용한 그룹 합계/건수 템플릿
    
    ```abap
    TYPES: BEGIN OF ty_collect,
             key1 TYPE tab-key1,
             key2 TYPE tab-key2,
             sum  TYPE p LENGTH 16 DECIMALS 2,
             cnt  TYPE i,
           END OF ty_collect.
    
    DATA: gt_collect TYPE SORTED TABLE OF ty_collect
                       WITH UNIQUE KEY key1 key2,
          gs_collect TYPE ty_collect.
    
    " 소스 데이터 읽기
    SELECT *
      INTO TABLE @DATA(gt_src)
      FROM tab
      WHERE ...
    
    " 합계 + 건수 집계
    LOOP AT gt_src INTO DATA(gs_src).
      CLEAR gs_collect.
      gs_collect-key1 = gs_src-key1.
      gs_collect-key2 = gs_src-key2.
      gs_collect-sum  = gs_src-amount.
      gs_collect-cnt  = 1.
      COLLECT gs_collect INTO gt_collect.
    ENDLOOP.
    
    ```
    
- 5) 2단계 집계(합계/건수 → 평균) 템플릿
    
    ```abap
    " 1차: SUM + CNT 집계 (위 COLLECT 또는 수동 READ/MODIFY 사용)
    
    " 2차: 평균 계산 + 출력 구조 만들기
    LOOP AT gt_collect INTO gs_collect.
      CLEAR gs_output.
    
      " 필요하면 마스터 테이블에서 이름/설명 읽기
      READ TABLE gt_master INTO DATA(gs_master)
        WITH KEY key1 = gs_collect-key1
        BINARY SEARCH.
    
      IF sy-subrc = 0.
        gs_output-key1      = gs_master-key1.
        gs_output-text_info = gs_master-text.
      ELSE.
        gs_output-key1      = gs_collect-key1.
      ENDIF.
    
      gs_output-key2 = gs_collect-key2.
    
      IF gs_collect-cnt > 0.
        gs_output-avg_value = gs_collect-sum / gs_collect-cnt.
      ENDIF.
    
      gs_output-sum_value = gs_collect-sum.
    
      APPEND gs_output TO gt_output.
    ENDLOOP.
    
    ```
    
- 6) 월별 PIVOT 리포트 템플릿
    
    ```abap
    TYPES: BEGIN OF ty_month_sum,
             key      TYPE tab-key,
             jan_sum  TYPE p LENGTH 16 DECIMALS 2,
             feb_sum  TYPE p LENGTH 16 DECIMALS 2,
             mar_sum  TYPE p LENGTH 16 DECIMALS 2,
             apr_sum  TYPE p LENGTH 16 DECIMALS 2,
             may_sum  TYPE p LENGTH 16 DECIMALS 2,
             jun_sum  TYPE p LENGTH 16 DECIMALS 2,
             jul_sum  TYPE p LENGTH 16 DECIMALS 2,
             aug_sum  TYPE p LENGTH 16 DECIMALS 2,
             sep_sum  TYPE p LENGTH 16 DECIMALS 2,
             oct_sum  TYPE p LENGTH 16 DECIMALS 2,
             nov_sum  TYPE p LENGTH 16 DECIMALS 2,
             dec_sum  TYPE p LENGTH 16 DECIMALS 2,
           END OF ty_month_sum.
    
    DATA: gt_month TYPE TABLE OF ty_month_sum,
          gs_month TYPE ty_month_sum.
    
    " key 마스터 LOOP
    LOOP AT gt_key INTO DATA(gs_key).
      CLEAR gs_month.
      gs_month-key = gs_key-key.
    
      LOOP AT gt_src INTO DATA(gs_src)
           WHERE key = gs_key-key.
    
        DATA(lv_month) = gs_src-date+4(2).
    
        CASE lv_month.
          WHEN '01'. gs_month-jan_sum += gs_src-amount.
          WHEN '02'. gs_month-feb_sum += gs_src-amount.
          WHEN '03'. gs_month-mar_sum += gs_src-amount.
          WHEN '04'. gs_month-apr_sum += gs_src-amount.
          WHEN '05'. gs_month-may_sum += gs_src-amount.
          WHEN '06'. gs_month-jun_sum += gs_src-amount.
          WHEN '07'. gs_month-jul_sum += gs_src-amount.
          WHEN '08'. gs_month-aug_sum += gs_src-amount.
          WHEN '09'. gs_month-sep_sum += gs_src-amount.
          WHEN '10'. gs_month-oct_sum += gs_src-amount.
          WHEN '11'. gs_month-nov_sum += gs_src-amount.
          WHEN '12'. gs_month-dec_sum += gs_src-amount.
        ENDCASE.
    
      ENDLOOP.
    
      APPEND gs_month TO gt_month.
    ENDLOOP.
    
    ```
    
- 7) LIKE 검색 + 점수/등급 템플릿
    
    ```abap
    PARAMETERS: p_name TYPE scustom-name.
    SELECT-OPTIONS: so_fdate FOR sbook-fldate NO-EXTENSION.
    
    DATA: lv_pattern TYPE scustom-name.
    
    AT SELECTION-SCREEN.
      IF p_name IS INITIAL.
        MESSAGE '이름을 입력하세요.' TYPE 'E'.
      ENDIF.
    
      IF strlen( p_name ) < 4.
        MESSAGE '이름은 4자리 이상 입력하세요.' TYPE 'E'.
      ENDIF.
    
    START-OF-SELECTION.
      lv_pattern = '%' && p_name && '%'.
    
      SELECT ...
        INTO TABLE @DATA(gt_join)
        FROM scustom
        INNER JOIN sbook     ON ...
        INNER JOIN ztsurvey  ON ...
       WHERE scustom~name LIKE @lv_pattern
         AND sbook~fldate IN @so_fdate
         AND sbook~cancelled <> 'X'.
    
      LOOP AT gt_join INTO DATA(gs_join).
        DATA(lv_avg)  = ( gs_join-score1 + gs_join-score2 +
                          gs_join-score3 + gs_join-score4 +
                          gs_join-score5 ) / 5.
        DATA(lv_avg10) = lv_avg * 10.
    
        DATA(lv_status) TYPE char1.
        IF lv_avg10 < 50.
          lv_status = 'L'.
        ELSEIF lv_avg10 < 75.
          lv_status = 'M'.
        ELSE.
          lv_status = 'H'.
        ENDIF.
    
        " 평균/등급을 포함한 출력 구조에 담아서 APPEND ...
      ENDLOOP.
    
    ```
    
- 8) HR 스타일: 나이/연차 + 텍스트 포맷 + 출력 템플릿
    
    ```abap
    PARAMETERS: p_pernr TYPE n LENGTH 8 OBLIGATORY,
                p_name  TYPE c LENGTH 10 OBLIGATORY,
                p_dob   TYPE dats       OBLIGATORY,
                p_jikwi TYPE n LENGTH 1 OBLIGATORY,
                p_edat  TYPE dats       OBLIGATORY.
    
    DATA: gv_age        TYPE i,
          gv_age_real   TYPE i,
          gv_leave_days TYPE i,
          gv_dob_text   TYPE char40,
          gv_edat_text  TYPE char40,
          gv_jikwi_text TYPE char40,
          gv_age_line   TYPE char40,
          gv_leave_line TYPE char20.
    
    AT SELECTION-SCREEN.
      IF p_jikwi < 1 OR p_jikwi > 7.
        MESSAGE '직위 코드는 1~7 사이여야 합니다.' TYPE 'E'.
      ENDIF.
    
      IF p_dob > sy-datum OR p_edat > sy-datum.
        MESSAGE '날짜가 올바르지 않습니다.' TYPE 'E'.
      ENDIF.
    
    START-OF-SELECTION.
    
      CALL FUNCTION 'Z_GET_AGE'
        EXPORTING
          iv_dob  = p_dob
        IMPORTING
          ev_age1 = gv_age
          ev_age2 = gv_age_real.
    
      CALL METHOD zcl_hr=>get_leave_days
        EXPORTING
          iv_edat  = p_edat
          iv_jikwi = p_jikwi
        IMPORTING
          ev_days  = gv_leave_days.
    
      PERFORM get_date_text USING    p_dob
                            CHANGING gv_dob_text.
      PERFORM get_date_text USING    p_edat
                            CHANGING gv_edat_text.
      PERFORM get_jikwi_text USING    p_jikwi
                             CHANGING gv_jikwi_text.
      PERFORM build_output.
      PERFORM display_output.
    
    ```
    

## 버튼

- 데이터베이스 뷰 만들기
    
    
    ![image.png](attachment:e353ba86-698f-440b-ba39-0889955a80e7:image.png)
    
    ![image.png](attachment:58c586b2-e7df-40eb-a3aa-4c4c7c4f3faf:image.png)
    
    ![image.png](attachment:c70a73e6-fe15-4090-a0fa-e885468c8b27:image.png)
    
    → 생성 버튼 클릭
    
    → 직접 모두 입력하기 
    
    →  Table fields  버튼 클릭해서 넣고 싶은 필드들 모두 클릭해서 추가하기
    
    → 액티브 및 저장 
    

## 개념

- 1. 타입 & 데이터 선언
    - **Local Type / Local Structure (TYPES … BEGIN OF … END OF …)**
        
        ```abap
        TYPES: BEGIN OF ty_sum,
                 carrid        TYPE sflight-carrid,
                 connid        TYPE sflight-connid,
                 total_payment TYPE sflight-paymentsum,
               END OF ty_sum.   " STANDARD TABLE 
        ```
        
        - DB 테이블 그대로 보여주는 게 아니라, **비즈니스에서 보고 싶은 형태로 결과를 설계할 때 (** 최종 출력 구조, 집계용 중간 구조 (SUM/COUNT/AVG용) )
        - 예: `TY_SUM`, `TY_DATA`, `TY_AGG`, `TY_JOIN`
    - **Internal Table(gt_*) & Work Area (gs_*)**
        
        ```abap
        DATA: gt_sum TYPE SORTED TABLE OF ty_sum WITH UNIQUE KEY carrid connid. " SORTED TABLE WITH UNIQUE KEY 
        ```
        
        - **Global Table** (내부 테이블) : 여러 행(row)을 담는 메모리 테이블
        - **Global Structure** (워크에어리어, 한 줄) : 구조 1줄을 담는 변수, LOOP 안에서 한 행씩 처리할 때 사용
        - 종류
            - STANDARD TABLE
                - 인덱스 기반: 1, 2, 3...
                - `APPEND`, `LOOP`, `READ TABLE ... WITH KEY` (느림, linear search)
            - SORTED TABLE WITH UNIQUE KEY
                - 지정한 키 기준으로 항상 정렬 유지.
                - `READ TABLE ... WITH KEY`가 **이진 탐색**.
                - `COLLECT` 사용 시: 키 기준 중복 허용 X, 자동 합산.

---

- 2. Selection Screen 개념
    - **PARAMETERS (단일 값 입력)**
        - 단일 값 입력용
        - `OBLIGATORY` : 필수 입력, 비어 있으면 실행 전 에러
        - `MATCHCODE OBJECT zsh_customer01`: F4 ) Search Help 검색 도움 연결
        - 예) `PARAMETERS: p_fyear TYPE n LENGTH 4 OBLIGATORY.`
    - **SELECT-OPTIONS (범위/다중 값)**
        - 범위/다중 값 입력용(LOW, HIGH, SIGN, OPTION 필드를 가진 내부 테이블)
        - `FOR gs_tab-field` : 해당 필드 타입 자동 사용
        - 예) `SELECT-OPTIONS: so_carr FOR gs_scarr-carrid.`
    - **INITIALIZATION (값 세팅 패턴)**
        - 선택 화면이 뜨기 전에 기본 값 세팅
        - 예) 현재 년도 전체, 기본 항공사 코드 등
    - **AT SELECTION-SCREEN (값 존재 체크)**
        - 사용자가 F8 누르기 전에 입력 값 검증
        - `MESSAGE ... TYPE 'E'` 로 잘못된 입력 차단
        - 메시지 TYPE
            - `'E'` : 에러, 입력 화면으로 되돌려 보냄.
            - `'I'` : Information 팝업, 프로그램 계속 or `EXIT`으로 중단.
            - `'W'` : Warning.
            - `'A'` : Abort.

---

- 3. Open SQL 개념
    - Simple SELECT INTO INTERNAL TABLE
        
        ```abap
        SELECT *
          INTO TABLE gt_sbook
          FROM sbook
          WHERE fldate   IN so_fdate
            AND customid IN so_id
            AND cancelled <> 'X'.
        ```
        
        - `IN so_fdate`: SELECT-OPTIONS와 바로 연동.
        - `INTO TABLE gt_sbook`: 전체 결과를 internal table에.
        - `SELECT *` → 개발 초기에 편하지만, 운영에서는 필요한 필드만 명시하는 게 좋음.
        - `sy-subrc` 체크로 결과 존재 여부 판단.
    - SELECT ... INTO CORRESPONDING FIELDS OF TABLE
        
        ```abap
        SELECT *
          INTO CORRESPONDING FIELDS OF TABLE gt_sbook
          FROM sbook
          WHERE carrid   IN so_carr
            AND fldate   IN so_fdate
            AND cancelled <> 'X'.
        ```
        
        - **필드명 기준으로 매핑,** 구조가 달라도 **필드명 기준으로 공통 필드만 매핑**
        - `gt_sbook`이 `sbook`과 다른 구조라도, 이름이 같은 필드만 매핑.
        - 나머지 필드는 자동으로 초기화.
    - Aggregation (SUM, GROUP BY)
        
        ```abap
        SELECT carrid, connid, SUM( paymentsum ) AS total_payment
          FROM sflight
          INTO TABLE @gt_sum
          WHERE carrid IN @so_carr
          GROUP BY carrid, connid.
        
        ```
        
        - 이런 구조의 요구사항에 사용
            - 항공사/노선별 매출 합계
            - 고객별 예약 건수, 매출
            - 월별 합계
        - `SUM( paymentsum )`: 집계함수
        - `GROUP BY carrid, connid`: 이 조합별로 SUM
        - 결과는 **각 Group별 1 Row**.
        - `AS total_payment`: 필드 alias → `TY_SUM-total_payment`에 매핑.
    - JOIN 패턴
        
        ```abap
        SELECT scustom~id
               scustom~name
               scustom~postcode
               ...
               sbook~custtype
          INTO CORRESPONDING FIELDS OF TABLE gt_data
          FROM scustom
          INNER JOIN sbook
            ON scustom~id = sbook~customid
          WHERE scustom~id IN so_id
            AND sbook~fldate IN so_fdate
            AND sbook~cancelled <> 'X'.
        
        ```
        
        - 여러 테이블을 한 번에 조인.
        - 예) `FROM scustom INNER JOIN sbook ON ... INNER JOIN ztsurvey_00 ON ...`
        - 마스터 + 트랜잭션 + 부가 테이블을 한 번에 불러올 때 사용.
    - **조건 연산 - BETWEEN, LIKE, <> 연산**
        - `IN so_xxx` : SELECT-OPTIONS와 연동
        - `BETWEEN lv_from AND lv_to` : 기간 조회
        - `LIKE lv_pattern` : 부분 문자열 검색
        - `<> 'X'` : 플래그(취소 여부 등) 체크

---

- 4. 내부 테이블 처리/집계 개념
    - **LOOP AT ... INTO ...**
        
        ```abap
        LOOP AT gt_sbook INTO gs_sbook.
          ...
        ENDLOOP.
        ```
        
        - internal table 한 행씩 읽으면서 비즈니스 로직 수행.
        - 자주 쓰는 안쪽 패턴
            - `READ TABLE ... INTO ... WITH KEY ...`
            - `COLLECT`
            - `APPEND`
            - `MODIFY ... FROM ...`
            - `CLEAR 구조`
            - `CONTINUE`, `EXIT`
    - **READ TABLE**
        
        ```abap
        READ TABLE gt_scustom INTO gs_scustom
          WITH KEY id = gs_sbook-customid
          BINARY SEARCH.
        ```
        
        - 특정 키로 행을 찾을 때 사용.
        - `WITH KEY id = ...` : 키 값으로 검색.
        - `BINARY SEARCH` 사용하려면 **해당 키로 SORT 되어 있어야 함**.
        - 성공 시 `sy-subrc = 0`, 실패 시 ≠ 0.
    - **COLLECT 패턴**
        
        1) SUM 집계 (ZQUIZ_09, 방법2)
        
        ```abap
        DATA: gt_sum TYPE SORTED TABLE OF ty_sum WITH UNIQUE KEY carrid connid.
        
        LOOP AT gt_sflight INTO gs_sflight.
          CLEAR gs_sum.
          gs_sum-carrid        = gs_sflight-carrid.
          gs_sum-connid        = gs_sflight-connid.
          gs_sum-total_payment = gs_sflight-paymentsum.
          COLLECT gs_sum INTO gt_sum.
        ENDLOOP.
        ```
        
        - 동작 방식
            - 키 필드(carrid, connid)가 같으면
                - 그 row를 찾아서 **numeric 필드는 자동 합산**
            - 키 필드 + numeric 필드 → typical 집계 패턴
        
        2) 건수 집계 (COUNT) – ZQUIZ_10
        
        ```abap
        gs_data-bookcnt = 1.
        COLLECT gs_data INTO gt_data.
        ```
        
        - `BOOKCNT` 필드가 numeric이므로
            
            같은 고객에 대해 계속 `1`씩 더해져서 **건수 집계**가 됨.
            
        
        3) COLLECT 조건
        
        - 내부 테이블은 **키가 있는 SORTED/HASHED TABLE** 사용 권장.
        - numeric 필드만 합산됨.
    - **수동 집계 패턴 (ZQUIZ_11의 ty_agg)**
        
        ```abap
        READ TABLE gt_agg INTO gs_agg
          WITH KEY carrid = gs_sbook-carrid
                   connid = gs_sbook-connid.
        
        IF sy-subrc = 0.
          lv_index = sy-tabix.
          gs_agg-sum_days = gs_agg-sum_days + lv_tmp_days.
          gs_agg-cnt      = gs_agg-cnt + 1.
          MODIFY gt_agg FROM gs_agg INDEX lv_index.
        ELSE.
          CLEAR gs_agg.
          gs_agg-carrid   = gs_sbook-carrid.
          gs_agg-connid   = gs_sbook-connid.
          gs_agg-sum_days = lv_tmp_days.
          gs_agg-cnt      = 1.
          APPEND gs_agg TO gt_agg.
        ENDIF.
        ```
        
        - 패턴 설명
            1. 집계 테이블에서 현재 key(carrid, connid) 검색
            2. 있으면 → 기존 합계/건수에 더하기
            3. 없으면 → 새 row 생성해서 APPEND
        - **SUM + COUNT + 나중에 AVG 계산**이 필요할 때.
        - `COLLECT`로는 SUM/COUNT를 동시에 표현하기 애매할 때.
    - **MODIFY / APPEND / CLEAR / CONTINUE / EXIT**
        - `APPEND gs_data TO gt_data.`
            
            → 테이블 마지막에 row 추가.
            
        - `CLEAR gs_data.`
            
            → 구조 초기화 (숫자 0, 문자 공백, 날짜 '00000000')
            
        - `MODIFY gt_data FROM gs_data.`
            
            → LOOP 중에 현재 row 값 업데이트.
            
        - `MODIFY gt_agg FROM gs_agg INDEX lv_index.`
            
            → 특정 인덱스 row 수정.
            
        - `CONTINUE.` : 현재 LOOP iteration만 스킵.
        - `EXIT.` : LOOP / 프로그램 흐름 탈출.

---

- 5. 날짜/숫자/문자 처리 개념
    - SY-DATUM 슬라이싱 & CONCATENATE
        
        ```abap
        so_fdate-low  = sy-datum+0(4) && '0101'. "YYYY0101
        so_fdate-high = sy-datum+0(4) && '1231'.
        
        -------------------------------------------------------
        
        CONCATENATE lv_year '0101' INTO lv_from.
        CONCATENATE lv_year '1231' INTO lv_to.
        ```
        
        - `sy-datum+0(4)`: 년도 (YYYY)
        - `+4(2)`: 월 (MM)
        - `+6(2)`: 일 (DD)
        - 문자열 연결하여 날짜형에 넣기 (자동 변환됨)
    - **월 구하기 (YYYYMMDD에서)**
        
        ```abap
        lv_month = gs_sflight-fldate+4(2). "05, 10 이런 문자열
        CASE lv_month.
          WHEN '01'. ...
          WHEN '02'. ...
        ENDCASE.
        ```
        
        → 월별로 합계 컬럼(JANSUM, FEBSUM, ... DECSUM)에 누적
        
    - **날짜 차이 계산**
        
        ```abap
        lv_tmp_days = gs_sbook-order_date - gs_sbook-fldate.
        ```
        
        - ABAP에서 DATS - DATS 는 정수(일수 차이)로 계산
        - 이걸 집계해서 평균 `days_ahead` 계산
            
            ```abap
            IF gs_agg-cnt > 0.
              gs_data-days_ahead = gs_agg-sum_days / gs_agg-cnt.
            ENDIF.
            ```
            
        - 평균 `days_ahead` 계산 결과로 점수 계산
            
            ```abap
            lv_avg = ( gs_join-score1 +
                       gs_join-score2 +
                       gs_join-score3 +
                       gs_join-score4 +
                       gs_join-score5 ) / 5.
            
            gs_data-average = lv_avg.
            lv_avg10 = lv_avg * 10.
            
            IF lv_avg10 < 50.
              gs_data-status = 'L'.
            ELSEIF lv_avg10 < 75.
              gs_data-status = 'M'.
            ELSE.
              gs_data-status = 'H'.
            ENDIF.
            ```
            
            - `lv_avg`는 P타입(DECIMAL 1자리) → 소수점 평균 가능
            - 등급(STATUS)을 문자형 `CHAR1`로 저장
    - **문자 패턴 검색 - 이름 LIKE 검색 패턴**
        
        ```abap
        lv_pattern = '%' && p_cname && '%'.
        
        WHERE scustom~name  LIKE @lv_pattern
        ```
        
        - `%문자열%` 패턴으로 **부분 문자열 검색**
        - 문자열 길이 4자리 이상 입력 체크
        - `%` 와일드카드 사용
    - **숫자를 문자로 변환 (WRITE TO)**
        
        ```abap
        DATA: lv_age_char      TYPE char3,
              lv_age_real_char TYPE char3,
              lv_leave_char    TYPE char3.
        
        WRITE gv_age        TO lv_age_char.
        WRITE gv_age_real   TO lv_age_real_char.
        WRITE gv_leave_days TO lv_leave_char.
        
        ```
        
        → 숫자를 문자로 바꾸는 간단한 포맷 변환.
        

---

- 6. 재 사용 단위 개념
    - **Function Module 호출**
        
        ```abap
        CALL FUNCTION 'Z_GET_AGE_G01'
          EXPORTING
            iv_dob  = p_dob
          IMPORTING
            ev_age1 = gv_age
            ev_age2 = gv_age_real.
        ```
        
        - 재사용 가능/테스트 가능한 공통 기능(**나이 계산**)을 함수로 분리.
        - `EXPORTING`: 입력 파라미터
        - `IMPORTING`: 결과 파라미터
        - 함수 내부는 별도 개발/변경 가능
    - **Static Class Method 호출**
        
        ```abap
        CALL METHOD zcl_ex_g01=>get_leave_date_g01
          EXPORTING
            iv_edat  = p_edat
            iv_jikwi = p_jikwi
          IMPORTING
            ev_days  = gv_leave_days.
        ```
        
        - `클래스이름=>메소드명`: static method 호출.
        - 연차 계산 로직을 클래스에 넣어서 **OOP 스타일 재사용**.
    - **FORM / PERFORM (Subroutine)**
        
        ```abap
        PERFORM get_date_format USING    p_dob
                                CHANGING gv_dob_text.
        
        FORM get_date_format
          USING    pv_date TYPE dats
          CHANGING cv_date TYPE char40.
          ...
        ENDFORM.
        ```
        
        - 프로그램 내부에서만 쓰는 **작은 유틸리티** 함수.
            - 날짜 텍스트 포맷 처리
            - 직위 코드 → 직위명 변환 (`GET_JIKWI_TEXT`)
            - 출력 문자열 조립 (`BUILD_OUTPUT`, `DISPLAY_OUTPUT`)
    - **Subroutine 내부 1 - 텍스트 심볼 활용 로직**
        
        ```abap
        CASE pv_jikwi.
          WHEN 1.
            cv_jikwi = text-j01. "사장
          WHEN 2.
            cv_jikwi = text-j02. "이사
          ...
        ENDCASE.
        ```
        
        - `text-j01` : 프로그램 텍스트 심볼
        - 멀티언어/변경 가능 텍스트를 코드에서 분리하기 위한 장치
    - **Subroutine 내부 2 - 원하는 텍스트 형식으로 변환 로직(생년월일)**
        
        ```abap
        DATA: LV_AGE_CHAR      TYPE CHAR3,
                LV_AGE_REAL_CHAR TYPE CHAR3,
                LV_LEAVE_CHAR    TYPE CHAR3.
        
          " 숫자를 문자로 변환.
          WRITE GV_AGE        TO LV_AGE_CHAR.
          WRITE GV_AGE_REAL   TO LV_AGE_REAL_CHAR.
          WRITE GV_LEAVE_DAYS TO LV_LEAVE_CHAR.
        
          CONCATENATE LV_AGE_CHAR '세 (만'
                      LV_AGE_REAL_CHAR '세)'
                 INTO GV_AGE_LINE
          SEPARATED BY SPACE.
        
          CONCATENATE LV_LEAVE_CHAR '일'
                 INTO GV_LEAVE_LINE
          SEPARATED BY SPACE.
        ```
        
    - **Subroutine 내부 3 - 원하는 텍스트 형식으로 변환 로직(나이)**
        
        ```abap
          USING    PV_DATE TYPE DATS
          CHANGING CV_DATE TYPE CHAR40.
        
          DATA: LV_YEAR  TYPE CHAR4,
                LV_MONTH TYPE CHAR2,
                LV_DAY   TYPE CHAR2.
        
          IF PV_DATE IS INITIAL.
            CLEAR CV_DATE.
            RETURN.
          ENDIF.
        
          LV_YEAR  = PV_DATE+0(4).
          LV_MONTH = PV_DATE+4(2).
          LV_DAY   = PV_DATE+6(2).
        
          CONCATENATE LV_YEAR  '년'
                      LV_MONTH '월'
                      LV_DAY   '일'
                 INTO CV_DATE
          SEPARATED BY SPACE.
        ```
        

---

- 7. 출력 개념
    - **CL_DEMO_OUTPUT=>DISPLAY**
        
        ```abap
        cl_demo_output=>display( gt_data ).
        ```
        
        - 개발/테스트용으로 **매우 편한** 출력.
        - internal table/structure 를 HTML 형태로 보여줌.
        - ALV 쓰기 전에 로직 검증할 때 자주 사용.
    - **Classic List – WRITE / ULINE**
        
        ```abap
        FORM display_output .
        
          WRITE: / '사원정보'.
          ULINE.
        
          WRITE: / '사번:', 20 p_pernr NO-ZERO.
          WRITE: / '성명:', 20 p_name.
          WRITE: / '생년월일:', 20 gv_dob_text.
          WRITE: / '나이:', 20 gv_age_line.
          WRITE: / '직위:', 20 gv_jikwi_text.
          WRITE: / '입사일:', 20 gv_edat_text.
          WRITE: / '연차:', 20 gv_leave_line.
        
        ENDFORM.
        ```
        
        - `WRITE: /` : 새 줄 시작
        - `20 p_name` : 20번째 칼럼에 필드 출력
        - `NO-ZERO` : leading zero 제거
        - `ULINE.` : 구분선 출력
        - 실제 업무 리포트에서 ALV 대신 간단히 쓸 수 있는 패턴.

---

- 8. 퀴즈별 만능 템플릿 요약
    - ZQUIZ_09 – SUM vs COLLECT 집계 패턴
        1. DB 레벨 집계 템플릿
            
            ```abap
            SELECT key1 key2 SUM( amount ) AS total
              INTO TABLE @gt_sum
              FROM tab
              WHERE ...
              GROUP BY key1, key2.
            ```
            
        2. 앱 레벨 집계 템플릿 (COLLECT)
            
            ```abap
            SELECT *
              INTO TABLE gt_src
              FROM tab
              WHERE ...
            
            LOOP AT gt_src INTO gs_src.
              CLEAR gs_agg.
              gs_agg-key1   = gs_src-key1.
              gs_agg-key2   = gs_src-key2.
              gs_agg-sumval = gs_src-amount.
              COLLECT gs_agg INTO gt_agg.
            ENDLOOP.
            ```
            
    - ZQUIZ_10 – 고객별 예약 건수 + 등급 분류
        1. 패턴
            1. Selection screen: 고객 ID 범위, 날짜 범위
            2. SBOOK에서 예약 읽기
            3. SCUSTOM에서 고객 마스터 읽기
            4. LOOP SBOOK → 고객 정보 붙이기 → `BOOKCNT`=1 → `COLLECT`로 고객별 예약건수 합산
            5. 2차 LOOP: `BOOKCNT` 기준으로 등급(GRADE: P/G/S) 판정
        2. 일반화 템플릿
            
            > “마스터 + 트랜잭션 + 건수 기반 등급” 요구사항에 그대로 적용 가능
            > 
    - ZQUIZ_11 – 1차/2차 집계 + 평균 계산
        1. 패턴
            - 1차 LOOP로 `(CARRID, CONNID)`별 Sum/Count 집계 (`ty_agg`)
            - 2차 LOOP로 **출력 구조** 생성 + 항공사명 join
            - 결과: 노선별 “평균 (출발일-예약일)” 일수
        2. 일반화 템플릿 - 구조 활용
            - 상품별 평균 리드타임
            - 고객별 평균 지연일수
            - 등등 “평균”이 필요할 때 **전형적인 2단계 집계 패턴**
    - ZQUIZ_12 – 월별 합계 Pivot 패턴
        1. 패턴
            1. 대상 연도 + 항공사로 SFLIGHT 조회
            2. 항공사 SCARR 조회
            3. 항공사 LOOP
                - 해당 항공사 SFLIGHT LOOP
                - 날짜에서 월 추출 (+4(2))
                - 월에 따라 `JANSUM`, `FEBSUM`, ..., `DECSUM`에 누적
                - GS_DATA APPEND
            
            이건 **월별 컬럼을 가로로 펼친 Pivot 형태 리포트** 템플릿
            
    - ZQUIZ_13 – LIKE 검색 + 설문 평균 + 등급
        1. 패턴
            - 이름 부분 검색 (`LIKE '%이름%'`)
            - 기간 입력 (NO-EXTENSION)
            - 3-way JOIN (SCUSTOM + SBOOK + ZTSURVEY_00)
            - 평균 점수 계산
            - 점수 구간별 상태코드(L/M/H) 부여
            
            **고객 만족도, 점수 기반 등급, KPI 리포트**에서 거의 그대로 사용할 수 있는 구조.
            

---

- 9. 실무에 바로 쓰는 코드 설계 체크리스트
    - **결과가 어떻게 보여야 하는가?**
        - 컬럼들 → `TY_DATA` 설계
        - 중간 집계 필요? → `TY_AGG` 같은 별도 구조
    - **입력 조건은 무엇인가?**
        - 날짜/ID 범위 → `SELECT-OPTIONS`
        - 단일 값 (년도, 코드, 이름 등) → `PARAMETERS`
        - 기본값 필요? → `INITIALIZATION`
        - 검증 로직? → `AT SELECTION-SCREEN` + MESSAGE
    - **어떤 테이블에서 어떤 조건으로 데이터를 읽을까?**
        - 단일 테이블? → `SELECT ... INTO TABLE`
        - 여러 테이블? → `JOIN` OR `두번 SELECT + READ TABLE`
    - **집계/계산은 어디서 할까?**
        - 가능하면 DB 레벨 `SUM/GROUP BY`
        - 복잡한 로직이면 LOOP + `COLLECT` or 수동 SUM/COUNT
    - **성능 고려 포인트**
        - `SORT` 후 `READ TABLE ... BINARY SEARCH`
        - 키가 있는 `SORTED TABLE` + `COLLECT`
        - 필요한 필드만 SELECT
    - **로직 재사용할 부분은 분리**
        - 여러 프로그램에서 쓸 계산 → `FUNCTION`, `CLASS METHOD`
        - 프로그램 안에서만 공통으로 쓰는 로직 → `FORM`
    - **출력**
        - 개발중: `CL_DEMO_OUTPUT=>DISPLAY( gt_data )`
        - 실제: ALV or Classic list (`WRITE`)
