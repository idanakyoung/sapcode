# 🧭 Lesson 11 - **Dictionary Object Dependencies & Table Changes & Views and Maintenace Views**

# 🔵 **Unit 1. ABAP Dictionary Object**

1. SAP DDIC – Active Version & Inactive Version
    1. SAP Dictionary 오브젝트(SE11) → 항상 **두 가지 버전** 존재
        1. **Active Version(활성 버전)** → 시스템에서 실제로 사용되는 버전
        2. **Inactive Version(비활성 버전)** → 수정했지만 아직 활성화(Activate)되지 않은 버전
    2. Active Version (활성 버전) : 현재 시스템에서 실제 운영되는 버전
    3. Inactive Version (비활성 버전) : 개발자가 잠시 임시로 만든 변경본

# 🔵 **Unit 2. Identifying Dependencies with ABAP
Dictionary Objects**

![image.png](attachment:b456e2b0-30cc-4602-9cdc-297b12574bb4:image.png)

1. SAP Data Dictionary(DDIC) 오브젝트들은 서로 계층적으로 연결되어 있으며, 한 오브젝트를 수정하면 상위 또는 하위 오브젝트가 영향을 받을 수 있다.
2. Domain
    - DDIC 오브젝트 중 가장 기초적인 정의 단위
    - 데이터 타입, 길이, 값 범위(Value Range) 등을 정의
    - 예: CHAR 10, NUMC 3, DEC 11(2)
3. Data Element
    - Domain을 기반으로 필드의 의미(semantic)를 정의
    - 필드 레이블, 검색 도움(Search Help) 등 추가 정보 포함
    - 한 개 이상의 Data Element가 동일 Domain을 사용할 수 있음
4. Structure 및 Table
    1. Structure
        - 데이터 요소(Data Element)로 구성되는 논리적 구조
        - DB에는 생성되지 않으며 프로그램에서 타입 정의 등으로 사용됨
    2. Table
        - 실제 데이터가 저장되는 물리 테이블
        - 각 필드는 하나의 Data Element를 참조
        - 테이블 변경 시 DB 구조에도 변화가 발생
5. 테이블 간 관계 (contains)
    - 테이블은 다른 구조나 테이블의 필드를 포함할 수 있음
    - 예:
        - Include Structure 사용
        - Foreign key 관계
        - View나 Join을 통해 논리적 연결
6. Program 레벨
    - ABAP 프로그램은 Table 또는 Structure를 사용하여 데이터를 처리
    - SELECT문, 변수 타입 정의 등에서 DDIC 오브젝트를 참조
    - Programs → Table/Structure → Data Element → Domain 순으로 종속됨
7. Where-Used List
    
    → Where-Used List는 특정 오브젝트가 어디에서 사용되는지 추적하는 기능이다.
    
    DDIC 오브젝트에서 F7 또는 메뉴를 통해 확인할 수 있다.
    
    예시:
    
    - Domain 기준 → 어떤 Data Element가 참조하는지
    - Data Element 기준 → 어떤 테이블 필드가 사용하는지
    - Table 기준 → 어떤 프로그램에서 조회하거나 선언하는지
    
    즉, Domain부터 Program까지 전체 의존 구조를 역으로 추적해 올라가는 기능이다.
    
    ![image.png](attachment:3ca180ae-894c-4818-b9ef-fc818b56684b:image.png)
    

# 🔵 **Unit 3. Table Changes**

## ⚪ Topic A. Performing a Table Conversion

**테이블 변환(table conversion)**을 수행하는 방법과 변환 과정에서 발생할 수 있는 오류를 처리하는 방법

1. Changes to Database Tables
    1. ABAP 프로그램은 **항상 Active Version** 기준으로 DB 테이블을 읽고 사용한다.
    2. Table을 변경하고 Activate할 때, 시스템은 데이터베이스에 변경을 반영할지(ALTER TABLE, 변환 필요 등) 판단한다.
