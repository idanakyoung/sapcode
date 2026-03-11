# 🧭 ABAP 1st Exam 정리

---

## 0) 전체 흐름(시험 범위 큰 그림)

```
DDIC
  1) Domain / Fixed Value
  2) Foreign Key / Search Help / View
Program
  3) Internal Table / Structure Type / Table Type
  4) Function Module / Method / Message / Text Symbol
Logic
  5) SELECT / JOIN / DB View / COLLECT / SUM
Screen
  6) Search Help / Dynpro / ALV 기초
POU
  7) 집계 / 평균 / 월별 합계 / 등급 산출 문제
```

---

# 1) DDIC 핵심 정리

## 1-1) 대소문자 구분 (Case Sensitive)

### 핵심

- 문자열 비교/검색에서는 **대소문자 구분 여부**를 항상 주의해야 한다.
- 특히 **성명 검색**, `LIKE`, 패턴 검색에서 자주 걸린다.

### 포인트

- 이름 검색 조건 만들 때:
    - `'Kim'` 과 `'KIM'` 이 다르게 취급될 수 있음
- 시험에서는 **입력값 검증**, **LIKE 검색**, **문자열 길이 체크**와 같이 같이 나오는 경우가 많음

---

## 1-2) Fixed Values 처리

### 핵심

- Domain에 Fixed Value가 있으면 코드값을 텍스트로 바꿔서 보여주는 문제가 자주 나온다.
- 대표 패턴:
    - Domain 값 조회
    - 코드값 → 설명 텍스트 변환

### 대표 함수

```
CALL FUNCTION 'GET_DOMAIN_VALUES'
  EXPORTING
    DOMNAME         = 'YDGESCH_01'
  TABLES
    VALUES_TAB      = GT_GENDERS
  EXCEPTIONS
    NO_VALUES_FOUND = 1
    OTHERS          = 2.
```

### 활용 흐름

```
Domain Fixed Value 조회
  ↓
내부테이블에 코드/텍스트 적재
  ↓
LOOP 돌면서 현재 코드값과 비교
  ↓
텍스트 필드에 설명값 넣기
```

### 시험 포인트

- `DD07V` 타입 많이 사용
- `DOMVALUE_L` = 실제 코드값
- `DDTEXT` = 텍스트 설명

---

## 1-3) Foreign Key + Search Help

### 핵심

- 같은 Foreign Key를 가진 여러 필드에 Search Help를 걸어야 할 때
- 각각 Screen Painter에 직접 거는 것보다
- **Foreign Key / Check Table / Data Element 레벨에서 한 번에 지정**하는 방식이 더 좋다

### 포인트

- 가장 권장:
    - **Data Element에 Search Help 연결**
- Foreign Key 관계가 이미 있으면
    - Check Table 기반 F4 도움을 자동 활용 가능
- Dynpro에서 직접 Search Help 거는 방식은 재사용성이 떨어짐

### 기억할 것

```
Search Help 연결 우선순위
1) Data Element
2) Table / Structure Field
3) Screen Painter 직접 지정 (비추천)
```

---

## 1-4) 데이터베이스 뷰 만들어서 Join 줄이기

### 핵심

- 프로그램에서 복잡하게 JOIN하지 않고
- **DB View를 미리 만들어두고 SELECT** 하는 방식이 가능하다

### 장점

- 코드 짧아짐
- 재사용성 좋아짐
- 프로그램에서는 일반 테이블처럼 SELECT 가능

### 패턴

```
SE11에서 View 생성
  ↓
필요한 테이블 연결
  ↓
Table Fields에서 필요한 필드 선택
  ↓
프로그램에서 View를 SELECT
```

### 포인트

- 시험에서 “조인 안 하고 데이터 처리”라고 나오면
    
    → **Database View 활용** 떠올리기
    
- 필요한 필드는 **Table Fields** 에서 골라서 포함

---

# 2) 프로그램 작성 핵심

## 2-1) 내부 테이블 선언 조건

### 핵심

프로그램에서 테이블 타입처럼 쓰려면 보통 아래 둘 중 하나가 필요하다.

- **Table Type**
- **Structure Type**

### 시험식 정리

- 내부 테이블을 만들 때
    - DDIC에 Table Type이 있으면 바로 사용 가능
    - 없으면 Structure Type 기반으로 선언 가능

### 대표 예시

```
DATA: GT_DATA TYPE TABLE OF YSEMPINFO_01,
      GS_DATA LIKE LINE OF GT_DATA.
```

또는

```
TYPES: BEGIN OF ts_data,
         field1 TYPE ...,
         field2 TYPE ...,
       END OF ts_data.

DATA: gt_data TYPE TABLE OF ts_data,
      gs_data TYPE ts_data.
```

### 포인트

- 시험에서는 **로컬 타입(TYPES)** 직접 만드는 문제 자주 나옴
- 특히 출력용 구조는 `TYPES BEGIN OF ... END OF` 로 직접 만드는 패턴 자주 사용

---

## 2-2) 메시지 찾기 T-code

### 핵심

- 메시지 클래스 / 메시지 번호 확인할 때 메시지 관리 트랜잭션을 사용

### 자주 기억

- `SE91` : Message Class 관리
- 프로그램 안에서는:

```
MESSAGE E016(ZMSG_G01).
```

### 포인트

- `E` = Error
- `I` = Information
- 시험에서 메시지 처리 묻는 경우 매우 자주 나옴

---

## 2-3) 함수 모듈 확인 T-code

### 핵심

- 함수 모듈 확인은 `SE37`
- 어떤 파라미터가 있는지 확인할 때 **Import / Export / Tables / Exceptions** 탭 확인

### 포인트

- 함수 모듈 문제 나오면
    1. `SE37`
    2. 함수명 입력
    3. Import 탭 확인
    4. F8 테스트 가능

---

## 2-4) FORM / FM / METHOD 차이

### 비교표

| 구분 | FORM | Function Module | Method |
| --- | --- | --- | --- |
| 범위 | 현재 프로그램 내부 | 여러 프로그램 재사용 | 클래스 기반 재사용 |
| 호출 | `PERFORM` | `CALL FUNCTION` | `CALL METHOD` |
| 특징 | 단순 로직 | 전역 공유 | 객체지향 / 확장성 |
| 위치 | 리포트 내부 | SE37 | SE24 |

### 핵심 정리

### FORM

- 간단한 출력/문자열 조립/내부 처리

```
PERFORM show_name.

FORM show_name.
  WRITE: / '안녕하세요!'.
ENDFORM.
```

### Function Module

- 공통 로직 재사용

```
CALL FUNCTION 'Z_GET_AGE'
  EXPORTING
    iv_dob = p_dob
  IMPORTING
    ev_age = gv_age.
```

### Method

- OOP 방식
- 정적/인스턴스 메서드 구분

```
CALL METHOD zcl_calc=>get_tax
  EXPORTING
    iv_amount = 1000
  IMPORTING
    ev_tax    = gv_tax.
```

### 시험 포인트

- 리포트 내부 전용 → `FORM`
- 여러 프로그램 공통 → `FM`
- 객체지향 확장형 → `METHOD`

---

## 2-5) Text Symbol

### 핵심

- 프로그램 내 텍스트 상수를 관리하는 기능
- `TEXT-J01`, `TEXT-001` 형태로 사용

### 등록 경로

```
Goto → Text Elements → Text Symbols
```

### 예시

| Text Symbol | 내용 |
| --- | --- |
| J01 | 사장 |
| J02 | 이사 |
| J03 | 부장 |
| J04 | 차장 |
| J05 | 과장 |
| J06 | 대리 |
| J07 | 사원 |

### 사용 예시

```
CASE pv_jikwi.
  WHEN 1.
    cv_jikwi = TEXT-J01.
  WHEN 2.
    cv_jikwi = TEXT-J02.
ENDCASE.
```

### 포인트

- 시험에서 “직위 코드 → 직위명 변환” 문제에 잘 어울림
- 하드코딩보다 Text Symbol 방식이 깔끔함

---

# 3) SELECT / JOIN / VIEW / 집계 핵심

## 3-1) JOIN vs DB View

### 핵심

- 프로그램 안에서 직접 JOIN 가능
- SE11에서 View를 만들어 SELECT 가능

### 비교

| 항목 | JOIN | DB View |
| --- | --- | --- |
| 위치 | 프로그램 | DDIC(SE11) |
| 재사용성 | 낮음 | 높음 |
| 코드 | 길어질 수 있음 | 단순해짐 |
| 관리 | 프로그램별 관리 | 중앙 관리 |

### 포인트

- 시험에서는 둘 다 가능
- “조인 안 하고 처리” = View 활용 가능성 높음

---

## 3-2) SUM vs COLLECT

### 핵심

- 집계 문제는 보통 두 방식이 나온다.
    - SQL의 `SUM + GROUP BY`
    - ABAP의 `COLLECT`

### 비교표

