
# 🧭 Lesson 9 - **ABAP Dictionary : 프로그래밍 데이터 타입과 활용**

# 🔵 **Unit 1. ABAP Dictionary 추가 개념**

1. Search Help (서치헬프)
    1. 같은 PARAMETERS / SELECT-OPTIONS라도 해당 필드의 Data Element / Domain의 Search Help가 무엇으로 설정되어 있는지에 따라 F4 화면이 완전히 달라진다.
    2. **그 필드(Data Element / Domain)에 붙어 있는 Search Help(서치헬프)가 다르기 때문**이다.
    3. 속한 테이블/데이터요소가 사용하는 Domain, Search Help, Check Table이 서로 다르기 때문이다.

# 🔵 **Unit 2. Creating Domains and Data Elements**

![image.png](attachment:c980bfea-9b1e-4784-8db4-f2b98b66a2d0:image.png)

## 1. Domain (도메인)

![image.png](attachment:348490cb-9c8c-4ec2-a37c-4df9c3457ae8:image.png)

도메인은 ABAP Dictionary에서 필드의 기술적 속성(Technical Properties)을 정의하는 객체이다.

### 1.1 Domain이 정의하는 요소

- Data Type (CHAR, NUMC, DEC, DATS, TIMS 등)
- Length (필드 길이)
- Value Range (허용되는 값 범위)
    - Fixed Values (단일 값 또는 범위)

### 1.2 Domain의 역할

- 필드의 형식과 길이를 결정한다.
- Value Range가 설정되어 있으면 입력 값 검증도 자동 제공된다.
- 만들어진 Domain은 Data Element (데이터 요소)가 사용한다. (ABAP System에서 사용 X)

---

## 2. Data Element (데이터 요소)

![image.png](attachment:940a1bad-d2ae-446d-817b-511733d97deb:image.png)

데이터 요소는 필드의 의미(Semantics)와 *UI 관련 속성*을 정의하는 객체이다.

도메인이 기술적 속성을 제공한다면, 데이터 요소는 “이 필드가 무엇을 의미하는가”를 설명한다.

### 2.1 Data Element가 제공하는 요소

- Field Label (Short / Medium / Long)
- Documentation
- Search Help 연결(F4 Help)
- Translation (다국어 라벨)
- Parameter ID (SET/GET Parameter 사용 가능)

### 2.2 Data Element의 역할

- 여러 화면(Screen)에서 동일한 필드를 재사용할 때 공통 의미를 보장한다.
- F4 Search Help, 라벨, 번역 등을 한 번에 관리할 수 있다.
- 동일한 데이터 요소를 사용한 모든 프로그램/화면에서 일관된 UI/UX 제공.

---

## 3. Domain과 Data Element의 관계

- Domain → 기술 속성 제공
- Data Element → 의미 제공 + Domain을 참조함
- 하나의 Domain을 여러 Data Element가 공유할 수도 있다.

```abap
Domain: Length=3, Type=CHAR
Data Element: Airline Code (라벨/문서/검색 도움 연결)
필드: SFLIGHT-CARRID, ZTAB-AIRLINE_ID 등에서 재사용
```

---

## 4. 실습 코드 구조 분석

### 4.1. 프로그램 이름

```abap
REPORT ZBC430_G01_DATA_ELEMENTS.

-> Domain → Data Element → ABAP 프로그램에서 TYPE으로 사용
```

이 프로그램은 그룹(G01)이 작성하는 ABAP 실행 프로그램이다.

---

### 4.2. PARAMETERS

여기서 사용되는 TYPE들은 Lesson 1에서 직접 만든 Data Element(Z타입)이다.

```
PARAMETERS: PA_FNAME TYPE ZFIRSTNAME_G01,
            PA_LNAME TYPE ZLASTNAME_G01,
            PA_ACTIV TYPE ZASSETS_G01,
            PA_LIABS TYPE ZLIABILTIES_G01.

```