2. Structure Adjustment in the ABAP Dictionary
    
    1) 테이블을 삭제 후 재생성
    
    - DB 테이블을 삭제하고
    - Dictionary의 Active Version을 기준으로 다시 생성
    - 테이블 내용은 삭제됨 (데이터 유실)
    
    2) ALTER TABLE 로 구조 변경
    
    - DB 테이블 정의를 직접 변경
    - 기존 데이터는 유지
    - 경우에 따라 인덱스는 재생성해야 할 수 있음
    
    3) 테이블을 변환(conversion)
    
    - 가장 시간이 많이 소요되는 방식
    - DB 시스템이 ALTER TABLE을 지원하지 않을 경우 사용
    - 대량 데이터가 있을 경우 매우 오래 걸릴 수 있음
    
    데이터 존재 여부에 따른 처리
    
    - **데이터 없음** → 삭제 후 새 구조로 즉시 생성
    - **데이터 존재** → ALTER TABLE 또는 Conversion 수행
    
    주의할 점
    
    - 변환 과정에서는 테이블을 사용하는 모든 프로그램을 중단해야 함
    - 변환 중 데이터 구조가 일시적으로 일치하지 않기 때문에 잘못된 동작이 발생할 수 있음

1. The Table Conversion Process : 테이블을 변환할 때 SAP 시스템이 어떤 절차를 사용하는지는 다음 요소에 따라 달라진다.
    1. 테이블을 변환할 때 SAP 시스템이 어떤 절차를 사용하는지는 다음 요소에 따라 달라진다.
        - 구조 변경의 종류
        - 사용 중인 데이터베이스 시스템
        - 테이블에 데이터가 있는지 여부
    2. 예시 설명 : 특정 테이블 TAB에서 Field 3의 길이를 60 → 30으로 축소했다고 가정.
    - Dictionary에는
        - Active Version: Field 3 → 길이 60
        - Inactive Version: Field 3 → 길이 30
    - DB의 실제 테이블은 Active Version과 동일 (길이 60)
    
    이 상황에서 활성화(Activate)를 수행하면 시스템은 구조를 비교하고 변환이 필요한지 판단한다.
    

🔴 에러 발생 - Active  오류 해결 ( 데이터가 있을 경우 조정 및 액티브 활성화)

1. 주의할 점 : Delete data 눌러서 조정하지 말기 → 모든 Client의 데이터가 다 삭제됨

![image.png](attachment:25e533cf-642d-48d1-83b7-1132c0875df2:image.png)

![image.png](attachment:8a050bda-cb6e-4978-a873-4a14b5e803a1:image.png)

## ⚪ Topic B. Enhancing Tables with Append Structures

1. 개요
    1. Append Structure는 SAP에서 **표준 테이블(standard table)**을 수정하지 않고도 **필드를 추가하여 확장**할 수 있도록 하는 메커니즘이다. 표준 객체를 직접 수정하는 것은 권장되지 않기 때문에, SAP는 ‘Append’라는 안전한 확장 방식을 제공한다.
2. Append Structure란?
    1. 기존 테이블이나 구조를 확장하기 위해 **추가 필드를 별도의 구조로 정의**하는 방식
    2. 필드 명명 규칙
        - 필드 이름은 **"ZZ" 또는 "YY"로 시작**해야 함
        - 고객 필드임을 의미
    3. Append Structure 내부 동작
        1. SAP 표준 테이블 기본 필드 로드
        2. Append Structure 검색
        3. Append Structure의 필드가 표준 필드 뒤에 “붙여서” 병합됨
        4. 최종 구조가 DB 및 프로그램에 제공됨 → Activate
    4. Append Structure 적용 시 주의 사항
        - 테이블 필드 길이 또는 타입 변경은 Append 구조에서는 불가
        - SAP Upgrade 시 Append는 자동 병합
        - 동일 필드명 중복 불가
        - 대량 데이터가 있는 테이블에 Append 추가 시 구조 조정 시간 증가 가능