| 항목 | SQL SUM | COLLECT |
| --- | --- | --- |
| 처리 위치 | DB | ABAP |
| 성능 | 일반적으로 좋음 | 데이터 많으면 불리 |
| 코드 | 간단 | 루프 필요 |
| 용도 | 표준 집계 | 누적 처리 |

### 기억 공식

```
DB에서 바로 묶을 수 있다 → SUM / GROUP BY
내부테이블 누적 처리 필요 → COLLECT
```

---

## 3-3) COLLECT 주의점

### 핵심

- 키 필드가 같으면 숫자 필드 자동 합산
- 키가 다르면 새 행 추가

### 예시

```
GS_DATA-BOOKCNT = 1.
COLLECT GS_DATA INTO GT_DATA.
```

### 포인트

- `BOOKCNT = BOOKCNT + 1` 직접 안 써도 누적 가능
- 정확한 집계를 위해
    - 정렬
    - 키 구성
    - 숫자 필드/문자 필드 구조 이해가 중요

---

# 4) 시험 프로그램 1 핵심 정리

## 핵심 포인트

- View `YVEMPINFO_01` 에서 조회
- `SELECT-OPTIONS`, `PARAMETERS` 혼합 사용
- 연도 입력을 날짜 범위(`GV_BEGDA`, `GV_ENDDA`)로 변환
- 이름/부서명 길이 검증
- Domain Fixed Value를 텍스트로 변환
- 최종 출력은 `CL_DEMO_OUTPUT=>DISPLAY`

---

## 프로그램 1에서 꼭 기억할 것

### 1) 연도 → 날짜 범위 변환

```
GV_BEGDA = SO_YEAR-LOW && '0101'.
GV_ENDDA = SO_YEAR-HIGH && '1231'.
```

### 2) LIKE 패턴 만들기

```
GV_ENAME = '%' && PA_ENAME && '%'.
GV_ORGTX = '%' && PA_ORGTX && '%'.
```

### 3) Fixed Value 텍스트 치환

```
READ TABLE GT_GENDERS INTO GS_GENDER
  WITH KEY DOMVALUE_L = GS_DATA-GESCH.
IF SY-SUBRC = 0.
  GS_DATA-GESTX = GS_GENDER-DDTEXT.
ENDIF.
```

### 4) 입력 길이 검증

```
IF PA_ENAME IS NOT INITIAL AND STRLEN( PA_ENAME ) < 4.
  MESSAGE E016(ZMSG_G01).
ENDIF.
```

---

# 5) 시험 프로그램 2 핵심 정리

## 핵심 포인트

- 로컬 구조 `TS_DATA` 직접 선언
- `SBOOK` + `STRAVELAG` 조합
- `READ TABLE ... BINARY SEARCH`
- `CASE` 로 고객 유형/좌석 클래스별 건수 분기
- `COLLECT` 로 집계

---

## 기억할 패턴

### 1) 로컬 타입 선언

```
TYPES : BEGIN OF TS_DATA,
          AGENCYNUM TYPE SBOOK-AGENCYNUM,
          NAME      TYPE STRAVELAG-NAME,
          BOOKCNT   TYPE I,
          ...
        END OF TS_DATA.
```

### 2) BINARY SEARCH 전제

```
SORT GT_STRAVELAG BY AGENCYNUM.
```

### 3) READ TABLE + BINARY SEARCH

```
READ TABLE GT_STRAVELAG INTO GS_STRAVELAG
  WITH KEY AGENCYNUM = GS_SBOOK-AGENCYNUM BINARY SEARCH.
```

### 4) COLLECT 집계

```
GS_DATA-BOOKCNT = 1.
COLLECT GS_DATA INTO GT_DATA.
```
> ABAP 1st Exam 정리
> 
- 대소문자 구분 case-sensetive → 성명 같은 예시의 경우 사용
- Fixed Values 처리
- 같은 Foregin key 를 가진 다른 테이블의 필드에 Search Help를 달 때  Foregin key 설정에서 한 번에 지정할 수 있는 방법
    
    
- 데이터베이스 뷰 만들어서 조인 안하고 데이터 처리하기
    
    →  Table fields 안에서 불러오고 싶은 필드들 다 불러오기
    