| 파라미터 | TYPE | 의미 |
| --- | --- | --- |
| PA_FNAME | ZFIRSTNAME_G01 | 이름 (도메인 + 데이터 요소 기반) |
| PA_LNAME | ZLASTNAME_G01 | 성 |
| PA_ACTIV | ZASSETS_G01 | 자산 |
| PA_LIABS | ZLIABILTIES_G01 | 부채 |

정리하면:

- SAP 기본 타입이 아니라
- Lesson 1에서 만든 **Data Element(Z~~)** 를 직접 TYPE으로 사용하고 있다.

---

### 4.3. 내부 변수 선언

```
DATA: RESULT TYPE ZASSETS_G01.
```

순자산 계산 결과도 동일한 Data Element 타입을 사용한다.

---

### 4.4. 실제 로직

4.4.1 사용자 입력 출력

```
WRITE: 'Client:', PA_FNAME, PA_LNAME.
```

4.4.2 순자산 계산

```
RESULT = PA_ACTIV - PA_LIABS.
```

4.4.3 결과 출력

```
WRITE: 'Finance:', PA_ACTIV, PA_LIABS, RESULT.
```

# 🔵 **Unit 3. Creating Structures (Flat Structures, Nested Structures, Table Types, Deep Structures)**

## 1. 구조의 전체 흐름

ABAP Dictionary에서 정의된 객체들은 다음과 같은 단계로 사용된다.

```abap
[Dictionary]

   Domain  ---->  Data Element  ---->  Structure (Flat / Nested)
                                         |
                                         v
                                 Table Type(ITAB) / DB Table
                                         |
                                         v
                                  ABAP Program 변수
```

- **Domain**: 데이터 타입, 길이, 값 범위 등 기술 정보
- **Data Element**: 의미, 텍스트 라벨, F4 검색도움
- **Structure**: 여러 Data Element 또는 Structure를 묶은 논리적 타입
- **Table Type**: Structure 기반의 Internal Table 라인 타입
- **ABAP Program**: `DATA wa TYPE 구조체명` 형태로 사용

---

## 2. Flat Structure (단일 구조)

### 2.1 개념

Flat Structure는 모든 필드가 **한 단계(1-Level)**로 구성된 구조체로,

구조 내부에 다른 구조체가 포함되지 않는다.

### 2.2 구성 예

Structure: **ADDRESS**

| Field | Type |
| --- | --- |
| STREET | ZSTREET |
| ZIPCODE | ZZIPCODE |
| CITY | ZCITY |

### 2.3 ABAP 사용 예

```
DATA wa_adr TYPE address.

wa_adr-street  = 'Neurott Str. 15a'.
wa_adr-zipcode = 'D-69190'.
wa_adr-city    = 'Walldorf'.
```

### 2.4 Flat Structure 특징 요약

- 모든 필드가 Data Element
- 중첩 구조 없음
- 접근 방식: `구조명-필드명`
- 단순한 데이터 집합에 적합

---

## 3. Nested Structure (중첩 구조)

### 3.1 개념

Nested Structure는 구조 내부에 **또 다른 Structure 타입의 컴포넌트**가 포함된 형태이다.

접근 방식은 `상위구조-하위구조-필드`와 같이 계층이 깊어진다.

### 3.2 구성 예

Structure: **NAME**

| Field | Type |
| --- | --- |
| FIRSTNAME | ZFIRSTNAME |
| LASTNAME | ZLASTNAME |

Structure: **ADDRESS**

| Field | Type |
| --- | --- |
| STREET | ZSTREET |
| ZIPCODE | ZZIPCODE |
| CITY | ZCITY |

Structure: **PERSON**

| Component | Type |
| --- | --- |
| NAME | NAME (Structure) |
| ADDRESS | ADDRESS (Structure) |

### 3.3 ABAP 사용 예

```
DATA wa_pers TYPE person.

wa_pers-name-firstname  = 'Hans'.
wa_pers-address-city    = 'Walldorf'.
```

### 3.4 Nested Structure 특징 요약

- 구조 내부에 Structure 포함
- 계층화된 필드 접근
- 복합 엔티티 표현에 적합

---

## 4. Deep Structure

### 4.1 개념

