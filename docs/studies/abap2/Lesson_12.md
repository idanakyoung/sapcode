# 🧭 Lesson 12 – Inner Join / Group By / Having / Order By / SALV

---

## 0) 전체 흐름(공통 뼈대)

```
Selection Screen
  ↓
DB SELECT
  - INNER JOIN
  - GROUP BY
  - HAVING
  - ORDER BY
  ↓
Internal Table 적재
  ↓
CL_SALV_TABLE=>FACTORY
  ↓
GO_SALV->DISPLAY( )
```

---

## 1) Unit 1. Inner Join

## 1-1) ZABAP_36_G01 – SALV 기본 출력

### 핵심

- `CL_SALV_TABLE`은 SAP에서 제공하는 **Simple ALV**
- 가장 간단하게 내부테이블을 ALV 형태로 출력할 수 있음
- `GO_SALV`는 실제 객체가 아니라 **객체 참조 변수**

### 참조 변수 선언

```
DATA: GO_SALV TYPE REF TO CL_SALV_TABLE.
```

### 의미

- `REF TO` = 객체 참조 변수
- `GO_SALV`는 객체 그 자체가 아니라 **객체 주소를 담는 변수**

### SALV 생성

```
TRY.
    CALL METHOD CL_SALV_TABLE=>FACTORY
      IMPORTING
        R_SALV_TABLE = GO_SALV
      CHANGING
        T_TABLE      = GT_SCARR.
  CATCH CX_SALV_MSG.
ENDTRY.
```

### 의미

- `FACTORY`
    - ALV 객체 생성
    - 내부테이블 연결
    - 생성된 ALV 객체를 `GO_SALV`에 넣어줌

### 출력

```
GO_SALV->DISPLAY( ).
```

### 포인트

- `FACTORY` = ALV 만들기
- `DISPLAY` = ALV 보여주기
- 실제 출력 데이터는 `GT_SCARR`
- `GO_SALV`는 보여주는 도구(뷰어)

---

## 1-2) ZBC405_G01_INNER_JOIN – INNER JOIN + SALV

### 핵심

- 여러 테이블을 `INNER JOIN`으로 연결해 조회
- `INTO CORRESPONDING FIELDS OF TABLE` 로 내부테이블 적재
- 결과를 SALV로 출력

---

### 출력 구조 정의

```
TYPES: BEGIN OF TS_DATA,
         CARRID     TYPE SPFLI-CARRID,
         CONNID     TYPE SPFLI-CONNID,
         FLDATE     TYPE SFLIGHT-FLDATE,
         CITYFROM   TYPE SPFLI-CITYFROM,
         CITYTO     TYPE SPFLI-CITYTO,
         FLTIME     TYPE SPFLI-FLTIME,
         PLANETYPE  TYPE SFLIGHT-PLANETYPE,
         SEATSOCC   TYPE SFLIGHT-SEATSOCC,
         SEATSMAX   TYPE SFLIGHT-SEATSMAX,
         OP_SPEED   TYPE SAPLANE-OP_SPEED,
         SPEED_UNIT TYPE SAPLANE-SPEED_UNIT,
       END OF TS_DATA.
```

### 포인트

- 조인 결과를 담을 출력 전용 구조를 직접 정의
- 여러 테이블 필드를 한 구조에 합쳐 담는 전형적인 방식

---

### 핵심 SELECT

```
SELECT A~CARRID A~CONNID
       B~FLDATE
       A~CITYFROM A~CITYTO A~FLTIME
       B~PLANETYPE B~SEATSOCC B~SEATSMAX
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM SPFLI AS A INNER JOIN SFLIGHT AS B
                  ON A~CARRID = B~CARRID
                  AND A~CONNID = B~CONNID
                  INNER JOIN SAPLANE AS C
                  ON B~PLANETYPE = C~PLANETYPE
  WHERE A~CARRID IN SO_CAR.
```

### 의미

- `SPFLI` 와 `SFLIGHT` 를
    - `CARRID`
    - `CONNID`
        
        기준으로 조인
        
- 다시 `SFLIGHT` 와 `SAPLANE` 를
    - `PLANETYPE`
        
        기준으로 조인
        

### 포인트

- `INNER JOIN`은 **양쪽에 모두 존재하는 데이터만** 조회됨
- `A~`, `B~`, `C~` 별칭을 사용하면 코드가 더 깔끔함
- `INTO CORRESPONDING FIELDS` 는 필드명이 같은 것끼리 자동 매핑

---

### SALV 출력

```
TRY.
    CALL METHOD CL_SALV_TABLE=>FACTORY
      IMPORTING
        R_SALV_TABLE = GO_SALV
      CHANGING
        T_TABLE      = GT_DATA.
  CATCH CX_SALV_MSG.
ENDTRY.

CALL METHOD GO_SALV->DISPLAY.
```