- 프로그램 1
    
    프로그램에서 테이블타입을 불러오기 위해서는 내부 테이블 형태로 불러와야하는데 여기서 내부 테이블을 생성하기 위해서는 두 가지 중 하나의 조건을 갖추어야 한다.
    
    1. Table Type
    2. Structure Type 
    
    → 해당 프로그램 내에서는 Structure Type 선언해서 불러오기
    
    → 메세지 불러오는 T-code
    
    → 어떤 메소드인지 확인 T-code (SE37) → IMPORT 탭으로 이동
    
    → f8 누르기
    
    ** 최종 코드
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report YEXAM_01_ABAP_01
    *&---------------------------------------------------------------------*
    *&
    *&---------------------------------------------------------------------*
    REPORT YEXAM_01_ABAP_01.
    
    * 프로그램 실행 결과 Out put 변수 선언.
    * Internal table & Work Area.
    DATA: GT_DATA TYPE TABLE OF YSEMPINFO_01,
          GS_DATA LIKE LINE OF GT_DATA.
    
    * Selection Screen - SO_YEAR(SELECT-OPTIONS) 사용.
    DATA: GV_YEAR  TYPE CHAR4,
          GV_BEGDA TYPE DATS, " 시작일 변수 선언.
          GV_ENDDA TYPE DATS, " 종료일 변수 선언.
          GV_ENAME TYPE STRING,
          GV_ORGTX TYPE STRING.
    
    * Domain Fixed Value & Text 할당할 변수.
    * Internal table & Work Area.
    DATA : GT_GENDERS TYPE TABLE OF DD07V,
           GS_GENDER  LIKE LINE OF GT_GENDERS.
    
    * Selection Screen - Input 필드 : 검색조건.
    SELECT-OPTIONS : SO_PERNR FOR GS_DATA-PERNR,
    SO_ORGEH       FOR GS_DATA-ORGEH,
    SO_GESCH       FOR GS_DATA-GESCH,
    SO_YEAR        FOR GV_YEAR NO-EXTENSION.
    
    PARAMETERS: PA_ENAME TYPE YT1001_01-ENAME,
                PA_ORGTX TYPE YT1002_01-ORGTX.
    
    *------------------------------------------------------------------------*
    INITIALIZATION.
      SO_PERNR-SIGN   = 'I'.
      SO_PERNR-OPTION = 'BT'.
      SO_PERNR-LOW    = 1.
      SO_PERNR-HIGH   = 9999999.
      APPEND SO_PERNR.
    
      SO_GESCH-SIGN   = 'I'.
      SO_GESCH-OPTION = 'BT'.
      SO_GESCH-LOW    = 1.
      SO_GESCH-HIGH   = 2.
      APPEND SO_GESCH.
    
      CALL FUNCTION 'GET_DOMAIN_VALUES'
        EXPORTING
          DOMNAME         = 'YDGESCH_01'
        TABLES
          VALUES_TAB      = GT_GENDERS
        EXCEPTIONS
          NO_VALUES_FOUND = 1
          OTHERS          = 2.
      IF SY-SUBRC <> 0.
    * Implement suitable error handling here
      ENDIF.
    
    *------------------------------------------------------------------------*
    AT  SELECTION-SCREEN.
      " 성명 필드 Input Check.
      IF PA_ENAME IS NOT INITIAL AND STRLEN( PA_ENAME ) < 4.
        MESSAGE E016(ZMSG_G01).
    *    MESSAGE '이름은 4자리 이상 입력하여 주세요.!' TYPE 'E'.
      ENDIF.
    
      " 부서명 필드 Input Check.
      IF PA_ORGTX IS NOT INITIAL AND STRLEN( PA_ORGTX ) < 4.
        MESSAGE E017(ZMSG_G01).
    *    MESSAGE '부서명은 4자리 이상 입력하여 주세요.!' TYPE 'E'.
      ENDIF.
    
    *------------------------------------------------------------------------*
    START-OF-SELECTION.
    
      READ TABLE SO_YEAR INDEX 1.
      IF SY-SUBRC <> 0.
        GV_BEGDA = '19000101'.
        GV_ENDDA = '99991231'.
      ELSEIF SO_YEAR-LOW IS NOT INITIAL AND SO_YEAR-HIGH IS INITIAL.
        GV_BEGDA = SO_YEAR-LOW && '0101'.
        GV_ENDDA = SO_YEAR-LOW && '1231'.
      ELSEIF SO_YEAR-LOW IS INITIAL AND SO_YEAR-HIGH IS NOT INITIAL.
        GV_BEGDA = '18000101'.
        GV_ENDDA = SO_YEAR-HIGH && '1231'.
      ELSE.
        GV_BEGDA = SO_YEAR-LOW && '0101'.
        GV_ENDDA = SO_YEAR-HIGH && '1231'.
      ENDIF.
    
      IF PA_ENAME IS NOT INITIAL.
        GV_ENAME = '%' && PA_ENAME && '%'.
      ELSE.
        GV_ENAME = '%'.
      ENDIF.
    
      IF PA_ORGTX IS NOT INITIAL.
        GV_ORGTX = '%' && PA_ORGTX && '%'.
      ELSE.
        GV_ORGTX = '%'.
      ENDIF.
    
    *----------------------------------------------------*
      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE GT_DATA
      FROM YVEMPINFO_01
      WHERE PERNR IN SO_PERNR
      AND ORGEH IN SO_ORGEH
      AND GESCH IN SO_GESCH
      AND GBDAT BETWEEN GV_BEGDA AND GV_ENDDA
      AND ORGTX LIKE GV_ORGTX.
    
      LOOP AT GT_DATA INTO GS_DATA.
        READ TABLE GT_GENDERS INTO GS_GENDER
          WITH KEY DOMVALUE_L = GS_DATA-GESCH.
        IF SY-SUBRC = 0.
          GS_DATA-GESTX = GS_GENDER-DDTEXT.
        ENDIF.
        MODIFY GT_DATA FROM GS_DATA.
        CLEAR: GS_DATA, GS_GENDER.
      ENDLOOP.
    
      CL_DEMO_OUTPUT=>DISPLAY( GT_DATA ).
    ```
    
- 프로그램 2
    
    **최종코드
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report YEXAM_02_ABAP_01
    *&---------------------------------------------------------------------*
    *&
    *&---------------------------------------------------------------------*
    REPORT YEXAM_02_ABAP_01.
    
    * Local Structure data type 선언.
    TYPES : BEGIN OF TS_DATA,
              AGENCYNUM TYPE SBOOK-AGENCYNUM,
              NAME      TYPE STRAVELAG-NAME,
              BOOKCNT   TYPE I,
              ECOCNT    TYPE I,
              BIZCNT    TYPE I,
              FSTCNT    TYPE I,
              PRIVAT    TYPE I,
              BUSINE    TYPE I,
              STREET    TYPE STRAVELAG-STREET,
              CITY      TYPE STRAVELAG-POSTCODE,
              POSTCODE  TYPE STRAVELAG-CITY,
              COUNTRY   TYPE STRAVELAG-COUNTRY,
              TELEPHONE TYPE STRAVELAG-TELEPHONE,
            END OF TS_DATA.
    
    * 변수 선언.
    DATA : GT_DATA TYPE TABLE OF TS_DATA,
           GS_DATA LIKE LINE OF GT_DATA.
    
    * SBOOK Table 데이터 할당할 변수.
    * Internal table & Work Area.
    DATA : GT_SBOOK TYPE TABLE OF SBOOK,
           GS_SBOOK LIKE LINE OF GT_SBOOK.
    
    * STRAVELAG Table 데이터 할당할 변수.
    * Internal table & Work Area.
    DATA : GT_STRAVELAG TYPE TABLE OF STRAVELAG,
           GS_STRAVELAG LIKE LINE OF GT_STRAVELAG.
    
    *----------------------------------------------------------------------------*
    SELECT-OPTIONS: SO_AGNC FOR GS_STRAVELAG-AGENCYNUM NO-EXTENSION,
                    SO_FDAT FOR GS_SBOOK-FLDATE NO-EXTENSION.
    
    *----------------------------------------------------------------------------*
    INITIALIZATION.
      SO_FDAT-SIGN = 'I'.
      SO_FDAT-OPTION = 'BT'.
      SO_FDAT-HIGH = SY-DATUM+0(6) && '01'.
      SO_FDAT-HIGH = SO_FDAT-HIGH - 1.
    *  SUBTRACT 1 FROM so_fdat.
      SO_FDAT-LOW = SO_FDAT-HIGH+0(4) && '0101'.
      APPEND SO_FDAT.
    
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE GT_STRAVELAG
        FROM STRAVELAG.
    
      SORT GT_STRAVELAG BY AGENCYNUM.
    *--------------------------------------------------------------------------
    AT SELECTION-SCREEN.
      READ TABLE SO_FDAT INDEX 1.
      IF SY-SUBRC <> 0.
        MESSAGE 'Flight date를 입력하여 주세요!.' TYPE 'E'.
      ELSEIF SO_FDAT-LOW >= SY-DATUM+0(6) && '01'.
        MESSAGE '시작일은 현재월 1일 (첫날)보다 작아야 합니다.' TYPE 'E'.
      ENDIF.
    *----------------------------------------------------------------------------*
    START-OF-SELECTION.
      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE GT_SBOOK
      FROM SBOOK
      WHERE FLDATE IN SO_FDAT
        AND AGENCYNUM IN SO_AGNC
        AND CANCELLED <> 'X'.
    
      SORT GT_SBOOK BY AGENCYNUM.
    
    * Travel Agency에서 예약하지 않은 데이터 삭제.
      DELETE GT_SBOOK WHERE AGENCYNUM IS INITIAL.
    
      LOOP AT GT_SBOOK INTO GS_SBOOK.
        "MOVE-CORRESPONDING GS_SBOOK TO GS_DATA.
        "GS_DATA-AGENCYNUM = GS_SBOOK-AGENCYNUM.
    
        READ TABLE GT_STRAVELAG INTO GS_STRAVELAG
          WITH KEY AGENCYNUM = GS_SBOOK-AGENCYNUM BINARY SEARCH.
        IF SY-SUBRC = 0.
          MOVE-CORRESPONDING GS_STRAVELAG TO GS_DATA.
        ELSE.
          CONTINUE.
        ENDIF.
    
        CASE GS_SBOOK-CUSTTYPE.
          WHEN 'B'.
            GS_DATA-BUSINE = 1.
          WHEN 'P'.
            GS_DATA-PRIVAT = 1.
        ENDCASE.
    
        CASE GS_SBOOK-CLASS.
          WHEN 'Y'.
            GS_DATA-ECOCNT = 1.
          WHEN 'C'.
            GS_DATA-BIZCNT = 1.
          WHEN 'F'.
            GS_DATA-FSTCNT = 1.
        ENDCASE.
    
        GS_DATA-BOOKCNT = 1.
        COLLECT GS_DATA INTO GT_DATA.
        CLEAR: GS_DATA, GS_SBOOK.
      ENDLOOP.
    
      CL_DEMO_OUTPUT=>DISPLAY( GT_DATA ).
    ```
    
---

# 6) POU / 퀴즈 핵심 정리