Deep Structure는 구조 내부에 Table Type(내부 테이블)이 포함된 구조이다.

Table Type은 2차원 구조이므로 포함하는 순간 Structure 전체가 Deep Structure가 된다.

### 4.2 구성 예

```
S_FLIGHT_INFO
  CARRID
  CONNID
  BOOKING (Table Type)
```

---

## 5. Flat / Nested / Deep 비교

| 유형 | 포함 요소 | 계층 수준 | 예시 | 접근 방식 |
| --- | --- | --- | --- | --- |
| Flat | Data Element만 포함 | 1단계 | ADDRESS | `wa-field` |
| Nested | Structure 포함 | 2단계 이상 | PERSON | `wa-struct-field` |
| Deep | Table Type 포함 | 2차원 포함 | S_FLIGHT_INFO | `wa-tab[index]-field` |

---

## 📂 6. 실제 사례: ZSCARR_G01 Structure 분석 (1)

![image.png](attachment:44f095a2-3b37-4637-8d06-65c3aa475253:image.png)

ZSCARR_G01은 Connection 정보를 담는 구조체로,

Data Element와 Structure 두 종류 모두를 포함하는 **Nested Structure**이다.

### 6.1 전체 구성 표

| Component | Component Type | 실제 타입 | 설명 |
| --- | --- | --- | --- |
| CARRID | S_CARR_ID | Data Element | Airline Code |
| CONNID | S_CONN_ID | Data Element | Flight Connection Number |
| CITY | ZSCONN_G01 | **Structure** | 도시·공항 정보 묶음 |
| .INCLUDE | ZSCURRENCY_G01 | **Structure** | 통화 및 기타 속성 |
| CARRNAME | S_CARRNAME | Data Element | Airline name |
| CURRCODE | S_CURRCODE | Data Element | Local currency of airline |

---

### 6.2 CITY가 포함하는 Sub-Structure (ZSCONN_G01)

ZSCONN_G01 구조는 아래의 네 개 필드를 가진 구조체이다.

| Field | Type | 설명 |
| --- | --- | --- |
| CITYFROM | S_FROM_CITY | 출발 도시 |
| AIRPFROM | S_FROM_AIRP | 출발 공항 |
| CITYTO | S_TO_CITY | 도착 도시 |
| AIRPTO | S_TO_AIRP | 도착 공항 |

따라서 CITY는 단일 필드가 아니라,

4개의 필드를 가진 **중첩 구조체 필드**이다.

---

### 6.3 ZSCARR_G01 구조 도식

```
ZSCARR_G01
 ├─ CARRID          (DE)
 ├─ CONNID          (DE)
 ├─ CITY            (STRUCT ZSCONN_G01)
 │      ├─ CITYFROM
 │      ├─ AIRPFROM
 │      ├─ CITYTO
 │      └─ AIRPTO
 ├─ INCLUDE ZSCURRENCY_G01  (STRUCT)
 │      ├─ (통화 관련 필드들)
 ├─ CARRNAME        (DE)
 └─ CURRCODE        (DE)
```

---

### 6.4 요약

1. Structure는 여러 Data Element 또는 Structure를 묶어 사용하는 타입이다.
2. Flat Structure는 단순 필드(Data Element)만 포함한다.
3. Nested Structure는 Structure를 컴포넌트로 포함한다.
4. Deep Structure는 Table Type을 포함한다.
5. ZSCARR_G01은 **CITY(Structure) + INCLUDE(Structure)** 두 요소 때문에 Nested Structure에 해당한다.

## 📂 7. 실제 사례: Nested Structure ABAP Program (2)

아래 프로그램은 Nested Structure를 실제 ABAP에서 어떻게 사용하는지 보여주는 예시이다.

### 7.1 프로그램 코드 (원본 + 주석 설명)

