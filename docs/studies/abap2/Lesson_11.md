# 🧭 Lesson 11 – Methods of the ALV Grid / Row Delete / Toolbar Event

---

## 0) 전체 흐름(공통 뼈대)

```
ALV Grid 출력
  1) ALV 기본 출력 완료
  2) ALV Control Method로 현재 상태 조회
  3) 선택 행 / 셀 / 컬럼 정보 가져오기
  4) USER_COMMAND에서 삭제 / 계산 로직 처리
  5) TOOLBAR 이벤트로 커스텀 버튼 추가
  6) PRINT 이벤트로 출력 헤더/조건 표시
```

---

## 1) Unit 1. Methods of the ALV Grid 이론

### 핵심

- `CL_GUI_ALV_GRID`는 화면에 한 번 출력한 뒤에도 다양한 **메서드(Method)** 로 현재 상태를 조회하거나 사용자 동작을 제어할 수 있다.
- 단, 클래스 메서드 중 **PUBLIC Visibility** 인 것만 외부에서 사용할 수 있다.
- `PRIVATE`, `PROTECTED` 메서드는 직접 사용 불가하다.

### 포인트

- ALV는 단순 출력 도구가 아니라 **출력 후에도 상태를 읽고 제어하는 컨트롤 객체**
- 이벤트 + 메서드를 같이 써야 실무형 기능이 나온다

---

## 2) ALV Control Methods 개요

### 목적

- 사용자가 선택한 셀 / 행 / 컬럼 정보 조회
- 현재 커서 위치 파악
- 서브토탈 정보 조회
- 툴바 이벤트 강제 트리거
- 표준 사용자 커맨드 변경

---

## 3) ALV Control Methods 상세 정리

| 구분 | 메서드 | 기능 요약 | 주요 용도 | 핵심 포인트 |
| --- | --- | --- | --- | --- |
| 3.1 | `GET_CURRENT_CELL` | 현재 커서 셀 조회 | 클릭한 셀 기준 처리 | 커서 기준, 셀 1개 |
| 3.2 | `GET_SELECTED_CELLS` | 선택된 셀들 조회 | 멀티 셀 처리 | 셀 단위 다중 선택 |
| 3.3 | `GET_SELECTED_COLUMNS` | 선택 컬럼 목록 조회 | 컬럼 기준 기능 | 필드명 반환 |
| 3.4 | `GET_SELECTED_ROWS` | 선택 행 목록 조회 | 삭제/일괄처리 | 실무 사용 빈도 높음 |
| 3.5 | `GET_SUBTOTALS` | 현재 서브토탈 정보 조회 | 소계 기반 후처리 | 소계 설정 상태에서 의미 |
| 3.6 | `SET_TOOLBAR_INTERACTIVE` | 툴바 이벤트 재트리거 | 툴바 재구성 | TOOLBAR 이벤트와 세트 |
| 3.7 | `SET_USER_COMMAND` | 사용자 커맨드 변경 | 표준 기능 치환 | 영향 범위 큼 |

---

## 3-1) GET_CURRENT_CELL

### 핵심

- 현재 커서가 위치한 **단일 셀** 정보를 가져온다.

### 반환 정보

- Row ID
- Column ID
- Value

### 언제 쓰나

- 사용자가 지금 클릭한 셀 기준 처리
- 더블클릭 / 클릭 이벤트 후 상세 처리

### 포인트

- 선택된 셀 전체가 아니라 **현재 커서 한 칸**
- 여러 셀을 처리하려면 `GET_SELECTED_CELLS` 사용

---

## 3-2) GET_SELECTED_CELLS

### 핵심

- 사용자가 선택한 **복수 셀** 정보를 가져온다.

### 언제 쓰나

- 드래그한 셀 범위 일괄 처리
- 입력 범위 검증
- 셀 단위 계산

### 포인트

- 멀티 셀 선택 UI일 때 의미가 큼
- 행 단위 처리면 `GET_SELECTED_ROWS`가 더 단순하다

---

## 3-3) GET_SELECTED_COLUMNS

### 핵심

- 선택된 컬럼의 필드명 목록을 가져온다.

### 언제 쓰나

- 특정 컬럼 기준 기능 버튼 구현
- 선택 컬럼 숨김 / 합계 / 정렬 등

### 포인트

- 컬럼 헤더 선택이 전제
- 행 정보나 셀 값은 없음

---

## 3-4) GET_SELECTED_ROWS

### 핵심