- 퀴즈 9 - 항공사/편명별 합산 (집계)
    
    # ABAP 집계 처리 방식 비교 정리 (SUM / COLLECT)
    
    ## 1. 목적
    
    항공사 코드(SFLIGHT-CARRID)를 조건으로 하여, 편명(CONNID)별로 PAYMENTSUM 값을 집계하는 두 가지 방법을 비교한다.
    
    - 방법 1: SELECT 문에서 SUM 집계 처리
    - 방법 2: COLLECT 문을 사용한 내부테이블 기반 집계 처리
    
    ---
    
    ## 2. 집계 결과 구조 정의
    
    ```abap
    TYPES: BEGIN OF ty_sum,
             carrid        TYPE sflight-carrid,
             connid        TYPE sflight-connid,
             total_payment TYPE sflight-paymentsum,
           END OF ty_sum.
    
    ```
    
    ---
    
    ## 3. 방법 1 – SELECT 문 내에서 SUM 집계 처리
    
    ### 주요 특징
    
    - SQL 레벨에서 집계를 처리하여 결과를 바로 얻는다.
    - 코드가 가장 간결하고 성능도 안정적이다.
    - GROUP BY 기준으로 정확하게 집계된다.
    
    ### 코드
    
    ```abap
    REPORT zquiz_09_g01.
    
    TYPES: BEGIN OF ty_sum,
             carrid        TYPE sflight-carrid,
             connid        TYPE sflight-connid,
             total_payment TYPE sflight-paymentsum,
           END OF ty_sum.
    
    DATA: gt_sflight TYPE TABLE OF sflight,
          gs_sflight TYPE sflight.
    
    DATA: gt_sum TYPE TABLE OF ty_sum,
          gs_sum TYPE ty_sum.
    
    SELECT-OPTIONS: so_car FOR gs_sflight-carrid.
    
    INITIALIZATION.
      CLEAR so_car.
      so_car-sign   = 'I'.
      so_car-option = 'EQ'.
      so_car-low    = 'LH'.
      APPEND so_car.
    
    START-OF-SELECTION.
    
      SELECT carrid,
             connid,
             SUM( paymentsum ) AS total_payment
        FROM sflight
        WHERE carrid IN @so_car
        GROUP BY carrid, connid
        INTO TABLE @gt_sum.
    
      cl_demo_output=>display( gt_sum ).
    
    ```
    
    ---
    
    ## 4. 방법 2 – COLLECT 문을 이용한 집계 처리
    
    ### 주요 특징
    
    - ABAP 내부에서 루프를 돌며 집계한다.
    - 동일 키(carrid, connid)의 데이터가 존재하면 합산하고, 없으면 신규 추가한다.
    - COLLECT를 사용할 때는 SORTED TABLE 또는 HASHED TABLE + UNIQUE KEY 로 선언하는 것이 정확한 집계를 위해 권장된다.
    
    ### 코드
    
    ```abap
    REPORT zquiz_09_g01.
    
    TYPES: BEGIN OF ty_sum,
             carrid        TYPE sflight-carrid,
             connid        TYPE sflight-connid,
             total_payment TYPE sflight-paymentsum,
           END OF ty_sum.
    
    DATA: gt_sflight TYPE TABLE OF sflight,
          gs_sflight TYPE sflight.
    
    DATA: gt_sum TYPE SORTED TABLE OF ty_sum
                      WITH UNIQUE KEY carrid connid,
          gs_sum TYPE ty_sum.
    
    SELECT-OPTIONS: so_car FOR gs_sflight-carrid.
    
    INITIALIZATION.
      CLEAR so_car.
      so_car-sign   = 'I'.
      so_car-option = 'EQ'.
      so_car-low    = 'LH'.
      APPEND so_car.
    
    START-OF-SELECTION.
    
      SELECT *
        FROM sflight
        INTO TABLE @gt_sflight
        WHERE carrid IN @so_car.
    
      LOOP AT gt_sflight INTO gs_sflight.
        CLEAR gs_sum.
        gs_sum-carrid        = gs_sflight-carrid.
        gs_sum-connid        = gs_sflight-connid.
        gs_sum-total_payment = gs_sflight-paymentsum.
    
        COLLECT gs_sum INTO gt_sum.
      ENDLOOP.
    
      cl_demo_output=>display( gt_sum ).
    
    ```
    
    ---
    
    ## 5. 비교 정리
    
    | 항목 | 방법 1: SQL SUM 집계 | 방법 2: COLLECT |
    | --- | --- | --- |
    | 처리 위치 | DB 레벨에서 집계 | ABAP 내부에서 집계 |
    | 성능 | 일반적으로 더 우수 | 데이터량 많을 시 비효율적 |
    | 코드 간결성 | 가장 간단함 | 루프 + COLLECT 필요 |
    | 정확성 | GROUP BY 기준 명확 | SORTED/HASHED + UNIQUE KEY 사용 시 안정적 |
    | 사용 목적 | 표준적인 집계 처리 | 단순 누적 처리에 유용 |
    
- 퀴즈 10 - 예약 정보 예약 고객 정보 불러오기
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report ZQUIZ_10_G01
    *&---------------------------------------------------------------------*
    *&
    *&---------------------------------------------------------------------*
    REPORT ZQUIZ_10_G01.
    
    TYPES: BEGIN OF TY_DATA,
             ID        TYPE SCUSTOM-ID,
             NAME      TYPE SCUSTOM-NAME,
             BOOKCNT   TYPE I,
             GRADE     TYPE CHAR1,
             POSTCODE  TYPE SCUSTOM-POSTCODE,
             CITY      TYPE SCUSTOM-CITY,
             COUNTRY   TYPE SCUSTOM-COUNTRY,
             STREET    TYPE SCUSTOM-STREET,
             TELEPHONE TYPE SCUSTOM-TELEPHONE,
             CUSTTYPE  TYPE SBOOK-CUSTTYPE,
           END OF TY_DATA.
    
    DATA: GT_SBOOK   TYPE TABLE OF SBOOK,
          GS_SBOOK   TYPE SBOOK,
          GT_SCUSTOM TYPE TABLE OF SCUSTOM,
          GS_SCUSTOM TYPE SCUSTOM.
    
    DATA: GT_DATA TYPE TABLE OF TY_DATA,
          GS_DATA TYPE TY_DATA.
    
    SELECT-OPTIONS: SO_ID FOR GS_SCUSTOM-ID,
                    SO_FDATE FOR GS_SBOOK-FLDATE.
    
    *------------------------------------------------------
    
    INITIALIZATION.
      SO_ID-SIGN   = 'I'.
      SO_ID-OPTION = 'BT'.
      SO_ID-LOW    = 1.
      SO_ID-HIGH   = 50.
      APPEND SO_ID.
    
      SO_FDATE-SIGN = 'I'.
      SO_FDATE-OPTION = 'BT'.
      SO_FDATE-LOW = SY-DATUM+0(4) && '0101'.
      SO_FDATE-HIGH = SY-DATUM+0(4) && '1231'.
      APPEND SO_FDATE.
    
    *------------------------------------------------------
    
    AT  SELECTION-SCREEN.
    
      READ TABLE SO_FDATE INDEX 1.
      IF SY-SUBRC <> 0.
        MESSAGE 'Flight date를 입력하여 주세요!.' TYPE 'E'.
      ENDIF.
    
    START-OF-SELECTION.
    
      SELECT *
        INTO TABLE GT_SCUSTOM
        FROM SCUSTOM
        WHERE ID IN SO_ID.
    
      SORT GT_SCUSTOM BY ID.
    
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE GT_SBOOK
        FROM SBOOK
        WHERE FLDATE IN SO_FDATE
          AND CUSTOMID IN SO_ID
          AND CANCELLED <> 'X'.
    
      LOOP AT GT_SBOOK INTO GS_SBOOK.
    
        READ TABLE GT_SCUSTOM INTO GS_SCUSTOM
          WITH KEY ID = GS_SBOOK-CUSTOMID BINARY SEARCH.
        IF SY-SUBRC = 0.
          MOVE-CORRESPONDING GS_SCUSTOM TO GS_DATA.
        ELSE.
          CONTINUE.
        ENDIF.
    
    * BOOKCNT = BOOKCNT + 1 자동 합산.
        GS_DATA-BOOKCNT = 1.
        COLLECT GS_DATA INTO GT_DATA.
    
        CLEAR: GS_DATA, GS_SBOOK.
    
      ENDLOOP.
    
      LOOP AT GT_DATA INTO GS_DATA.
    
        IF GS_DATA-BOOKCNT >= 10.
          GS_DATA-GRADE = 'P'.
        ELSEIF GS_DATA-BOOKCNT >= 5.
          GS_DATA-GRADE = 'G'.
        ELSE.
          GS_DATA-GRADE = 'S'.
        ENDIF.
    
        MODIFY GT_DATA FROM GS_DATA.
        CLEAR GS_DATA.
    
      ENDLOOP.
    
    *------------------------------------------------------
    *Out Put
    
      CL_DEMO_OUTPUT=>DISPLAY( GT_DATA ).
    
    *------------------------------------------------------
    ```
    
- 퀴즈 11 - 항공사/편명별 예약 리드 타임 평균 계산 프로그램
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report ZQUIZ_11_G01 (Template-Based)
    *&---------------------------------------------------------------------*
    REPORT zquiz_11_g01.
    
    *------------------------------------------------------*
    * 1) OUTPUT STRUCTURE 정의
    *------------------------------------------------------*
    TYPES: BEGIN OF ty_data,
             carrid     TYPE scarr-carrid,
             carrname   TYPE scarr-carrname,
             connid     TYPE sbook-connid,
             days_ahead TYPE p LENGTH 8 DECIMALS 2,  " 출발일 - 예약일 평균
           END OF ty_data.
    
    * 집계용 내부 테이블 구조 (CARRID + CONNID 단위 SUM/COUNT)
    TYPES: BEGIN OF ty_agg,
             carrid    TYPE scarr-carrid,
             connid    TYPE sbook-connid,
             sum_days  TYPE i,
             cnt       TYPE i,
           END OF ty_agg.
    
    *------------------------------------------------------*
    * 2) DATA 선언
    *------------------------------------------------------*
    DATA: gt_data TYPE TABLE OF ty_data,
          gs_data TYPE ty_data.
    
    DATA: gt_agg TYPE TABLE OF ty_agg,
          gs_agg TYPE ty_agg.
    
    DATA: gt_scarr TYPE TABLE OF scarr,
          gs_scarr TYPE scarr.
    
    DATA: gt_sbook TYPE TABLE OF sbook,
          gs_sbook TYPE sbook.
    
    DATA: lv_tmp_days TYPE i,
          lv_index    TYPE sy-tabix.
    
    *------------------------------------------------------*
    * 3) SELECTION SCREEN
    *------------------------------------------------------*
    SELECT-OPTIONS: so_carr  FOR gs_scarr-carrid,
                    so_fdate FOR gs_sbook-fldate.
    
    *------------------------------------------------------*
    * 4) INITIALIZATION (기본값 설정)
    *------------------------------------------------------*
    INITIALIZATION.
    
      " 기본 Carrier
      so_carr-sign   = 'I'.
      so_carr-option = 'EQ'.
      so_carr-low    = 'LH'.
      APPEND so_carr.
    
      " 기본 Flight Date → 해당 연도 전체
      so_fdate-sign   = 'I'.
      so_fdate-option = 'BT'.
      so_fdate-low    = sy-datum+0(4) && '0101'.
      so_fdate-high   = sy-datum+0(4) && '1231'.
      APPEND so_fdate.
    
    *------------------------------------------------------*
    * 5) AT SELECTION-SCREEN (입력 검증)
    *------------------------------------------------------*
    AT SELECTION-SCREEN.
    
      READ TABLE so_fdate INDEX 1.
      IF sy-subrc <> 0.
        MESSAGE 'Flight Date를 입력해주세요.' TYPE 'E'.
      ENDIF.
    
    *------------------------------------------------------*
    * 6) START-OF-SELECTION : 본 로직
    *------------------------------------------------------*
    START-OF-SELECTION.
    
    *------------------------------------------------------*
    * 6-1) 항공사 정보 조회 (Carrier Name용)
    *------------------------------------------------------*
      SELECT *
        INTO TABLE gt_scarr
        FROM scarr
        WHERE carrid IN so_carr.
    
      SORT gt_scarr BY carrid.
    
    *------------------------------------------------------*
    * 6-2) 예약 데이터(SBOOK) 조회
    *------------------------------------------------------*
      SELECT *
        INTO CORRESPONDING FIELDS OF TABLE gt_sbook
        FROM sbook
        WHERE carrid   IN so_carr
          AND fldate   IN so_fdate
          AND cancelled <> 'X'.
    
      IF sy-subrc <> 0.
        MESSAGE '해당 조건의 예약 데이터가 없습니다.' TYPE 'I'.
        EXIT.
      ENDIF.
    
    *------------------------------------------------------*
    * 6-3) 1차 집계 루프 (CARRID + CONNID 단위 SUM/COUNT)
    *------------------------------------------------------*
      CLEAR gt_agg.
    
      LOOP AT gt_sbook INTO gs_sbook.
    
        " 날짜 차이 = 출발일 - 주문일
        lv_tmp_days = gs_sbook-order_date - gs_sbook-fldate.
    
        CLEAR gs_agg.
        gs_agg-carrid = gs_sbook-carrid.
        gs_agg-connid = gs_sbook-connid.
    
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
    
      ENDLOOP.
    
    *------------------------------------------------------*
    * 6-4) 2차 루프 : 출력 테이블 생성 (Carrier Name + 평균 계산)
    *------------------------------------------------------*
      CLEAR gt_data.
    
      LOOP AT gt_agg INTO gs_agg.
    
        CLEAR gs_data.
        CLEAR gs_scarr.
    
        " 항공사 이름 붙이기
        READ TABLE gt_scarr INTO gs_scarr
          WITH KEY carrid = gs_agg-carrid
          BINARY SEARCH.
    
        IF sy-subrc = 0.
          gs_data-carrid   = gs_scarr-carrid.
          gs_data-carrname = gs_scarr-carrname.
        ELSE.
          gs_data-carrid = gs_agg-carrid.
        ENDIF.
    
        gs_data-connid = gs_agg-connid.
    
        IF gs_agg-cnt > 0.
          gs_data-days_ahead = gs_agg-sum_days / gs_agg-cnt.
        ENDIF.
    
        APPEND gs_data TO gt_data.
    
      ENDLOOP.
    
    *------------------------------------------------------*
    * 7) 출력
    *------------------------------------------------------*
      cl_demo_output=>display( gt_data ).
    
    ```
    
