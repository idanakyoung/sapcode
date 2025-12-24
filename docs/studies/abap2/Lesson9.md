# 🧭 Lesson 9 – ALV Grid

## 🔵 Unit 1. ALV GRID FIELD CATALOG

---

## 1. Field Catalog 개념 정리

### 1.1 Field Catalog란?

- **ALV Grid에서 각 컬럼의 속성(메타데이터)을 정의하는 테이블**
- 어떤 컬럼을:
    - 보여줄지 / 숨길지
    - 어떤 순서로 출력할지
    - 헤더 텍스트를 뭘로 할지
    - 체크박스 / 핫스팟 / 합계 / 강조 표시할지
        
        를 **개발자가 직접 제어**하기 위한 수단
        

---

### 1.2 Field Catalog로 가능한 작업

| 기능 | 가능 여부 |
| --- | --- |
| 컬럼 추가 | 가능 |
| 컬럼 숨김 | 가능 |
| 체크박스 표시 | 가능 |
| 핫스팟(클릭) | 가능 |
| 헤더 텍스트 변경 | 가능 |
| 출력 길이 제어 | 가능 |
| 합계/소계 | 가능 |
| 컬럼 강조 색상 | 가능 |

---

### 1.3 ALV Grid 컬럼 생성 방식 2가지

| 방식 | 파라미터 |
| --- | --- |
| DDIC 구조 기반 자동 생성 | `I_STRUCTURE_NAME` |
| 개발자 수동 정의 | `IT_FIELDCATALOG` |

### 비교 정리

| 상황 | I_STRUCTURE_NAME | Field Catalog |
| --- | --- | --- |
| DB 필드만 출력 | 가능 | 가능 |
| 계산 필드 추가 | 불가 | 가능 |
| 컬럼 순서 제어 | 제한적 | 가능 |
| 컬럼 숨김 | 제한적 | 가능 |
| 헤더 변경 | 제한적 | 가능 |

---

### 1.4 Field Catalog 사용 시 필수 규칙

| 규칙 | 이유 |
| --- | --- |
| `I_STRUCTURE_NAME` 제거 | 자동 컬럼 생성 방지 |
| `IT_FIELDCATALOG` 필수 | 컬럼 정의 제공 |
| `IT_OUTTAB` 정확히 전달 | 출력 데이터 매핑 |

> Field Catalog 쓰는 순간부터
> 
> 
> → `I_STRUCTURE_NAME`는 **절대 같이 쓰지 않는다**
> 

---

## 2. 데이터 구조에 따른 ALV 생성 패턴

### Case 1. 내부 테이블 = DDIC 구조

- 내부 테이블 라인 타입 = DDIC 구조
- 예: `TYPE TABLE OF SBOOK`

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    i_structure_name = 'SBOOK'
  CHANGING
    it_outtab = gt_data.

```

---

### Case 2. DDIC 구조 + 추가 필드

- 내부 테이블에 계산 필드 존재
- 예: `EXCP`, `PERCENTAGE`, `COLOR` 등

```abap
* i_structure_name 제거
* field catalog 사용

```

---

### Case 3. DDIC와 무관한 구조

- `TYPES`로 정의한 로컬 구조
- 계산 필드 위주

```abap
CALL METHOD go_alv->set_table_for_first_display
  CHANGING
    it_outtab       = gt_data
    it_fieldcatalog = gt_fcat.

```

---

## 3. ZABAP_31_G01 – Field Catalog 실습

---

### 3.1 Field Catalog 선언 (TOP)

```abap
DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

```

- `GT_FCAT` : 컬럼 정의 테이블
- `GS_FCAT` : 컬럼 하나씩 설정하는 작업용 구조

---

### 3.2 INIT_ALV에서 Field Catalog 생성 서브루틴 호출

```abap
PERFORM set_fcat.

```

---

### 3.3 Field Catalog 서브루틴 기본 구조

```abap
FORM set_fcat.
  CLEAR gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-coltext   = 'Carrier'.
  gs_fcat-col_pos   = 1.
  APPEND gs_fcat TO gt_fcat.

ENDFORM.

```

---

### 3.4 REF_TABLE / REF_FIELD 주의사항

- **반드시 DDIC 객체만 가능**
- 로컬 `TYPES`, 로컬 구조 필드는 참조 불가

```abap
gs_fcat-ref_table = 'SBOOK'.
gs_fcat-ref_field = 'CARRID'.