```abap
*&---------------------------------------------------------------------*
*& Report  SAPBC430S_STRUCT_NESTED                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
*&  Nested Structure를 ABAP 코드에서 사용하는 예제                    *
*&---------------------------------------------------------------------*

REPORT  zbc400_g01_struct_nested.

" 내부 변수 선언: zpersong01 구조를 기반으로 Work Area 생성
DATA wa_person TYPE zpersong01.

START-OF-SELECTION.

  " 하위 구조 NAME 내부 필드에 값 할당
  wa_person-name-firstname = 'Harry'.
  wa_person-name-lastname  = 'Potter'.

  " 동일한 최상위 구조에 포함된 주소 관련 필드에 값 할당
  wa_person-street = 'Privet Drive'.
  wa_person-nr     = '3'.
  wa_person-zip    = 'GB-10889'.
  wa_person-city   = 'London'.

  " 값 출력
  WRITE: / wa_person-name-firstname,
           wa_person-name-lastname,
           wa_person-street,
           wa_person-nr,
           wa_person-zip,
           wa_person-city.
```

---

### 7.2 사용된 구조: ZPERSONG01 분석

ZPERSONG01은 다음과 같은 구성으로 이루어진 Nested Structure이다.

### 7.2.1 전체 구성 표

| Component | Component Type | 실제 타입 | 설명 |
| --- | --- | --- | --- |
| NAME | ZNAME_G01 | **Structure** | 이름 정보 구조 |
| STREET | ZSTREET_G01 | Data Element | 주소: 거리명 |
| NR | ZHOUSENUM_G01 | Data Element | 주소: 번지 |
| ZIP | ZZIPCODE_G01 | Data Element | 우편번호 |
| CITY | ZCITY_G01 | Data Element | 도시 |

→ NAME 때문에 **Nested Structure**로 분류된다.

---

### 7.3 Sub-Structure: ZNAME_G01 구성

ZNAME_G01은 이름 정보를 담는 Structure이다.

| Field | Type | 설명 |
| --- | --- | --- |
| FIRSTNAME | ZFIRSTNAME_G01 | 이름 |
| LASTNAME | ZLASTNAME_G01 | 성 |

따라서 ABAP에서는 다음과 같이 접근한다:

```
wa_person-name-firstname
wa_person-name-lastname
```

---

### 7.4 구조 도식

```
ZPERSONG01
 ├─ NAME (STRUCT ZNAME_G01)
 │     ├─ FIRSTNAME
 │     └─ LASTNAME
 ├─ STREET (DE)
 ├─ NR (DE)
 ├─ ZIP (DE)
 └─ CITY (DE)
```

---

### 7.5 ABAP 실행 시 결과 흐름

1. NAME 구조 내부에 FIRSTNAME, LASTNAME 값을 넣음
2. STREET, NR, ZIP, CITY는 동일한 최상위 레벨에서 직접 값 할당
3. WRITE 구문으로 순서대로 출력

---

### 7.6 요약

1. 프로그램은 **Nested Structure(ZPERSONG01)**를 Work Area로 사용한다.
2. NAME은 Structure 타입이기 때문에 **2단계 접근 방식**(`wa_person-name-firstname`)을 사용한다.
3. 나머지 필드는 모두 Data Element이므로 1단계 접근 방식(`wa_person-city`)을 사용한다.
4. Nested Structure를 ABAP에서 실제로 어떻게 다루는지 쉽게 확인할 수 있는 기본 예제이다.

## 📂 8. 실제 사례: Data Elements 사용 ABAP Program (3)

아래 프로그램은 ABAP Dictionary에서 생성한 **Data Element 기반의 타입**을

ABAP PARAMETERS / DATA 구문에서 어떻게 사용하는지 보여주는 예제이다.

### 8.1 프로그램 코드 (원본 + 주석 설명)

