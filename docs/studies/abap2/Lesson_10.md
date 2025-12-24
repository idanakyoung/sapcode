# 🧭 Lesson 10 – ALV Grid 활용

---

## 0) 전체 흐름(공통 뼈대)

```
Selection Screen → DB SELECT → CALL SCREEN 100
Screen 100 (PBO)
  1) STATUS_0100        : PF-STATUS / TITLE
  2) CLEAR_OK_CODE      : OK_CODE 초기화
  3) INIT_ALV           : 컨테이너/그리드 생성 + FCAT 준비 + 출력
Screen 100 (PAI)
  USER_COMMAND_0100     : BACK/CANCEL/EXIT 처리
```

---

## 1) ZABAP_32_G01 (기본 틀: Structure 자동 컬럼)

### 핵심

- `I_STRUCTURE_NAME = 'SCARR'`로 **컬럼 자동 생성**
- `IT_OUTTAB = GT_SCARR`만 넘기면 됨
- FCAT 없음

### 포인트

- 빠르게 ALV 그리기용 “기본 골격”
- 컬럼 제어(순서/숨김/추가/핫스팟)는 거의 못 함 → 다음 실습(33~35)로 넘어감

---

## 2) ZABAP_33_G01 (#field catalog1) – FCAT 완전 수동(직접 APPEND)

### 핵심

- `I_STRUCTURE_NAME` **사용 안 함**
- `GT_FCAT`에 컬럼을 **직접 정의**
- `SET_TABLE_FOR_FIRST_DISPLAY`에서 `IT_FIELDCATALOG`로 컬럼 생성

### FCAT 작성 패턴(핵심 반복 구조)

```abap
GS_FCAT-FIELDNAME = 'CARRID'.
GS_FCAT-COL_POS   = 1.
GS_FCAT-COLTEXT   = 'Airline'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'CARRNAME'.
GS_FCAT-COL_POS   = 2.
GS_FCAT-HOTSPOT   = 'X'.
GS_FCAT-REF_TABLE = 'SCARR'.
APPEND GS_FCAT TO GT_FCAT.

```

### 포인트

- `CLEAR GS_FCAT` 안 하면 이전 컬럼 속성이 다음 컬럼에 섞일 수 있음
- `REF_TABLE` 넣으면 DDIC 정보 기반으로 텍스트/도메인 등 자동 보완 가능
- 컬럼 많아질수록 코드가 길어짐(수동이라서)

---

## 3) ZABAP_34_G01 (#field catalog2) – Structure 기반 + FCAT 최소 수정

### 핵심

- `I_STRUCTURE_NAME = 'ZSCARRIER_G00'`로 **자동 컬럼 생성**
- FCAT은 “전체 정의”가 아니라 **수정할 필드만 최소 입력**
- 즉 **구조가 기본**, FCAT은 “속성 덮어쓰기”

### 최소 FCAT 예시(핫스팟만)

```abap
GS_FCAT-FIELDNAME = 'CARRNAME'.
GS_FCAT-HOTSPOT   = 'X'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'URL'.
GS_FCAT-HOTSPOT   = 'X'.
APPEND GS_FCAT TO GT_FCAT.

```

### ALV 호출(중요)

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  EXPORTING
    I_STRUCTURE_NAME = 'ZSCARRIER_G00'
  CHANGING
    IT_OUTTAB       = GT_SCARR
    IT_FIELDCATALOG = GT_FCAT.

```

### 포인트

- 구조에서 컬럼 순서/텍스트/길이 대부분 해결
- FCAT은 “핫스팟 같은 옵션만” 손대서 유지보수 좋음

---

## 4) ZABAP_35_G01 (#field catalog3) – MERGE로 FCAT 자동 생성 + LOOP 후처리

### 핵심

- `LVC_FIELDCATALOG_MERGE`로 구조 기반 FCAT을 **한 번에 생성**
- 그 다음 `LOOP AT GT_FCAT`로 필요한 필드만 속성 변경(후처리)
- 마지막에 `IT_FIELDCATALOG = GT_FCAT`만 넘김 (`I_STRUCTURE_NAME` 없어도 됨)

### 4-1) FCAT 자동 생성

```abap
CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
    I_STRUCTURE_NAME = 'ZSCARRIER_G00'
  CHANGING
    CT_FIELDCAT      = GT_FCAT.