- 퀴즈 12 - 항공사 별 연간 월 별 매출 집계 프로그램
    
    ```jsx
    **&---------------------------------------------------------------------*
    **& Report ZQUIZ_12_G01
    **&---------------------------------------------------------------------*
    REPORT ZQUIZ_12_G01.
    
    *------------------------------------------------------*
    * 타입 정의
    TYPES: BEGIN OF TY_DATA,
             CARRID   TYPE SFLIGHT-CARRID,
             CARRNAME TYPE SCARR-CARRNAME,
             CURRCODE TYPE SCARR-CURRCODE,
             JANSUM   TYPE P LENGTH 16 DECIMALS 2,
             FEBSUM   TYPE P LENGTH 16 DECIMALS 2,
             MARSUM   TYPE P LENGTH 16 DECIMALS 2,
             APRSUM   TYPE P LENGTH 16 DECIMALS 2,
             MAYSUM   TYPE P LENGTH 16 DECIMALS 2,
             JUNSUM   TYPE P LENGTH 16 DECIMALS 2,
             JULSUM   TYPE P LENGTH 16 DECIMALS 2,
             AUGSUM   TYPE P LENGTH 16 DECIMALS 2,
             SEPSUM   TYPE P LENGTH 16 DECIMALS 2,
             OCTSUM   TYPE P LENGTH 16 DECIMALS 2,
             NOVSUM   TYPE P LENGTH 16 DECIMALS 2,
             DECSUM   TYPE P LENGTH 16 DECIMALS 2,
           END OF TY_DATA.
    
    DATA: GT_DATA TYPE TABLE OF TY_DATA,
          GS_DATA TYPE TY_DATA.
    
    DATA: GT_SFLIGHT TYPE TABLE OF SFLIGHT,
          GS_SFLIGHT TYPE SFLIGHT.
    
    DATA: GT_SCARR TYPE TABLE OF SCARR,
          GS_SCARR TYPE SCARR.
    
    DATA: LV_FROM  TYPE SFLIGHT-FLDATE,
          LV_TO    TYPE SFLIGHT-FLDATE,
          LV_YEAR  TYPE CHAR4,
          LV_MONTH TYPE N LENGTH 2.
    
    *------------------------------------------------------*
    * 선택 화면
    PARAMETERS: P_FYEAR TYPE N LENGTH 4.         "조회할 회계년도 (예: 2025)
    SELECT-OPTIONS: SO_CARR FOR GS_SFLIGHT-CARRID.
    
    *------------------------------------------------------*
    INITIALIZATION.
    
      IF P_FYEAR IS INITIAL.
        P_FYEAR = SY-DATUM+0(4).                "기본값: 올해
      ENDIF.
    
      SO_CARR-SIGN   = 'I'.
      SO_CARR-OPTION = 'EQ'.
      SO_CARR-LOW    = 'AA'.
      APPEND SO_CARR.
    
    *------------------------------------------------------*
    AT SELECTION-SCREEN.
    
      IF P_FYEAR IS INITIAL.
        MESSAGE '조회할 년도를 입력해 주세요.' TYPE 'E'.
      ENDIF.
    
    *------------------------------------------------------*
    START-OF-SELECTION.
    
    * 조회할 기간 계산 
      LV_YEAR = P_FYEAR.
      CONCATENATE LV_YEAR '0101' INTO LV_FROM.
      CONCATENATE LV_YEAR '1231' INTO LV_TO.
    
    * 항공편 데이터 조회 (해당 년도 + 항공사)
      SELECT *
        INTO TABLE GT_SFLIGHT
        FROM SFLIGHT
        WHERE CARRID IN SO_CARR
          AND FLDATE BETWEEN LV_FROM AND LV_TO.
    
      IF SY-SUBRC <> 0.
        MESSAGE '해당 조건에 맞는 Flight 데이터가 없습니다.' TYPE 'I'.
        EXIT.
      ENDIF.
    
      SORT GT_SFLIGHT BY CARRID FLDATE.
    
    * 항공사 정보 조회
      SELECT *
        INTO TABLE GT_SCARR
        FROM SCARR
        WHERE CARRID IN SO_CARR.
    
      SORT GT_SCARR BY CARRID.
    
    * 월별 합계 집계
      LOOP AT GT_SCARR INTO GS_SCARR.
    
        CLEAR GS_DATA.
        GS_DATA-CARRID   = GS_SCARR-CARRID.
        GS_DATA-CARRNAME = GS_SCARR-CARRNAME.
        GS_DATA-CURRCODE = GS_SCARR-CURRCODE.
    
        LOOP AT GT_SFLIGHT INTO GS_SFLIGHT
             WHERE CARRID = GS_SCARR-CARRID.
    
          LV_MONTH = GS_SFLIGHT-FLDATE+4(2).   "YYYYMMDD 중 MM 부분
    
          CASE LV_MONTH.
            WHEN '01'. GS_DATA-JANSUM = GS_DATA-JANSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '02'. GS_DATA-FEBSUM = GS_DATA-FEBSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '03'. GS_DATA-MARSUM = GS_DATA-MARSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '04'. GS_DATA-APRSUM = GS_DATA-APRSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '05'. GS_DATA-MAYSUM = GS_DATA-MAYSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '06'. GS_DATA-JUNSUM = GS_DATA-JUNSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '07'. GS_DATA-JULSUM = GS_DATA-JULSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '08'. GS_DATA-AUGSUM = GS_DATA-AUGSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '09'. GS_DATA-SEPSUM = GS_DATA-SEPSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '10'. GS_DATA-OCTSUM = GS_DATA-OCTSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '11'. GS_DATA-NOVSUM = GS_DATA-NOVSUM + GS_SFLIGHT-PAYMENTSUM.
            WHEN '12'. GS_DATA-DECSUM = GS_DATA-DECSUM + GS_SFLIGHT-PAYMENTSUM.
          ENDCASE.
    
        ENDLOOP.
    
        APPEND GS_DATA TO GT_DATA.
    
      ENDLOOP.
    *------------------------------------------------------*
    * 출력
      CL_DEMO_OUTPUT=>DISPLAY( GT_DATA ).
    ```
    
    ![image.png](attachment:b85bf470-0670-40bd-a72c-b15c4c12259d:image.png)
    
    ![image.png](attachment:806587ac-d470-490b-8e50-8c26d9326e9e:image.png)
    
