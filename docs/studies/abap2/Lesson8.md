# 🧭 Lesson 8 – ALV Screen 활용 (Design/Sort/Color/Toolbar/Quiz)

---

## 🟡 SAP 시스템 필드 (SY-*) 정리

| 필드 | 의미 |
| --- | --- |
| SY-REPID | 현재 실행 중인 Report 이름 |
| SY-CPROG | 호출한 프로그램 이름 |
| SY-SUBRC | 실행 결과 코드 (0 = 성공) |
| SY-DATUM | 시스템 날짜 (YYYYMMDD) |
| SY-UZEIT | 시스템 시간 |
| SY-UNAME | 로그인 사용자 |
| SY-TABIX | 내부테이블 현재 인덱스 |
| SY-UCOMM | 버튼 / 메뉴 Function Code |
| SY-DBCNT | SELECT 결과 건수 |
| SY-DYNNR | 현재 Screen 번호 |
| SY-TCODE | 현재 Transaction Code |

---

## 0) ALV Design 기능별 “필수 연결 공식” (이거만 외우면 됨)

### A. Exception(신호등) 컬럼

- **데이터에 필드**: `EXCP TYPE c length 1`
- **레이아웃 연결**: `GS_LAYOUT-EXCP_FNAME = 'EXCP'`
- (옵션) LED 스타일: `GS_LAYOUT-EXCP_LED = 'X'`
- **값 규칙**: 보통 `'1'/'2'/'3'` (Red/Yellow/Green)

```
EXCP 값 → ALV 아이콘
'1'   → 🔴
'2'   → 🟡
'3'   → 🟢

```

---

### B. Row Color(행 색상)

- **데이터에 필드**: `COLOR TYPE c length 4` (예: `C610`)
- **레이아웃 연결**: `GS_LAYOUT-INFO_FNAME = 'COLOR'`

```
COLOR = 'C610' 이면
해당 행 전체가 지정 색으로 칠해짐
```

---

### C. Cell Color(셀 색상)

- **데이터에 필드**: `IT_FIELD_COLORS TYPE LVC_T_SCOL`
- **레이아웃 연결**: `GS_LAYOUT-CTAB_FNAME = 'IT_FIELD_COLORS'`
- **셀 지정 방식**: `LVC_S_SCOL`에 `FNAME`(필드명) + `COLOR` 세팅 후 테이블에 APPEND

```
IT_FIELD_COLORS = [
  {FNAME='PERCENTAGE', COLOR=RED},
  {FNAME='PLANETYPE',  COLOR=GREEN},
  ...
]
```

---

### D. Sort Criteria(기본 정렬)

- **정렬 테이블**: `GT_SORT TYPE LVC_T_SORT`
- **ALV 호출**: `IT_SORT = GT_SORT`

---

### E. Toolbar 숨김

- **전체 툴바 제거**: `GS_LAYOUT-NO_TOOLBAR = 'X'`
- **버튼만 제거**: `GT_UIEXCLUDE` + `IT_TOOLBAR_EXCLUDING = GT_UIEXCLUDE`

---

## 1) ZABAP_31_G01 – Exception Column

### 1-1) 타입 확장(기존 SBOOK + EXCP 추가)

```abap
TYPES: BEGIN OF ts_data,
         INCLUDE TYPE sbook,
         excp TYPE char1,
       END OF ts_data.

DATA: gt_data TYPE TABLE OF ts_data,
      gs_data TYPE ts_data.
```

**왜 이렇게 함?**

- `SBOOK` 필드 전부 쓰면서 `EXCP`만 추가해야 해서 `INCLUDE TYPE` 사용

---

### 1-2) SELECT는 꼭 “CORRESPONDING”으로

```abap
SELECT *
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  FROM sbook
  WHERE carrid IN so_car
    AND connid IN so_con
    AND fldate IN so_fdt.
```

**왜 CORRESPONDING?**

- `gt_data`는 `sbook + excp` 구조라서
- 그냥 `INTO TABLE`하면 구조 불일치 날 수 있음

---

### 1-3) EXCP 값 채우는 로직(가공)

```abap
LOOP AT gt_data INTO gs_data.

  IF gs_data-luggweight <= 10.
    gs_data-excp = '3'.
  ELSEIF gs_data-luggweight > 10 AND gs_data-luggweight <= 20.
    gs_data-excp = '2'.
  ELSE.
    gs_data-excp = '1'.
  ENDIF.

  MODIFY gt_data FROM gs_data TRANSPORTING excp.
  CLEAR gs_data.
ENDLOOP.
```