```

---

## 4. Field Catalog 주요 Output 속성 정리

### 4.1 컬럼 속성 표

| 필드 | 설명 |
| --- | --- |
| `COL_POS` | 출력 순서 |
| `COLTEXT` | 헤더 텍스트 |
| `OUTPUTLEN` | 출력 폭 |
| `NO_OUT` | 컬럼 숨김 |
| `TECH` | 기술 컬럼 (사용자 화면에서 숨김) |
| `KEY` | 키 컬럼 |
| `LOWERCASE` | 소문자 허용 |
| `CHECKBOX` | 체크박스 표시 |
| `HOTSPOT` | 클릭 가능 컬럼 |
| `DO_SUM` | 합계 표시 |
| `NO_SUM` | 합계 제외 |
| `EMPHASIZE` | 컬럼 강조 |

---

### 4.2 EMPHASIZE (컬럼 강조)

| 값 | 의미 |
| --- | --- |
| `X` | 기본 강조 |
| `Cxyz` | 사용자 정의 색상 |

```abap
gs_fcat-emphasize = 'C610'.

```

---

### 4.3 CHECKBOX 컬럼

```abap
gs_fcat-checkbox = 'X'.

```

- 읽기 전용 체크박스로 표시됨

---

### 4.4 HOTSPOT 컬럼

```abap
gs_fcat-hotspot = 'X'.

```

- 클릭 이벤트 처리 가능
- 이벤트: `HOTSPOT_CLICK`

---

## 5. Field Catalog + 계산 필드

### 5.1 계산 필드 데이터 채우기 (Main Logic)

```abap
LOOP AT gt_data INTO gs_data.
  gs_data-luggweight = gs_data-luggweight * 2.
  MODIFY gt_data FROM gs_data TRANSPORTING luggweight.
  CLEAR gs_data.
ENDLOOP.

```

---

### 5.2 Field Catalog에 계산 필드 추가

```abap
CLEAR gs_fcat.
gs_fcat-fieldname = 'LUGGWEIGHT'.
gs_fcat-coltext   = 'Luggage'.
gs_fcat-col_pos   = 5.
APPEND gs_fcat TO gt_fcat.

```

---

## 🔵 Unit 2. ALV EVENT AND METHOD

---

## 6. Double Click Event (Dialog)

---

### 6.1 이벤트 핸들러 클래스 정의

```abap
CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_double_click
        FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING es_row_no e_column.
ENDCLASS.

```

---

### 6.2 이벤트 핸들러 구현

```abap
CLASS lcl_event_handler IMPLEMENTATION.
  METHOD on_double_click.
    MESSAGE i016(BC405_408)
      WITH es_row_no-row_id e_column-fieldname.
  ENDMETHOD.
ENDCLASS.

```

---

### 6.3 이벤트 핸들러 등록

```abap
SET HANDLER lcl_event_handler=>on_double_click FOR go_alv.

```

---

## 7. Double Click → Dialog Screen 호출

### 7.1 선택된 행 데이터 읽기

```abap
READ TABLE gt_data INTO gs_data INDEX es_row_no-row_id.

```

---

### 7.2 Dialog Screen 호출

```abap
CALL SCREEN 110
  STARTING AT 5 5.

```

- Screen Type: **Dialog**
- 위치 지정 가능

---

## 8. HOTSPOT EVENT 처리

---

### 8.1 Field Catalog에서 HOTSPOT 설정

```abap
gs_fcat-hotspot = 'X'.

```

---

### 8.2 이벤트 메서드 분기 처리

```abap
CASE e_column-fieldname.
  WHEN 'NAME'.
    CALL SCREEN 200.
  WHEN 'AGENCYNUM'.
    CALL SCREEN 210.
ENDCASE.

```

> 여러 핫스팟 필드가 있을 경우
> 
> 
> **FIELDNAME 기준으로 반드시 분기**
> 

---

## 9. ZBC405_G01_ALV – Double Click 값 합산 예제

---

### 9.1 이벤트 핸들러 핵심 로직

```abap
READ TABLE gt_flights INTO gs_flight
  INDEX es_row_no-row_id.

lv_booking_total =
  gs_flight-seatsocc +
  gs_flight-seatsocc_b +
  gs_flight-seatsocc_f.

MESSAGE lv_booking_total TYPE 'I'.

```

---

## 10. ZQUIZ_17_G01 (2) – Dialog Popup 연계

- ALV → 더블클릭
- 선택 행 기반 데이터 조회
- Dialog Screen에 상세 표시

핵심 흐름:

```
ALV Row Double Click
→ Event Handler
→ READ TABLE (ROW_ID)
→ CALL SCREEN (Dialog)
→ 상세 데이터 표시

```

---

## 11. Lesson 9 핵심 요약

- Field Catalog는 **ALV 컬럼 제어의 핵심**
- 계산 필드 / 강조 / 체크박스 / 핫스팟은 **무조건 Field Catalog**
- 이벤트 처리는 **클래스 + SET HANDLER**
- HOTSPOT / DOUBLE CLICK은 **컬럼 이름 기준 분기**
- Dialog Screen은 **데이터 전달 흐름을 명확히 유지**

