# 🧭 Lesson 10 - **Performance During Table Access**

# 🔵 **Unit 1. Creating Database Table Indexes**

1. Index란?
    1. **ABAP Dictionary Transparents Table  마지막 탭에 있는 테이블 레코드**
    2. 정렬된 데이터 → 검색 시 이진 탐색(BINARY SEARCH) 가능 → 빠른 조회
    3. 인덱스는 데이터베이스 테이블의 특정 필드만 **정렬된 형태로 따로 저장해둔 복사본**이다.
    4. 실습 화면
        
        ![image.png](attachment:72876556-b627-4272-a679-301f6f246eb3:image.png)
        
2. Secondary Index란?
    1. 테이블에서 특정 조건으로 검색할 때 DB가 더 빠르게 찾을 수 있도록 **별도의 정렬된 목록(인덱스)** 을 만들어두는 것
    2. 예:
    
    ```
    SELECT * FROM ZTAB WHERE NAME = 'KIM'.
    
    ```
    
    - NAME 필드가 Key가 아니면 DB는 테이블 전체를 뒤져서 찾음(Full Table Scan) → 여기에 **Secondary Index(NAME)** 를 만들면 NAME 기준으로 정렬된 인덱스에서 먼저 찾아서 훨씬 빠르게 검색 가능함

# 🔵 **Unit 2. Setting Up Table Buffering**

1. Table Buffering이란? 
    1. **Application Server 메모리에 테이블 내용을 저장**하여 데이터베이스 접근을 줄이는 기법
2. Buffering 유형 (Buffering Types)
    1. Single Record Buffering
        - 하나의 레코드 단위로 캐싱
        - 주로 Primary Key 기반 단건 조회에 사용
    2. Generic Buffering
        1. Generic Buffering을  사용할 때는 Generic Key를 설정해야 한다.
            1. Generic Primary key : 필드 중 앞에서부터 몇 개를 기반으로 데이터를 버퍼링할지 정하는 것
        - Primary key 일부 필드 단위로 버퍼링
        - Primary Key의 일부 필드만 기준으로 그룹 단위로 버퍼링하는 방식
    3. Full Buffering
        - 테이블 전체를 메모리에 저장
        - 작은 Lookup 테이블에 적합
        - 조회는 매우 빠르지만 메모리 사용 많음
3. Table Buffering의 단점
    1. 데이터 최신성이 떨어질 수 있음
    2. 버퍼 동기화 비용 증가
        1. 각각의 서버(Application Server = 앱 서버)마다 버퍼가 있기 때문에 누적되어 있는 데이터가 다를 수 있음 그래서 동기화가 필요한데, 이 시점에서 비용이 증가함.
    3. 메모리 사용량 증가
4. 버퍼링이 적합한 테이블
    1. 읽기(Read) 작업이 대부분인 테이블
        - 데이터가 거의 변경되지 않고
        - SELECT 조회가 주로 이루어지는 테이블은 버퍼링에 적합하다.
        - 버퍼에서 바로 읽기 때문에 조회 성능이 크게 향상된다.
    2. 데이터의 일시적 불일치를 허용할 수 있는 테이블
        - DB의 최신 데이터와 버퍼의 데이터가 잠깐 다를 수 있다.
        - 이런 일시적 차이가 업무적으로 문제가 되지 않는 테이블에만 버퍼링을 적용한다.
        - 예: 국가 코드, 단순 마스터 데이터, 환경 설정 테이블 등
5. 버퍼링이 적합하지 않은 테이블
    1. 데이터 변경이 자주 발생하는 테이블
        - INSERT, UPDATE, DELETE가 많으면
            
            버퍼가 계속 무효화되고 다시 로딩되어
            
            성능이 오히려 나빠진다.
            
        - 이러한 테이블은 버퍼링을 사용해서는 안 된다.
    2. 즉시 최신 데이터가 필요한 테이블
        - 실시간으로 정확해야 하는 트랜잭션 데이터(VBAK, VBAP 등)는 버퍼링을 사용하면 안 된다.
        - 버퍼의 특성 상 최신 데이터 반영이 지연될 수 있기 때문이다.
    3.  버퍼링이 적합하지 않은 테이블일 때, Secondary Index를 사용하는 방법
        1. 버퍼링은 변경이 많거나 실시간성이 중요한 대용량 테이블에는 적용할 수 없기 때문에, 이러한 테이블에서 조회 성능을 높이고 싶을 때는 대신 **Secondary Index**를 사용한다.
        2. Secondary Index는 WHERE 절에 자주 사용되는 비키 필드나 조인 조건 필드를 기준으로 DB 단계에서 검색 속도를 개선하는 역할을 하며, 특히 버퍼링이 불가능한 테이블에서 효과적인 성능 향상 방법이다.

# 🔵 **Unit 3. Input Checks**

1. Creating Fixed Values : 도메인(Domain)에서 제한된 값만 입력되도록 지정하는 방법
    1. 예시 : Gender Domain
        - M = Male
        - F = Female
        
        → 필드에 M/F 외 값은 입력 불가 → Input Validation 자동 수행
        
2. Foreign Key를 통한 Input Check : 두 테이블 간의 관계를 정의해서 입력된 값이 **참조 테이블에 존재하는지 자동으로 검사하는 기능**
    1. Foreign Key를 통한 Input Check는 **ABAP Dictionary에서만 동작** 하는 것이고, 실제 DB 레벨에서 테이블 간 관계가 정의되는 것은 아니다.
    2. SAP DDIC에서 Foreign Key를 만든다 = “Validation 규칙”을 만든 것이 실제 데이터베이스에는 Foreign Key Constraint가 만들어지지 않는다. 
    3. ABAP DDIC에서는 입력 검사가 되지만 DB가 직접 검사하지는 않는다!
3. Creating Text Tables
    1. Master Table = 코드값(기준값)을 저장
    2. Text Table은 Master Table을 설명하기 위한 테이블이기 때문에, ext Table을 배우기 전에 반드시 Master Table 개념을 알아야 한다.
    3. Creating Text Tables의 구조는 항상 아래처럼 이루어진다:
    
    ```abap
    [Master Table] 1  ----  N [Text Table]
    ```
    
    → 그래서 Text Table을 이해하려면 먼저 Master Table이 어떤 성격의 테이블인지 알아야 한다.
