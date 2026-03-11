# 🧭 Lesson 13 – SORT & DELETE / SUBMIT / RANGE / BDC / MEMORY

---

## 0) 전체 흐름(공통 뼈대)

```
Internal Table 전처리
  1) SORT
  2) DELETE ADJACENT DUPLICATES
  3) FOR ALL ENTRIES 조회 최적화
Program 호출
  4) SUBMIT으로 다른 프로그램 실행
  5) PARAMETERS / SELECT-OPTIONS / RANGE 전달
자동 입력 / 데이터 전달
  6) BDC(BDCDATA)로 트랜잭션 자동 실행
  7) ABAP Memory로 프로그램 간 데이터 전달
```

---

## 1) Unit 1. SORT & DELETE, SUBMIT, RANGE

---

## 1-1) ZABAP_37_G01 – SORT & DELETE

### 핵심

- `DELETE ADJACENT DUPLICATES` 는 **반드시 SORT 후에 사용**해야 의미가 있다.
- 이 구문은 **서로 붙어 있는 중복 행만** 삭제한다.
- 따라서 정렬하지 않으면 중복이 남거나 엉뚱한 결과가 나온다.

---

### 기본 구문

```
SORT GT_SPFLI BY CARRID CONNID.

DELETE ADJACENT DUPLICATES FROM GT_SPFLI
  COMPARING CARRID.
```

### 의미

- 먼저 `CARRID`, `CONNID` 기준으로 정렬
- 그 다음 인접한 중복을 비교해서 삭제

### 포인트

- `ADJACENT` = 붙어 있는 것만 비교
- 정렬 없이 쓰면 중복이 떨어져 있어서 삭제 안 될 수 있음

---

## 1-2) COMPARING 필드 의미

### 핵심

- `COMPARING` 에 어떤 필드를 넣느냐에 따라 중복 제거 단위가 달라진다.

### 예시 1) 비교 필드가 적을 때

```
DELETE ADJACENT DUPLICATES FROM GT_SPFLI
  COMPARING CARRID.
```

- 같은 `CARRID` 만 보면 중복으로 판단
- 항공사 단위로 더 많이 줄어듦

### 예시 2) 비교 필드가 많을 때

```
DELETE ADJACENT DUPLICATES FROM GT_SPFLI
  COMPARING CARRID CONNID.
```

- `CARRID + CONNID` 가 모두 같아야 중복
- 더 세밀한 단위로 중복 제거

### 포인트

- 비교 필드가 적을수록 결과 건수가 더 적어진다
- 비교 필드가 많을수록 더 상세 단위로 남는다

---

## 1-3) FOR ALL ENTRIES

### 핵심

- 내부테이블의 여러 값을 기준으로 DB에서 한 번에 조회할 때 사용
- 내부적으로는 **루프마다 DB를 여러 번 호출하는 방식이 아니라**
- `WHERE ... OR ... OR ...` 형태로 한 번 조회하는 개념

### 기본 구문

```
SELECT * FROM SBOOK
  FOR ALL ENTRIES IN GT_SPFLI
  WHERE CARRID = GT_SPFLI-CARRID
    AND CONNID = GT_SPFLI-CONNID.
```

---

### 내부 동작 개념

```
WHERE ( CARRID = 'AA' AND CONNID = '001' )
   OR ( CARRID = 'AA' AND CONNID = '017' )
   OR ( CARRID = 'LH' AND CONNID = '040' )
```

### 의미

- `GT_SPFLI` 의 각 행이 하나의 OR 조건이 된다
- 즉, 내부테이블 값 목록을 기준으로 여러 조건을 한 번에 조회

---

## 1-4) FOR ALL ENTRIES에서 SORT & DELETE가 중요한 이유

### 핵심

- `FOR ALL ENTRIES`는 내부테이블 한 행당 OR 조건 하나를 만든다.
- 중복이 있으면 불필요한 OR 조건이 늘어나서 성능이 나빠진다.
- 그래서 보통 아래 패턴으로 사용한다.

```
1) 기준 Internal Table 조회
2) SORT
3) DELETE ADJACENT DUPLICATES
4) FOR ALL ENTRIES
```

### 포인트

- 중복 제거 없이 FAE 쓰면 성능 낭비
- 특히 기준값이 많을수록 더 중요

---

## 1-5) 전체 코드 흐름