- 퀴즈 13 - 고객 명 기반 예약·설문 데이터 통합 조회 및 만족도 등급 산출 프로그램
    
    ![image.png](attachment:b85bf470-0670-40bd-a72c-b15c4c12259d:image.png)
    
    ![image.png](attachment:806587ac-d470-490b-8e50-8c26d9326e9e:image.png)
    
    ![image.png](attachment:eed9b98f-2c1c-447e-8e7d-9bfcd7758b3b:image.png)
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report ZQUIZ_13_G01
    *&---------------------------------------------------------------------*
    *&
    *&---------------------------------------------------------------------*
    REPORT ZQUIZ_13_G01.
    
    TYPES: BEGIN OF TY_DATA,
             STATUS     TYPE CHAR1,
             CUSTOMID   TYPE SCUSTOM-ID,
             NAME       TYPE SCUSTOM-NAME,
             CARRID     TYPE SBOOK-CARRID,
             CONNID     TYPE SBOOK-CONNID,
             FLDATE     TYPE SBOOK-FLDATE,
             BOOKID     TYPE SBOOK-BOOKID,
             CUSTTYPE   TYPE SBOOK-CUSTTYPE,
             ORDER_DATE TYPE SBOOK-ORDER_DATE,
             AVERAGE    TYPE P LENGTH 5 DECIMALS 1,
           END OF TY_DATA.
    
    TYPES: BEGIN OF TY_JOIN,
             CUSTOMID   TYPE SCUSTOM-ID,
             NAME       TYPE SCUSTOM-NAME,
             CARRID     TYPE SBOOK-CARRID,
             CONNID     TYPE SBOOK-CONNID,
             FLDATE     TYPE SBOOK-FLDATE,
             BOOKID     TYPE SBOOK-BOOKID,
             CUSTTYPE   TYPE SBOOK-CUSTTYPE,
             ORDER_DATE TYPE SBOOK-ORDER_DATE,
             SCORE1     TYPE ZTSURVEY_00-EVL01,
             SCORE2     TYPE ZTSURVEY_00-EVL02,
             SCORE3     TYPE ZTSURVEY_00-EVL03,
             SCORE4     TYPE ZTSURVEY_00-EVL04,
             SCORE5     TYPE ZTSURVEY_00-EVL05,
           END OF TY_JOIN.
    
    DATA: GT_JOIN TYPE TABLE OF TY_JOIN,
          GS_JOIN TYPE TY_JOIN.
    
    DATA: GT_DATA TYPE TABLE OF TY_DATA,
          GS_DATA TYPE TY_DATA.
    
    DATA: GT_SCUSTOM TYPE TABLE OF SCUSTOM,
          GS_SCUSTOM TYPE SCUSTOM.
    
    DATA: GT_SBOOK TYPE TABLE OF SBOOK,
          GS_SBOOK TYPE SBOOK.
    
    DATA: GT_ZTSURVEY_00 TYPE TABLE OF ZTSURVEY_00,
          GS_ZTSURVEY_00 TYPE ZTSURVEY_00.
    
    DATA: LV_AVG TYPE P LENGTH 5 DECIMALS 1.
    DATA: LV_AVG10 TYPE I.
    DATA: LV_PATTERN TYPE SCUSTOM-NAME.
    
    PARAMETERS P_CNAME TYPE SCUSTOM-NAME MATCHCODE OBJECT zsh_customer01.
    SELECT-OPTIONS: SO_FDATE FOR GS_SBOOK-FLDATE NO-EXTENSION.
    
    *------------------------------------------------------*
    INITIALIZATION.
    
      CLEAR SO_FDATE.
      SO_FDATE-SIGN   = 'I'.
      SO_FDATE-OPTION = 'BT'.
      CONCATENATE SY-DATUM+0(6) '01' INTO SO_FDATE-LOW.
      SO_FDATE-HIGH   = SY-DATUM.
      APPEND SO_FDATE.
    
    *------------------------------------------------------*
    AT SELECTION-SCREEN.
    
      IF P_CNAME IS INITIAL.
        MESSAGE '고객이름을 입력하여 주세요.' TYPE 'E'.
      ENDIF.
    
      IF STRLEN( P_CNAME ) < 4.
        MESSAGE '고객이름은 4자리 이상 입력하세요!' TYPE 'E'.
      ENDIF.
    
      LOOP AT SO_FDATE.
        IF SO_FDATE-LOW > SY-DATUM OR SO_FDATE-HIGH > SY-DATUM.
          MESSAGE '현재일보다 미래일자는 입력할 수 없습니다.' TYPE 'E'.
        ENDIF.
      ENDLOOP.
    
    *------------------------------------------------------*
    START-OF-SELECTION.
    
      LV_PATTERN = '%' && P_CNAME && '%'.
    
      SELECT
            SCUSTOM~ID,
            SCUSTOM~NAME,
            SBOOK~CARRID,
            SBOOK~CONNID,
            SBOOK~FLDATE,
            SBOOK~BOOKID,
            SBOOK~CUSTTYPE,
            SBOOK~ORDER_DATE,
            ZTSURVEY_00~EVL01,
            ZTSURVEY_00~EVL02,
            ZTSURVEY_00~EVL03,
            ZTSURVEY_00~EVL04,
            ZTSURVEY_00~EVL05
          INTO TABLE @GT_JOIN
          FROM SCUSTOM
            INNER JOIN SBOOK
              ON SBOOK~CUSTOMID = SCUSTOM~ID
            INNER JOIN ZTSURVEY_00
              ON ZTSURVEY_00~BOOKID = SBOOK~BOOKID
           WHERE SCUSTOM~NAME  LIKE @LV_PATTERN
             AND SBOOK~FLDATE  IN @SO_FDATE
             AND SBOOK~CANCELLED <> 'X'.
    
      IF GT_JOIN IS INITIAL.
        MESSAGE '조건에 맞는 데이터가 없습니다.' TYPE 'I'.
        EXIT.
      ENDIF.
    
      LOOP AT GT_JOIN INTO GS_JOIN.
    
        CLEAR: GS_DATA, LV_AVG.
    
        GS_DATA-CUSTOMID   = GS_JOIN-CUSTOMID.
        GS_DATA-NAME       = GS_JOIN-NAME.
        GS_DATA-CARRID     = GS_JOIN-CARRID.
        GS_DATA-CONNID     = GS_JOIN-CONNID.
        GS_DATA-FLDATE     = GS_JOIN-FLDATE.
        GS_DATA-BOOKID     = GS_JOIN-BOOKID.
        GS_DATA-CUSTTYPE   = GS_JOIN-CUSTTYPE.
        GS_DATA-ORDER_DATE = GS_JOIN-ORDER_DATE.
    
        LV_AVG = ( GS_JOIN-SCORE1 +
                   GS_JOIN-SCORE2 +
                   GS_JOIN-SCORE3 +
                   GS_JOIN-SCORE4 +
                   GS_JOIN-SCORE5 ) / 5.
    
        GS_DATA-AVERAGE = LV_AVG.
        LV_AVG10 = LV_AVG * 10.
    
        IF LV_AVG10 < 50.
          GS_DATA-STATUS = 'L'.
        ELSEIF LV_AVG10 < 75.
          GS_DATA-STATUS = 'M'.
        ELSE.
          GS_DATA-STATUS = 'H'.
        ENDIF.
    
        APPEND GS_DATA TO GT_DATA.
    
      ENDLOOP.
    
    *------------------------------------------------------*
    * Output
    
      CL_DEMO_OUTPUT=>DISPLAY( GT_DATA ).
    ```
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report ZQUIZ_13_G00
    *&---------------------------------------------------------------------*
    *&
    *&---------------------------------------------------------------------*
    REPORT ZQUIZ_13_G00.
    
    * Output data.
    DATA: BEGIN OF GS_OUTDATA,
            STATUS     TYPE CHAR1,
            CUSTOMID   TYPE SBOOK-CUSTOMID,
            NAME       TYPE SCUSTOM-NAME,
            CARRID     TYPE SBOOK-CARRID,
            CONNID     TYPE SBOOK-CONNID,
            FLDATE     TYPE SBOOK-FLDATE,
            BOOKID     TYPE SBOOK-BOOKID,
            CUSTTYPE   TYPE SBOOK-CUSTTYPE,
            ORDER_DATE TYPE SBOOK-ORDER_DATE,
            AVERAGE    TYPE P LENGTH 3 DECIMALS 2,
          END OF GS_OUTDATA,
          GT_OUTDATA LIKE TABLE OF GS_OUTDATA.
    
    * DB view data read.
    DATA: GT_BOOK TYPE TABLE OF ZVBOOKSURVEY_G00,
          GS_BOOK LIKE LINE OF GT_BOOK.
    
    * Selection screen - input field.
    PARAMETERS: PA_NAME TYPE SCUSTOM-NAME.
    
    SELECT-OPTIONS: SO_FDT FOR GS_BOOK-FLDATE NO-EXTENSION.
    
    INITIALIZATION.
    * 현재년월에 대한 첫날, 현재년월일 기본값 설정.
      SO_FDT-SIGN   = 'I'.
      SO_FDT-OPTION = 'BT'.
      SO_FDT-LOW    = SY-DATUM+0(6) && '01'.
      SO_FDT-HIGH   = SY-DATUM.
      APPEND SO_FDT.
    
    AT SELECTION-SCREEN.
      IF PA_NAME IS INITIAL.
        MESSAGE E010(ZMSG_G00).
      ENDIF.
    
      IF STRLEN( PA_NAME ) < 4.
        MESSAGE E016(ZMSG_G00).
      ENDIF.
    
      READ TABLE SO_FDT INDEX 1.
      IF sy-subrc = 0 and so_fdt-LOW > sy-datum.
        MESSAGE e012(ZMSG_G00).
      ENDIF.
    
    START-OF-SELECTION.
    ```
    
