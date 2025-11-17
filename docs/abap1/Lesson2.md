# 🧭 **Lesson 2 - Basic ABAP Language Elements**

## 🔵 Unit1.  **Elementary Data Objects**

1. ABAP Standard Data Types
    1. Complete Type (완전 자료형)
        1. 특정 길이가 지정되어 있어서 길이(LENGTH)나 소수점(DECIMALS)을 지정하지 않아도 되는 타입, 타입 자체가 이미 고정 크기를 가지고 있음
        
        | 데이터 타입 | 설명 | 저장 크기 / 특징 | 예시 값 |
        | --- | --- | --- | --- |
        | **D** | 날짜(Date) | 고정 8자리(YYYYMMDD) | `'20250101'` |
        | **T** | 시간(Time) | 고정 6자리(HHMMSS) | `'153045'` |
        | **I** | 정수(Integer, 4바이트) | -2,147,483,648 ~ 2,147,483,647 | `123` |
        | **INT8** | 8바이트 정수 | 매우 큰 정수 저장 가능 | `999999999999` |
        | **F** | 부동소수점(Float, 8바이트) | IEEE double precision | `3.1415926` |
        | **STRING** | 가변 길이 문자열 | 메모리는 동적 할당 | `'Hello ABAP'` |
        | **XSTRING** | 가변 길이 이진(Binary) | 주로 파일/이미지 저장 | `0xFF01A3...` |
        | **DECFLOAT16** | 고정 소수점(16자리 정밀도) | 고정 십진 부동소수점 | `123.456` |
        | **DECFLOAT34** | 고정 소수점(34자리 정밀도) | 매우 높은 정밀도 | `123456789.987654321` |
    2. Incomplete Type (불완전 자료형)
        1. 특정 길이가 지정되어있지 않아서 **길이(LENGTH나** 소수점(DECIMALS)**)을 지정하지 않으면 의미가 없다**
        
        | 타입 | 의미 | 왜 Incomplete? | 사용 용도 |
        | --- | --- | --- | --- |
        | **C** | 문자 | LENGTH 없으면 1자 → 의미 없음 | 텍스트, 코드 |
        | **N** | 숫자 문자 | LENGTH 없으면 1자리 숫자 | 우편번호, 문서번호 |
        | **X** | 바이트 | LENGTH 없으면 크기 미정 | RAW, 파일 조각 |
        | **P** | Packed 숫자 | LENGTH/DECIMALS 필요 | 금액, 수량 |
2. Local Data Type Definition(로컬 데이터 타입 선언)
    1. 로컬 타입 선언 중 ‘인컴플리트 타입’만 가능한 것
    
    ```json
    "-----------------------------------------------------------
    " Local Type Definitions (Incomplete Data Types Only)
    "-----------------------------------------------------------
    
    TYPES: 
      " Character type (문자)
      ty_name         TYPE c LENGTH 20,
    
      " Numeric text type (숫자 문자)
      ty_customer_no  TYPE n LENGTH 10,
    
      " Hexadecimal / Byte field (바이트)
      ty_raw4         TYPE x LENGTH 4,
    
      " Packed number (금액/수량 등)
      ty_amount       TYPE p LENGTH 7 DECIMALS 2.
    
    ```
    