```
REPORT ZABAP_37_G01.

DATA: GT_SPFLI TYPE TABLE OF SPFLI,
      GS_SPFLI LIKE LINE OF GT_SPFLI,
      GT_SBOOK TYPE TABLE OF SBOOK.

SELECT-OPTIONS: SO_CAR FOR GS_SPFLI-CARRID,
                SO_CON FOR GS_SPFLI-CONNID.

SELECT *
  INTO TABLE GT_SPFLI
  FROM SPFLI
  WHERE CARRID IN SO_CAR
    AND CONNID IN SO_CON.

IF GT_SPFLI IS NOT INITIAL.

  GS_SPFLI-CARRID = 'AA'.
  GS_SPFLI-CONNID = '0017'.
  APPEND GS_SPFLI TO GT_SPFLI.

  SORT GT_SPFLI BY CARRID CONNID.

  DELETE ADJACENT DUPLICATES FROM GT_SPFLI
    COMPARING CARRID.

*  SELECT *
*    INTO TABLE GT_SBOOK
*    FROM SBOOK
*    FOR ALL ENTRIES IN GT_SPFLI
*    WHERE CARRID = GT_SPFLI-CARRID
*      AND CONNID = GT_SPFLI-CONNID.
ENDIF.

CL_DEMO_OUTPUT=>DISPLAY( GT_SBOOK ).
```

### 포인트

- 기준 테이블 먼저 채움
- 필요 시 값 추가
- 정렬
- 중복 제거
- 그 후 FAE 조회

---

## 2) ZABAP_39_G01 – SUBMIT 호출 대상 프로그램

### 핵심

- `SUBMIT` 은 다른 실행 프로그램(Report)을 호출하는 구문
- 보통 선택화면이 있는 프로그램을 대신 실행할 때 사용
- 실행 결과를 재사용하거나 흐름을 연결할 때 유용

---

### 예시 프로그램

```
REPORT ZABAP_39_G01.

DATA: GT_SFLIGHTS TYPE TABLE OF SFLIGHT,
      GS_SFLIGHT  LIKE LINE OF GT_SFLIGHTS.

DATA: GO_SALV TYPE REF TO CL_SALV_TABLE.

SELECT-OPTIONS: SO_CAR FOR GS_SFLIGHT-CARRID,
                SO_CON FOR GS_SFLIGHT-CONNID.

SELECT *
  INTO TABLE GT_SFLIGHTS
  FROM SFLIGHT
  WHERE CARRID IN SO_CAR
    AND CONNID IN SO_CON.

TRY.
    CALL METHOD CL_SALV_TABLE=>FACTORY
      IMPORTING
        R_SALV_TABLE = GO_SALV
      CHANGING
        T_TABLE      = GT_SFLIGHTS.
  CATCH CX_SALV_MSG.
ENDTRY.

CALL METHOD GO_SALV->DISPLAY.
```

### 포인트

- 이 프로그램이 나중에 `SUBMIT` 으로 호출되는 대상이 될 수 있음
- 보통 Selection Text 변경이나 호출 실습과 연결

---

## 3) ZABAP_38_G01 – SUBMIT & RANGE

### 핵심

- 현재 프로그램에서 다른 프로그램을 실행할 때
- `PARAMETERS` 값을 다른 프로그램의 `SELECT-OPTIONS` 에 넘길 수 있다
- 단일값도 넘길 수 있고, `RANGE TABLE` 형태로 여러 조건도 넘길 수 있다

---

## 3-1) 호출 대상 프로그램

```
REPORT ZABAP_38_G01.

DATA: GT_SPFLI TYPE TABLE OF SPFLI,
      GS_SPFLI LIKE LINE OF GT_SPFLI.

PARAMETERS: PA_CAR TYPE SPFLI-CARRID OBLIGATORY.

SELECT *
  INTO TABLE GT_SPFLI
  FROM SPFLI
  WHERE CARRID = PA_CAR.

LOOP AT GT_SPFLI INTO GS_SPFLI.
  WRITE:/ GS_SPFLI-CARRID,
          GS_SPFLI-CONNID,
          GS_SPFLI-CITYFROM,
          GS_SPFLI-CITYTO,
          GS_SPFLI-AIRPFROM,
          GS_SPFLI-AIRPTO.
ENDLOOP.
```

---

## 3-2) SUBMIT 기본 개념

### 핵심

- 현재 프로그램의 값을
- 호출되는 프로그램의 선택조건으로 넘길 수 있다

### 예시 흐름

```
현재 프로그램의 PA_CAR
  ↓
호출 대상 프로그램의 SO_CAR 로 전달
```

