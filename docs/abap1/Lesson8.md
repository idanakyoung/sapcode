# 🧭 Lesson 8 - **Open SQL & Inner Join**

# 🔵 **Unit 1. Data Modeling and Data Retrieval : Open SQL**

### 1. FUNCTION Z_GET_SMOKER_G01 (LOOP + READ/MODIFY 방식)

```abap
FUNCTION Z_GET_SMOKER_G01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  ZBC400_S_SMOKER-CARRID   " 항공사 코드
*"     REFERENCE(IV_CONNID) TYPE  ZBC400_S_SMOKER-CONNID   " 항공편 번호
*"  EXPORTING
*"     REFERENCE(ET_DATA)   TYPE  ZBC400_T_SMOKER          " 라인타입 = ZBC400_S_SMOKER
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  " SBOOK에서 읽어올 필드 구조 정의 (로컬 타입)
  TYPES: BEGIN OF TS_SBOOK,
           CARRID TYPE SBOOK-CARRID,   " 항공사 코드
           CONNID TYPE SBOOK-CONNID,   " 항공편 번호
           SMOKER TYPE SBOOK-SMOKER,   " 흡연 여부(X: 흡연)
         END OF TS_SBOOK.

  "--------------------------------------------------------------------
  " SBOOK 데이터를 담기 위한 work area / internal table 선언
  "--------------------------------------------------------------------
  " work area (한 줄짜리 구조)
  DATA: BEGIN OF GS_SBOOK,
          CARRID TYPE SBOOK-CARRID,
          CONNID TYPE SBOOK-CONNID,
          SMOKER TYPE SBOOK-SMOKER,
        END OF GS_SBOOK,
        " internal table (동일 구조의 여러 줄)
        GT_SBOOK LIKE TABLE OF GS_SBOOK.

  " EXPORTING 파라미터 ET_DATA의 라인 타입에 맞는 work area
  DATA: GS_DATA LIKE LINE OF ET_DATA.

  "--------------------------------------------------------------------
  " 1. DB 테이블 SBOOK에서 데이터 읽기
  "--------------------------------------------------------------------
  SELECT CARRID
         CONNID
         SMOKER
    INTO TABLE GT_SBOOK
    FROM SBOOK
    WHERE CARRID = IV_CARRID.   " 현재는 CARRID만 조건으로 사용
    " AND CONNID = IV_CONNID.   " 필요하다면 이렇게 항공편까지 조건 추가 가능

  " SBOOK에 데이터가 하나도 없으면 예외 처리 (개선 포인트)
  IF GT_SBOOK IS INITIAL.
    RAISE NO_DATA.
  ENDIF.

  "--------------------------------------------------------------------
  " 2. GT_SBOOK을 LOOP 돌면서 ET_DATA에 집계 데이터 쌓기
  "--------------------------------------------------------------------
  LOOP AT GT_SBOOK INTO GS_SBOOK.

    "--------------------------------------------------------------
    " 2-1. 현재 줄(GS_SBOOK)의 CARRID + CONNID 조합이
    "      이미 ET_DATA에 존재하는지 확인
    "--------------------------------------------------------------
    READ TABLE ET_DATA INTO GS_DATA
      WITH KEY CARRID = GS_SBOOK-CARRID
               CONNID = GS_SBOOK-CONNID.

    "--------------------------------------------------------------
    " 2-2. 해당 키(CARRID+CONNID)로 이미 집계된 라인이 없는 경우
    "      => 새로운 라인 생성
    "--------------------------------------------------------------
    IF SY-SUBRC <> 0.
      " SBOOK에서 읽은 필드값을 ET_DATA 라인 구조로 복사
      " (필드명이 같으면 자동으로 매핑)
      MOVE-CORRESPONDING GS_SBOOK TO GS_DATA.

      " 흡연자/비흡연자 카운터 초기값 설정
      IF GS_SBOOK-SMOKER = 'X'.
        " 흡연자일 경우 흡연자 카운트 1
        GS_DATA-SMOKER_CNT = 1.
      ELSE.
        " 비흡연자일 경우 비흡연자 카운트 1
        GS_DATA-NONSMK_CNT = 1.
      ENDIF.

      " 새로 만든 집계 라인을 ET_DATA에 추가
      APPEND GS_DATA TO ET_DATA.

    "--------------------------------------------------------------
    " 2-3. 해당 키(CARRID+CONNID)로 이미 집계된 라인이 있는 경우
    "      => 기존 라인에 카운트만 증가
    "--------------------------------------------------------------
    ELSE.

      " 흡연자/비흡연자에 따라 카운터만 1씩 증가
      IF GS_SBOOK-SMOKER = 'X'.
        " 흡연자 카운트 +1
        ADD 1 TO GS_DATA-SMOKER_CNT.
      ELSE.
        " 비흡연자 카운트 +1
        ADD 1 TO GS_DATA-NONSMK_CNT.
      ENDIF.

      " 방금 수정한 GS_DATA를 ET_DATA에 반영
      " SY-TABIX : 방금 READ TABLE로 읽은 라인의 인덱스
      MODIFY ET_DATA FROM GS_DATA INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.

ENDFUNCTION.

```

---

### 2. FUNCTION Z_GET_SMOKER_G01_COLLECT (COLLECT 사용 버전)

```abap
FUNCTION Z_GET_SMOKER_G01_COLLECT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  ZBC400_S_SMOKER-CARRID   " 항공사 코드
*"  EXPORTING
*"     REFERENCE(ET_DATA)   TYPE  ZBC400_T_SMOKER          " 라인타입 = ZBC400_S_SMOKER
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  " SBOOK에서 읽어올 필드 구조 정의 (로컬 타입)
  TYPES: BEGIN OF TS_SBOOK,
           CARRID TYPE SBOOK-CARRID,   " 항공사 코드
           CONNID TYPE SBOOK-CONNID,   " 항공편 번호
           SMOKER TYPE SBOOK-SMOKER,   " 흡연 여부
         END OF TS_SBOOK.

  "--------------------------------------------------------------------
  " SBOOK 데이터를 담기 위한 internal table & work area 선언
  "--------------------------------------------------------------------
  DATA: GT_SBOOK TYPE TABLE OF TS_SBOOK,  " SBOOK 데이터를 받을 internal table
        GS_SBOOK LIKE LINE OF GT_SBOOK.   " 해당 internal table의 work area

  " EXPORTING 파라미터 ET_DATA의 라인 타입에 맞는 work area
  DATA: GS_DATA LIKE LINE OF ET_DATA.

  "--------------------------------------------------------------------
  " 1. DB 테이블 SBOOK에서 데이터 읽기
  "--------------------------------------------------------------------
  SELECT CARRID
         CONNID
         SMOKER
    INTO TABLE GT_SBOOK
    FROM SBOOK
    WHERE CARRID = IV_CARRID.

  " 데이터 유무 확인 후 예외 발생 (개선 포인트)
  IF GT_SBOOK IS INITIAL.
    RAISE NO_DATA.
  ENDIF.

  "--------------------------------------------------------------------
  " 2. GT_SBOOK LOOP 돌면서 COLLECT를 이용해 집계
  "--------------------------------------------------------------------
  LOOP AT GT_SBOOK INTO GS_SBOOK.

    " SBOOK에서 읽은 필드를 ET_DATA 라인 구조로 복사
    MOVE-CORRESPONDING GS_SBOOK TO GS_DATA.

    " 흡연자/비흡연자에 따라 카운터 1 설정
    IF GS_SBOOK-SMOKER = 'X'.
      " 흡연자
      GS_DATA-SMOKER_CNT = 1.
    ELSE.
      " 비흡연자
      GS_DATA-NONSMK_CNT = 1.
    ENDIF.

    "----------------------------------------------------------------
    " COLLECT:
    "  - 내부테이블의 키(CARRID, CONNID 등)가 같은 라인이 이미 있으면
    "    => 숫자 필드(SMOKER_CNT, NONSMK_CNT)를 자동으로 합산
    "  - 없으면
    "    => 새로운 라인으로 추가
    "----------------------------------------------------------------
    COLLECT GS_DATA INTO ET_DATA.

    " 다음 LOOP에 영향을 주지 않도록 work area 초기화
    CLEAR GS_DATA.

  ENDLOOP.

ENDFUNCTION.

```