3. Global Type Definition(글로벌 타입 선언)
    1. 글로벌 타입(Global Type)은 **ABAP Dictionary(SE11)** 에서 정의되며 모든 프로그램에서 재사용 가능한 **시스템 전체 공용 타입**이다. 로컬 타입(TYPES)과 달리 **표준화, 재사용, 일관성**을 위해 생성한다.
    2. 인터널 테이블(Internal Table) 기본 개념
        1. **ABAP 프로그램 메모리 안에서만 존재하는 임시 테이블(배열/리스트/컬렉션)** 이다. 프로그램 내부에서 데이터를 담아두는 메모리 테이블
        2. 틀을 먼저 만든 뒤 테이블 생성됨
            
            
            | 개념 | 설명 |
            | --- | --- |
            | **틀(라인 타입)** | 구조체(Structure) — 테이블의 한 줄 형태 |
            | **인터널 테이블** | 그 구조체를 여러 개 담는 “메모리 테이블” |
            | **먼저 틀 → 그다음 테이블 타입 필요** | 인터널 테이블은 틀 없이는 생성 불가 |
            |  |  |
        3. ABAP 글로벌 변수 네이밍 규칙 (gv_, gs_, gt_)
            1. 예시
                
                
                | 구분 | 예시 | 의미 |
                | --- | --- | --- |
                | **gv_name** | 단일 값(Global Variable) | 문자, 숫자, 날짜 등 1개 값 |
                | **gs_employee** | 구조체(Global Structure) | EMPNO, NAME, DEPT 같은 필드 묶음 |
                | **gt_employee** | 인터널 테이블(Global Table) | STRUCTURE가 여러 줄 반복되는 리스트 |
                
                ```json
                DATA gv_total_count TYPE i.
                DATA gv_user_id     TYPE n LENGTH 10.
                DATA gv_flag        TYPE c LENGTH 1.
                ```
                
            2. TYPE vs LIKE 비교
                1. 핵심 비교 표
                    1. 핵심: LIKE 뒤에는 “데이터 자체”가 아니라 “타입을 가진 것”이 와야 한다
                
                | 구분 | TYPE | LIKE |
                | --- | --- | --- |
                | 의미 | **데이터 타입을 직접 지정** | **다른 변수나 필드의 타입을 따라감** |
                | 뒤에 오는 것 | **스탠다드 타입** (i, c, n, string, p…) OR **DDIC 타입** | **이미 존재하는 변수명 / 구조체 필드명** OR **DDIC 타입(Field)** |
                | 특징 | 길이·소수점 직접 지정 가능 | 타입을 그대로 가져옴(길이 포함) |
                | 용도 | 새로운 타입 정의 | 동일한 형식으로 맞춰야 할 때 |
                
                1) TYPE 사용 예시 (직접 타입 지정)
                
                - TYPE 뒤에는 **문자형, 숫자형, 패킹, 날짜형 등 스탠다드 타입**이 온다.
                - 또는 **DDIC Data Element** 도 올 수 있음.
                
                ```json
                DATA lv_name  TYPE c LENGTH 20.
                DATA lv_count TYPE i.
                DATA lv_amt   TYPE p LENGTH 7 DECIMALS 2.
                ```
                
                2) LIKE 사용 예시 (다른 변수/필드의 타입을 그대로 참조)
                
                - LIKE 뒤에는 **이미 선언된 변수 / 구조체 필드 / DB 테이블 필드** → 즉 **값이 아니라, 그 값의 타입을 가져오는 대상**이 와야 함.
                
                ```json
                DATA lv_name TYPE c LENGTH 20.
                DATA lv_user LIKE lv_name.     " lv_name 과 동일한 타입 (C LENGTH 20)
                ```
                
                3) TYPE vs LIKE 뒤에 무엇이 오는지 정리표
                
                | 문법 | 뒤에 올 수 있는 것 | 예시 |
                | --- | --- | --- |
                | **TYPE** | 스탠다드 타입(I, C, N, P…), STRING, XSTRING | `TYPE c LENGTH 20`, `TYPE i` |
                | **TYPE** | DDIC 타입(Data Element) | `TYPE zde_customer_no` |
                | **LIKE** | **이미 선언된 변수** | `lv_new LIKE lv_old` |
                | **LIKE** | **구조체 필드** | `lv_name LIKE ls_emp-name` |
                | **LIKE** | **DB 테이블 필드** | `lv_carr LIKE sflight-carrid` |
                | **LIKE** | DDIC 참조 필드 (Data Element도 가능) | `lv_carr LIKE s_carrid` |
            
            4) 예시 화면
            
            ![image.png](attachment:41dc2d69-a2f8-4cec-b176-95b7366f6885:image.png)
            
            ![image.png](attachment:a4c95775-bc96-4e50-96e4-ec946fc4eb2f:image.png)
            