---

## 3-3) VIA SELECTION-SCREEN

### 핵심

- `VIA SELECTION-SCREEN` 이 있으면
    - 호출 대상 프로그램의 선택화면을 한 번 보여줌
- 없으면
    - 선택화면 없이 바로 실행

### 포인트

```
VIA SELECTION-SCREEN 있음  → 선택화면 표시 후 실행
VIA SELECTION-SCREEN 없음 → 바로 실행
```

---

## 3-4) AND RETURN

### 핵심

- `AND RETURN` 을 쓰면
- 호출된 프로그램 실행 후 다시 원래 프로그램으로 돌아온다

```
현재 프로그램
   ↓
SUBMIT 대상 프로그램 실행
   ↓
다시 현재 프로그램으로 복귀
   ↓
이후 코드 계속 실행
```

### 포인트

- `CALL SCREEN` 처럼 흐름이 이어지는 느낌으로 이해하면 쉬움
- 시험에서 자주 묻는 포인트

---

## 3-5) RANGE 전용 내부테이블

### 핵심

- `SELECT-OPTIONS` 나 `IN` 조건에 넘길 수 있는 범위 테이블을 직접 만들어서 사용할 수 있다

### 예시

```
RS_CAR-SIGN = 'I'.
RS_CAR-OPTION = 'BT'.
RS_CAR-LOW = PA_CAR.
RS_CAR-HIGH = 'LH'.
APPEND RS_CAR TO RT_CAR.

CLEAR RS_CAR.
RS_CAR-SIGN = 'E'.
RS_CAR-OPTION = 'EQ'.
RS_CAR-LOW = 'AZ'.
APPEND RS_CAR TO RT_CAR.
```

### 의미

- 첫 번째 조건:
    - 포함(`I`)
    - Between(`BT`)
    - `PA_CAR ~ 'LH'`
- 두 번째 조건:
    - 제외(`E`)
    - Equal(`EQ`)
    - `AZ` 제외

---

## 3-6) RANGE 핵심 정리

### SIGN

- `I` : Include
- `E` : Exclude

### OPTION

- `EQ` : 같다
- `BT` : 범위
- `CP` : 패턴 등

### 포인트

- `IN` 조건과 연결해서 쓰는 것이 핵심
- 시험에서는 `SIGN + OPTION + LOW + HIGH` 구조를 정확히 알아야 함

---

## 4) CREATE DATA & RECORDING PROGRAM

---

## 4-1) T-code 확인

### 핵심

- 특정 트랜잭션이 어떤 프로그램을 실행하는지 확인할 수 있다

### 방법

- `SE93` 에서 T-code 확인
- 또는 직접 T-code 실행 후 프로그램명 확인
- 이후 `SE80` 에서 프로그램 구조/레이아웃 확인 가능

---

## 4-2) SHDB

### 핵심

- `SHDB` 는 트랜잭션을 녹화(Recording)해서
- BDC 코드로 변환할 때 사용하는 도구

### 흐름

```
SHDB 실행
  ↓
New Recording
  ↓
트랜잭션 입력
  ↓
직접 화면 입력/저장
  ↓
Recording 결과 확인
  ↓
BDC 코드 생성 참고
```

### 포인트

- 화면 기반 자동입력 프로그램 만들 때 가장 기본 도구

---

## 5) ZABAP_40_G01 – RECORDING / BDC

### 핵심

- BDC는 사람이 SAP 화면에서 입력하는 과정을
- 프로그램이 그대로 따라 하게 하는 방식
- `BDCDATA` 를 채우고 `CALL TRANSACTION` 으로 실행한다

---

## 5-1) 전체 코드

```
REPORT ZABAP_40_G01.

DATA: GT_BDCDATA TYPE TABLE OF BDCDATA,
      GS_BDCDATA LIKE LINE OF GT_BDCDATA.

GS_BDCDATA-PROGRAM = 'SAPBC402_PGCD_CREATE_CUSTOMER'.
GS_BDCDATA-DYNPRO = '0100'.
GS_BDCDATA-DYNBEGIN = 'X'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-NAME'.
GS_BDCDATA-FVAL = '김철수'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-FORM'.
GS_BDCDATA-FVAL = 'Mr.'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-STREET'.
GS_BDCDATA-FVAL = 'busanjingu'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-POSTCODE'.
GS_BDCDATA-FVAL = '12345'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-CITY'.
GS_BDCDATA-FVAL = 'busan'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-COUNTRY'.
GS_BDCDATA-FVAL = 'KR'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'SCUSTOM-TELEPHONE'.
GS_BDCDATA-FVAL = '050-9824-9251'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CLEAR GS_BDCDATA.
GS_BDCDATA-FNAM = 'BDC_OKCODE'.
GS_BDCDATA-FVAL = '=SAVE'.
APPEND GS_BDCDATA TO GT_BDCDATA.

CALL TRANSACTION 'BC402_CALD_CRE_CUST'
  USING GT_BDCDATA
  MODE 'N'.
```