- 사용자가 선택한 행 번호를 가져온다.
- 실무에서 가장 많이 쓰는 메서드 중 하나

### 언제 쓰나

- 선택 행 삭제
- 선택 행 상세조회
- 일괄 승인 / 전송 / 취소

### 반환

- 선택된 행 Index 목록

### 포인트

- 정렬 / 필터 후에는 표시 인덱스 기준일 수 있으니 주의
- 내부테이블 인덱스와 ALV 인덱스 매핑을 항상 의식해야 함

---

## 3-5) GET_SUBTOTALS

### 핵심

- 현재 ALV에 적용된 소계(Subtotal) 상태를 조회한다.

### 언제 쓰나

- 사용자가 정렬/소계한 결과를 바탕으로 추가 계산할 때

### 포인트

- 소계가 걸려 있을 때만 의미 있음
- 조회용이지 수정용은 아님

---

## 3-6) SET_TOOLBAR_INTERACTIVE

### 핵심

- TOOLBAR 이벤트를 다시 발생시켜 툴바를 인터랙티브하게 다시 구성한다.

### 언제 쓰나

- 조건에 따라 툴바 버튼 구성을 바꾸고 싶을 때
- 사용자 버튼 동적 추가/변경

### 포인트

- 보통 `TOOLBAR` 이벤트와 세트
- 버튼만 추가하지 말고 클릭 후 `USER_COMMAND` 흐름까지 설계해야 함

---

## 3-7) SET_USER_COMMAND

### 핵심

- 현재 사용자 커맨드(Function Code)를 다른 값으로 바꾼다.

### 언제 쓰나

- 표준 기능을 커스텀 기능으로 치환할 때
- 특정 버튼의 동작을 조건부 변경할 때

### 포인트

- 영향 범위가 큼
- 실무에서는 특정 Fcode만 제한적으로 바꾸는 식으로 사용 권장

---

## 4) Method : CELL DELETE / ROW DELETE 실습

### 핵심

- 선택한 행을 삭제하는 로직은 보통 `GET_SELECTED_ROWS`로 구현한다.
- 선택 행이 없으면 메시지 처리
- 선택 행이 있으면 내부테이블에서 해당 인덱스를 삭제

---

## 4-1) 변수 선언

```
DATA: LT_ROW TYPE LVC_T_ROID,
      LS_ROW LIKE LINE OF LT_ROW.
```

### 의미

- `LT_ROW` : 선택된 행 번호 목록
- `LS_ROW` : 행 번호 Work Area

---

## 4-2) 선택 행 가져오기

보통 `ON_USER_COMMAND` 안에서 사용한다.

```
GO_ALV_GRID->GET_SELECTED_ROWS(
  IMPORTING
    ET_ROW_NO = LT_ROW ).
```

---

## 4-3) 삭제 로직

```
IF LINES( LT_ROW ) <= 0.
  MESSAGE 'Row를 선택하여 주세요!' TYPE 'I'.
ELSE.
  READ TABLE LT_ROW INTO LS_ROW INDEX 1.
  DELETE GT_DATA INDEX LS_ROW-ROW_ID.
ENDIF.
```

### 포인트

- 선택된 행이 없으면 정보 메시지
- 첫 번째 선택 행을 읽어서 내부테이블 삭제

---

## 4-4) 주의사항

### 핵심

- `GS_LAYOUT-SEL_MODE = 'A'` 처럼 다중 선택 모드일 때
- 삭제를 `LOOP ... DELETE INDEX` 식으로 단순 처리하면 위험하다

### 이유

- 삭제가 일어날 때마다 인덱스가 계속 바뀌기 때문
- 루프 중간에 인덱스가 밀리면 잘못된 행이 삭제될 수 있음

### 포인트

- 다중 삭제는 **뒤에서부터 삭제**하거나
- 삭제 대상 인덱스를 따로 정리해서 처리해야 한다

---

## 4-5) GET_CURRENT_CELL 관련

### 핵심

- 주석 처리된 일부 코드/메서드는 현재 커서 셀 위치를 보는 용도
- 주로 디버깅이나 현재 클릭 위치 확인용으로 사용

---

## 5) ZBC405_G01_ALV – Exercise 13, 14 : TOOLBAR

---

## 5-1) 이벤트 핸들러 선언

### 핵심

ALV에서 특정 이벤트가 발생했을 때 자동으로 실행될 메서드를 선언한다.