### 포인트

- INNER JOIN 결과를 바로 SALV로 확인 가능
- 실습에서는 조회 + 확인용으로 SALV가 아주 편함

---

## 2) Unit 2. Group By

## 2-1) ZBC405_G01_GROUP_BY – GROUP BY 기본 집계

### 핵심

- `GROUP BY` 는 같은 그룹끼리 묶어서 집계할 때 사용
- `SUM`, `COUNT`, `AVG` 같은 집계 함수와 함께 사용
- 일반 컬럼과 집계 함수를 같이 쓰면 일반 컬럼은 반드시 `GROUP BY`에 포함

---

### 출력 구조 정의

```
TYPES: BEGIN OF TS_DATA,
         CARRID       TYPE SFLIGHT-CARRID,
         CONNID       TYPE SFLIGHT-CONNID,
         SEATSMAX     TYPE SFLIGHT-SEATSMAX,
         SEATSOCC     TYPE SFLIGHT-SEATSOCC,
         NUM_FLLIGHTS TYPE I,
       END OF TS_DATA.
```

---

### 핵심 SELECT

```
SELECT CARRID CONNID
       SUM( SEATSMAX )
       SUM( SEATSOCC )
       COUNT( * )
  INTO TABLE GT_DATA
  FROM SFLIGHT
  WHERE CARRID IN SO_CAR
  GROUP BY CARRID CONNID
  ORDER BY CARRID CONNID.
```

### 의미

- `CARRID + CONNID` 기준으로 그룹화
- 각 그룹별
    - 최대 좌석 합계
    - 탑승 좌석 합계
    - 항공편 수
        
        계산
        

### 포인트 1) 집계 함수 규칙

- `SELECT`에 일반 컬럼 + 집계 함수가 같이 있으면
- 일반 컬럼은 반드시 `GROUP BY`에 들어가야 함

예:

```
일반 컬럼 = CARRID, CONNID
→ GROUP BY CARRID CONNID 필수
```

### 포인트 2) COUNT(*)

- 해당 그룹의 행 개수
- 여기서는 항공사/노선별 **항공편 수** 의미

---

### 별칭 사용 버전

```
SELECT CARRID CONNID
       SUM( SEATSMAX ) AS SEATSMAX
       SUM( SEATSOCC ) AS SEATSOCC
       COUNT( * ) AS NUM_FLLIGHTS
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM SFLIGHT
  WHERE CARRID IN SO_CAR
  GROUP BY CARRID CONNID
  ORDER BY CARRID CONNID.
```

### 포인트

- `AS 별칭`을 구조체 필드명과 맞추면
- `INTO CORRESPONDING FIELDS`와 궁합이 좋음

---

## 3) Unit 3. Having / Order By

## 3-1) ZBC405_G01_GROUP_BY2 – HAVING + ORDER BY 확장

### 핵심

- `HAVING` 은 `GROUP BY` 후 집계 결과에 조건을 거는 구문
- `ORDER BY` 로 집계 결과 정렬 가능
- `COUNT( DISTINCT ... )` 도 시험 포인트

---

### 출력 구조 정의

```
TYPES: BEGIN OF TS_DATA,
         CARRID       TYPE SFLIGHT-CARRID,
         SEATSMAX     TYPE SFLIGHT-SEATSMAX,
         SEATSOCC     TYPE SFLIGHT-SEATSOCC,
         SEATSMAX_AVG TYPE SFLIGHT-SEATSMAX,
         SEATSOCC_AVG TYPE SFLIGHT-SEATSOCC,
         NUM_CONNID   TYPE I,
         NUM_FLIGHTS  TYPE I,
       END OF TS_DATA.
```

---

### Selection Screen 확장

```
SELECT-OPTIONS: SO_CAR FOR GS_DATA-CARRID,
                SO_AVGMA FOR GS_DATA-SEATSMAX_AVG,
                SO_AVGOC FOR GS_DATA-SEATSOCC_AVG.
```

### 의미

- `SO_CAR` : 항공사 조건
- `SO_AVGMA` : 평균 최대좌석 조건
- `SO_AVGOC` : 평균 탑승좌석 조건

### 포인트

- 단순 row 조건이 아니라
- **집계 결과의 평균값 조건**을 화면에서 받는 구조

---

### 핵심 SELECT

```
SELECT CARRID
       SUM( SEATSMAX ) AS SEATSMAX
       SUM( SEATSOCC ) AS SEATSOCC
       AVG( SEATSMAX ) AS SEATSMAX_AVG
       AVG( SEATSOCC ) AS SEATSOCC_AVG
       COUNT( DISTINCT CONNID ) AS NUM_CONNID
       COUNT( * ) AS NUM_FLIGHTS
  INTO CORRESPONDING FIELDS OF TABLE GT_DATA
  FROM SFLIGHT
  WHERE CARRID IN SO_CAR
  GROUP BY CARRID
  HAVING AVG( SEATSMAX ) IN SO_AVGMA
     AND AVG( SEATSOCC ) IN SO_AVGOC
  ORDER BY SEATSMAX_AVG DESCENDING
           SEATSOCC_AVG DESCENDING.
```