---

### 3. 개념 및 풀이 설명 (노션용 정리)

### 3-1. 이 함수들이 하는 일 요약

두 함수 모두 공통 목표는 같습니다.

- DB 테이블 SBOOK에서 특정 항공사(CARRID)의 예약 데이터를 읽고
- 항공편(CONNID)별로
    - 흡연자 수(SMOKER_CNT)
    - 비흡연자 수(NONSMK_CNT)
- 를 집계해서 `ET_DATA`라는 internal table로 돌려주는 기능

차이점은 “집계하는 방법”입니다.

- `Z_GET_SMOKER_G01`
    
    → 직접 `READ TABLE` + `APPEND` + `MODIFY`를 써서 수동으로 집계
    
- `Z_GET_SMOKER_G01_COLLECT`
    
    → `COLLECT` 구문을 사용해서 자동으로 합산
    

---

### 3-2. 데이터 구조 이해하기

1. SBOOK 테이블에서 사용하는 필드들
    - `CARRID` : 항공사 코드 (예: LH, AA 등)
    - `CONNID` : 항공편 번호
    - `SMOKER` : 흡연 여부
        - `'X'` : 흡연자
        - 그 외(공백 등) : 비흡연자
2. ZBC400_S_SMOKER 구조(추정)
    
    수업 시간에 만든 구조라 대략 다음과 같이 구성되었을 가능성이 높습니다.
    
    - `CARRID` : 항공사
    - `CONNID` : 항공편
    - `SMOKER_CNT` : 흡연자 수 (NUMC 또는 INT)
    - `NONSMK_CNT` : 비흡연자 수 (NUMC 또는 INT)
    
    이 구조의 테이블 타입이 `ZBC400_T_SMOKER` 이고,
    
    `ET_DATA`의 라인 타입이 바로 `ZBC400_S_SMOKER`입니다.
    

---

### 3-3. Z_GET_SMOKER_G01 흐름(LOOP + READ/MODIFY)

1. SBOOK에서 데이터 읽기
    
    ```abap
    SELECT CARRID CONNID SMOKER
      INTO TABLE GT_SBOOK
      FROM SBOOK
      WHERE CARRID = IV_CARRID.
    
    ```
    
    - 전달받은 `IV_CARRID`와 같은 항공사에 대한 모든 예약 데이터를 GT_SBOOK에 담습니다.
    - 인터페이스에 `IV_CONNID`도 있지만, 현재 SELECT에서는 사용하지 않고 있습니다.
        - 특정 항공편만 보고 싶다면
            
            ```abap
            WHERE CARRID = IV_CARRID
              AND CONNID = IV_CONNID.
            
            ```
            
            이렇게 조건을 추가해야 합니다.
            
2. LOOP로 한 줄씩 처리
    
    ```abap
    LOOP AT GT_SBOOK INTO GS_SBOOK.
    
    ```
    
    - 각 예약(한 사람) 단위로 반복하면서,
        
        "이 사람이 탄 항공편에 흡연자/비흡연자를 1명 더해라" 라는 의미로 처리합니다.
        
3. 이미 집계된 라인이 있는지 확인
    
    ```abap
    READ TABLE ET_DATA INTO GS_DATA
      WITH KEY CARRID = GS_SBOOK-CARRID
               CONNID = GS_SBOOK-CONNID.
    
    ```
    
    - `ET_DATA` 안에서
        - 항공사 = 현재줄의 CARRID
        - 항공편 = 현재줄의 CONNID
    - 인 라인이 있는지 찾습니다.
    - `SY-SUBRC` 값
        - `0` : 찾음 → 기존 라인에 카운트만 +1
        - `≠0` : 못 찾음 → 새로운 라인을 만들어서 추가
4. 새로운 라인 생성 로직
    - 못 찾았을 때
        
        ```abap
        IF SY-SUBRC <> 0.
          MOVE-CORRESPONDING GS_SBOOK TO GS_DATA.
        
          IF GS_SBOOK-SMOKER = 'X'.
            GS_DATA-SMOKER_CNT = 1.
          ELSE.
            GS_DATA-NONSMK_CNT = 1.
          ENDIF.
        
          APPEND GS_DATA TO ET_DATA.
        
        ```
        
    - `MOVE-CORRESPONDING`으로 SBOOK 필드를 `GS_DATA`에 복사
        - 이름이 같은 필드만 복사됩니다.
        - 여기서는 `CARRID`, `CONNID`가 복사될 가능성이 높습니다.
    - 그리고 그 예약이 흡연자인지 비흡연자인지에 따라 카운터를 1로 세팅
    - 마지막에 `APPEND`로 새 라인을 추가
5. 기존 라인 업데이트 로직
    - 찾았을 때 (`SY-SUBRC = 0`)
        
        ```abap
        ELSE.
          IF GS_SBOOK-SMOKER = 'X'.
            ADD 1 TO GS_DATA-SMOKER_CNT.
          ELSE.
            ADD 1 TO GS_DATA-NONSMK_CNT.
          ENDIF.
        
          MODIFY ET_DATA FROM GS_DATA INDEX SY-TABIX.
        ENDIF.
        
        ```
        
    - 이미 존재하는 집계 라인에 대해
        - 흡연자라면 `SMOKER_CNT` + 1
        - 비흡연자라면 `NONSMK_CNT` + 1
    - `SY-TABIX`는 `READ TABLE`이 찾은 라인의 인덱스
        - 그 인덱스로 `MODIFY`해서 값을 업데이트

요약하면, 이 함수는

1. SBOOK에서 예약 데이터를 읽고
2. 각 예약을 한 줄씩 보면서
3. "이 항공편이 ET_DATA에 이미 있나?" 확인 후
    - 없으면 새로 만들고
    - 있으면 카운트만 올리는

수작업 집계 방식입니다.

---

### 3-4. Z_GET_SMOKER_G01_COLLECT 흐름(COLLECT 사용)

이번 함수는 기본 아이디어는 같지만, 집계 부분을 `COLLECT` 하나로 단순화합니다.

1. SBOOK SELECT
    
    ```abap
    SELECT CARRID CONNID SMOKER
      INTO TABLE GT_SBOOK
      FROM SBOOK
      WHERE CARRID = IV_CARRID.
    
    ```
    
    - 동일하게 항공사별 데이터를 읽어옵니다.
2. LOOP + COLLECT
    
    ```abap
    LOOP AT GT_SBOOK INTO GS_SBOOK.
    
      MOVE-CORRESPONDING GS_SBOOK TO GS_DATA.
    
      IF GS_SBOOK-SMOKER = 'X'.
        GS_DATA-SMOKER_CNT = 1.
      ELSE.
        GS_DATA-NONSMK_CNT = 1.
      ENDIF.
    
      COLLECT GS_DATA INTO ET_DATA.
    
      CLEAR GS_DATA.
    ENDLOOP.
    
    ```
    
    핵심은 `COLLECT`입니다.
    
