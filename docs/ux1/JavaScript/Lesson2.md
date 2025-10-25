# 🎓JavaScript  Lesson 2

# Lesson 2. JavaScript Data Types (문자열/숫자형/논리형·null·undefined)

> 🗓️ 학습 주제: JS 데이터 타입과 주요 메서드/함수 실습
> 
> 
> ✏️ 작성자: **구나경**
> 

---

## 🧠 **개념 정리**

### 🔸 문자열 (String)

- **이스케이프(escape) 시퀀스**는 `\`(백슬래시)로 표기해.
    - `\"`, `\'` : 따옴표 문자 자체를 출력
    - `\n` : 줄바꿈(개행, **New Line**)
    - `\r` : 캐리지 리턴(**Carriage Return**) → 커서를 맨 앞으로 이동
    - `\t` : 탭(Tab)
    - `\\` : 백슬래시 자체
- **따옴표 섞어쓰기**
    - `"` 안에 `'`는 그대로 가능, `'` 안에 `"`도 가능
    - 같은 따옴표 안에서 같은 따옴표를 쓰려면 **이스케이프** 필요(예: `"He said \"Hi\""`).
- **주요 속성/메서드**
    - 길이: `.length`
    - 부분 문자열: `.substring(start, end)` → `start`부터 **end 전까지**
    - 문자 읽기: `.charAt(index)`
    - 인덱스 찾기: `.indexOf("S")` (없으면 `1`)
    - 구분하여 배열로: `.split(",")`
    - 대소문자 변환: `.toUpperCase()`, `.toLowerCase()`
    - 문자/유니코드 변환: `.charCodeAt(0)`, `String.fromCharCode(72)`

> 💡 substring(1, 4)는 인덱스 1부터 3까지를 의미해.
> 
> 
> 💡 `charAt(4)`는 **다섯 번째** 문자를 반환(인덱스는 0부터 시작).
> 

---

### 🔸 숫자형 (Number)

- 정수/실수를 모두 **Number** 한 타입으로 다룸.
- **정수 변환**
    - `parseInt(value)` : 문자열을 정수로 파싱(소수점 이하 버림)
    - `parseInt("524.23") → 524`
    - 숫자 반올림 가족: `Math.floor`, `Math.ceil`, `Math.round`, **소수점 제거만**은 `Math.trunc`(음수도 0쪽으로 절삭)
- **진법 지정**: `parseInt("10", 2) → 2`
    
    (두 번째 인자로 **기수(radix)** 지정 권장)
    

> ⚠️ parseInt(15.9)처럼 숫자를 넣을 때는 내부적으로 문자열 변환 후 파싱하므로
> 
> 
> 소수점 절삭 목적이라면 `Math.trunc(15.9)`가 더 명확해.
> 

---

### 🔸 논리형 (Boolean) & 값의 부재

- **Boolean**: `true`, `false`
    - 자주 쓰는 **truthy/falsy**
        - falsy: `0`, `NaN`, `""`(빈 문자열), `null`, `undefined`, `false`
        - 그 외 대부분은 truthy
- **`null` vs `undefined`**
    - `null` : **의도적으로 ‘없음’**을 명시한 값 (개발자가 비워둠)
    - `undefined` : **아직 값이 할당되지 않음** (브라우저/엔진이 줌)
- 타입 확인: `typeof null`은 역사적 이유로 `"object"`, `typeof undefined`는 `"undefined"`

> 💡 비교는 가능하면 **엄격 일치(===)**를 사용하자.
> 
> 
> `null == undefined`는 `true`지만, `null === undefined`는 `false`.
> 

---

## 💻 **코드 예제 정리**

### 🧩 1️⃣ 문자열: 따옴표/이스케이프/개행·캐리지리턴·탭

```html
<!-- Lesson2: String Type (escape & control chars) -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>String Type</title>
</head>
<body>
  <script>
    var sVar  = "JAVAScript Program";
    console.log("sVar :", sVar);

    var sVar1 = 'JAVAScript Program';
    console.log("sVar1 :", sVar1);

    var sVar2 = "JAVAScript \"Program\"";
    console.log("sVar2 :", sVar2);

    var sVar3 = 'JAVAScript "Program"';
    console.log("sVar3 :", sVar3);

    var sVar4 = "JAVA'Script Program";
    console.log("sVar4 :", sVar4);

    // New Line
    var sVar5 = "JAVAScript \nProgram";
    alert(sVar5);

    // Carriage Return (커서를 맨 앞으로 이동)
    var sVar6 = "JAVAScript \rProgram";
    alert(sVar6);

    // Tab key
    var sVar7 = "JAVAScript \tProgram";
    alert(sVar7);
  </script>
</body>
</html>

```

### 💡 포인트

- `\n`, `\r`, `\t`의 시각적 효과를 **alert**로 확인
- 따옴표 섞기와 이스케이프의 차이를 **console**로 확인