3. 실습 1
    1. 예시 구조체(Structure)
        
        ![image.png](attachment:5a7f032c-f62a-4e54-b503-9ac8cf0ed641:image.png)
        
    2. 코드
        
        ```abap
        *&---------------------------------------------------------------------*
        *& Report ZABAP_23_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZABAP_23_G01.
        
        * Structure Variable.
        DATA GS_DEPT TYPE ZDEPMENTG01.
        
        GS_DEPT-CARRIER = 'AA'.
        GS_DEPT-DEPARTMENT = 'ADMI'.
        GS_DEPT-TELNR = '02-2445-8743'.
        GS_DEPT-FAXNR = '02-2445-8743'.
        GS_DEPT-LAST_CHANGED_BY = '010001'.
        GS_DEPT-CHANGED_ON = SY-DATUM.
        
        *WRITE GS_DEPT.
        
        WRITE : GS_DEPT-CARRIER,
                GS_DEPT-DEPARTMENT,
                GS_DEPT-TELNR,
                GS_DEPT-FAXNR,
                GS_DEPT-LAST_CHANGED_BY,
                GS_DEPT-CHANGED_ON.
        ```
        
    3. 구조체(Structure)의 모든 필드가 CHAR 타입일 때 WRITE 구조체 구문이 가능한 이유
        1. 전제 상황
            
            예시 테이블/구조체: `ZDEPMENTG01` 해당 구조체의 필드 대부분은 **CHAR 기반 타입**이다:
            
            - CARRIER (CHAR)
            - DEPARTMENT (CHAR)
            - TELNR (CHAR)
            - FAXNR (CHAR)
            - LAST_CHANGED_BY (NUMC → CHAR-like)
            - CHANGED_ON (DATS → CHAR-like)
            
            그리고 아래와 같은 코드가 가능하다.
            
            ```abap
            REPORT ZABAP_23_G01.
            
            DATA GS_DEPT TYPE ZDEPMENTG01.
            
            GS_DEPT-CARRIER         = 'AA'.
            GS_DEPT-DEPARTMENT      = 'ADMI'.
            GS_DEPT-TELNR           = '02-2445-8743'.
            GS_DEPT-FAXNR           = '02-2445-8743'.
            GS_DEPT-LAST_CHANGED_BY = '010001'.
            GS_DEPT-CHANGED_ON      = SY-DATUM.
            
            WRITE GS_DEPT.
            
            ```
            
        2. 왜 `WRITE GS_DEPT.` 가 가능한가?
            1. ABAP에서 구조체를 `WRITE`로 출력할 수 있는 이유는, 구조체가 내부적으로 연속된 메모리 블록(레코드)로 구성되어 각 필드를 고정 길이 그대로 순서대로 이어 출력하며, 모든 필드가 CHAR·NUMC·DATS·TIMS 같은 **CHAR-like 타입**이면 문자열처럼 그대로 병합해 표시할 수 있기 때문이다. 반대로 구조체 안에 정수(INT), 실수(FLOAT), Packed(DEC/CURR), RAW 같은 비문자형 타입이 포함되어 있으면 자동 변환이 필요해 출력 형식이 달라지거나 깨질 수 있다.
4. 실습 2 - Scarr - Copy 구조체 ZTSCARR_G01 → Append Structures 추가하기
    1. 실습 결과 - Append Structure 확인 화면
        
        ![image.png](attachment:d598d86c-6b2a-4422-886b-f318bf29799c:image.png)
        
    2. 정리 
        1. 마지막 위치에만 붙는다
            - Append Structure는 항상 테이블의 **마지막 필드 뒤에 병합**된다.
            - 중간에 삽입 불가
        2. 필드명 규칙
            - `ZZ*`, `YY*`처럼 **Z/Y 접두어 필수**
        3. 표준 필드와 충돌 없음
            - 원본 구조 및 SAP 표준 필드 변경 위험 없음
        4. 여러 번 활성화해도 안전
            - Append는 별도 구조이므로 Upgrade 시에도 자동 병합됨