```

### 4-2) 후처리(예: 특정 컬럼만 HOTSPOT)

```abap
LOOP AT GT_FCAT INTO GS_FCAT.
  CASE GS_FCAT-FIELDNAME.
    WHEN 'CARRNAME' OR 'URL'.
      GS_FCAT-HOTSPOT = 'X'.
  ENDCASE.
  MODIFY GT_FCAT FROM GS_FCAT.
ENDLOOP.

```

### 4-3) ALV 적용

```abap
CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY
  CHANGING
    IT_OUTTAB       = GT_SCARR
    IT_FIELDCATALOG = GT_FCAT.

```

### 포인트

- 컬럼이 많고 “특정 속성만 일괄 변경”할 때 가장 편함
- 실무에서 구조 기반 + 후처리 패턴 자주 씀

---

## 5) 33 / 34 / 35 비교(한 눈에)

| 프로그램 | 컬럼 생성 | FCAT 역할 | 장점 | 단점 |
| --- | --- | --- | --- | --- |
| 33 | FCAT 100% 수동 | 컬럼 정의 전부 | 완전 통제 | 코드 길어짐 |
| 34 | 구조 자동 + FCAT 일부 | 일부 속성만 수정 | 깔끔/유지보수 | 구조 영향 큼 |
| 35 | MERGE 자동 + 후처리 | 자동생성 후 일괄 수정 | 대량 컬럼 + 일괄 변경 최적 | MERGE 이해 필요 |

---

## 6) 툴바 생성/제거 관련 (ZABAP_31_G01 참고 내용)

### 6-1) 툴바 “영역 자체” 제거

```abap
GS_LAYOUT-NO_TOOLBAR = 'X'.

```

- 툴바가 통째로 사라짐(버튼/영역 모두 없음)

### 6-2) 스탠다드 버튼만 제거(영역은 유지)

```abap
APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL TO GT_UIEXCLUDE.

```

- 툴바 영역은 남고, 스탠다드 버튼만 숨김

### 6-3) 주의

- 내가 만든 커스텀 툴바(사용자 버튼)를 숨기려면 위 방식과 다르게 처리해야 함
- **SET_TABLE_FOR_FIRST_DISPLAY 호출 파라미터로 전달해야 적용됨**
    - `IT_TOOLBAR_EXCLUDING = GT_UIEXCLUDE`

---

## 7) ZQUIZ_18_G01 – Field Catalog ④ (집계형/월별 합계, Macro/FORM)

### 목표 구조

- 월별 합계를 표시할 DDIC 구조가 없음 → **프로그램 내부 구조(TYPES)로 직접 생성**
- 컬럼이 많음(1~12월) → **매크로로 FCAT 반복 제거**

---

### 7-1) 출력 전용 구조(TYPES)

```abap
TYPES: BEGIN OF ty_data,
         carrid   TYPE sflight-carrid,
         carrname TYPE scarr-carrname,
         currcode TYPE scarr-currcode,
         jansum   TYPE p LENGTH 16 DECIMALS 2,
         ...
         decsum   TYPE p LENGTH 16 DECIMALS 2,
       END OF ty_data.

```

---

### 7-2) FCAT 선언

```abap
DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

```

---

### 7-3) FCAT 생성 위치(분리)

```abap
PERFORM set_fcat.

```

---

### 7-4) FCAT 초기화(중복 방지)

```abap
FORM set_fcat.
  CLEAR gt_fcat.

```

---

### 7-5) 매크로(월 컬럼 반복 제거 핵심)

```abap
DEFINE add_fcat.
  CLEAR gs_fcat.
  gs_fcat-fieldname  = &1.
  gs_fcat-coltext    = &2.
  gs_fcat-col_pos    = &3.
  gs_fcat-decimals_o = 2.
  gs_fcat-do_sum     = 'X'.
  APPEND gs_fcat TO gt_fcat.
END-OF-DEFINITION.