3. COLLECT의 동작 원리
    - `COLLECT wa INTO itab.` 의 의미
        - 내부 테이블(itab)의 키 필드가 `wa`와 동일한 라인이 있으면
            - 숫자 타입 필드를 자동으로 더해서 합산
        - 없으면
            - 새로운 라인을 추가
    
    이때 중요한 포인트:
    
    1. `ET_DATA`의 키 설정
    - 테이블 타입 `ZBC400_T_SMOKER`의 키가 어떻게 되어 있는지에 따라 동작이 달라집니다.
    - 보통 이런 집계를 할 때는
        - 키: `CARRID`, `CONNID`
    - 이렇게 설정해 놓습니다.
    - 그래야 항공편별로 한 줄씩만 생기고, 카운트가 합산됩니다.
    1. 합산되는 필드
    - 숫자 타입 필드만 합산됩니다.
    - 여기서는 `SMOKER_CNT`, `NONSMK_CNT`가 숫자 필드이므로
        - 현재줄이 흡연자라면 `SMOKER_CNT`가 1씩 증가
        - 비흡연자라면 `NONSMK_CNT`가 1씩 증가
4. CLEAR GS_DATA 이유
    - COLLECT는 work area에 남아 있는 값들을 기준으로 동작하기 때문에
        
        다음 LOOP에 영향을 주지 않도록 `CLEAR GS_DATA`로 초기화해 주는 것이 좋습니다.
        
    - 예를 들어, 이전 LOOP에서 SMOKER_CNT가 1로 세팅된 상태가 남아 있으면
        
        다음 MOVE-CORRESPONDING에서 덮어쓰지 않는 필드는 그대로 남을 수 있습니다.
        
    - 그렇기 때문에 LOOP 마지막에 항상 초기화하는 것이 안전합니다.

---

### 3-5. 두 함수의 비교 정리

1. 공통점
    - 둘 다 SBOOK 데이터를 읽고
    - 항공편(CONNID) 단위로
        - 흡연자 수
        - 비흡연자 수
    - 를 집계해서 `ET_DATA`로 내보냅니다.
2. 차이점
    1. 집계 방식
    - `Z_GET_SMOKER_G01`
        - 직접 `READ TABLE`로 검색
        - 없으면 `APPEND`
        - 있으면 `ADD` 후 `MODIFY`
        - 보다 “로우 레벨” 구현, 동작이 눈에 잘 보임
    - `Z_GET_SMOKER_G01_COLLECT`
        - `COLLECT` 한 줄로 “찾아서 있으면 합산, 없으면 추가”를 처리
        - 코드는 훨씬 짧고 깔끔
        - 대신 내부 테이블 키 정의를 정확히 알아야 합니다.
    1. 인터페이스
    - 첫 번째 함수: `IV_CARRID`, `IV_CONNID` 둘 다 받음
        - 하지만 실제 SELECT에서는 `IV_CONNID`를 사용하지 않음(개선 가능)
    - 두 번째 함수: `IV_CARRID`만 받음
        - 항공사 단위 집계에 맞는 인터페이스

# 🔵 **Unit 2. Inner Join**

### 1. 주석 상세 버전 코드

```abap
*&---------------------------------------------------------------------*
*& Report ZABAP_17_G01
*&---------------------------------------------------------------------*
*& 항공편(SFLIGHT) + 항공사(SCARR)를 INNER JOIN으로 조회해서
*& 선택한 항공사에 대한 비행편 목록을 출력하는 프로그램
*&---------------------------------------------------------------------*
REPORT ZABAP_17_G01.

"---------------------------------------------------------------
" 1. 로컬 구조 타입 정의 (TS_FLIGHT)
"    - SFLIGHT + SCARR에서 필요한 필드만 모아서 한 구조로 사용
"---------------------------------------------------------------
TYPES: BEGIN OF TS_FLIGHT,
         CARRID   TYPE SFLIGHT-CARRID,   " 항공사 코드
         CONNID   TYPE SFLIGHT-CONNID,   " 항공편 번호
         FLDATE   TYPE SFLIGHT-FLDATE,   " 비행 날짜
         SEATSMAX TYPE SFLIGHT-SEATSMAX, " 좌석 수(최대)
         SEATSOCC TYPE SFLIGHT-SEATSOCC, " 예약된 좌석 수
         CARRNAME TYPE SCARR-CARRNAME,   " 항공사 이름 (SCARR에서 가져옴)
       END OF TS_FLIGHT.

"---------------------------------------------------------------
" 2. 내부 테이블 / 작업 영역 선언
"---------------------------------------------------------------
DATA: GT_FLIGHTS TYPE TABLE OF TS_FLIGHT, " 조회 결과 전체를 담을 internal table
      GS_FLIGHT  LIKE LINE OF GT_FLIGHTS. " 한 줄씩 처리할 work area

"---------------------------------------------------------------
" 3. 선택 화면 파라미터
"    - 사용자가 보고 싶은 항공사(CARRID)를 입력
"---------------------------------------------------------------
PARAMETERS PA_CAR TYPE SFLIGHT-CARRID.    " 예: 'LH', 'AA' 등

"---------------------------------------------------------------
" 4. DB 테이블 데이터 읽기 - INNER JOIN
"    - SFLIGHT(항공편) + SCARR(항공사 마스터)를 조인
"    - 동일한 CARRID를 가진 두 테이블의 데이터를 합쳐서 한 줄로 가져옴
"---------------------------------------------------------------

" 예전 방식: 테이블 이름 직접 사용 (참고용, 현재는 주석 처리)
"*SELECT SFLIGHT~CARRID SFLIGHT~CONNID SFLIGHT~SEATSMAX SFLIGHT~SEATSOCC
"*       SCARR~CARRNAME
"*  INTO TABLE GT_FLIGHTS
"*  FROM SFLIGHT INNER JOIN SCARR
"*               ON SFLIGHT~CARRID = SCARR~CARRID
"*  WHERE SFLIGHT~CARRID = PA_CAR.

" 실제 사용하는 코드: 테이블에 ALIAS(A, B) 사용
SELECT A~CARRID
       A~CONNID
       A~FLDATE
       A~SEATSMAX
       A~SEATSOCC
       B~CARRNAME
  INTO TABLE GT_FLIGHTS
  FROM SFLIGHT AS A
  INNER JOIN SCARR AS B
          ON A~CARRID = B~CARRID     " 조인 조건 (같은 항공사 코드)
  WHERE A~CARRID = PA_CAR.           " 선택 화면에서 입력한 항공사만

"---------------------------------------------------------------
" 5. 조회된 데이터를 LOOP로 출력
"---------------------------------------------------------------
LOOP AT GT_FLIGHTS INTO GS_FLIGHT.

  " /: 줄바꿈 후 한 줄 출력
  WRITE: / GS_FLIGHT-CARRID,    " 항공사 코드
           GS_FLIGHT-CARRNAME,  " 항공사 이름
           GS_FLIGHT-CONNID,    " 항공편 번호
           GS_FLIGHT-FLDATE,    " 비행 날짜
           GS_FLIGHT-SEATSMAX,  " 최대 좌석 수
           GS_FLIGHT-SEATSOCC.  " 예약된 좌석 수

ENDLOOP.

```

---

### 2. 이론: INNER JOIN 개념 정리

### 2-1. JOIN이 필요한 이유

테이블을 하나만 쓰면, 그 테이블에 있는 정보만 볼 수 있습니다.

