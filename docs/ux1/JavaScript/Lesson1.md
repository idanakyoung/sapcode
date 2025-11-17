---
layout: default
title: "Lesson 1 - 자바스크립트 기초"
grand_parent: "UX1 — UI5 Programming"
parent: "JavaScript"
nav_order: 1
---

#🎓 JavaScript  Lesson 1

# Lesson 1. JavaScript Language Basics

> 🗓️ 학습 주제: JS 데이터 타입과 주요 메서드/함수 실습
> 
> 
> ✏️ 작성자: **구나경**
> 

## 🧠 **개념 정리**

### 🔸 스파게티 프로그램 vs 프로시저 프로그램

- **스파게티 프로그램**
    - 옛날 언어(코볼, 베이직 등)처럼
        
        코드가 순차적으로만 실행되고 구조화되지 않은 프로그램을 말해.
        
    - 코드가 길고 복잡해질수록 유지보수가 어렵고, 흐름이 꼬여버림.
    - → 이름처럼 "스파게티처럼 얽혀 있는 구조"라는 의미야 🍝
- **프로시저 프로그램**
    - 명령을 ‘절차(Procedure)’ 단위로 묶어서 실행하는 구조.
    - 함수나 서브루틴(작은 작업 단위)을 만들어 재사용이 가능해짐.

---

### 🔸 OOP (Object-Oriented Programming, 객체지향 프로그래밍)

- 객체지향 언어는 **“객체(Object)” 단위로 코드가 구성되는 언어**야.
- *클래스(Class)**라는 ‘틀’을 먼저 정의하고
    
    그 틀을 바탕으로 여러 개의 **객체(함수 + 속성)**를 만들어 사용해.
    
- JavaScript도 객체지향 언어 중 하나야 ✅

> 💬 예시:
> 
> 
> `class`는 붕어빵 틀,
> 
> `object`는 그 틀로 찍은 각각의 붕어빵!
> 

---

### 🔸 자바스크립트 코드 불러오기

- 스크립트를 HTML에 직접 작성할 수도 있고,
    
    외부 JS 파일을 만들어서 **불러올 수도 있음.**
    

```html
<script>
  alert("Hello, World!");
</script>

```

```html
<script src="hello.js"></script>

```

- 이렇게 하면 **HTML이 자바스크립트 코드를 읽어 실행**하게 돼.

---

### 🔸 (Tip) `! + Enter` → 자동 document 표시

> 💡 Visual Studio Code(VSCode)에서
> 
> 
> HTML 파일을 작성할 때 `!` 입력 후 `Enter` 키를 누르면
> 
> 자동으로 기본 HTML 문서 구조 (`<!DOCTYPE html>` ~ `</html>`)가 생성돼!
> 

---

---

## 💻 **코드 예제 정리**

### 🧩 1️⃣ Hello World (기본 구조 + alert)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Hello World</title>
</head>
<body>
  <script>
    alert("Hello World")

    var txt = "button"
    var stxt = txt.slice(1)
    alert(stxt)
  </script>
</body>
</html>

```

### 💡 포인트

- `alert()` : 팝업창으로 메시지 띄우기
- `.slice(1)` : 문자열 일부 잘라내기 → `"button" → "utton"`

---

### 💬 2️⃣ 콘솔 출력 (console.log)

```jsx
alert("hello world");
console.log("JAVAScript");

var txt = "JAVAScript Hello world";
console.log(txt);

```

### 💡 포인트

| 함수 | 출력 위치 | 설명 |
| --- | --- | --- |
| `alert()` | 팝업창 | 사용자에게 즉시 보여줌 |
| `console.log()` | 개발자 도구(Console) | 코드 실행 결과 확인용 |

> 📍 F12 → Console 탭에서 확인 가능!
> 

---

### 📂 3️⃣ 외부 JS 파일 연결 (script src)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JavaScript Reference</title>
  <script src="hello_msg.js" defer></script>
</head>
<body>
</body>
</html>

```

### 💡 포인트

- `src` : 외부 자바스크립트 파일 경로 지정
- `defer` : HTML이 전부 로드된 뒤 JS 실행
- 파일 구조:
    
    ```
    project/
    ├─ index.html
    └─ hello_msg.js
    
    ```
    

### ⚙️ 4️⃣ 함수(Function) + onload 이벤트

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>JavaScript Head call function</title>
  <script>
    function get_hello() {
      alert("Hello, World")
    }
  </script>