**중요 포인트**

- `TRANSPORTING excp` → 다른 필드 덮어쓰기 방지
- `CLEAR gs_data` → 다음 루프에서 값 섞이는 습관 방지

---

### 1-4) Layout에서 신호등 연결

```abap
gs_layout-excp_fname = 'EXCP'.
gs_layout-excp_led   = 'X'.
```

---

## 2) SORT CRITERIA – ZABAP_31_G01

### 2-1) 선언

```abap
DATA: gt_sort TYPE lvc_t_sort.
```

### 2-2) 값 채우기(F01에서 보통)

```abap
DATA: ls_sort LIKE LINE OF gt_sort.

ls_sort-fieldname = 'FLDATE'.
ls_sort-down      = 'X'.
APPEND ls_sort TO gt_sort.

CLEAR ls_sort.
ls_sort-fieldname = 'CUSTOMID'.
ls_sort-up        = 'X'.
APPEND ls_sort TO gt_sort.
```

### 2-3) ALV 호출에 연결

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    is_layout = gs_layout
  CHANGING
    it_outtab = gt_data
    it_sort   = gt_sort.
```

---

## 3) COLOR – ZABAP_31_G01

### 3-1) Row Color용 구조 확장

```abap
TYPES: BEGIN OF ts_data,
         INCLUDE TYPE sbook,
         color TYPE c LENGTH 4,
       END OF ts_data.

```

### 3-2) 로직(예: 흡연자만 빨간행)

```abap
LOOP AT gt_data INTO gs_data.
  IF gs_data-smoker = 'X'.
    gs_data-color = 'C610'.
  ENDIF.
  MODIFY gt_data FROM gs_data TRANSPORTING color.
  CLEAR gs_data.
ENDLOOP.

```

### 3-3) Layout 연결

```abap
gs_layout-info_fname = 'COLOR'.

```

---

## 4) CELL COLOR – ZABAP_31_G01

### 4-1) 구조 확장(셀 색상 테이블)

```abap
TYPES: BEGIN OF ts_data,
         INCLUDE TYPE sbook,
         it_field_colors TYPE lvc_t_scol,
       END OF ts_data.

DATA: gs_field_color TYPE lvc_s_scol.

```

### 4-2) 특정 셀만 색칠하는 로직(예: SMOKER 컬럼)

```abap
LOOP AT gt_data INTO gs_data.

  CLEAR gs_data-it_field_colors.

  IF gs_data-smoker = 'X'.
    CLEAR gs_field_color.
    gs_field_color-fname = 'SMOKER'.
    gs_field_color-color-col = col_negative.
    gs_field_color-color-int = 1.
    gs_field_color-color-inv = 0.
    gs_field_color-nokeycol = 'X'.
    APPEND gs_field_color TO gs_data-it_field_colors.
  ENDIF.

  MODIFY gt_data FROM gs_data TRANSPORTING it_field_colors.
  CLEAR gs_data.
ENDLOOP.

```

### 4-3) Layout 연결

```abap
gs_layout-ctab_fname = 'IT_FIELD_COLORS'.

```

---

## 5) HIDDEN FUNCTIONS – ZABAP_31_G01

### 5-1) 버튼만 숨김(UI Exclude)

```abap
DATA: gt_uiexclude TYPE ui_functions.

APPEND cl_gui_alv_grid=>mc_fc_excl_all TO gt_uiexclude.  "전체 버튼 숨김(스탠다드만)

```

또는 필요한 것만:

```abap
APPEND cl_gui_alv_grid=>mc_fc_loc_copy       TO gt_uiexclude.
APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row TO gt_uiexclude.

```

### 5-2) ALV 호출에 전달

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    it_toolbar_excluding = gt_uiexclude
    is_layout            = gs_layout
  CHANGING
    it_outtab            = gt_data.

```

### 5-3) 레이아웃 툴바 제거랑 차이

- `GS_LAYOUT-NO_TOOLBAR = 'X'` → **툴바 영역 자체 삭제**
- `IT_TOOLBAR_EXCLUDING` → **영역은 유지, 버튼만 삭제**

---

# 6) ZBC405_G01_ALV – COLOR/EXCP/CTAB 한 번에

### 6-1) 구조