---

### 💬 2️⃣ 문자열 메서드: 길이/부분문자열/문자·인덱스/분할/대소문자/유니코드

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>String Methods</title>
</head>
<body>
  <script>
    let sVar = "JAVAScript Programming";

    // 문자열의 길이
    alert(sVar.length);

    // 부분 문자열: 인덱스 1부터 3까지(4는 제외)
    alert(sVar.substring(1, 4));

    // 특정 위치의 문자: 인덱스 4(다섯 번째 문자)
    alert(sVar.charAt(4));

    // 특정 문자의 인덱스: "S"가 처음 나타나는 위치
    alert(sVar.indexOf("S"));

    // "," 기준으로 나누기 (앞 공백이 남을 수 있음 → .map(x => x.trim()) 권장)
    var sName = "홍길동, 김철수, 바나나, 오렌지";
    var aName = sName.split(",");
    alert(aName);
    console.log(aName);

    // 대문자/소문자 변환
    alert(sVar.toUpperCase());
    alert(sVar.toLowerCase());

    var sHel = "Hello World";
    // 문자 -> 유니코드
    alert(sHel.charCodeAt(0));      // 'H' → 72
    // 유니코드 -> 문자
    alert(String.fromCharCode(72));  // 72 → 'H'
  </script>
</body>
</html>

```

### 💡 포인트

- `substring(start, end)`는 **end 미포함**
- `split(",")` 후 공백 제거 시: `sName.split(",").map(s => s.trim())`
- 유니코드는 **코드 유닛 기준**으로 동작(이모지/특수문자 일부는 2유닛 사용 가능)

---

### 🔢 3️⃣ 숫자형: `parseInt`와 정수 처리

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Number - parseInt</title>
</head>
<body>
  <script>
    var iDec = 15.9;
    // parseInt: 문자열을 정수로 파싱 (소수점 이하 버림)
    var iInt = parseInt(iDec);
    alert(iInt); // 15

    var iInt2 = parseInt(524.23);
    alert(iInt2); // 524

    // 권장: 숫자 절삭은 Math.trunc (음수도 0을 향해 절삭)
    alert(Math.trunc(-15.9)); // -15

    // 문자열 + 진법(radix) 지정
    alert(parseInt("10", 2));  // 2
    alert(parseInt("FF", 16)); // 255
  </script>
</body>
</html>

```

### 💡 포인트

- **절삭 목적** → `Math.trunc`가 의도를 더 분명히 드러냄
- **문자열 파싱** 시엔 **기수(radix)** 지정 습관화

---

### ✅ 4️⃣ (보너스) Boolean / null / undefined 빠른 체킹

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Boolean & Null/Undefined</title>
</head>
<body>
  <script>
    // truthy / falsy
    console.log(!!"text", !!0, !!"", !!null, !!undefined); // true false false false false

    // null vs undefined
    let a;                // 값 미할당 → undefined
    let b = null;         // 의도적 비어있음 → null
    console.log(typeof a, typeof b); // "undefined", "object"

    console.log(a == null);  // true  (느슨한 비교)
    console.log(a === null); // false (엄격 비교)
  </script>
</body>
</html>

```

### 💡 포인트

- `!!value`로 **truthy/falsy**를 빠르게 확인
- 비교는 **`===`** 권장(예상치 못한 형변환 방지)

---

## 🧠 **핵심 요약 정리표**

| 개념 | 설명 | 예시 |
| --- | --- | --- |
| 이스케이프 | 특수문자/제어문자 표기 | `\"`, `\n`, `\t`, `\\` |
| 길이/부분 | 문자열 길이/발췌 | `"abc".length`, `.substring(1,3)` |
| 문자/인덱스 | 특정 문자/위치 찾기 | `.charAt(2)`, `.indexOf("S")` |
| 분리 | 구분자로 배열 생성 | `"a,b".split(",")` |
| 대소문자 | 케이스 변환 | `.toUpperCase()/.toLowerCase()` |
| 코드포인트 | 문자↔유니코드 | `.charCodeAt(0)`, `String.fromCharCode(72)` |
| 정수 변환 | 문자열→정수 | `parseInt("524.23") → 524` |
| 절삭 대안 | 수학적 절삭 | `Math.trunc(15.9) → 15` |
| 진법 | 기수 지정 | `parseInt("10", 2) → 2` |
| 논리 | truthy/falsy | `!!value` |
| 부재 | null / undefined | 의도적 없음 / 미할당 |

---

## 🌈 **한 줄 요약**

> 문자열은 메서드로 ‘읽고·나누고·바꾸고’ 다룬다.
> 
> 
> 숫자는 `parseInt`보단 목적에 맞는 `Math.*`를,
> 
> 논리/부재 값은 `===`와 truthy/falsy 기준으로 안전하게 다루자. 🚀
>