## ⚪ Topic C. **Views and Maintenace Views**

1. Database View란?
    - 실제 데이터를 저장하지 않는 **논리적 테이블**
    - 여러 테이블의 데이터를 **Join**하여 하나의 구조처럼 보여줌
    - Projection(필드 선택), Selection(조건 설정) 가능
    - Open SQL로 일반 테이블처럼 SELECT·UPDATE 가능 (제약 있음)
2.  View의 역할
    - 여러 테이블 데이터를 결합(Join)
    - 특정 필드를 제외하여 보여줌(Projection)
    - 조건에 맞는 데이터만 표시(Selection)
    - 유지 보수 가능한 화면을 제공(Maintenance View)
3.  View의 종류
    
    
    | View 종류 | Join | Projection | Selection | 목적 | DB에 생성? |
    | --- | --- | --- | --- | --- | --- |
    | **Database View** | O | O | O | 여러 테이블 결합 | O |
    | **Projection View** | X | O | X | 단일 테이블 필드 제한 | X |
    | **Help View** | O(Outer Join 가능) | O | O | Search Help | 경우에 따라 다름 |
    | **Maintenance View** | X(Join 아님) | O | O |  | X |
    
    1. **Database View**
    
    - 여러 테이블을 **Inner Join** 으로 결합
    - 데이터베이스 레벨에서 실제 VIEW 객체가 생성됨
    - Open SQL(SELECT/UPDATE/INSERT/DELETE) 가능
    - Join 조건 필요
    - Projection / Selection 조건 모두 가능
    - **사용 목적:** 논리적으로 결합된 데이터를 하나의 테이블처럼 조회할 때
    
    ---
    
    2. **Projection View**
    
    - 단일 테이블에서 **특정 필드만 선택하여 보여주는 뷰**
    - 여러 테이블 Join 불가
    - Projection(필드 제한)만 가능
    - Selection 조건 설정 불가
    - 유지보수 화면(SM30) 생성 불가
    - **사용 목적:** 필요 없는 필드를 제거한 간단한 조회용 View 만들 때
    
    ---
    
    3. **Help View**
    
    - F4 Search Help를 위해 사용하는 뷰
    - 여러 테이블을 Outer Join으로 결합 가능
    - Selection 조건 사용 가능
    - 화면용 UI로 사용되는 Search Help 와 연결됨
    - DB 레벨에 실제 VIEW 생성되지 않을 수 있음
    - **사용 목적:** F4 검색 도움(Search Help)의 값 목록 제공
    
    ---
    
    4. **Maintenance View**
    
    - 여러 테이블을 하나의 유지 보수 객체처럼 관리(SM30)
    - Foreign Key 기반의 Parent–Child 구조로 테이블 연결
    - Projection / Selection 가능
    - Join이 아니라 **logical table grouping** 개념
    - DB에는 실제 VIEW가 생성되지 않음
    - INSERT/UPDATE/DELETE 화면 자동 제공
    - **사용 목적:** SM30에서 여러 테이블을 동시에 관리하는 유지 보수 화면 생성
4. Projection (Field Selection)
    1. 정의 : Projection은 **원본 테이블의 필드 중 필요한 필드만 선택하여 View에 포함 시키는 작업**이다.
    2. 목적
        - 필요 없는 필드를 제외하여 데이터 구조를 단순화
        - 조회 성능 향상
        - 사용자에게 불필요한 정보 감춤
        - 특정 업무 화면에 필요한 정보만 보여줄 때 사용
    3. 특징
        - 테이블의 전체 필드가 아닌 **일부 필드만 View에 포함됨**
        - Database View, Projection View, Maintenance View에서 모두 사용 가능
        - Projection View는 **Projection만 수행하는 View** (Join 불가)
    4. 예시
        
        원본 SFLIGHT 테이블:
        
        CARRID / CONNID / PRICE / CURRENCY / PLANETYPE
        
        View에서는 PLANETYPE 제외:
        
        CARRID / CONNID / PRICE / CURRENCY
        
    5. 주의점
        - Projection은 단순히 "보여지는 필드"를 줄일 뿐, 원본 테이블 데이터를 삭제하는 것이 아님
        - Projection에서 제외된 필드로는 Selection(WHERE) 작성이 불가능할 수도 있음 (Database View 제한)