---

## 5-2) BDCDATA 구조

### 핵심 필드

```
PROGRAM   : 화면 프로그램명
DYNPRO    : 화면 번호
DYNBEGIN  : 'X' = 새 화면 시작
FNAM      : 필드명 또는 BDC_OKCODE
FVAL      : 입력값 또는 기능코드
```

---

## 5-3) BDCDATA 작성 규칙

```
[화면 시작 줄]
PROGRAM + DYNPRO + DYNBEGIN = 'X'

[필드 줄들]
FNAM + FVAL
```

### 포인트

- 화면이 바뀔 때마다 새 화면 시작 줄 필요
- 각 입력 필드는 한 줄씩 추가

---

## 5-4) 자주 쓰는 필드

```
BDC_OKCODE : 버튼/기능코드
BDC_CURSOR : 커서 위치
```

### 예시

- `=SAVE`
- `=ENTR`

---

## 5-5) MODE 옵션

### 핵심

```
MODE 'N'.  " OR 'E' OR 'A'
```

### 의미

| 모드 | 의미 |
| --- | --- |
| `A` | 전체 화면 항상 표시 |
| `E` | 에러 있을 때만 화면 표시 |
| `N` | 화면 표시 안 함 |

### 포인트

- 실습 때는 `A`, `E` 가 디버깅에 유리
- 실제 자동 실행은 `N` 자주 사용

---

## 5-6) BDC 핵심 정리

### 한 줄 요약

> BDC는 SAP 화면을 그대로 흉내 내는 자동 입력 방식이고,
> 
> 
> BDCDATA는 “어느 화면의 어떤 필드에 어떤 값을 넣을지” 적어둔 스크립트다.
> 

### 주의

- 화면이 바뀌면 깨질 수 있음
- 속도가 느릴 수 있음
- BAPI/API가 있으면 보통 그쪽이 우선

---

## 6) ZABAP_41_G01 / ZABAP_42_G01 – MEMORY

### 핵심

- `EXPORT TO MEMORY ID` 로 ABAP Memory에 데이터를 저장
- `IMPORT FROM MEMORY ID` 로 다른 프로그램에서 꺼냄
- `SUBMIT ... AND RETURN` 과 함께 자주 사용

---

## 6-1) 전체 흐름

```
ZABAP_41_G01
  1) SPFLI 조회
  2) GT_CONNECT를 ABAP Memory에 EXPORT
  3) SUBMIT으로 ZABAP_42_G01 실행
  4) 돌아와서 자기 리스트 출력

ZABAP_42_G01
  1) ABAP Memory에서 GT_CONNECT IMPORT
  2) SALV로 출력
```

---

## 6-2) 호출하는 쪽 – EXPORT

```
REPORT ZABAP_41_G01.

DATA: GT_CONNECT TYPE TABLE OF SPFLI,
      GS_CONNECT LIKE LINE OF GT_CONNECT.

SELECT-OPTIONS: SO_CAR FOR GS_CONNECT-CARRID.

SELECT *
  INTO TABLE GT_CONNECT
  FROM SPFLI
  WHERE CARRID IN SO_CAR.

EXPORT
  GT_CONNECT
  TO MEMORY ID 'CONECT'.

SUBMIT ZABAP_42_G01
  AND RETURN.

LOOP AT GT_CONNECT INTO GS_CONNECT.
  WRITE:/ GS_CONNECT-CARRID,
          GS_CONNECT-CONNID,
          GS_CONNECT-AIRPFROM,
          GS_CONNECT-CITYFROM,
          GS_CONNECT-AIRPTO,
          GS_CONNECT-CITYTO.
ENDLOOP.
```

### 포인트

- 조회 데이터 `GT_CONNECT` 를 메모리에 저장
- 그 후 다른 프로그램 호출

---

## 6-3) 호출되는 쪽 – IMPORT