- SFLIGHT
    - 항공사 코드(CARRID), 항공편 번호(CONNID), 날짜(FLDATE), 좌석 수 등 “비행편 정보”
    - “항공사 이름”은 없음
- SCARR
    - 항공사 코드(CARRID), 항공사 이름(CARRNAME), 통화 등 “항공사 마스터 정보”

우리는 이런 화면을 보고 싶습니다.

- 항공사 코드 + 항공사 이름 + 항공편 번호 + 비행 날짜 + 좌석 수 …

그 말은 곧

- SFLIGHT에 있는 필드 + SCARR에 있는 필드를 한 줄로 합쳐서 보고 싶다
    
    → 그래서 두 테이블을 묶어서 읽을 필요가 있고
    
    → 그게 바로 JOIN입니다.
    

---

### 2-2. INNER JOIN이란?

`INNER JOIN`은 두 테이블 모두에서 “조건에 맞는 데이터가 있을 때만” 결과에 포함시키는 JOIN입니다.

- 기준: 조인 조건(ON 이하)에 사용한 키(여기서는 CARRID)
- 예)
    - SFLIGHT에 CARRID = 'LH' 데이터가 있고
    - SCARR에도 CARRID = 'LH' 데이터가 있으면
        
        → 결과에 'LH'가 포함
        
    - 만약 SFLIGHT에는 있는데, SCARR에는 없는 CARRID라면
        
        → 결과에 나오지 않음
        

즉,

- SFLIGHT와 SCARR 둘 다에 존재하는 항공사 코드만 결과에 나온다

라는 의미입니다.

---

### 2-3. 이번 코드에서의 INNER JOIN

```abap
FROM SFLIGHT AS A
INNER JOIN SCARR AS B
        ON A~CARRID = B~CARRID
WHERE A~CARRID = PA_CAR.

```

- `FROM SFLIGHT AS A`
    - SFLIGHT 테이블을 A라는 별칭(ALIAS)으로 부름
- `INNER JOIN SCARR AS B`
    - SCARR 테이블을 B라는 별칭으로 부르고, SFLIGHT와 조인
- `ON A~CARRID = B~CARRID`
    - 두 테이블에서 CARRID가 같은 행끼리 합쳐서 한 줄로 만든다
- `WHERE A~CARRID = PA_CAR`
    - 그중에서, 사용자가 입력한 항공사 코드(PA_CAR)와 같은 것만 가져온다

결과는

- 하나의 행에
    - SFLIGHT의 정보(A~...)
    - SCARR의 정보(B~...)
- 가 섞여서 들어가게 됩니다.

이걸 바로 우리가 만든 `TS_FLIGHT` 구조에 맞게 `INTO TABLE GT_FLIGHTS`로 담는 것입니다.

---

### 3. 코드 흐름 설명 (쭉 이어서 이해하기)

1. 구조 정의
    
    ```abap
    TYPES: BEGIN OF TS_FLIGHT, ... END OF TS_FLIGHT.
    
    ```
    
    - SFLIGHT와 SCARR에서 필요한 필드를 모아서 “내가 쓸 전용 구조”를 만든 것
    - 이 구조를 쓰면 나중에 `GT_FLIGHTS` 한 줄만 봐도
        - 항공사 코드
        - 항공사 이름
        - 항공편 번호
        - 비행 날짜
        - 좌석 수
    - 를 한 번에 볼 수 있습니다.
2. 내부 테이블 / work area
    
    ```abap
    DATA: GT_FLIGHTS TYPE TABLE OF TS_FLIGHT,
          GS_FLIGHT  LIKE LINE OF GT_FLIGHTS.
    
    ```
    
    - `GT_FLIGHTS` : 조회 결과 전체가 들어갈 테이블
    - `GS_FLIGHT` : LOOP에서 한 줄씩 꺼내서 쓰는 임시 변수
3. 선택 화면 파라미터
    
    ```abap
    PARAMETERS PA_CAR TYPE SFLIGHT-CARRID.
    
    ```
    
    - 실행 시, 사용자가 항공사 코드를 직접 입력
    - 예: `LH`, `AA`, `AZ` 등
    - 이 값이 WHERE 조건에 사용됩니다.
4. SELECT ~ INNER JOIN
    
    ```abap
    SELECT A~CARRID A~CONNID A~FLDATE A~SEATSMAX A~SEATSOCC
           B~CARRNAME
      INTO TABLE GT_FLIGHTS
      FROM SFLIGHT AS A
      INNER JOIN SCARR AS B
              ON A~CARRID = B~CARRID
      WHERE A~CARRID = PA_CAR.
    
    ```
    
    - 두 테이블을 묶어서 항공사 정보 + 항공편 정보를 한 번에 읽어옴
    - `INTO TABLE GT_FLIGHTS` → 결과가 GT_FLIGHTS에 여러 줄로 들어감
5. LOOP 출력
    
    ```abap
    LOOP AT GT_FLIGHTS INTO GS_FLIGHT.
      WRITE: / ...
    ENDLOOP.
    
    ```
    
    - GT_FLIGHTS를 한 줄씩 꺼내서 화면에 출력
    - `WRITE: /` 는 “새 줄에서 출력 시작”이라는 뜻
    - 필드들을 나열해서 한 줄에 쭉 보여주는 형태

---

### 4. INNER JOIN 관련 핵심 포인트 요약

1. JOIN을 하는 이유
    - 한 테이블에 없는 정보를 다른 테이블에서 가져와서 “한 줄에 합쳐서” 보고 싶을 때 사용
2. INNER JOIN
    - 두 테이블 모두에 존재하는 데이터만 결과에 포함
    - 조건은 `ON` 절에 있는 키 기준 (지금은 CARRID)
3. ABAP에서의 INNER JOIN 문법 패턴
    
    ```abap
    SELECT 필드들
      INTO TABLE itab
      FROM 테이블1 AS A
      INNER JOIN 테이블2 AS B
              ON A~키필드 = B~키필드
      WHERE 조건.
    
    ```
    
4. ALIAS(A, B) 사용하는 이유
    - 테이블 이름이 길 때 편리
    - 같은 필드명을 여러 테이블에서 가져올 때, 어디 테이블 건지 명확하게 구분 가능
5. 구조를 먼저 정의해두는 이유
    - SELECT 결과를 한 번에 깔끔한 타입으로 받기 위해
    - 나중에 LOOP에서 사용하기 편하기 위해

# 🔵 **Unit 3. Classic Abap Reports**