5. Selection Condition = 필터링 가능한 곳
    1. 정의 :  Selection Condition은 View에 **WHERE 절처럼 조건을 주어 특정 데이터만 표시되게 하는 것**이다.
    2. 목적
        - 특정 레코드만 표시
        - Data Filtering
        - 특정 고객/통화/기간 등 조건부 데이터만 보여줄 때 사용
    3. 특징
        - View 생성 시 조건을 “고정”해버리는 방식
        - 조건을 만족하지 않는 데이터는 뷰에서 보이지 않음
        - Maintenance View에서는 의무적일 때도 있음 (관계 제어)
6. Join Condition (ON 조건)
    1. 정의 : Join Condition은 여러 테이블을 결합할 때 **어떤 기준으로 레코드를 연결할지**를 지정하는 조건이다.
    2. 특징
        1. Database View는 반드시 Join 조건이 필요 (Inner Join)
        2. Help View는 Outer Join도 가능
        3. Join 조건이 없으면 Cross-product가 되어 쓸모없는 데이터 발생
        4. Help Viewd와 Maintenance View는 Left outer join 사용
7. **Database View 실습** 
    1. Field 
        
        ![image.png](attachment:9940ba2f-d81f-4cc2-9122-ff2148f95ba9:image.png)
        
    2. Selection Condition 
        
        ![image.png](attachment:17fea3f0-61ab-4745-b0f0-cf47b05681b3:image.png)
        
    3. Join Condition
        
        ![image.png](attachment:365ab26a-b55d-4ad1-a6b4-50b5297a30b9:image.png)
        