4. **ABAP 숫자 저장 구조 (Packed Number, P Type) : Packed Number(P 타입)** 의 내부 구조(정수부 + 소수부 + 부호비트)
    1. 숫자 저장 구조 개념
        1. Packed Number(P)는 **BCD(Binary Coded Decimal)**방식으로 저장되며 아래와 같은 구조를 가집니다.
            
            ```json
            [정수자리] [정수자리] [정수자리] [소수자리] [소수자리] [부호비트]
            ```
            
        2. **정수자리 (Integer part) :** 숫자의 정수 부분이 저장되는 영역
        3. **소수자리 (Decimal part) :** DECIMALS 로 지정한 소수점 이하 자리수 저장 (소수점은 실제 저장되지 않음)
        4. **부호비트 (Sign bit) :** 마지막 1 nibble(4bit)이 + 또는 – 값을 가짐
            
            ```json
            1   2   3   4   5   D
            |   |   |   |   |   └─ 부호(-)  
            |   |   |   └────── 소수부(45)
            └─────────────── 정수부(123)
            ```
            
    2.  왜 알아야 하는가?
        1. Packed Number(P)의 내부 구조를 모르고 선언하면 Overflow(숫자 초과 오류)
    3. 최종 요약
        
        
        | 항목 | 설명 |
        | --- | --- |
        | **정수 자리** | 정수 숫자를 저장하는 공간 |
        | **소수 자리** | DECIMALS 만큼 소수 부 저장 |
        | **부호 비트(Sign Bit)** | 마지막 nibble, +/– 저장 |
        | **소수점은 저장되지 않음** | 숫자만 연속적으로 저장 |
        | **Packed Number는 BCD 방식** | 한 nibble(4bit)에 한 자리 수 |
    4. 2를 항상 곱한다 : 컴퓨터가 2진수 기반이라 자릿수 하나 증가할 때마다 값이 2배가 된다는 뜻 → **X / INT / FLOAT / 메모리 bit 계산** 같은 걸 설명할 때는 메모리는 **2진수** 기반 이라 항상 **"자릿수가 하나 올라가면 ×2 된다"**
        1. 첫 번째 1 → 2³ = **8 /** 두 번째 0 → 2² = **0 /** 세 번째 1 → 2¹ = **2 /** 네 번째 1 → 2⁰ = **1**
        
        ![image.png](attachment:303ab3da-bb3a-4d8f-bc4b-6525589eb2d1:image.png)
        
5. Text Symbols
    1. ABAP 프로그램에서 화면에 표시되는 텍스트(문자열)를 프로그램 코드 밖에서 관리하기 위한 기능
    2. 텍스트를 표시할 때 각 다국어로 표현하고자 할 때 사용하는 것
    3. Text Element 활용 예시 적용 화면 
        
        ![image.png](attachment:42e1cb8e-8899-41b7-b615-6e2086a4b194:image.png)
        

1. Dictionary 사용
    1. ‘where used list’ 사용 화면 
        
        ![image.png](attachment:bc5b26f0-1cb5-41dd-bf87-c1230a0d0e3a:image.png)
        
        ![image.png](attachment:062a4778-b3e4-4c17-99ee-ab30b84309a9:image.png)
        
    
    → 더블 클릭시 해당 작업화면으로 들어감
    
2. 데이터 타입(Data Type)  vs 데이터 오브젝트(Data Object) 정리
    
    
    | 구분 | 데이터 타입 (Data Type) | 데이터 오브젝트 (Data Object) |
    | --- | --- | --- |
    | 역할 | 변수의 **형태와 구조** 정의 | 실제 **메모리 공간(값 저장되는 곳)** |
    | 생성 시기 | 컴파일 타임 또는 DDIC 구성 | 프로그램 실행 시 메모리에 생성 |
    | 예 | TYPE c LENGTH 10, TYPE i | DATA lv_name TYPE c LENGTH 10 |
    | 저장되는 것 | 타입 정보 | 실제 값(데이터) |
    | 존재 방식 | 개념적(정의) | 물리적(메모리 존재) |
    | 필요성 | "이 변수는 어떤 모양으로 만들겠다" | "이 모양대로 실제 변수를 만든다" |
3. Initial Value(기본 초기값)
    1. ABAP 데이터 타입별 Initial Value(기본 초기값)
    
    | 데이터 타입 | 초기값(Initial Value) | 설명 |
    | --- | --- | --- |
    | **C (문자)** | `' '` (공백) | 길이만큼 전부 space |
    | **N (숫자문자)** | `'0'` 반복 | 길이만큼 0으로 채움 |
    | **D (날짜)** | `'00000000'` | 유효하지 않은 초기 날짜 |
    | **T (시간)** | `'000000'` | HHMMSS 전부 0 |
    | **I (정수)** | `0` | 숫자 그대로 0 |
    | **P (Packed)** | `0` | 소수 포함 0.00 형태 |
    | **F (Float)** | `0.0` | 부동소수점 0 |
    | **STRING** | 초기값 없음 → 빈 문자열 | `''` |
    | **X (Byte)** | `00` 반복 | 길이만큼 0 바이너리 |
    | **XSTRING** | 초기값 없음 | 빈 XSTRING |
    | **INT8** | `0` | 8바이트 정수 |
    | **DECFLOAT16/34** | `0` | 고정 소수점 0 |

## 🔵 Unit2. Using Basic ABAP Statementss

### A. 연산자 실습

1. 연산자 계산 실습 1
    1. 코드
        
        ```json
        REPORT ZABAP_03_G01.
        
        DATA : gv_result TYPE p LENGTH 8 DECIMALS 2,
               gv_str TYPE string VALUE 'abcdefghijk'.
        
        NEW-LINE.
        * 나눗셈 연산자들의 비교.
        gv_result = 10 / 4.
        WRITE : '나눗셈 연산자 / 일경우 : ' ,
              gv_result.
        
        NEW-LINE.
        
        gv_result = 10 DIV 4.
        WRITE : '나눗셈 연산자 DIV 일경우 : ' ,
              gv_result.
        
        NEW-LINE.
        * write 구문에 ;다음에 '/'는 NEW-LINE 기능과 같다.
        gv_result = 10 MOD 3.
        WRITE : '연산자 MOD : ' ,
              gv_result.
        
        * 문자열 길이 함수.
        gv_result = strlen( gv_str ).
        NEW-LINE.
        WRITE : '문자열의 길이 : ' , gv_result.
        
        *변수에 할당된 값 삭제.
        clear gv_result
        ```
        
    2. 결과 화면
        
        ![image.png](attachment:b91fce68-2d34-41af-b643-3e4ff2f2ee28:image.png)
        
2. 연산자 계산 퀴즈 1
    1. 코드
        
        ```json
        REPORT ZQUIZ_01_G01.
        
        PARAMETERS pa_amt TYPE I.
        PARAMETERS pa_vat TYPE I.
        DATA gv_RESULT TYPE p LENGTH 8 DECIMALS 2.
        
        gv_RESULT = pa_amt + ( pa_amt * ( pa_vat / 100 ) ).
        
        NEW-LINE.
        WRITE : 'Result : ' , gv_RESULT.
        ```
        
    2. 결과 화면
        
        ![image.png](attachment:fde4b04e-fae6-452b-8cd5-39c906e7ba97:image.png)
        
        ![image.png](attachment:a30c3d3c-d1bd-432f-9040-3b6790d979b3:image.png)
        
    
3. 연산자 계산 퀴즈 2
    1. 코드
        
        ```json
        REPORT ZQUIZ_02_G01.
        
        PARAMETERS pa_radi TYPE I.
        
        DATA gv_RESULT TYPE p LENGTH 8 DECIMALS 2.
        DATA lv_area TYPE decfloat34.
        CONSTANTS gc_pi TYPE p LENGTH 3 DECIMALS 2 VALUE '3.14'.
        
        gv_result = gc_pi * pa_radi ** 2.
        
        NEW-LINE.
        WRITE : '원의 넓이는 : ' , gv_RESULT.
        ```
        
    2. 결과 화면
        
        ![image.png](attachment:e6f26640-2ef3-46d9-a6c0-6f31439d28a4:image.png)
        
        ![image.png](attachment:c1f4995d-a788-41ef-ab23-7e91aa805025:image.png)
        

### B. 조건문 실습

1. ‘sy- ‘ 시작하는 필드 = 시스템 필드(System Fields) 
    1. 조건문, 에러 체크, 루프 제어 등에 자주 사용
    2. ABAP 실행 중 자동으로 SAP 시스템이 값을 넣어주는 필드
    3. 프로그램/사용자 정보
        
        
        | 필드 | 의미 |
        | --- | --- |
        | **sy-uname** | 현재 실행 중인 사용자 ID |
        | **sy-datum** | 오늘 날짜 (YYYYMMDD) |
        | **sy-uzeit** | 현재 시간 (HHMMSS) |
        | **sy-langu** | 사용자 언어 |
        | **sy-mandt** | 클라이언트 번호 |
    4. 프로그램 흐름/메시지
        
        
        | 필드 | 의미 |
        | --- | --- |
        | **sy-subrc** | 가장 최근 실행 명령의 결과 코드 (0 = 성공, 4/8/12 = 실패) |
        | **sy-msgid** | 메시지 ID |
        | **sy-msgty** | 메시지 타입(S/E/I/W 등) |
        | **sy-msgno** | 메시지 번호 |
        | **sy-msgv1~msgv4** | 메시지 변수 |
    5. LOOP / READ / SELECT 관련
        
        
        | 필드 | 의미 |
        | --- | --- |
        | **sy-tabix** | LOOP / READ TABLE 시 현재 row index |
        | **sy-index** | DO / LOOP AT 등 반복문에서 현재 반복 횟수 |
        | **sy-dbcnt** | SELECT / UPDATE 등 DB 작업 후 처리된 row 개수 |
        | **sy-rowno** | 인터널 테이블 처리 시 현재 줄 번호 |
    6. 화면/Selection screen 관련
        
        
        | 필드 | 의미 |
        | --- | --- |
        | **sy-ucomm** | 화면에서 눌린 버튼(Function code) |
        | **sy-dynnr** | 현재 화면 번호 |
        | **sy-repid** | 프로그램 이름 |
        | **sy-batch** | 배치 실행 여부 (X = Background Job) |
    7. 시스템 에러 / 디버깅 정보
        
        
        | 필드 | 의미 |
        | --- | --- |
        | **sy-sysid** | SAP 시스템 ID |
        | **sy-host** | 애플리케이션 서버 이름 |
        | **sy-modno** | 모듈 번호 |
        | **sy-staco** | 스택 번호 |
2. 전체 연산자 한눈에 보기 (올인원 요약표)
    1. 비교 연산자 (Comparison Operators)
        
        
        | 연산자 | 문자형 | 의미 |
        | --- | --- | --- |
        | `=` | EQ | 같다 |
        | `<>` | NE | 다르다 |
        | `>` | GT | 크다 |
        | `<` | LT | 작다 |
        | `>=` | GE | 크거나 같다 |
        | `<=` | LE | 작거나 같다 |
    2. 논리 연산자 (Logical Operators)
        
        
        | 연산자 | 의미 |
        | --- | --- |
        | AND | 그리고 |
        | OR | 또는 |
        | NOT | 아니다 |
    3. 산술 연산자 (Arithmetic Operators)
        
        
        | 연산자 | 의미 | 예시 |
        | --- | --- | --- |
        | `+` | 더하기 | lv = a + b |
        | `-` | 빼기 | lv = a - b |
        | `*` | 곱하기 | lv = a * b |
        | `/` | 나누기(소수 포함) | lv = a / b |
        | `**` | 거듭제곱 | lv = a ** 2 |
        | `iPOW` | 정수 제곱 함수 | lv = iPOW(5, 3) → 125 |
    4. 정수 연산자 (Integer Operators)
        
        
        | 연산자 | 의미 | 예시 |
        | --- | --- | --- |
        | DIV | 정수 나눗셈(몫) | `10 DIV 3 = 3` |
        | MOD | 나머지 | `10 MOD 3 = 1` |
    5. **문자/패턴 연산자 (Character / Pattern Operators)**
        
        
        | 연산자 | 의미 | 설명/예시 |
        | --- | --- | --- |
        | CO | Contains Only | `lv CO 'ABC' → A/B/C로만 구성된 경우` |
        | CN | Contains Not Only | `lv CN 'ABC' → 포함 안 되면` |
        | CA | Contains Any(중 하나라도 포함) | `lv CA 'XYZ' → X/Y/Z 중 하나라도 있으면` |
        | NA | Not Contains Any | `lv NA 'XYZ'` |
        | CP | 패턴 매칭 (LIKE) | `lv CP 'A*'` / `'*@gmail.com'` |
        | NP | 패턴 불일치 | `lv NP '*Z'` |
    6. 문자열 연산자 (String Operators)
        
        
        | 연산자 | 의미 | 예시 |
        | --- | --- | --- |
        | `&&` | 문자열 합치기 | `lv = a && b.` |
        | CONCATENATE | 여러 문자열 결합 | `CONCATENATE a b INTO lv.` |
    7. 특수 조건 연산자 (Special Condition Operators)
        
        
        | 연산자 | 의미 | 예시 |
        | --- | --- | --- |
        | `IS INITIAL` | 초기값인지 | `IF lv IS INITIAL.` |
        | `IS NOT INITIAL` | 초기값 아님 | `IF lv IS NOT INITIAL.` |
        | `BETWEEN` | 범위 포함 | `IF lv BETWEEN 1 AND 10.` |
        | `NOT BETWEEN` | 범위 제외 | `IF NOT lv BETWEEN 1 AND 10.` |
        | `IN` | 리스트 안 포함 | `IF lv IN lt_list.` |
    8. 문법 기반의 흐름 제어용 조건
        
        
        | 연산자/구문 | 역할 | 예시 |
        | --- | --- | --- |
        | CHECK | 조건 불만족 시 바로 리턴 | `CHECK lv > 0.` |
        | EXIT | LOOP 탈출 | `EXIT.` |
        | CONTINUE | LOOP 스킵 | `CONTINUE.` |
        | RETURN | FORM/메서드 종료 | `RETURN.` |
3. 조건문 계산 실습 1
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZABAP_04_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZABAP_04_G01.
        
        * selection screen - Input/Output field.
        PARAMETERS pa_car TYPE s_carr_id.
        
        * pa_car - Input/Output field에 데이터를 입력하지 않고 프로그램 실행 시 1 .
        IF pa_car is INITIAL.
          WRITE: 'Airline Code를 입력하세요'.
        ELSE.
          WRITE: 'Input Airline Code : ', pa_car.
        ENDIF.
        
        * pa_car - Input/Output field에 데이터를 입력하지 않고 프로그램 실행 시 2 .
        IF pa_car is not INITIAL.
        *IF not pa_car is INITIAL. 도 가능.
          WRITE: 'Input Airline Code : ', pa_car.
        ELSE.
          WRITE: 'Airline Code를 입력하세요'.
        ENDIF.
        ```
        
    2. 결과 화면
        1. 아무 것도 쓰지 않을 때
            
            ![image.png](attachment:f95884ea-fe47-4e8b-8355-40b4611bbcf9:image.png)
            
            ![image.png](attachment:c7eda325-a446-41ea-b753-d743efb76b04:image.png)
            
        2. 다른 값을 넣을 때 
            
            ![image.png](attachment:f97bed36-8bd6-4000-be9a-a48fd05a84ef:image.png)
            
            ![image.png](attachment:05508f36-8062-4586-8919-f381844e68d7:image.png)
            
4. 조건문  계산 퀴즈 1
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_03_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_03_G01.
        
        PARAMETERS pa_num TYPE I.
        DATA gv_RESULT TYPE c.
        DATA gv_cal TYPE p LENGTH 8 DECIMALS 2.
        
        gv_cal = pa_num MOD 2.
        
        *if gv_cal > 0 .
        ** gv_RESULT = '홀수'.
        *  WRITE : '해당 수는 홀수입니다.'.
        *  else.
        ** gv_RESULT = '짝수'.
        *  WRITE : '해당 수는 짝수입니다.'.
        *  ENDIF.
        
          if not gv_cal > 0 .
        * gv_RESULT = '홀수'.
          WRITE : '해당 수는 짝수입니다.'.
          else.
        * gv_RESULT = '짝수'.
          WRITE : '해당 수는 홀수입니다.'.
          ENDIF.
        ```
        
    2. 결과 화면
        
        ![image.png](attachment:a3374e66-2634-4f52-8c44-37b005e1d4f9:image.png)
        
        ![image.png](attachment:f0e59739-9c68-46ad-b1f0-06ad0daeaaea:image.png)
        
    
5. 조건문  계산 퀴즈 2
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_02_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_02_G01.
        
        PARAMETERS pa_radi TYPE I.
        PARAMETERS pa_type TYPE c LENGTH 1.
        
        DATA gv1_RESULT TYPE p LENGTH 8 DECIMALS 2.
        DATA gv2_RESULT TYPE p LENGTH 8 DECIMALS 2.
        CONSTANTS gc_pi TYPE p LENGTH 3 DECIMALS 2 VALUE '3.14'.
        gv1_result = gc_pi * pa_radi ** 2.
        gv2_result = gc_pi * pa_radi * 2.
        
        *if문
        IF pa_type = 'S' OR pa_type = 's'.
          WRITE : gv1_result.
        ELSEif pa_type = 'R' OR pa_type = 'r'.
          WRITE : gv2_result.
        ELSE.
          WRITE : 'S또는 R을 입력해주세요.'.
        ENDIF.
        
        *switch문
        DATA lv_type TYPE c LENGTH 1.
        lv_type = pa_type.
        
        TRANSLATE lv_type TO UPPER CASE.
        
        CASE lv_type.
          WHEN 'S'.
            WRITE gv1_result.
        
          WHEN 'R'.
            WRITE gv2_result.
        
          WHEN OTHERS.
            WRITE 'S 또는 R을 입력해주세요.'.
        ENDCASE.
        
        *NEW-LINE.
        *WRITE : '원의 넓이는 : ' , gv_RESULT.
        ```
        
    2. 결과 화면
    
    ![image.png](attachment:a76eef5a-576e-4afe-b499-d95ac210dbbf:image.png)
    
    ![image.png](attachment:bf411264-2c5f-45f3-a7f4-d7a06e18541e:image.png)
    

### C. 반복문 실습

1. 반복문 개요
2. 반복문  계산 실습 1
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZABAP_05_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZABAP_05_G01.
        
        * 반복문 처리 결과 값 - 변수 선언.
        DATA gv_result TYPE i.
        
        * selection screen - 인풋/아웃풋 필드.
        PARAMETERS pa_int TYPE i.
        
        * Do ~ Enddo 반복문.
        DO .
          gv_result = gv_result + sy-index.
        * Loop count (반복 횟수가) 화면에 입력된 값보다 크면 반복 종료.
           IF sy-index >= pa_int.
             exit.
           ENDIF.
        ENDDO.
        
        * DO n TIMES 반복문.
        DO pa_int TIMES.
          gv_result = gv_result + sy-index.
          WRITE / sy-index.
          ULINE.
        ENDDO.
        
        DO 10 TIMES.
          gv_result = gv_result + sy-index.
          WRITE / sy-index.
          ULINE.
        ENDDO.
        
        * while condition endwhile 반복문.
        * condition 참이면 반복, 거짓이면 반복 종료.
        WHILE pa_int >= sy-index.
          gv_result = gv_result + sy-index.
        ENDWHILE.
        
        WRITE : 'Result : ', gv_result.
        ```
        

1. 반복문  계산 퀴즈 1
    1. 코드
        
        ```json
        REPORT ZQUIZ_04_G01.
        
        PARAMETERS pa_num TYPE i.
        DATA gv_RESULT TYPE i.
        
        IF pa_num < 10.
          WRITE: '10 이상의 값을 입력해주세요.'.
          EXIT.
        ENDIF.
        
        DO pa_num TIMES.
        
        * sy-index 가 짝수일 때만 더하기.
          IF sy-index MOD 2 = 0.
            gv_result = gv_result + sy-index.
          ENDIF.
        
        ENDDO.
        
        WRITE: '짝수 합계 결과:', gv_result.
        ```
        
    2. 결과 화면
        
        ![image.png](attachment:7ae176cd-fc86-4aa9-802c-6b4cd3d39e78:image.png)
        
        ![image.png](attachment:baf012ff-87fc-42ca-a688-18a8cb632428:image.png)