</head>
<body onload="get_hello()">
</body>
</html>

```

### 💡 포인트

- `function` : 명령을 묶는 코드 블록
- `onload` : 페이지가 로드되면 자동 실행되는 이벤트
- `get_hello()` : 함수 호출 (괄호 꼭 써야 함!)

### ✨ 응용 (버튼 클릭으로 호출)

```html
<body>
  <button onclick="get_hello()">Click Me!</button>
</body>

```

---

### 🧭 5️⃣ MVC 패턴 / 식별자 / 변수 & 상수 / 외부 함수 호출

---

### 📌 MVC 패턴 (Model / View / Controller)

- **Model** : 데이터와 로직을 관리
- **View** : 사용자에게 보여지는 화면(UI)
- **Controller** : 사용자의 입력을 처리하고, Model과 View를 연결

> ⚙️ 자바스크립트에서도 MVC 원리가 적용돼
> 
> 
> View(HTML)나 Model(데이터)의 변화를 관리할 수 있음.
> 

---

### 📌 식별자(Identifier) 조건

| 조건 | 설명 |
| --- | --- |
| ✅ 대소문자 구별 | `Name` ≠ `name` |
| ✅ 문자열 가능 | 문자로 시작해야 함 |
| ✅ 사용 가능 기호 | `$`, `_` 가능 |
| ❌ 사용 불가 | 숫자로 시작, 키워드(reserved word) 사용 금지 |

> 예시:
> 
> 
> `let userName = "나경";` ✅
> 
> `let 1name = "error";` ❌
> 
> `let var = "error";` ❌
> 

---

### 📌 주석(Comment) 처리

| 구분 | 방법 | 설명 |
| --- | --- | --- |
| HTML 내 | `<!-- 내용 -->` | HTML 영역의 주석 |
| JS 내 (한 줄) | `// 내용` | Ctrl + / 단축키 가능 |
| JS 내 (여러 줄) | `/* 내용 */` | 블록 주석 |

---

### 📌 변수와 상수

| 구분 | 키워드 | 설명 |
| --- | --- | --- |
| 변수 | `var` / `let` | 값 변경 가능 |
| 상수 | `const` | 값 변경 불가 |

🧩 추가 설명

1️⃣ `var` 없이 변수 선언 시 → **Global 변수**

→ *strict mode*에서는 에러 발생 ⚠️

2️⃣ 일부 구버전 브라우저에서는 `let` 인식 안 됨 (ES6 이전)

---

### 🧩 예제 — 외부 함수 호출

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>External Function Call</title>
  <!-- JAVAScript 파일 이름 -->
  <script src="function.js"></script>
</head>
<!-- JAVAScript 함수 호출 onload로 실행 -->
<body onload="get_hello()">
</body>
</html>

```

### 📜 function.js

```jsx
function get_hello() {
  alert("Hello from external JS file!");
}

```

### 💡 포인트

- `<script src="function.js">` : 외부 함수 파일 연결
- `onload="get_hello()"` : HTML이 로드되면 자동 실행
- 함수가 외부 파일에 있어도 **HTML에서 바로 호출 가능**

---

## 🧠 **핵심 요약 정리표**

| 개념 | 설명 | 예시 |
| --- | --- | --- |
| `alert()` | 팝업창 출력 | `alert("Hi!")` |
| `console.log()` | 콘솔 출력 | `console.log("Hi!")` |
| `var / let` | 변수 선언 | `var name = "나경"` |
| `const` | 상수 선언 | `const PI = 3.14` |
| `.slice()` | 문자열 자르기 | `"button".slice(1)` |
| `<script src="">` | 외부 JS 파일 연결 | `src="hello.js"` |
| `function` | 함수 정의 | `function sayHi(){}` |
| `onload`, `onclick` | 이벤트 실행 | `<body onload="...">` |
| `MVC 패턴` | Model, View, Controller 구조 | 데이터 ↔ UI 제어 |
| 식별자 | 이름 규칙 | `$`, `_` 사용 가능, 숫자 불가 |

---

## 🌈 **한 줄 요약**

> 💬 “JavaScript는 HTML에 동작과 구조를 부여하는 언어!”
> 
> 
> MVC 구조로 데이터와 뷰를 제어하고,
> 
> 함수·변수·이벤트로 인터랙티브한 웹페이지를 완성한다. 🚀
>