---

## 3-2) WHERE vs HAVING

### 핵심

- `WHERE` : 그룹핑 전에 개별 row를 거름
- `HAVING` : 그룹핑 후 집계 결과를 거름

### 비교

| 구분 | 적용 시점 | 대상 |
| --- | --- | --- |
| WHERE | GROUP BY 전 | 개별 행(row) |
| HAVING | GROUP BY 후 | 집계 결과(SUM/AVG/COUNT) |

### 포인트

- `AVG(SEATSMAX)` 같은 집계값 조건은 `WHERE`에 못 씀
- 이런 조건은 반드시 `HAVING`

---

## 3-3) COUNT(DISTINCT CONNID)

### 핵심

```
COUNT( DISTINCT CONNID ) AS NUM_CONNID
```

### 의미

- 항공사별 서로 다른 노선 수를 계산
- 중복 `CONNID` 는 한 번만 셈

### 포인트

- `COUNT(*)` 는 전체 행 수
- `COUNT(DISTINCT 필드)` 는 중복 제거 후 개수

---

## 3-4) ORDER BY ... DESCENDING

### 핵심

```
ORDER BY SEATSMAX_AVG DESCENDING
         SEATSOCC_AVG DESCENDING.
```

### 의미

1. 평균 최대좌석이 큰 항공사부터
2. 같으면 평균 탑승좌석이 큰 순서

### 포인트

- 집계 결과도 정렬 가능
- 우선순위 정렬을 여러 개 줄 수 있음

---

## 4) SALV 출력 공통 패턴

### 핵심

Lesson 12의 세 프로그램은 조회 방식은 달라도 출력은 거의 같은 패턴이다.

```
TRY.
    CALL METHOD CL_SALV_TABLE=>FACTORY
      IMPORTING
        R_SALV_TABLE = GO_SALV
      CHANGING
        T_TABLE      = GT_DATA.
  CATCH CX_SALV_MSG.
ENDTRY.

CALL METHOD GO_SALV->DISPLAY.
```

### 포인트

- `GT_DATA` 만 준비되면 SALV 출력은 거의 고정 템플릿처럼 사용 가능
- 조회 실습 확인용으로 매우 편리

---

## 5) Inner Join / Group By / Having 비교(한 눈에)

| 항목 | Inner Join | Group By | Having / Order By |
| --- | --- | --- | --- |
| 목적 | 여러 테이블 결합 | 그룹별 집계 | 집계 결과 필터 / 정렬 |
| 기준 | ON 조건 | GROUP BY 컬럼 | HAVING 집계조건 / ORDER BY |
| 대표 함수 | - | SUM, COUNT, AVG | AVG, COUNT DISTINCT |
| 조건 위치 | WHERE | WHERE + GROUP BY | WHERE + GROUP BY + HAVING |
| 결과 | 상세 row 확장 | 그룹별 요약 | 집계 후 선별/정렬 |

---

## 6) 시험 포인트 / 실무 포인트

### 6-1) 시험 포인트

- `REF TO` = 객체 참조 변수
- `CL_SALV_TABLE=>FACTORY` 역할
- `DISPLAY()`는 출력 실행
- `INNER JOIN` 의 `ON` 조건 의미
- `INTO CORRESPONDING FIELDS` 자동 매핑
- 집계 함수 사용 시 일반 컬럼은 `GROUP BY` 필수
- `COUNT(*)` 와 `COUNT(DISTINCT ...)` 차이
- `WHERE` 와 `HAVING` 차이
- `ORDER BY ... DESCENDING` 다중 정렬

### 6-2) 실무 포인트

- 여러 테이블 상세 조회는 `INNER JOIN`
- 요약/통계는 `GROUP BY`
- 집계 결과 필터는 `HAVING`
- 조회 결과 빠른 확인은 SALV가 가장 간단

---

## 7) Lesson 12에서 제일 중요한 결론

- **SALV는 가장 간단하게 내부테이블을 ALV로 보여주는 클래스다**
- **INNER JOIN은 여러 테이블의 관련 데이터를 한 번에 조회할 때 사용한다**
- **GROUP BY는 그룹 단위 집계, HAVING은 집계 결과 조건에 사용한다**
- **COUNT(*), COUNT(DISTINCT), SUM, AVG는 시험에서 자주 같이 나온다**
- **Lesson 12는 “조회(Join) → 집계(Group By) → 집계결과 필터(Having) → SALV 출력” 흐름으로 이해하면 된다**