```

- `&1, &2, &3` = 매크로 인자
- `decimals_o = 2` : 출력 소수 2자리 고정
- `do_sum = 'X'` : 컬럼 합계 라인 표시

---

### 7-6) 기본 컬럼(보통 합계 X)

```abap
CLEAR gs_fcat.
gs_fcat-fieldname = 'CARRID'.
gs_fcat-coltext   = 'Carrier'.
gs_fcat-col_pos   = 1.
APPEND gs_fcat TO gt_fcat.

CLEAR gs_fcat.
gs_fcat-fieldname = 'CARRNAME'.
gs_fcat-coltext   = 'Carrier Name'.
gs_fcat-col_pos   = 2.
APPEND gs_fcat TO gt_fcat.

CLEAR gs_fcat.
gs_fcat-fieldname = 'CURRCODE'.
gs_fcat-coltext   = 'Curr'.
gs_fcat-col_pos   = 3.
APPEND gs_fcat TO gt_fcat.

```

---

### 7-7) 월별 합계 컬럼(매크로로 생성)

```abap
add_fcat 'JANSUM' 'Jan'  4.
add_fcat 'FEBSUM' 'Feb'  5.
add_fcat 'MARSUM' 'Mar'  6.
add_fcat 'APRSUM' 'Apr'  7.
add_fcat 'MAYSUM' 'May'  8.
add_fcat 'JUNSUM' 'Jun'  9.
add_fcat 'JULSUM' 'Jul'  10.
add_fcat 'AUGSUM' 'Aug'  11.
add_fcat 'SEPSUM' 'Sep'  12.
add_fcat 'OCTSUM' 'Oct'  13.
add_fcat 'NOVSUM' 'Nov'  14.
add_fcat 'DECSUM' 'Dec'  15.

```

---

### 7-8) ALV 출력(구조 없이 FCAT만)

```abap
CALL METHOD go_alv->set_table_for_first_display
  CHANGING
    it_outtab       = gt_data
    it_fieldcatalog = gt_fcat.

```

---

## 8) ZQUIZ_18 – 강사님 버전(DDIC 참조형 FCAT)

### 특징

- 월 컬럼이 DDIC 구조가 아니라면
    - `REF_TABLE/REF_FIELD`를 이용해 “금액 포맷”을 DDIC 기준으로 맞춤
- 통화 필드 연결: `CFIELDNAME = 'CURRCODE'`

예시(월 컬럼 하나)

```abap
ls_fcat-fieldname  = 'MON01'.
ls_fcat-col_pos    = 4.
ls_fcat-ref_table  = 'SFLIGHT'.
ls_fcat-ref_field  = 'PAYMENTSUM'.
ls_fcat-coltext    = '1월'.
ls_fcat-cfieldname = 'CURRCODE'.
APPEND ls_fcat TO gt_fcat.

```

- `REF_FIELD = PAYMENTSUM` → 금액 포맷/단위 처리 기반
- `CFIELDNAME = CURRCODE` → 통화키 연결

---

## 9) ZQUIZ_18 – 구조(I_STRUCTURE_NAME) 기반 버전

### 특징

- 월별 합계 구조를 DDIC 구조로 만들어둔 경우(예: `ZSPAYMENT_G15`)
- 그 구조명을 `I_STRUCTURE_NAME`로 넘겨서 자동 컬럼 생성

```abap
CALL METHOD go_alv->set_table_for_first_display
  EXPORTING
    i_structure_name = 'ZSPAYMENT_G15'
  CHANGING
    it_outtab        = gt_data.

```

추가로 컬럼명만 바꾸고 싶으면

- `IT_FIELDCATALOG` 같이 써서 `COLTEXT/OUTPUTLEN`만 덮어쓰는 방식으로 처리 가능

---

## 10) Lesson 10에서 제일 중요한 결론

- **기본(ALV 자동)**: 32
- **컬럼 수동 100%**: 33
- **구조 자동 + 일부만 수정**: 34
- **FCAT 자동 생성 + 후처리**: 35
- **집계형(월별 합계)처럼 컬럼이 많을 때**: ZQUIZ_18(매크로/FORM or DDIC 참조형)