8. **Projection View 실습**
    1. View  생성
        
        → Field 에서 Basis Table과 View Field 입력
        
        ![image.png](attachment:d306db69-f3c5-4b5d-b156-63a88dcb90a2:image.png)
        
    2. 메세지 출력 시 메세지 문자열 입력 방법
        
        ![image.png](attachment:f2d234d5-b399-47db-ab7e-eeb1e0094811:image.png)
        
    3. 코드
        
        ```abap
        *&---------------------------------------------------------------------*
        *& Report ZABAP_24_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        *REPORT ZABAP_24_G01.
        *
        ** DB View에서 읽어온 데이터 할당할 변수 선언.
        *DATA : GT_CUST TYPE TABLE OF ZVCUSTOM_G01,
        *       GS_CUST LIKE LINE OF GT_CUST,
        *       LV_NAME TYPE SCUSTOM-NAME.
        *
        ** Selection Screen.
        *PARAMETERS : PA_NAME TYPE SCUSTOM-NAME.
        *
        ** 검색 조회 조건.
        *IF PA_NAME IS INITIAL.
        *  WRITE '고객이름을 입력하여 주세요.'.
        *  exit.
        *ELSEIF STRLEN( PA_NAME ) < 3.
        *  WRITE '고객이름을 3자리 이상 입력하여 주세요.'.
        *  exit.
        *ENDIF.
        *
        ** LIKE 검색 패턴 생성.
        **CONCATENATE '%' PA_NAME '%' INTO LV_NAME. "CONCATENATE 쓰는 : 방법 1
        *lv_name = '%' && pa_name && '%'.  "&&기호 쓰는 : 방법 2
        *
        ** DB View에서 데이터 Read.
        *SELECT *
        *  INTO TABLE GT_CUST
        *  FROM ZVCUSTOM_G01
        *  WHERE NAME LIKE LV_NAME.
        *
        ** 검색 결과 없으면 메시지.
        *IF SY-SUBRC <> 0.
        *  WRITE '해당 고객이 없습니다.'.
        *  EXIT.
        *ENDIF.
        *
        ** 검색 결과 모두 출력.
        *LOOP AT GT_CUST INTO GS_CUST.
        *  WRITE:/ GS_CUST-ID,
        *          GS_CUST-NAME,
        *          GS_CUST-COUNTRY,
        *          GS_CUST-CITY,
        *          GS_CUST-POSTCODE,
        *          GS_CUST-STREET.
        *ENDLOOP.
        
        *------------------------------------강사님 방법---------------------------------------
        REPORT ZABAP_24_G01.
        
        * DB View에서 읽어온 데이터 할당할 변수 선언.
        DATA : GT_CUST  TYPE TABLE OF ZVCUSTOM_G01,
               GS_CUST  LIKE LINE OF GT_CUST,
               GV_WHERE TYPE STRING.
        
        * Selection Screen.
        PARAMETERS : PA_NAME TYPE SCUSTOM-NAME.
        
        AT SELECTION-SCREEN.
        *   검색 조회 조건.
          IF PA_NAME IS INITIAL.
            MESSAGE E010(ZMSG_G01).
          ELSEIF STRLEN( PA_NAME ) < 3.
            MESSAGE E011(ZMSG_G01).
          ENDIF.
        
        START-OF-SELECTION.
        * LIKE 검색 패턴 생성.
          GV_WHERE = '%' && PA_NAME && '%'.
        * CONCATENATE '%' PA_NAME '%' INTO gv_where. "CONCATENATE 쓰는 : 방법 1
        
        * DB View에서 데이터 Read.
          SELECT *
            INTO TABLE GT_CUST
            FROM ZVCUSTOM_G01
            WHERE NAME LIKE GV_WHERE.
        
        * 검색 결과 없으면 메시지.
          IF SY-SUBRC <> 0.
            WRITE '해당 고객이 없습니다.'.
            EXIT.
          ENDIF.
        
        * 검색 결과 모두 출력.
          LOOP AT GT_CUST INTO GS_CUST.
            WRITE:/ GS_CUST-ID,
                    GS_CUST-NAME,
                    GS_CUST-COUNTRY,
                    GS_CUST-CITY,
                    GS_CUST-POSTCODE,
                    GS_CUST-STREET.
          ENDLOOP.
        ```
        
9. **Maintenance View 실습**
    1. View  생성 / Join Condition
        
        ![image.png](attachment:f92a8ddd-62c0-4fbe-97ca-cf4a6740354e:image.png)
        
    2. Field 
        
        ![image.png](attachment:867792f5-09e8-484b-a0dd-23a93fb19412:image.png)
        
    3. 핵심
        1. 메뉴 바 확인 
            
            ![image.png](attachment:311793a2-263b-4406-85d0-7ef970a82982:image.png)
            
        2. Maintennance Dialog : radio Button 3 method
            
            ![image.png](attachment:7a7221ab-db02-4faa-882c-60e1bd56f891:image.png)
            
            ![image.png](attachment:9671e18e-2df6-41c9-8a9c-cc91f35e3e4f:image.png)
            
            ![image.png](attachment:908bdcac-be6a-4b0d-a09f-d63a9400cc49:image.png)
            
            ![image.png](attachment:36196ca4-4a65-468c-acbd-011237ae9b10:image.png)
            
            → 생성 완료 후 화면
            
            ![image.png](attachment:e14cb407-1a66-4db6-a463-614fc678c0b9:image.png)
            
            → 결과 화면
            
            /nsm30 → 추가 입력 및 삭제 등 변경 사항 수정
            
            ![image.png](attachment:7d126438-86e4-4d33-9792-4a0e91ef662f:image.png)