```abap
*&---------------------------------------------------------------------*
*& Report  SAPBC430S_DATA_ELEMENTS                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
*&  Data Element를 PARAMETERS와 변수 타입으로 사용하는 예제          *
*&---------------------------------------------------------------------*

REPORT  ZBC430_G01_DATA_ELEMENTS.

" 계산 결과를 저장할 변수: ZASSETS_G01 데이터 요소 사용
DATA: RESULT TYPE ZASSETS_G01.

" 입력 파라미터 정의: 모두 Data Element 기반 타입
PARAMETERS: PA_FNAME TYPE ZFIRSTNAME_G01,
            PA_LNAME TYPE ZLASTNAME_G01,
            PA_ACTIV TYPE ZASSETS_G01,
            PA_LIABS TYPE ZLIABILTIES_G01.

START-OF-SELECTION.

  " 클라이언트 이름 출력
  NEW-LINE.
  WRITE: 'Client:', PA_FNAME, PA_LNAME.

  " 순자산 계산 (자산 - 부채)
  RESULT = PA_ACTIV - PA_LIABS.

  " 자산 / 부채 / 순자산 출력
  NEW-LINE.
  WRITE: 'Finance:', PA_ACTIV, PA_LIABS, RESULT.
```

---

### 8.2 사용된 Data Element 구성

프로그램에서 사용되는 모든 타입은 **직접 만든 Data Element(Z~)** 기반이다.

| 변수/파라미터 | Data Element | 설명 |
| --- | --- | --- |
| RESULT | ZASSETS_G01 | 자산 값(금액) |
| PA_FNAME | ZFIRSTNAME_G01 | 고객 이름 |
| PA_LNAME | ZLASTNAME_G01 | 고객 성 |
| PA_ACTIV | ZASSETS_G01 | 자산(Assets) |
| PA_LIABS | ZLIABILTIES_G01 | 부채(Liabilities) |

Data Element에는 다음 정보가 포함되어 있다.

- 기술 속성: Type, Length
- 의미 정보: Short/Medium/Long Labels
- UI 정보: F4 Search Help 등
- Parameter ID(있을 경우)

---

### 8.3 프로그램 동작 흐름 도식

```
사용자 입력
   ↓
PARAMETERS (Data Element 타입)
   ↓
계산 결과 저장 (RESULT)
   ↓
자산 - 부채 계산
   ↓
WRITE로 출력
```

---

### 8.4 처리 로직 상세

1. 사용자가 화면에서
    - 이름
    - 성
    - 자산
    - 부채
        
        값을 입력한다.
        
2. ABAP Dictionary에서 정의한 Data Element 타입이
    
    PARAMETERS 필드에 적용된다.
    
3. 자산(PA_ACTIV) - 부채(PA_LIABS)를 계산하여
    
    RESULT 변수에 저장한다.
    
4. 최종적으로 다음 세 값이 출력된다.
    - PA_ACTIV
    - PA_LIABS
    - RESULT

---

### 8.5 요약

1. 이 예제는 **Data Element를 ABAP 프로그램의 타입으로 직접 사용하는 방법**을 보여준다.
2. PARAMETERS 구문은 화면 입력값을 Data Element의 규칙(타입/길이/라벨)에 따라 자동 처리한다.
3. 계산식 `RESULT = PA_ACTIV - PA_LIABS`는 Data Element의 Numeric 타입을 활용한다.
4. WRITE 구문으로 문자열 + 변수 출력이 가능하다.
5. 전체 프로그램은 Data Element의 재사용성 및 의미 구조를 보여주는 기본 실습 사례이다.

## 📂 9. 실제 사례: Internal Table 정렬 ITAB_SORTED Program (4)

다음 프로그램은 **Database Read → Internal Table 저장 → 정렬 테이블 출력** 과정을 통해

ABAP에서 Internal Table을 다루는 기본 방식(Sorted ITAB)을 보여주는 예제이다.

### 9.1 프로그램 코드 (원본 + 설명 포함)