```
PRINT_TOP FOR EVENT PRINT_TOP_OF_PAGE OF CL_GUI_ALV_GRID,
PRINT_TOL FOR EVENT PRINT_TOP_OF_LIST OF CL_GUI_ALV_GRID,

ON_TOOLBAR FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
  IMPORTING E_OBJECT,
ON_USER_COMMAND FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
  IMPORTING E_UCOMM.
```

### 의미

| 이벤트 | 실행 시점 |
| --- | --- |
| `PRINT_TOP_OF_PAGE` | 출력 시 페이지 상단 |
| `PRINT_TOP_OF_LIST` | 출력 시 리스트 상단 |
| `TOOLBAR` | 툴바 그릴 때 |
| `USER_COMMAND` | 버튼 클릭 시 |

### 포인트

- ALV는 이벤트 기반으로 기능 확장
- 이벤트 선언만 하고 끝이 아니라 **핸들러 등록까지 해야 실제 동작**

---

## 6) Exercise 13 – 출력(Print) 관련

---

## 6-1) PRINT_TOP 메서드

### 핵심

- ALV를 인쇄할 때 페이지 상단 머리글을 출력한다.

```
METHOD PRINT_TOP.

  DATA LV_POS TYPE I.
  FORMAT COLOR COL_HEADING.
  WRITE: / SY-DATUM.
  LV_POS = SY-LINSZ / 2 - 3.
  WRITE AT LV_POS SY-PAGNO.
  LV_POS = SY-LINSZ - 11.
  WRITE: AT LV_POS SY-UNAME.

ENDMETHOD.
```

### 출력 내용

- 날짜 `SY-DATUM`
- 페이지 번호 `SY-PAGNO`
- 사용자 `SY-UNAME`

### 포인트

- 화면 출력용이 아니라 **프린트 출력용 헤더**

---

## 6-2) PRINT_TOL 메서드

### 핵심

- 출력 시 리스트 상단에 Selection 조건을 출력한다.

```
METHOD PRINT_TOL.
  DATA: LS_SO_CAR LIKE LINE OF SO_CAR,
        LS_SO_CON LIKE LINE OF SO_CON.
  CONSTANTS: LC_END TYPE I VALUE 20.

  FORMAT COLOR COL_HEADING.
  WRITE:/ 'Select options'(000), AT LC_END SPACE.

  SKIP.

  WRITE:/ 'Airlines'(000), AT LC_END SPACE.
  ULINE AT /(lc_end).

  FORMAT COLOR COL_NORMAL.
  LOOP AT SO_CAR INTO LS_SO_CAR.
    WRITE:/ LS_SO_CAR-SIGN,
            LS_SO_CAR-OPTION,
            LS_SO_CAR-LOW,
            LS_SO_CAR-HIGH.
  ENDLOOP.

  SKIP.

  FORMAT COLOR COL_HEADING.
  WRITE:/ 'Connection'(002), AT LC_END SPACE.
  ULINE AT /(lc_end).
  FORMAT COLOR COL_NORMAL.
  LOOP AT SO_CON INTO LS_SO_CON.
    WRITE:/ LS_SO_CON-SIGN,
            LS_SO_CON-OPTION,
            LS_SO_CON-LOW NO-ZERO,
            LS_SO_CON-HIGH NO-ZERO.
  ENDLOOP.

  SKIP.

ENDMETHOD.
```

### 포인트

- 출력물이 어떤 조회 조건으로 나왔는지 보여주는 역할
- 종이 출력 / PDF 출력 시 특히 유용

---

## 6-3) PRINT용 구조 선언

```
GS_PRINT TYPE LVC_S_PRNT.
```

### 의미

- ALV가 출력 관련 이벤트를 사용할 수 있도록 하는 구조

---

## 6-4) ALV 호출 시 전달

```
IS_PRINT = GS_PRINT
```

### 포인트

- `SET_TABLE_FOR_FIRST_DISPLAY` 호출 시 같이 넘겨야 출력 이벤트가 적용됨

---

## 6-5) 추가 레이아웃 설정

```
GS_LAYOUT-PRNTLSTIN  = 'X'.
GS_LAYOUT-GRPCHGEDIT = 'X'.
```

### 의미

| 필드 | 의미 |
| --- | --- |
| `PRNTLSTIN` | 출력 시 리스트 헤더 활성화 |
| `GRPCHGEDIT` | 그룹 변경 관련 출력 옵션 |

---

## 7) Exercise 14 – 툴바 + 버튼 로직

---

## 7-1) ON_TOOLBAR 메서드

### 핵심

- ALV 툴바에 커스텀 버튼을 추가한다.

