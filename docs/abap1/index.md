---
title: UX1 — UI5 Programming (HTML/JS)
---

<div class="portal portal--ux1">

  <!-- 상단 큰 카드 (홈이랑 동일 스타일) -->
  <header class="portal-header">
    <p class="portal-small">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </p>
    <h1 class="portal-title">🎨 UX1 — UI5 Programming (HTML/JS)</h1>
    <p class="portal-sub">
      HTML/CSS/JavaScript 기초부터 SAP UI5까지 한 번에 정리하는 과정입니다.<br>
      실습 중심으로 UI 개발 감각을 다지는 것을 목표로 합니다.
    </p>
  </header>

  <!-- 아래 2컬럼 카드 영역 -->
  <section class="portal-grid">

    <!-- 🔹 왼쪽 컬럼: JS / UI5 트랙 -->
    <div>

      <!-- JavaScript Track 카드 -->
      <section class="portal-card">
        <h2>🟦 JavaScript Track</h2>
        <p class="portal-small">
          JS 기본 문법을 복습하면서 UI5에서 쓰이는 핵심 개념을 정리합니다.
        </p>

        <h3>기초 문법 · 함수 · DOM</h3>
        <ul class="portal-list">
          <li>JS 1 — <a href="{{ '/ux1/JavaScript/Lesson1' | relative_url }}">Lesson 1 · 기본 문법</a></li>
          <li>JS 2 — <a href="{{ '/ux1/JavaScript/Lesson2' | relative_url }}">Lesson 2 · 조건문 / 반복문</a></li>
          <li>JS 3 — <a href="{{ '/ux1/JavaScript/Lesson3' | relative_url }}">Lesson 3 · 함수</a></li>
          <li>JS 4 — <a href="{{ '/ux1/JavaScript/Lesson4' | relative_url }}">Lesson 4 · 객체</a></li>
          <li>JS 5 — <a href="{{ '/ux1/JavaScript/Lesson5' | relative_url }}">Lesson 5 · DOM / 이벤트</a></li>
        </ul>
      </section>

      <!-- SAP UI5 Track 카드 -->
      <section class="portal-card">
        <h2>🟩 SAP UI5 Track</h2>
        <p class="portal-small">
          View / Controller 구조와 Model, Data Binding, Routing을 단계적으로 정리합니다.
        </p>

        <h3>MVC · DataBinding · Routing · Fragment</h3>
        <ul class="portal-list">
          <li>UI5 1 — <a href="{{ '/ux1/UI5/Lesson1' | relative_url }}">Lesson 1 · View / Controller</a></li>
          <li>UI5 2 — <a href="{{ '/ux1/UI5/Lesson2' | relative_url }}">Lesson 2 · 데이터 바인딩</a></li>
          <li>UI5 3 — <a href="{{ '/ux1/UI5/Lesson3' | relative_url }}">Lesson 3 · Routing</a></li>
          <li>UI5 4 — <a href="{{ '/ux1/UI5/Lesson4' | relative_url }}">Lesson 4 · 모델(Model)</a></li>
          <li>UI5 5 — <a href="{{ '/ux1/UI5/Lesson5' | relative_url }}">Lesson 5 · JSONModel</a></li>
          <li>UI5 6 — <a href="{{ '/ux1/UI5/Lesson6' | relative_url }}">Lesson 6 · XML View</a></li>
          <li>UI5 7 — <a href="{{ '/ux1/UI5/Lesson7' | relative_url }}">Lesson 7 · Table Control</a></li>
          <li>UI5 8 — <a href="{{ '/ux1/UI5/Lesson8' | relative_url }}">Lesson 8 · Formatter</a></li>
          <li>UI5 9 — <a href="{{ '/ux1/UI5/Lesson9' | relative_url }}">Lesson 9 · Fragment</a></li>
          <li>UI5 10 — <a href="{{ '/ux1/UI5/Lesson_10' | relative_url }}">Lesson 10</a></li>
          <li>UI5 11 — <a href="{{ '/ux1/UI5/Lesson_11' | relative_url }}">Lesson 11</a></li>
          <li>UI5 12 — <a href="{{ '/ux1/UI5/Lesson_12' | relative_url }}">Lesson 12</a></li>
          <li>UI5 13 — <a href="{{ '/ux1/UI5/Lesson_13' | relative_url }}">Lesson 13</a></li>
          <li>UI5 14 — <a href="{{ '/ux1/UI5/Lesson_14' | relative_url }}">Lesson 14</a></li>
          <li>UI5 15 — <a href="{{ '/ux1/UI5/Lesson_15' | relative_url }}">Lesson 15</a></li>
          <li>UI5 16 — <a href="{{ '/ux1/UI5/Lesson_16' | relative_url }}">Lesson 16</a></li>
        </ul>
      </section>

    </div>

    <!-- 🔹 오른쪽 컬럼: 요약 / 체크리스트 -->
    <aside>

      <section class="portal-card">
        <h2>📚 이 과정에서 다루는 내용</h2>
        <ul class="portal-list">
          <li>HTML / CSS / JavaScript 기본 문법 복습</li>
          <li>SAP UI5 View / Controller 구조 이해</li>
          <li>JSONModel / ODataModel을 이용한 데이터 바인딩</li>
          <li>Routing, Fragment, Table Control 등 실무에서 자주 쓰는 UI 컴포넌트</li>
          <li>실습 기반으로 <strong>UI 하나 완성해 보기</strong></li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>✅ 학습 체크 포인트</h2>
        <ul class="portal-checklist">
          <li>[ ] JS 이벤트 / DOM 조작 코드를 이해하고 직접 작성할 수 있다.</li>
          <li>[ ] XML View와 Controller 파일 구조를 설명할 수 있다.</li>
          <li>[ ] JSONModel을 바인딩해서 리스트(Table)에 데이터를 표시할 수 있다.</li>
          <li>[ ] Routing을 이용해 두 화면 간 네비게이션을 구현할 수 있다.</li>
        </ul>
      </section>

    </aside>

  </section>

</div>