- 퀴즈 14 - 사원 정보 조회 프로그램 (연차 계산 만 나이 계산)
    
    ```jsx
    *&---------------------------------------------------------------------*
    *& Report ZQUIZ_14_G01
    *&---------------------------------------------------------------------*
    REPORT zquiz_14_g01.
    
    *--------------------------------------------------------------*
    * Selection Screen
    *--------------------------------------------------------------*
    PARAMETERS: p_pernr TYPE n LENGTH 8 OBLIGATORY,   "사번
                p_name  TYPE c LENGTH 10 OBLIGATORY,  "성명
                p_dob   TYPE dats       OBLIGATORY,   "생년월일
                p_jikwi TYPE n LENGTH 1 OBLIGATORY,   "직위(1~7)
                p_edat  TYPE dats       OBLIGATORY.   "입사일
    
    *--------------------------------------------------------------*
    * Global Data
    *--------------------------------------------------------------*
    DATA: gv_dob_text    TYPE char40,   "생년월일 (YYYY 년 MM 월 DD 일)
          gv_edat_text   TYPE char40,   "입사일   (YYYY 년 MM 월 DD 일)
          gv_age         TYPE i,        "나이
          gv_age_real    TYPE i,        "만나이
          gv_jikwi_text  TYPE char40,   "직위명
          gv_leave_days  TYPE i,        "연차일수
          gv_age_line    TYPE char40,   "나이 출력용 한 줄
          gv_leave_line  TYPE char20.   "연차 출력용 한 줄
    
    *--------------------------------------------------------------*
    * INITIALIZATION
    *--------------------------------------------------------------*
    INITIALIZATION.
    * 필요 시 기본값 세팅
    *  p_dob  = '19760101'.
    *  p_edat = '20020101'.
    
    *--------------------------------------------------------------*
    * AT SELECTION-SCREEN : 입력값 검증
    *--------------------------------------------------------------*
    AT SELECTION-SCREEN.
    
      " 직위코드 1~7 범위 체크
      IF p_jikwi < 1 OR p_jikwi > 7.
        MESSAGE '직위 코드는 1~7 사이여야 합니다.' TYPE 'E'.
      ENDIF.
    
      " 생년월일이 오늘 이후이면 오류
      IF p_dob > sy-datum.
        MESSAGE '생년월일이 올바르지 않습니다.' TYPE 'E'.
      ENDIF.
    
      " 입사일이 오늘 이후이면 오류
      IF p_edat > sy-datum.
        MESSAGE '입사일이 올바르지 않습니다.' TYPE 'E'.
      ENDIF.
    
    *--------------------------------------------------------------*
    * START-OF-SELECTION : 본 처리
    *--------------------------------------------------------------*
    START-OF-SELECTION.
    
      " 1) 날짜 포맷 변환
      PERFORM get_date_format USING    p_dob
                              CHANGING gv_dob_text.
    
      PERFORM get_date_format USING    p_edat
                              CHANGING gv_edat_text.
    
      " 2) 나이 / 만나이 계산 (FM)
      CALL FUNCTION 'Z_GET_AGE_G01'
        EXPORTING
          iv_dob  = p_dob
        IMPORTING
          ev_age1 = gv_age
          ev_age2 = gv_age_real.
    
      " 3) 직위 텍스트 변환 (FORM)
      PERFORM get_jikwi_text USING    p_jikwi
                             CHANGING gv_jikwi_text.
    
      " 4) 연차 일수 계산 (Global Class Method)
      CALL METHOD zcl_ex_g01=>get_leave_date_g01
        EXPORTING
          iv_edat  = p_edat
          iv_jikwi = p_jikwi
        IMPORTING
          ev_days  = gv_leave_days.
    
      " 5) 출력용 데이터 조립
      PERFORM build_output.
    
      " 6) 화면 출력
      PERFORM display_output.
    
    *--------------------------------------------------------------*
    * FORM 영역
    *--------------------------------------------------------------*
    
    *&---------------------------------------------------------------------*
    *&      Form  GET_DATE_FORMAT
    *&---------------------------------------------------------------------*
    *       날짜(YYYYMMDD)를 'YYYY 년 MM 월 DD 일' 문자열로 변환
    *---------------------------------------------------------------------*
    FORM get_date_format
      USING    pv_date TYPE dats
      CHANGING cv_date TYPE char40.
    
      DATA: lv_year  TYPE char4,
            lv_month TYPE char2,
            lv_day   TYPE char2.
    
      IF pv_date IS INITIAL.
        CLEAR cv_date.
        RETURN.
      ENDIF.
    
      lv_year  = pv_date+0(4).
      lv_month = pv_date+4(2).
      lv_day   = pv_date+6(2).
    
      CONCATENATE lv_year  '년'
                  lv_month '월'
                  lv_day   '일'
             INTO cv_date
      SEPARATED BY space.
    
    ENDFORM.                    "get_date_format
    
    *&---------------------------------------------------------------------*
    *&      Form  GET_JIKWI_TEXT
    *&---------------------------------------------------------------------*
    *       직위 코드(1~7)를 직위 Text Symbol 로 변환
    *       J01~J07 Text Symbol 은 프로그램 Text Symbols 에서 등록
    *---------------------------------------------------------------------*
    FORM get_jikwi_text
      USING    pv_jikwi TYPE n
      CHANGING cv_jikwi TYPE char40.
    
      CASE pv_jikwi.
        WHEN 1.
          cv_jikwi = TEXT-J01. "사장
        WHEN 2.
          cv_jikwi = TEXT-J02. "이사
        WHEN 3.
          cv_jikwi = TEXT-J03. "부장
        WHEN 4.
          cv_jikwi = TEXT-J04. "차장
        WHEN 5.
          cv_jikwi = TEXT-J05. "과장
        WHEN 6.
          cv_jikwi = TEXT-J06. "대리
        WHEN 7.
          cv_jikwi = TEXT-J07. "사원
        WHEN OTHERS.
          CLEAR cv_jikwi.
      ENDCASE.
    
    ENDFORM.                    "get_jikwi_text
    
    *&---------------------------------------------------------------------*
    *&      Form  BUILD_OUTPUT
    *&---------------------------------------------------------------------*
    *       출력에 사용할 한 줄 문자열들 조립
    *---------------------------------------------------------------------*
    FORM build_output.
    
      CONCATENATE gv_age '세 (만'
                  gv_age_real '세)'
             INTO gv_age_line
      SEPARATED BY space.
    
      CONCATENATE gv_leave_days '일'
             INTO gv_leave_line
      SEPARATED BY space.
    
    ENDFORM.                    "build_output
    
    *&---------------------------------------------------------------------*
    *&      Form  DISPLAY_OUTPUT
    *&---------------------------------------------------------------------*
    *       리스트 출력
    *---------------------------------------------------------------------*
    FORM display_output.
    
      WRITE: / '사원정보'.
      ULINE.
    
      WRITE: / '사번:', 20 p_pernr NO-ZERO.
      WRITE: / '성명:', 20 p_name.
      WRITE: / '생년월일:', 20 gv_dob_text.
      WRITE: / '나이:', 20 gv_age_line.
      WRITE: / '직위:', 20 gv_jikwi_text.
      WRITE: / '입사일:', 20 gv_edat_text.
      WRITE: / '연차:', 20 gv_leave_line.
    
    ENDFORM.                    "display_output
    ```
    
    - SE37에서 함수모듈 **Z_GET_AGE_G01** 만들고
        - Importing: `iv_dob TYPE dats`
        - Exporting: `ev_age1 TYPE i`, `ev_age2 TYPE i`
    - SE24에서 글로벌 클래스 **ZCL_EX_G01**, 메서드 **GET_LEAVE_DATE_G01** 만들고
        - IMPORTING `iv_edat TYPE dats`, `iv_jikwi TYPE numc1`
        - EXPORTING `ev_days TYPE i`
    - 프로그램 Text Symbols에 J01~J07(사장~사원) 등록
    
    ```jsx
    Program (Report)
     ├─ FORM (서브루틴)
     ├─ CALL FUNCTION → Function Module (SE37)
     └─ CALL METHOD   → Class Method (SE24)
    ```
    
    # ✅ 1. FORM 사용법 (리포트 내부에서만 사용)
    
    ### 📌 언제 써?
    
    - **그 프로그램 안에서만 쓰는 간단한 처리**
    - 출력, 문자열 조립, 단순 계산 등
    
    ### 📌 작성 위치
    
    리포트 맨 아래에 만든다.
    
    ### ✔️ 예시
    
    ```abap
    START-OF-SELECTION.
      PERFORM show_name.
    
    FORM show_name.
      WRITE: / '안녕하세요!'.
    ENDFORM.
    
    ```
    
    ➡️ **PERFORM** 로 호출한다.
    
    ---
    
    # ✅ 2. Function Module 사용법 (SE37에서 만들고 전역 사용 가능)
    
    ### 📌 언제 써?
    
    - 여러 프로그램에서 **공통으로 사용하는 로직**
        
        (예: 나이 계산, 금액 계산, 로그인 체크 등)
        
    - 시스템 전체 공유할 필요가 있을 때
    
    ### 📌 만들어지는 곳
    
    - SE37 (Function Builder)
    - Function Group 안에 저장됨
    
    ### ✔️ Function Module 예시 (SE37)
    
    ### Import / Export 파라미터 예시
    
    - Importing: iv_dob (생년월일)
    - Exporting: ev_age (나이)
    
    ### 코드 예시
    
    ```abap
    FUNCTION z_get_age.
      DATA lv_year TYPE i.
    
      lv_year = sy-datum(4) - iv_dob(4).
      ev_age  = lv_year.
    
    ENDFUNCTION.
    
    ```
    
    ### ✔️ 호출하는 방법 (리포트에서)
    
    ```abap
    CALL FUNCTION 'Z_GET_AGE'
      EXPORTING
        iv_dob = p_dob
      IMPORTING
        ev_age = gv_age.
    
    ```
    
    ➡️ **CALL FUNCTION** 으로 호출한다.
    
    ---
    
    # ✅ 3. METHOD 사용법 (클래스 안에 있는 함수)
    
    ### 📌 언제 써?
    
    - **객체 지향 OOP 방식으로 만들고 싶을 때**
    - 재사용 + 확장성 + 유지보수 용이
    - TRY/CATCH(예외처리) 가능
    - FM보다 더 현대적인 방식
    
    ### 📌 만들어지는 곳
    
    - SE24 (Class Builder)
    - 클래스 안에 method들이 존재함
    
    ---
    
    # ✔️ 클래스 예시 (SE24)
    
    클래스 이름: `ZCL_CALC`
    
    메서드 이름: `GET_TAX`
    
    ```abap
    METHOD get_tax.
      ev_tax = iv_amount * 0.1.
    ENDMETHOD.
    
    ```
    
    ---
    
    # ✔️ 호출하는 방법
    
    ### 1) 인스턴스 메서드(객체 생성해야 함)
    
    ```abap
    DATA lo_obj TYPE REF TO zcl_calc.
    
    CREATE OBJECT lo_obj.
    
    CALL METHOD lo_obj->get_tax
      EXPORTING
        iv_amount = 1000
      IMPORTING
        ev_tax    = gv_tax.
    
    ```
    
    ### 2) 정적 메서드 (객체 생성 없이 호출)
    
    ```abap
    CALL METHOD zcl_calc=>get_tax
      EXPORTING
         iv_amount = 1000
      IMPORTING
         ev_tax    = gv_tax.
    
    ```
    
    ➡️ **CALL METHOD** 또는 `object->method` 방식으로 호출한다.
    
    ---
    
    # 🎯 핵심 요약
    
    | FORM | FM | METHOD |
    | --- | --- | --- |
    | 단순 | 전역 공유 | 객체지향 |
    | 현재 리포트에서만 | 여러 프로그램에서 재사용 | 확장성 최고 |
    | PERFORM | CALL FUNCTION | CALL METHOD |
    
    ---
    
    # 🔥 너의 현재 프로그램 기준으로 다시 설명
    
    ### FORM
    
    - `get_date_format`
    - `get_jikwi_text`
    - `display_output`
    - `build_output`
        
        ➡️ **이건 프로그램 안에서만 쓰면 되니까 FORM으로 맞음**
        
    
    ### Function Module
    
    - `Z_GET_AGE_G01`
        
        ➡️ 여러 프로그램에서 나이 계산에 재사용 가능
        
    
    ### Class Method
    
    - `ZCL_EX_G01=>GET_LEAVE_DATE_G01`
        
        ➡️ 객체지향으로 연차 계산 구현 (시험 스타일)
        
    
    # ✅ 📌 목표
    
    `TEXT-J01`, `TEXT-J02`, `TEXT-J03` … 이런 걸 텍스트 엘리먼트에 등록해서
    
    리포트에서 이렇게 쓰는 것:
    
    ```abap
    cv_jikwi = TEXT-J05.   "과장
    
    ```
    
    ---
    
    # ⭐ 1. 텍스트 엘리먼트(Text Elements) 화면 들어가기
    
    1. 프로그램 열기
    2. 상단 메뉴에서
        
        **Goto → Text elements → Text symbols**
        
        클릭
        
    
    경로:
    
    ```
    Program → Goto → Text Elements → Text Symbols
    
    ```
    
    이 화면이 나오면 성공!
    
    ---
    
    # ⭐ 2. 새로운 Text Symbol 추가하기
    
    예시로 J01 ~ J07 을 추가한다고 하면:
    
    | Text Symbol ID | Text 내용 |
    | --- | --- |
    | J01 | 사장 |
    | J02 | 이사 |
    | J03 | 부장 |
    | J04 | 차장 |
    | J05 | 과장 |
    | J06 | 대리 |
    | J07 | 사원 |
    
    추가 순서:
    
    1. 화면 상단 **New Entries** 클릭
    2. 다음처럼 입력
    
    예)
    
    ```
    Text Symbol : J01
    Text        : 사장
    
    ```
    
    1. Enter
    2. 다시 같은 방식으로 J02 ~ J07 모두 등록
    3. 저장(CTRL+S)
    
    ---
    
    # ⭐ 3. 프로그램에서 사용하는 방법
    
    등록이 끝나면 프로그램에서는 이렇게 사용 가능:
    
    ```abap
    CASE pv_jikwi.
      WHEN 1.
        cv_jikwi = TEXT-J01.
      WHEN 2.
        cv_jikwi = TEXT-J02.
      WHEN 3.
        cv_jikwi = TEXT-J03.
      WHEN 4.
        cv_jikwi = TEXT-J04.
      WHEN 5.
        cv_jikwi = TEXT-J05.
      WHEN 6.
        cv_jikwi = TEXT-J06.
      WHEN 7.
        cv_jikwi = TEXT-J07.
    ENDCASE.
    
    ```
    
    이 Text-J01 등이 바로 **텍스트 엘리먼트에서 불러오는 문자열**이야!
    
    ---
    
    # ⭐ 4. Text Symbol 설명 (암기용)
    
    | 구문 | 의미 |
    | --- | --- |
    | `TEXT-J01` | 프로그램 텍스트 심벌 J01 |
    | `TEXT-001` | 자동 번호 텍스트 심벌 |
    | `TEXT-T01` | Title, Frame 등에서 자주 쓰는 텍스트 |
    
    텍스트 심벌은 OBject 단위로 저장되니 리포트 하나에 붙어 있음.
    
    ---
    
    # ⭐ 완전 정리
    
    ### 🔹 설정 과정
    
    ```
    리포트 → Goto → Text Elements → Text Symbols → New Entries
    
    ```
    
    ### 🔹 직접 등록
    
    ```
    J01 = 사장
    J02 = 이사
    J03 = 부장
    J04 = 차장
    J05 = 과장
    J06 = 대리
    J07 = 사원
    
    ```
    
    ### 🔹 프로그램에서 사용
    
    ```
    cv_jikwi = TEXT-J05.
    
    ```