```
METHOD ON_TOOLBAR.
  DATA LS_BUTTON TYPE STB_BUTTON.

  LS_BUTTON-BUTN_TYPE = 3.
  APPEND LS_BUTTON TO E_OBJECT->MT_TOOLBAR.

  CLEAR LS_BUTTON.
  LS_BUTTON-FUNCTION  = 'PERCENTAGE'.
  LS_BUTTON-TEXT      = '% Total'.
  LS_BUTTON-QUICKINFO = 'Total economy utilization'.
  LS_BUTTON-BUTN_TYPE = 0.
  APPEND LS_BUTTON TO E_OBJECT->MT_TOOLBAR.

  CLEAR LS_BUTTON.
  LS_BUTTON-FUNCTION  = 'PERCENTAGE_MARKED'.
  LS_BUTTON-TEXT      = '% Marked'.
  LS_BUTTON-QUICKINFO = 'Economy utilization(marked flights)'.
  LS_BUTTON-BUTN_TYPE = 0.
  APPEND LS_BUTTON TO E_OBJECT->MT_TOOLBAR.
ENDMETHOD.
```

### 구성

- 구분선 추가: `BUTN_TYPE = 3`
- 버튼 1: `% Total`
- 버튼 2: `% Marked`

### 포인트

- `FUNCTION` 값이 나중에 `E_UCOMM`으로 들어간다
- 즉, 버튼 이름이 아니라 **Function Code가 핵심 연결 고리**

---

## 7-2) ON_USER_COMMAND 메서드

### 핵심

- 툴바 버튼 클릭 시 실제 계산 로직을 처리한다.

```
METHOD ON_USER_COMMAND.
  DATA: LV_OCCUPIED   TYPE I,
        LV_CAPACITY   TYPE I,
        LV_PERCENTAGE TYPE P LENGTH 8 DECIMALS 1,
        LV_TEXT       TYPE STRING,
        LT_ROW_NO     TYPE LVC_T_ROID,
        LS_ROW_NO     TYPE LVC_S_ROID.

  CASE E_UCOMM.
    WHEN 'PERCENTAGE'.
      LOOP AT GT_FLIGHT INTO GS_FLIGHT.
        LV_OCCUPIED = LV_OCCUPIED + GS_FLIGHT-SEATSOCC.
        LV_CAPACITY = LV_CAPACITY + GS_FLIGHT-SEATSMAX.
      ENDLOOP.
      LV_PERCENTAGE = LV_OCCUPIED / LV_CAPACITY * 100.
      MOVE LV_PERCENTAGE TO LV_TEXT.
      LV_TEXT = 'Percentage of occupied seats:' && ' ' && LV_TEXT.
      MESSAGE LV_TEXT TYPE 'I'.

    WHEN 'PERCENTAGE_MARKED'.
      GO_ALV_GRID->GET_SELECTED_ROWS( IMPORTING ET_ROW_NO = LT_ROW_NO ).

      IF LINES( LT_ROW_NO ) > 0.
        LOOP AT LT_ROW_NO INTO LS_ROW_NO.
          READ TABLE GT_FLIGHT INTO GS_FLIGHT INDEX LS_ROW_NO-ROW_ID.
          LV_OCCUPIED = LV_OCCUPIED + GS_FLIGHT-SEATSOCC.
          LV_CAPACITY = LV_CAPACITY + GS_FLIGHT-SEATSMAX.
        ENDLOOP.
        LV_PERCENTAGE = LV_OCCUPIED / LV_CAPACITY * 100.
        MOVE LV_PERCENTAGE TO LV_TEXT.
        LV_TEXT = 'Percentage of occupied seats:' && ' ' && LV_TEXT.
        MESSAGE LV_TEXT TYPE 'I'.
      ELSE.
        MESSAGE 'Please mark at least one row' TYPE 'I'.
      ENDIF.
  ENDCASE.
ENDMETHOD.
```

---

## 7-3) 버튼별 기능

### 1) `PERCENTAGE`

- 전체 비행편 기준 좌석 점유율 계산

```
총 점유 좌석 / 총 좌석 수 * 100
```

### 2) `PERCENTAGE_MARKED`

- 사용자가 선택한 행만 기준으로 좌석 점유율 계산
- 핵심 메서드:

```
GO_ALV_GRID->GET_SELECTED_ROWS(
  IMPORTING ET_ROW_NO = LT_ROW_NO ).
```

### 포인트

- 선택 행이 없으면 메시지
- 선택 행이 있으면 그 행만 READ TABLE 해서 계산