```abap
*&---------------------------------------------------------------------*
*& Report  SAPBC430S_ITAB_SORTED                                       *
*&---------------------------------------------------------------------*
*&  Internal Table를 읽고 정렬하여 출력하는 예제                       *
*&---------------------------------------------------------------------*

REPORT  ZBC430_G01_ITAB_SORTED.

" Internal Table 및 Work Area 선언
DATA it_flight TYPE zit_sflightg01.   " Z 구조 기반 Internal Table
DATA wa_sflight TYPE sflight.         " Work Area (SFLIGHT 단일 행)

"------------------------------
" 1) 데이터베이스 순서 그대로 출력
"------------------------------
WRITE / 'Printout in tableorder of Database:'.

SELECT * FROM sflight
  INTO wa_sflight
  WHERE carrid = 'JL'.

  WRITE: / wa_sflight-carrid,
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDSELECT.

ULINE.

"------------------------------
" 2) DB 결과를 Internal Table에 담고, 정렬된 순서로 출력
"------------------------------

SELECT * FROM sflight
  INTO TABLE it_flight
  WHERE carrid = 'JL'.

WRITE / 'Printout in tableorder of sorted ITAB:'.

LOOP AT it_flight INTO wa_sflight.
  WRITE: / wa_sflight-carrid,
           wa_sflight-connid,
           wa_sflight-fldate,
           wa_sflight-price,
           wa_sflight-currency,
           wa_sflight-planetype.
ENDLOOP.
```

---

### 9.2 사용된 타입 정의

| 변수 | 타입 | 설명 |
| --- | --- | --- |
| it_flight | ZIT_SFLIGHTG01 | SFLIGHT 기반 커스텀 Internal Table |
| wa_sflight | SFLIGHT | 단일 행 구조(Work Area) |

ZIT_SFLIGHTG01은 보통 다음 요소를 가진다.

- Line Type: SFLIGHT 구조
- Key: CARRID, CONNID, FLDATE 등
- Table Kind: SORTED TABLE 또는 STANDARD TABLE
    
    (교육 과정에서 Sorted Table로 정의하는 경우가 많음)
    

---

### 9.3 프로그램 처리 흐름 도식

```
1) SELECT ... ENDSELECT
       ↓
   DB에서 읽은 순서대로 출력

2) SELECT INTO TABLE
       ↓
   Internal Table(it_flight)에 전체 저장
       ↓
   Sorted Table 속성에 따라 자동 정렬됨
       ↓
   LOOP로 정렬된 결과 출력
```

---

### 9.4 핵심 동작 설명

### (1) SELECT ... ENDSELECT

- 데이터베이스의 물리적 순서에 따라 한 줄씩 읽어서 출력한다.
- 이 부분은 **정렬되지 않은 원본 DB 순서**이다.

### (2) SELECT INTO TABLE

- 같은 조건(carrid = ‘JL’)으로 전체 데이터를 Internal Table에 담는다.
- it_flight가 **SORTED TABLE**이면
    
    → 자동으로 Primary Key 기준 정렬이 적용된다.
    

### (3) LOOP AT it_flight

- Internal Table에 저장된 항목을 정렬된 순서로 출력한다.

---

### 9.5 출력 비교

| 단계 | 정렬 여부 | 기준 |
| --- | --- | --- |
| SELECT … ENDSELECT | 정렬 없음 | DB 물리적 순서 |
| SELECT … INTO TABLE → LOOP | **정렬 있음** | Internal Table의 Key 기준 |

Sorted Table의 Key는 교육 실습 기준으로

`CARRID + CONNID + FLDATE` 조합일 가능성이 높다.

---

### 9.6 요약

1. SELECT … ENDSELECT → DB의 실제 순서대로 출력된다.
2. SELECT INTO TABLE → Internal Table(ZIT_SFLIGHTG01)에 정렬 기준에 맞게 자동 정렬된다.
3. LOOP AT 출력 시 **Sorted ITAB 기준 순서**로 출력된다.
4. 이 예제는 ABAP Internal Table이 가진 **정렬 기능**과 **SELECT 방식 차이**를 보여주는 기본 실습이다.

## 📂 10. 실제 사례: Deep Structure + Internal Table Program (5)

아래 프로그램은 **Nested Structure(ZPERSONG00)**와 그 내부에 존재하는 **Table Type 컴포넌트(PHONE)**에 여러 라인을 추가하는 정식 Deep Structure 실습 예제이다.

### 10.1 프로그램 코드 (원본 + 설명 포함)