```abap
TYPES: BEGIN OF ts_data,
         INCLUDE TYPE sflight,
         color           TYPE c LENGTH 4,
         light           TYPE c LENGTH 1,
         it_field_colors TYPE lvc_t_scol,
       END OF ts_data.

DATA: gt_flights TYPE TABLE OF ts_data,
      gs_flight  TYPE ts_data.

DATA: gs_layout      TYPE lvc_s_layo,
      gs_field_color TYPE lvc_s_scol.

```

### 6-2) 가공 로직(행색/신호등/셀색)

```abap
LOOP AT gt_flights INTO gs_flight.

  "행 색: 이번 달 데이터면 색 부여
  IF gs_flight-fldate(6) = sy-datum(6).
    gs_flight-color = 'C610'.
  ENDIF.

  "신호등: 예약수에 따라
  IF gs_flight-seatsocc = 0.
    gs_flight-light = '1'.
  ELSEIF gs_flight-seatsocc < 50.
    gs_flight-light = '2'.
  ELSE.
    gs_flight-light = '3'.
  ENDIF.

  "셀 색: 747-400이면 PLANETYPE만 강조
  CLEAR gs_flight-it_field_colors.
  IF gs_flight-planetype = '747-400'.
    CLEAR gs_field_color.
    gs_field_color-fname = 'PLANETYPE'.
    gs_field_color-color-col = col_positive.
    gs_field_color-color-int = 1.
    gs_field_color-color-inv = 0.
    gs_field_color-nokeycol = 'X'.
    APPEND gs_field_color TO gs_flight-it_field_colors.
  ENDIF.

  MODIFY gt_flights FROM gs_flight
    TRANSPORTING color light it_field_colors.
  CLEAR gs_flight.

ENDLOOP.

```

### 6-3) Layout 연결(3종 세트)

```abap
FORM set_layout.
  gs_layout-grid_title = 'Flights'.
  gs_layout-no_vgridln = 'X'.
  gs_layout-no_hgridln = 'X'.

  gs_layout-info_fname = 'COLOR'.            "행 색
  gs_layout-ctab_fname = 'IT_FIELD_COLORS'.  "셀 색
  gs_layout-excp_fname = 'LIGHT'.            "신호등
  gs_layout-sel_mode   = 'A'.
ENDFORM.

```

---

# 7) ZQUIZ_17_G01 – 예약율 + 신호등 + 100% 셀 빨강

## 7-1) Selection Screen 초기값(이번달 1일~오늘)

```abap
so_fdt-low  = sy-datum+0(4) && sy-datum+4(2) && '01'.
so_fdt-high = sy-datum.

```

## 7-2) 예약율 계산

```abap
IF gs_flight-seatsmax = 0.
  gs_flight-percentage = 0.
ELSE.
  gs_flight-percentage =
    ( gs_flight-seatsocc * 100 ) / gs_flight-seatsmax.
ENDIF.

```

## 7-3) 신호등

```abap
IF gs_flight-percentage < 60.
  gs_flight-light = '1'.
ELSEIF gs_flight-percentage < 90.
  gs_flight-light = '2'.
ELSE.
  gs_flight-light = '3'.
ENDIF.

```

## 7-4) 100%면 PERCENTAGE 셀 빨강

```abap
CLEAR gs_flight-it_field_colors.

IF gs_flight-percentage = 100.
  CLEAR gs_field_color.
  gs_field_color-fname = 'PERCENTAGE'.
  gs_field_color-color-col = col_negative.
  gs_field_color-color-int = 1.
  APPEND gs_field_color TO gs_flight-it_field_colors.
ENDIF.

```

---

# 8) GS_VARIANT / PA_VARI / GV_SAVE 정리 (ALV Variant)

## 8-1) 선언

```abap
DATA: gs_variant TYPE disvariant.
DATA: gv_save    TYPE char1.
PARAMETERS: pa_vari TYPE disvariant-variant.

```

## 8-2) 필수 세팅

```abap
gs_variant-report = sy-cprog.
gs_variant-variant = pa_vari.
gv_save = 'A'.

```

## 8-3) ALV 호출에 전달

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    is_variant = gs_variant
    i_save     = gv_save
    is_layout  = gs_layout
  CHANGING
    it_outtab       = gt_flights
    it_fieldcatalog = gt_fcat.

```

---

## 9) Screen 0100 Flow Logic(고정 템플릿)

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE clear_ok_code.
  MODULE init_alv.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

--- 