1. **Classic Abap Selection screen (선택화면)**
    1. SELECT-OPTIONS란?
        1. **Selection screen(선택화면)에서 범위/여러 개 선택을 입력 받는 구문** 기본 PARAMETERS는 한 개 값만 받는데,SELECT-OPTIONS는 **여러 개(단 의 값**,**구간(range)**을 한 번에 입력 받을 수 있음.
        2. SELECT-OPTIONS가 만들어주는 변수는 다음 4가지 컬럼을 가진 내부테이블 형식이다:
            
            
            | 필드 | 의미 |
            | --- | --- |
            | SIGN | 포함/제외 (I=Include, E=Exclude) |
            | OPTION | 조건( EQ, NE, BT, GE, LE, CP… ) |
            | LOW | 시작 값 |
            | HIGH | 범위 끝 값 (단일 값일 때는 비어 있음) |
        3. PARAMETERS vs SELECT-OPTIONS 비교
            
            
            | 항목 | PARAMETERS | SELECT-OPTIONS |
            | --- | --- | --- |
            | 입력 개수 | 1개 값만 | 여러 값 가능 |
            | 범위 입력 | 불가능 | 가능 |
            | Exclude | 불가능 | 가능 |
            | 내부 타입 | 단일 변수 | 내부 테이블 |
            | 실무 사용 빈도 | 기본 단일 값 | 거의 모든 리포트에 필수 |
        4. SELECT-OPTIONS 문법 
            1. SELECT-OPTIONS 문법 기본형
                
                ```abap
                SELECT-OPTIONS s_name FOR <element>.
                
                ```
                
                여기서 중요한 것:
                
                - **`FOR` 뒤에는 타입(type) 이름이 오면 안 된다.**
                - **반드시 "구조체의 필드" 또는 "데이터 오브젝트의 필드"가 와야 한다.**
                - 즉, *“값을 담을 수 있는 실제 필드(elementary field)”* 가 와야 한다.
            2. 왜 타입(type)이 오면 안 될까?
                
                예:
                
                ```abap
                SELECT-OPTIONS: S_CAR FOR SFLIGHT-CARRID.
                
                ```
                
                이렇게 쓰면 SAP는 다음을 자동으로 만든다:
                
                - S_CAR-SIGN
                - S_CAR-OPTION
                - S_CAR-LOW (타입 = SFLIGHT-CARRID)
                - S_CAR-HIGH (타입 = SFLIGHT-CARRID)
                
                → 즉, **LOW/HIGH 필드를 만들기 위해서 실제 자료형을 알고 있는 “필드”가 필요함** 타입(type)은 “정의”일 뿐 실제 필드가 아니므로 LOW/HIGH에 값을 채울 기준이 되지 못한다. 그래서 반드시 “실제 필드(데이터 요소)”가 필요하다.
                
            3. SELECT-OPTIONS에서 FOR 뒤에 올 수 있는 것
                
                ### 1) DDIC 테이블/뷰의 필드
                
                ```abap
                SELECT-OPTIONS s_car FOR sflight-carrid.
                ```
                
                ### 2) 구조(structure)의 필드
                
                ```abap
                TYPES: BEGIN OF ty_s,
                         carr TYPE sflight-carrid,
                       END OF ty_s.
                
                DATA: ls_s TYPE ty_s.
                
                SELECT-OPTIONS s_car FOR ls_s-carr.
                ```
                
                ### 3) DATA 선언된 단일 변수
                
                ```abap
                DATA gv_carrid TYPE sflight-carrid.
                SELECT-OPTIONS s_car FOR gv_carrid.
                ```
                
                ### 4) PARAMETERS도 가능
                
                ```abap
                PARAMETERS p_car TYPE sflight-carrid.
                SELECT-OPTIONS s_car FOR p_car.
                ```
                
            4. FOR 뒤에 오면 안 되는 것 (중요)
                
                ### 단순 타입 정의(type)
                
                ```abap
                TYPES ty_car TYPE sflight-carrid.
                SELECT-OPTIONS s_car FOR ty_car.       "오류 → 실제 필드가 아님
                
                ```
                
                ### 구조 전체
                
                ```abap
                DATA: ls_flight TYPE sflight.
                SELECT-OPTIONS s_car FOR ls_flight.    "오류 → 구조 전체는 element가 아님
                
                ```
                
                ### 테이블 이름만 넣기
                
                ```abap
                SELECT-OPTIONS s_car FOR sflight.      "오류 → 필드가 아님
                
                ```
                
                이유는 모두 동일하다.
                
                → **FOR 뒤에는 반드시 “단일 elementary 필드(값을 담는 변수)”가 와야 한다.**
                
2. ABAP Report Events (클래식 리포트 이벤트)
    1. 정의 : Classic ABAP Report는 단순히 위에서 아래로 실행되는 게 아니다. SAP가 **특정 시점에 자동으로 호출하는 이벤트 블록**이 존재하고, 우리는 그 이벤트들 속에 코드를 넣어서 화면을 제어한다. 즉, Report는 “이벤트 기반 프로그래밍 구조”라고 보면 된다.
    2. 이벤트 전체 흐름(가장 중요한 개념) → 클래식 레포트는 **아래 순서대로 이벤트가 실행된다**:
        
        # 하지만 입력 **순서**는 중요하지 않다**. but ABAP System은 위치를 찾아서 순서대로 실행** 
        
        1. **INITIALIZATION**
            - 선택 화면 나오기 전 기본값 설정
        2. **AT SELECTION-SCREEN OUTPUT (선택화면 그리기 직전)**
            - 선택 화면 그리기 직전 → 화면 조작
        3. **AT SELECTION-SCREEN (입력값 검사)**
            - 실행(F8) 직전 → 입력값 검증
        4. **START-OF-SELECTION (메인 로직 시작)**
            - 메인 로직(DB SELECT, 계산)
        5. **GET (Logical Database 전용)**
        6. **END-OF-SELECTION (마무리 화면 출력 준비)**
            - 출력 단계 (WRITE)
        7. **TOP-OF-PAGE (페이지 헤더 출력)**
            - 페이지 헤더/푸터 출력
        8. **END-OF-PAGE (페이지 푸터 출력)**
        9. **AT LINE-SELECTION (인터랙티브 리스트 클릭 이벤트)**
            - 리스트 더블 클릭 시 인터랙티브 처리
    3. 중복 사용 안 되는 이벤트 (한 번만 가능)
        1. 아래 이벤트는 **한 프로그램 안에 딱 1번만** 선언할 수 있다.
        
        | 이벤트 | 설명 |
        | --- | --- |
        | **INITIALIZATION** | 선택화면 초기값 설정 |
        | **AT SELECTION-SCREEN OUTPUT** | 선택화면 그리기 전 |
        | **START-OF-SELECTION** | 메인 로직 시작 |
        | **END-OF-SELECTION** | 출력 단계 |
        | **TOP-OF-PAGE** | 리스트 페이지 헤더 |
        | **END-OF-PAGE** | 리스트 페이지 푸터 |
        
        → 이 이벤트들은 **프로그램 실행 시 시스템이 “특정 타이밍”에 딱 한 번 호출하는 이벤트**라서 중복 선언하면 문법 오류가 난다.
        
    4. 중복 사용 가능한 이벤트
        1. 아래 이벤트는 **필드 단위 / 조건별로 여러 번 사용할 수 있다.**
        
        | 이벤트 | 설명 |
        | --- | --- |
        | **AT SELECTION-SCREEN ON <field>** | 특정 필드 검증 |
        | **AT SELECTION-SCREEN ON BLOCK <block>** | 블록 단위 검증 |
        | **AT USER-COMMAND** | 사용자 커맨드 처리 |
        | **AT LINE-SELECTION** | 리스트 클릭 이벤트 |
3. 실습 1 - ZABAP_18_G01
    1. 요구 사항 : 프로그램 전체 흐름 설명
        1. 선택 화면에서 `SO_CAR`로 **항공사 코드(CARRID)를 여러 개/범위로 입력** 받는다.
        2. 사용자가 실행(F8)하면,
            
            `SPFLI` 테이블에서 `CARRID`가 `SO_CAR` 조건에 해당하는 모든 행을 읽는다.
            
        3. 한 행씩 읽을 때마다 `GS_CONNECT`에 담고,
            
            그때그때 `WRITE`로 `CARRID, CONNID, CITYFROM, CITYTO`를 출력한다.
            
        
              → 즉, “선택한 항공사들의 노선 목록을 리스트로 출력하는 간단 리포트”이다.
        
    2. 변수 선언 부분 풀이
        
        ```abap
        DATA : GV_CAR     TYPE SCARR-CARRID,
               GS_CONNECT TYPE SPFLI.
        ```
        
        - `GV_CAR`
            - 단일 값만 저장하는 **elementary variable (단일 필드 변수)**
            - 타입은 `SCARR-CARRID`와 동일
        - `GS_CONNECT`
            - `SPFLI` 테이블 한 줄 전체와 같은 구조를 가지는 **structure variable**
            - 필드 예: `CARRID, CONNID, CITYFROM, CITYTO, AIRPFROM, AIRPTO, ...`
        
        이 둘의 차이를 수업에서 보여주려고 일부러 둘 다 선언해 둔 것이다.
        
    3. SELECT-OPTIONS와 FOR의 의미 (이 코드에서 가장 중요한 부분)
    
    ```abap
    SELECT-OPTIONS: SO_CAR FOR GS_CONNECT-CARRID. "방법2.
    ```
    
    여기서 핵심 포인트:
    
    1. `FOR` 뒤에는 **타입 이름이 아니라 “실제 필드”가 와야 한다.
        - OK: `GV_CAR`, `GS_CONNECT-CARRID`, `SFLIGHT-CARRID` 등
        - NG: `TYPE scarr-carrid`, `TYPE ty_carrid` 등
    2. `FOR GS_CONNECT-CARRID` 라고 쓰면
        - `SO_CAR-LOW` 와 `SO_CAR-HIGH`의 타입이 `GS_CONNECT-CARRID` (즉 CARRID 타입) 으로 자동 설정된다.
        - `GV_CAR`를 기준으로 해도 결과는 동일하다. (`GV_CAR` 타입이 CARRID이기 때문)
    3. `SO_CAR`는 내부적으로 다음과 같은 구조를 가진 **RANGE 테이블**이다.
        
        
        | 필드 | 의미 |
        | --- | --- |
        | SIGN | I(Include) 또는 E(Exclude) |
        | OPTION | EQ, NE, BT, GE, LE, CP 등 |
        | LOW | 조회 시작 값 |
        | HIGH | 조회 끝 값(범위일 때 사용) |
        
        그래서 selection screen에서
        
        여러 값 / 범위 / 제외 조건 등을 모두 넣을 수 있고,
        
        `WHERE CARRID IN SO_CAR` 한 줄로 다 처리할 수 있다.
        
    4. 코드
        
        ```jsx
        *&---------------------------------------------------------------------*
        *& Report ZABAP_18_G01
        *&---------------------------------------------------------------------*
        *&  SPFLI(항공편 마스터)에서 항공사(CARRID)를 선택 조건으로
        *&  노선 정보를 조회해서 리스트로 출력하는 리포트
        *&---------------------------------------------------------------------*
        REPORT ZABAP_18_G01.
        
        *---------------------------------------------------------------------*
        * 1. 변수 선언
        *---------------------------------------------------------------------*
        DATA: GV_CAR     TYPE SCARR-CARRID, " elementary variable (단일 필드 변수)
              GS_CONNECT TYPE SPFLI.        " structure variable (SPFLI 한 줄 구조)
        
        *---------------------------------------------------------------------*
        * 2. Selection screen - SELECT-OPTIONS
        *    - SELECT-OPTIONS는 "타입(TYPE)"이 아니라
        *      "실제 필드(엘리먼트 변수 또는 구조체의 필드)"를 기준으로 FOR 사용
        *---------------------------------------------------------------------*
        
        "* 방법1: 단일 변수(엘리먼트 변수)에 대해 FOR
        "*SELECT-OPTIONS: SO_CAR FOR GV_CAR.
        
        * 방법2: 구조체 변수의 필드에 대해 FOR
        SELECT-OPTIONS: SO_CAR FOR GS_CONNECT-CARRID.
        
        " 위 두 줄 중 하나만 활성화해서 사용 가능
        " 둘 다 의미는 동일:
        "   - SO_CAR 의 LOW/HIGH 필드 타입이 CARRID와 동일해진다.
        
        *---------------------------------------------------------------------*
        * 3. DB 테이블 SPFLI에서 데이터 읽기
        *    - SELECT ... ENDSELECT 구문 사용
        *    - WHERE CARRID IN so_car : 선택화면의 선택조건을 그대로 사용
        *---------------------------------------------------------------------*
        SELECT *
          INTO GS_CONNECT
          FROM SPFLI
          WHERE CARRID IN SO_CAR.
        
          " 한 건 읽을 때마다 바로바로 출력
          WRITE: / GS_CONNECT-CARRID,
                   GS_CONNECT-CONNID,
                   GS_CONNECT-CITYFROM,
                   GS_CONNECT-CITYTO.
        
        ENDSELECT.
        ```
        
4. 실습 2 - ZABAP_19_G01
    1. 요구 사항 : 이 Report가 하는 일
        1. 실행하면
            - 선택 화면에 PA_DATE(비행일자)가 오늘 날짜로 자동 설정됨
            - SO_CAR에는 항공사 ‘AA’가 기본값으로 추가됨
        2. 사용자가 실행(F8)을 누르면
            - SFLIGHT 테이블에서
                
                `FLDATE = PA_DATE` 인 항공편을 전부 읽어온다
                
        3. 결과를 리스트로 출력한다
            - CARRID / CONNID / FLDATE 3개만 출력
    2. 코드
        
        ```jsx
        *&---------------------------------------------------------------------*
        *& Report ZABAP_19_G01
        *&---------------------------------------------------------------------*
        *&   - SFLIGHT 테이블에서 특정 날짜(PA_DATE)의 항공편을 조회하는 리포트
        *&   - 초기 실행 시 날짜 기본값 세팅, SELECT-OPTIONS 초기값 추가 예제 포함
        *&---------------------------------------------------------------------*
        REPORT ZABAP_19_G01.
        
        *---------------------------------------------------------------------*
        * 1. 내부 테이블 / 작업 영역 선언
        *---------------------------------------------------------------------*
        DATA : GT_FLIGHT TYPE TABLE OF SFLIGHT,      " 전체 조회 결과 저장
               GS_FLIGHT LIKE LINE OF GT_FLIGHT.     " LOOP용 work area
        
        *---------------------------------------------------------------------*
        * 2. Selection screen
        *---------------------------------------------------------------------*
        " SELECT-OPTIONS는 '타입'이 아니라 '실제 필드'를 기준으로 선언해야 한다.
        SELECT-OPTIONS: SO_CAR FOR GS_FLIGHT-CARRID.   " 항공사 코드 조건
        
        " PARAMETERS는 단일 값 입력
        PARAMETERS PA_DATE TYPE SFLIGHT-FLDATE.        " 비행일자
        " DEFAULT SY-DATUM.   ← 이렇게 적어도 되지만, INITIALIZATION 예제 위해 주석
        
        *---------------------------------------------------------------------*
        * 3. INITIALIZATION
        *    - 선택화면이 나타나기 전에 기본값을 세팅하는 이벤트
        *---------------------------------------------------------------------*
        INITIALIZATION.
        
          " 날짜 기본값 = 오늘 날짜
          PA_DATE = SY-DATUM.
        
          " SELECT-OPTIONS의 내부 테이블(SO_CAR)에 기본값 한 줄 추가
          " LOW = 'AA' 항공사로 고정 (Include, Equal 조건)
          SO_CAR-SIGN   = 'I'.    " Include
          SO_CAR-OPTION = 'EQ'.   " Equal
          SO_CAR-LOW    = 'AA'.
          APPEND SO_CAR.
        
          " 아래는 두 번째 값 추가 예제 (현재는 주석)
          "* SO_CAR-SIGN   = 'I'.
          "* SO_CAR-OPTION = 'EQ'.
          "* SO_CAR-LOW    = 'DL'.
          "* APPEND SO_CAR.
        
          " 날짜 조작 예시 (PA_DATE를 +10일)
          "* PA_DATE = PA_DATE + 10.
        
        *---------------------------------------------------------------------*
        * 4. AT SELECTION-SCREEN
        *    - 사용자가 입력한 값을 검증하는 부분 (현재 주석)
        *---------------------------------------------------------------------*
        "* AT SELECTION-SCREEN.
        "*   IF PA_DATE < SY-DATUM.
        "*     MESSAGE '현재일보다 미래 일자를 입력하여주세요!' TYPE 'E'.
        "*   ENDIF.
        
        *---------------------------------------------------------------------*
        * 5. START-OF-SELECTION
        *    - 메인 로직: DB SELECT 수행
        *---------------------------------------------------------------------*
        START-OF-SELECTION.
        
          " 날짜 = PA_DATE 인 SFLIGHT 데이터 조회
          SELECT *
            INTO TABLE GT_FLIGHT
            FROM SFLIGHT
            WHERE FLDATE = PA_DATE.
            " 여기서는 CARRID 조건은 사용하지 않음
            " (SO_CAR 사용하려면 AND CARRID IN SO_CAR 추가 가능)
        
        *---------------------------------------------------------------------*
        * 6. 출력 (END-OF-SELECTION 단계에서 LOOP로 출력해도 OK)
        *---------------------------------------------------------------------*
          LOOP AT GT_FLIGHT INTO GS_FLIGHT.
        
            WRITE: / GS_FLIGHT-CARRID,
                     GS_FLIGHT-CONNID,
                     GS_FLIGHT-FLDATE.
        
          ENDLOOP.
        ```
        
    
5. 실습 3 - ZQUIZ_08_G01
    1. 코드 풀이(개념 설명)
        
        (1) Internal Table / Work Area
        
        ```abap
        DATA : GT_SBOOK TYPE TABLE OF SBOOK,
               GS_SBOOK LIKE LINE OF GT_SBOOK.
        ```
        
        - `GT_SBOOK` : 조회 결과 전체가 저장되는 내부 테이블
        - `GS_SBOOK` : LOOP에서 1줄씩 받는 work area
        - 둘 모두 SBOOK 테이블의 구조를 그대로 사용
        
        ---
        
        (2) SELECT-OPTIONS
        
        ```abap
        SELECT-OPTIONS: SO_ID  FOR GS_SBOOK-CUSTOMID,
                        SO_FDT FOR GS_SBOOK-FLDATE.
        ```
        
        - **SO_ID** → 고객번호(CUSTOMID)를 여러 개 / 여러 범위 입력 가능
        - **SO_FDT** → 날짜 범위 입력 가능 (예: 20250101 ~ 20250131)
        
        중요 포인트:
        
        `FOR` 뒤에는 **타입이 아니라 실제 필드**가 와야 한다.
        
        ---
        
        (3) INITIALIZATION
        
        프로그램 실행하면 selection screen이 뜨기 전에 **자동 1회 실행됨**.
        
        이 프로그램에서 하는 일:
        
        ```abap
        LV_YEAR = SY-DATUM(4).           " 오늘 날짜에서 연도만 추출
        SO_FDT-LOW  = LV_YEAR && '0101'. " 올해 1월1일
        SO_FDT-HIGH = LV_YEAR && '1231'. " 올해 12월31일
        APPEND SO_FDT.                   " select-options 테이블에 한 줄 추가
        ```
        
        즉, 실행과 동시에 비행일자 조건이
        
        ```
        20250101 ~ 20251231
        ```
        
        이렇게 자동으로 세팅된다.
        
        ---
        
        (4) START-OF-SELECTION (메인 로직)
        
        선택화면에서 값 입력 + 실행(F8) 후 가장 먼저 실행되는 이벤트.
        
        ```abap
        SELECT *
          INTO TABLE GT_SBOOK
          FROM SBOOK
          WHERE CUSTOMID IN SO_ID
            AND FLDATE   IN SO_FDT.
        ```
        
        - `IN SO_ID`
            
            → SIGN/OPTION/LOW/HIGH 구조 전체를 SQL 조건으로 자동 변환
            
        - `IN SO_FDT`
            
            → 날짜 범위도 자동 적용
            
        
        이런 RANGE 테이블 조건을 직접 쓸 수 있는 것이 SELECT-OPTIONS의 강력한 특징.
        
        ---
        
        (5) 결과 출력
        
        ```abap
        LOOP AT GT_SBOOK INTO GS_SBOOK.
        
          WRITE: / GS_SBOOK-CARRID,
                   GS_SBOOK-CONNID,
                   GS_SBOOK-FLDATE,
                   GS_SBOOK-BOOKID,
                   GS_SBOOK-CUSTOMID,
                   GS_SBOOK-CUSTTYPE,
                   GS_SBOOK-CLASS,
                   GS_SBOOK-ORDER_DATE.
        
        ENDLOOP.
        ```
        
        - SELECT된 결과를 한 줄씩 출력
        - `/` → 줄바꿈
        - 공항코드(CITYFROM, CITYTO)는 SBOOK에 없어서 출력하지 않음
            
            (SPFLI 테이블에 있음)
            
    2. 코드
        
        ```jsx
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_08_G01
        *&---------------------------------------------------------------------*
        *&   - SBOOK 테이블에서 고객번호 / 비행일자 조건으로 데이터를 조회하는 리포트
        *&   - 실행 시 so_fdt는 자동으로 1년 전체(1월1일 ~ 12월31일) 세팅
        *&   - 조회된 항공편 예약정보를 리스트로 출력
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_08_G01.
        
        *---------------------------------------------------------------------*
        * 1. Internal table & work area 선언
        *---------------------------------------------------------------------*
        DATA : GT_SBOOK TYPE TABLE OF SBOOK,        " 전체 조회 결과
               GS_SBOOK LIKE LINE OF GT_SBOOK.      " LOOP에서 1줄씩 받는 구조체
        
        *---------------------------------------------------------------------*
        * 2. Selection screen
        *    - SELECT-OPTIONS : 여러 값/범위 입력 가능
        *---------------------------------------------------------------------*
        SELECT-OPTIONS: SO_ID  FOR GS_SBOOK-CUSTOMID,   " 고객번호 범위
                        SO_FDT FOR GS_SBOOK-FLDATE.     " 비행일자 범위
        
        *---------------------------------------------------------------------*
        * 3. INITIALIZATION
        *    - 선택화면이 표시되기 전에 자동 실행
        *    - so_fdt LOW/HIGH 값을 “올해 1월1일~12월31일”로 자동 설정
        *---------------------------------------------------------------------*
        INITIALIZATION.
        
          DATA: LV_YEAR TYPE N LENGTH 4.   " 연도만 담는 변수 (예: '2025')
        
          " SY-DATUM = YYYYMMDD 이므로 앞 4자리만 잘라오면 연도
          LV_YEAR = SY-DATUM(4).
        
          " so_fdt 에 기본 범위 지정
          SO_FDT-SIGN = 'I'.
          SO_FDT-OPTION = 'BT'.  " 임의의 TEST 고객 번호
          SO_FDT-LOW  = LV_YEAR && '0101'.   " 올해의 1월 1일
          SO_FDT-HIGH = LV_YEAR && '1231'.   " 올해의 12월 31일
          APPEND SO_FDT.                     " select-options 내부 테이블에 추가
        
        *---------------------------------------------------------------------*
        * 4. START-OF-SELECTION
        *    - 메인 로직(DB SELECT)
        *---------------------------------------------------------------------*
        START-OF-SELECTION.
        
          " CUSTOMID, FLDATE 조건을 모두 적용하여 SBOOK 데이터 조회
          SELECT *
            INTO TABLE GT_SBOOK
            FROM SBOOK
            WHERE CUSTOMID IN SO_ID     " 고객번호 범위 조건
              AND FLDATE   IN SO_FDT.   " 비행일자 범위 조건
        
        *---------------------------------------------------------------------*
        * 5. 결과 출력
        *---------------------------------------------------------------------*
          LOOP AT GT_SBOOK INTO GS_SBOOK.
        
            WRITE :/ GS_SBOOK-CARRID,
                     GS_SBOOK-CONNID,
                     GS_SBOOK-FLDATE,
                     GS_SBOOK-BOOKID,
                     GS_SBOOK-CUSTOMID,
                     GS_SBOOK-CUSTTYPE,
                     GS_SBOOK-CLASS,
                     GS_SBOOK-ORDER_DATE.
        
          ENDLOOP.
        ```
        
    
6. 실습 4 - ZQUIZ_08_G01_INNERJOIN
    1. 프로그램 목적
        
        이 프로그램은 다음 데이터를 조회하는 리포트이다:
        
        - SBOOK(예약) + SCUSTOM(고객마스터)를 **INNER JOIN**
        - 고객 이름(name)을 가져옴
        - 예약일(order_date)과 비행일(fldate)의 차이(adays)를 계산
        - 고객번호/비행일자 범위 조건으로 출력
    2. 핵심 개념 요약
        
        ### 1) INNER JOIN
        
        두 테이블(SBOOK, SCUSTOM)을 고객ID 기준으로 묶음:
        
        ```
        SBOOK-CUSTOMID = SCUSTOM-ID
        
        ```
        
        → 고객 이름(name)을 가져올 수 있다.
        
        ---
        
        ### 2) SELECT-OPTIONS
        
        - `so_id` → 고객번호 범위
        - `so_fdt` → 비행일자 범위
        
        `IN so_xx` 문법으로 WHERE에 그대로 사용할 수 있다.
        
        ---
        
        ### 3) INITIALIZATION의 역할
        
        프로그램 실행 시
        
        비행일자(so_fdt)에 **해당 연도의 1월1일 ~ 12월31일**을 자동 입력.
        
        ```
        20250101 ~ 20251231
        
        ```
        
        ---
        
        ### 4) ADAYS 계산
        
        ABAP에서는 날짜끼리 빼면 “일(day) 차이”가 자동 계산된다.
        
        ```abap
        adays = fldate - order_date.
        
        ```
        
    3. SELECT 구문 구조 설명
        
        ```abap
        SELECT a~carrid
               a~connid
               a~fldate
               ...
               b~name AS custname
        
        ```
        
        ### 왜 a~ b~ 를 쓰는가?
        
        - JOIN에서는 **테이블 별칭(alias)** 필수
        - 동일한 필드(customid)가 여러 테이블에 있을 수 있기 때문
    4. LOOP + MODIFY 과정
        
        조회 결과 한 줄씩 GS_RESULT로 받고:
        
        1. ADAYS 계산
        2. WRITE로 출력
        3. GT_RESULT 내부 테이블에 다시 업데이트(MODIFY)
    5. 전체 처리 순서
        1. 선택 화면 표시
        2. INITIALIZATION → 날짜 기본값 자동 세팅
        3. START-OF-SELECTION → INNER JOIN SELECT
        4. LOOP → ADAYS 계산 후 출력
        5. 종료
    6. 코드
        
        ```jsx
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_08_G01_INNERJOIN
        *&---------------------------------------------------------------------*
        *&  - SBOOK + SCUSTOM INNER JOIN
        *&  - 고객 이름 가져오기
        *&  - ADAYS = FLDATE - ORDER_DATE 계산
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_08_G01_INNERJOIN.
        
        *---------------------------------------------------------------------*
        * 1. 로컬 구조 정의 (JOIN 결과 + 추가계산 필드 포함)
        *---------------------------------------------------------------------*
        TYPES: BEGIN OF ts_result,
                 carrid      TYPE sbook-carrid,          " 항공사 코드
                 connid      TYPE sbook-connid,          " 항공편 번호
                 fldate      TYPE sbook-fldate,          " 비행일자
                 bookid      TYPE sbook-bookid,          " 예약번호
                 customid    TYPE sbook-customid,        " 고객ID
                 custname    TYPE scustom-name,          " 고객 이름 (SCUSTOM)
                 custtype    TYPE sbook-custtype,        " 고객 유형
                 class       TYPE sbook-class,           " 클래스
                 order_date  TYPE sbook-order_date,      " 예약일
                 adays       TYPE i,                     " 출발일까지 남은 일수
               END OF ts_result.
        
        DATA: gt_result TYPE TABLE OF ts_result,          " 전체 결과 테이블
              gs_result TYPE ts_result.                   " LOOP용 work area
        
        *---------------------------------------------------------------------*
        * 2. Selection screen
        *---------------------------------------------------------------------*
        SELECT-OPTIONS: so_id  FOR gs_result-customid,    " 고객번호 범위
                        so_fdt FOR gs_result-fldate.      " 비행일자 범위
        
        *---------------------------------------------------------------------*
        * 3. INITIALIZATION
        *    - so_fdt 기본값 : 올해 1월 1일 ~ 12월 31일
        *---------------------------------------------------------------------*
        INITIALIZATION.
        
          DATA lv_year TYPE n LENGTH 4.
          lv_year = sy-datum(4).                         " 오늘 연도만 추출
        
          so_fdt-sign   = 'I'.                           " Include
          so_fdt-option = 'BT'.                          " Between
          so_fdt-low    = lv_year && '0101'.             " YYYY0101
          so_fdt-high   = lv_year && '1231'.             " YYYY1231
          APPEND so_fdt.
        
        *---------------------------------------------------------------------*
        * 4. START-OF-SELECTION
        *    - INNER JOIN SBOOK + SCUSTOM
        *    - 고객 이름(name) 매핑
        *---------------------------------------------------------------------*
        START-OF-SELECTION.
        
          SELECT a~carrid
                 a~connid
                 a~fldate
                 a~bookid
                 a~customid
                 b~name       AS custname                 " 고객 이름 가져오기
                 a~custtype
                 a~class
                 a~order_date
            FROM sbook   AS a
            INNER JOIN scustom AS b
               ON a~customid = b~id                       " 고객ID 기준 join
            INTO CORRESPONDING FIELDS OF TABLE gt_result
            WHERE a~customid IN so_id
              AND a~fldate   IN so_fdt.
        
        *---------------------------------------------------------------------*
        * 5. ADAYS 계산 및 출력
        *---------------------------------------------------------------------*
          LOOP AT gt_result INTO gs_result.
        
            " ADAYS = 출발일 - 예약일
            gs_result-adays = gs_result-fldate - gs_result-order_date.
        
            " 결과 출력
            WRITE: / gs_result-carrid,
                     gs_result-connid,
                     gs_result-fldate,
                     gs_result-bookid,
                     gs_result-customid,
                     gs_result-custname,
                     gs_result-order_date,
                     gs_result-adays.
        
            " 계산된 ADAYS를 내부테이블에도 업데이트
            MODIFY gt_result FROM gs_result.
        
          ENDLOOP.
        
        ```