```abap
*&---------------------------------------------------------------------*
*& Report  SAPBC430S_STRUCT_NESTED                                     *
*&---------------------------------------------------------------------*
*&  Deep Structure: Structure + Internal Table 포함 실습               *
*&---------------------------------------------------------------------*

REPORT zbc430_g01_struct_deep.

" Deep Structure의 Work Area
DATA wa_person TYPE zpersong01.

" PHONE 구조(Internal Table 라인 타입) Work Area
DATA wa_phone TYPE str_phone.

START-OF-SELECTION.

  " 1) Nested Structure 부분 (NAME 구조 내부 필드)
  WA_PERSON-NAME-FIRSTNAME = 'Harry'.
  WA_PERSON-NAME-LASTNAME  = 'Potter'.

  " 2) Flat Structure 부분 (주소 관련 단일 필드)
  WA_PERSON-STREET = 'Privet Drive'.
  WA_PERSON-NR     = '3'.
  WA_PERSON-ZIP    = 'GB-10889'.
  WA_PERSON-CITY   = 'London'.

  " 3) Deep Structure 부분: PHONE(Internal Table)에 여러 라인 추가
  WA_PHONE-P_TYPE   = 'TEL'.
  WA_PHONE-P_NUMBER = '051-252-2562'.
  APPEND WA_PHONE TO WA_PERSON-PHONE.

  WA_PHONE-P_TYPE   = 'FAX'.
  WA_PHONE-P_NUMBER = '051-252-2569'.
  APPEND WA_PHONE TO WA_PERSON-PHONE.

  WA_PHONE-P_TYPE   = 'MOB'.
  WA_PHONE-P_NUMBER = '010-252-2562'.
  APPEND WA_PHONE TO WA_PERSON-PHONE.

  " 4) 출력
  WRITE: / WA_PERSON-NAME-FIRSTNAME,
           WA_PERSON-NAME-LASTNAME,
           WA_PERSON-STREET,
           WA_PERSON-NR,
           WA_PERSON-ZIP,
           WA_PERSON-CITY.
  ULINE.

  LOOP AT WA_PERSON-PHONE INTO WA_PHONE.
    WRITE: AT 35 WA_PHONE-P_TYPE,
                 WA_PHONE-P_NUMBER.
    NEW-LINE.
  ENDLOOP.
```

---

### 10.2 사용된 구조: ZPERSONG00 분석

ZPERSONG00은 다음 세 가지 요소를 모두 포함하는 **Deep Structure**이다.

### 구성 요소

| Component | Type | 실제 타입 | 설명 |
| --- | --- | --- | --- |
| NAME | ZNAME_G01 | **Structure** | 하위 구조 (FIRSTNAME/LASTNAME) |
| STREET | ZSTREET_G01 | Data Element | 거리명 |
| NR | ZHOUSENUM_G01 | Data Element | 번지 |
| ZIP | ZZIPCODE_G01 | Data Element | 우편번호 |
| CITY | ZCITY_G01 | Data Element | 도시 |
| PHONE | STR_PHONE_TAB | **Table Type** | 전화번호(Internal Table) |

> PHONE이 Table Type이므로 이 전체 구조는 Flat/Nested가 아닌
> 
> 
> **Deep Structure**로 분류된다.
> 

---

### 10.3 PHONE Structure (STR_PHONE)

PHONE은 Internal Table 라인 타입이며, 다음과 같이 구성된다.

| Field | Type | 설명 |
| --- | --- | --- |
| P_TYPE | ZPHONETYPE_G01 | TEL/FAX/MOB 등 전화 종류 |
| P_NUMBER | ZPHONENUM_G01 | 실제 번호 |

WA_PERSON-PHONE 은 **Internal Table**이며,

WA_PHONE 은 그 **라인 타입(Structure)** 이다.

---

### 10.4 Deep Structure 도식

```
ZPERSONG00
 ├─ NAME (STRUCT ZNAME_G01)
 │     ├─ FIRSTNAME
 │     └─ LASTNAME
 ├─ STREET (DE)
 ├─ NR (DE)
 ├─ ZIP (DE)
 ├─ CITY (DE)
 └─ PHONE (ITAB: STR_PHONE_TAB)
        ├─ P_TYPE
        ├─ P_NUMBER
        ├─ (여러 라인 추가 가능)
```