```
REPORT ZABAP_42_G01.

DATA: GT_SPFLI TYPE TABLE OF SPFLI.

DATA: GO_SALV TYPE REF TO CL_SALV_TABLE.

IMPORT
  GT_CONNECT TO GT_SPFLI
  FROM MEMORY ID 'CONNECT'.

TRY.
    CALL METHOD CL_SALV_TABLE=>FACTORY
      IMPORTING
        R_SALV_TABLE = GO_SALV
      CHANGING
        T_TABLE      = GT_SPFLI.
  CATCH CX_SALV_MSG.
ENDTRY.

CALL METHOD GO_SALV->DISPLAY.
```

### 포인트

- Memory ID 문자열이 정확히 같아야 함
- 저장 이름 / 가져올 이름 매핑도 중요

### 주의

현재 노트 기준으로는 저장할 때 `'CONECT'`, 가져올 때 `'CONNECT'` 로 보여서

**ID가 다르면 IMPORT가 안 됩니다.**

실제로는 **같은 MEMORY ID** 를 써야 합니다.

예:

```
EXPORT GT_CONNECT TO MEMORY ID 'CONNECT'.
IMPORT GT_CONNECT TO GT_SPFLI FROM MEMORY ID 'CONNECT'.
```

---

## 6-4) ABAP Memory 특징

### 핵심

- ABAP Memory는 **SAP GUI 창(External Session)마다 독립적**
- 다른 창에서는 접근 불가
- 창 간 데이터 교환 불가

### 포인트

- 같은 세션 안에서만 전달 가능
- 완전 영구 저장소가 아님

---

## 7) Lesson 13 핵심 비교(한 눈에)

| 항목 | 핵심 기능 | 대표 키워드 | 주의점 |
| --- | --- | --- | --- |
| SORT + DELETE ADJACENT DUPLICATES | 중복 제거 | `SORT`, `DELETE ADJACENT DUPLICATES` | 정렬 없이 쓰면 안 됨 |
| FOR ALL ENTRIES | 내부테이블 기준 다건 조회 | `FOR ALL ENTRIES IN` | 중복 제거 중요 |
| SUBMIT | 다른 Report 실행 | `SUBMIT`, `VIA SELECTION-SCREEN`, `AND RETURN` | 선택화면 표시 여부 확인 |
| RANGE | 조건 집합 전달 | `SIGN`, `OPTION`, `LOW`, `HIGH` | `IN` 과 함께 사용 |
| BDC | 화면 자동 입력 | `BDCDATA`, `CALL TRANSACTION` | 화면 바뀌면 깨질 수 있음 |
| ABAP Memory | 프로그램 간 데이터 전달 | `EXPORT/IMPORT TO MEMORY ID` | 같은 세션에서만 가능 |

---

## 8) 시험 포인트 / 실무 포인트

### 8-1) 시험 포인트

- `DELETE ADJACENT DUPLICATES` 는 **SORT 후 사용**
- `COMPARING` 필드에 따라 중복 제거 단위가 달라짐
- `FOR ALL ENTRIES` 는 내부테이블 한 행당 OR 조건 개념
- `SUBMIT` 에서
    - `VIA SELECTION-SCREEN`
    - `AND RETURN`
        
        의미 구분
        
- `RANGE` 구조:
    - `SIGN`
    - `OPTION`
    - `LOW`
    - `HIGH`
- `BDCDATA` 구조 필드 암기
- `CALL TRANSACTION ... MODE`
- `EXPORT / IMPORT TO MEMORY ID`
- Memory ID는 정확히 동일해야 함

### 8-2) 실무 포인트

- FAE 전 중복 제거는 거의 필수 습관
- BDC는 가능하면 마지막 수단
- 프로그램 간 간단한 데이터 전달은 Memory가 편함
- 세션이 다르면 ABAP Memory 공유 안 됨

---

## 9) Lesson 13에서 제일 중요한 결론

- **중복 제거는 `SORT → DELETE ADJACENT DUPLICATES` 순서가 핵심이다**
- **`FOR ALL ENTRIES` 는 OR 조건 기반이므로 기준 테이블 중복 제거가 중요하다**
- **`SUBMIT` 으로 다른 프로그램을 실행할 수 있고, `VIA SELECTION-SCREEN`, `AND RETURN` 옵션이 중요하다**
- **`RANGE` 는 `SIGN/OPTION/LOW/HIGH` 구조로 조건 집합을 만든다**
- **BDC는 화면 자동입력, ABAP Memory는 같은 세션 내 프로그램 간 데이터 전달 방식이다**