---

## 8) 핸들러 등록

### 핵심

- 이벤트 핸들러를 선언만 하고 등록하지 않으면 아무 것도 동작하지 않는다.

```
SET HANDLER LCL_EVENT_HANDLER=>ON_TOOLBAR FOR GO_ALV_GRID.
SET HANDLER LCL_EVENT_HANDLER=>ON_USER_COMMAND FOR GO_ALV_GRID.
```

### 포인트

- 실무에서 제일 자주 빠뜨리는 부분 중 하나
- `PRINT_TOP`, `PRINT_TOL` 도 마찬가지로 이벤트 등록 흐름을 같이 봐야 함

---

## 9) 전체 실행 흐름

```
ALV 생성
 ↓
이벤트 핸들러 선언
 ↓
PRINT 이벤트 → 출력 시 머리글 / 조건 출력
 ↓
TOOLBAR 이벤트 → 버튼 생성
 ↓
사용자 버튼 클릭
 ↓
USER_COMMAND 이벤트 발생
 ↓
선택 행 조회 / 계산 로직 실행
 ↓
메시지 출력
```

---

## 10) 이 단원에서 중요한 비교 포인트

| 항목 | 기능 | 대표 메서드 | 실무 포인트 |
| --- | --- | --- | --- |
| 현재 커서 셀 조회 | 지금 클릭한 한 칸 확인 | `GET_CURRENT_CELL` | 디버깅/상세 처리 |
| 선택 셀 조회 | 여러 셀 범위 확인 | `GET_SELECTED_CELLS` | 멀티셀 처리 |
| 선택 컬럼 조회 | 컬럼 단위 기능 | `GET_SELECTED_COLUMNS` | 컬럼명 기반 |
| 선택 행 조회 | 행 단위 기능 | `GET_SELECTED_ROWS` | 삭제/일괄처리 핵심 |
| 출력 헤더 | 인쇄 상단 정보 | `PRINT_TOP_OF_PAGE` | 날짜/페이지/사용자 |
| 출력 조건 | 인쇄 리스트 상단 | `PRINT_TOP_OF_LIST` | 조회 조건 표시 |
| 툴바 버튼 추가 | 커스텀 버튼 생성 | `TOOLBAR` 이벤트 | 버튼 생성 |
| 버튼 클릭 처리 | 기능 실행 | `USER_COMMAND` 이벤트 | 계산/삭제 로직 |

---

## 11) 시험 포인트 / 실무 포인트

### 11-1) 시험 포인트

- `CL_GUI_ALV_GRID` 메서드 중 **PUBLIC만 사용 가능**
- `GET_CURRENT_CELL` 과 `GET_SELECTED_ROWS` 차이
- `GET_SELECTED_ROWS` 로 선택 행 삭제 가능
- 다중 선택 삭제 시 인덱스 변경 주의
- `TOOLBAR` 이벤트에서 버튼 생성
- `USER_COMMAND` 이벤트에서 Function Code 처리
- `FUNCTION` 값이 `E_UCOMM` 으로 넘어간다
- 출력 이벤트:
    - `PRINT_TOP_OF_PAGE`
    - `PRINT_TOP_OF_LIST`
- `IS_PRINT`, `LVC_S_PRNT`, `PRNTLSTIN` 연결 관계

### 11-2) 실무 포인트

- 행 삭제/일괄 처리 기능은 `GET_SELECTED_ROWS`가 핵심
- 툴바 버튼 추가 시 `ON_TOOLBAR` + `ON_USER_COMMAND` 세트로 기억
- 출력 기능은 화면용이 아니라 인쇄용이라는 점 구분
- 이벤트 선언보다 **핸들러 등록 누락**을 더 조심해야 함

---

## 12) Lesson 11에서 제일 중요한 결론

- **ALV는 출력 후에도 메서드로 현재 상태를 읽고 제어할 수 있다**
- **선택 행 처리의 핵심 메서드는 `GET_SELECTED_ROWS` 이다**
- **삭제 기능은 인덱스 변경 문제 때문에 다중 선택 처리 시 특히 주의해야 한다**
- **커스텀 툴바는 `TOOLBAR` 이벤트에서 만들고, 클릭 처리는 `USER_COMMAND`에서 한다**
- **출력 기능은 `PRINT_TOP_OF_PAGE`, `PRINT_TOP_OF_LIST`, `IS_PRINT`, `GS_PRINT` 설정이 함께 맞물려야 동작한다**