---

### 10.5 프로그램 실행 흐름

```
1) wa_person 생성
   - Nested Structure(NAME)
   - Flat Structure(STREET, NR, ZIP, CITY)
   - Deep Component(PHONE ITAB)

2) NAME 구조 내부 필드 값 입력

3) 주소 필드 값 입력

4) PHONE ITAB에 TEL/FAX/MOB 라인 추가 (APPEND)

5) 메인 필드 출력 후 PHONE ITAB LOOP 출력
```

---

### 10.6 출력 형식

출력은 다음과 같은 구조로 표현된다.

```
Harry Potter Privet Drive 3 GB-10889 London
--------------------------------------------
                                  TEL 051-252-2562
                                  FAX 051-252-2569
                                  MOB 010-252-2562
```

---

### 10.7 요약

1. ZPERSONG00은 **Nested Structure + Internal Table**을 포함하는 **Deep Structure**이다.
2. PHONE은 Table Type이므로 여러 라인(APPEND)을 추가할 수 있다.
3. NAME은 Structure, 나머지 주소는 Data Element 기반이다.
4. 출력은
    - 첫 줄: Nested + Flat 필드 출력
    - 이후: PHONE Internal Table 라인 LOOP 출력
5. Deep Structure의 구조적 특징과 ABAP에서사용 방식을 보여주는 기본 예제이다.

# 🔵 **Unit 4. Creating Transparent Tables**

1. Transparent Table
    1. Transparent Table의 특징
        - ABAP Dictionary에 존재하는 테이블 정의(table definition)가
            
            데이터베이스의 실제 테이블 형태와 **완전히 동일하게 매핑**된다.
            
        - 필드 이름, 데이터 타입, 길이, 키 등 모든 정의가 DB 스키마로 그대로 전달된다.
        - ABAP 프로그램에서 SELECT, INSERT, UPDATE와 같은 SQL 처리를 수행할 수 있다.
    2. Technical Settings :  테이블 정의(table definition)가 DB에 실제로 어떻게 만들어질지 결정
        1. **Data Class : Data Class는 테이블의 데이터가 DB의 어떤 Tablespace에 저장될지를 결정**
        2. **Size Category : 해당 테이블에 얼마나 많은 레코드가 저장될지 예상하는 값 → 데이터 예상량에 따른 용량 계획**
        3. **Buffering Settings :** 자주 조회하는 테이블은 매번 DB로 가지 않고 **WAS 메모리에서 바로 읽음** → 속도 극대화
        4. Technical Settings가 동작하는 방식 (ABAP → WAS → DB) 
            
            ```abap
            SE11에서 테이블 정의(table definition) 저장  
                  ↓
            Technical Settings에서 Data Class/Size/Buffering 지정  
                  ↓
            테이블 활성화(Activate)  
                  ↓
            WAS가 DB에 테이블을 생성/변경하는 DDL 명령 실행
                  ↓
            DB에 실제 테이블 스키마 생성 또는 업데이트
                  ↓
            WAS의 테이블 버퍼 설정 적용
            ```
            
    3. Create Tables in the ABAP Dictionary 실습 1
        1. 필수적으로 가장 처음에는 클라이언트 즉 MANDT가 와야 한다.
            
            ![image.png](attachment:a80bbf58-b6ea-4d4b-aa4e-de1c9ede9a09:image.png)
            
        2. 나머지 필드 작성 및 primary key 설정
            
            ![image.png](attachment:c818a5ea-0178-453f-9143-8149c1a0e13e:image.png)
            
        3. currency/quantity fields 에 화폐 단위나 수량 단위 참고할 수 있게 설정 
            
            ![image.png](attachment:ba14b40b-c81b-43b9-9a37-b6dca93b7d35:image.png)
            
        4. 나머지 세팅
            
            ![image.png](attachment:8ad14eca-5cf7-4d6a-87e0-f27cd4b3fc65:image.png)
