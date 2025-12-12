---
title: UX1 — UI5 Programming (HTML/JS)
---

<style>
:root {
  --portal-bg: #fff7fb;
  --portal-card-bg: #ffffff;
  --portal-border: #ffd6ec;
  --portal-shadow: 0 12px 30px rgba(255, 143, 180, 0.22);
  --text-main: #222431;
  --text-sub: #5f6472;
  --text-muted: #9a9fb0;
  --link: #0066cc;
  --link-hover: #004c99;
}

body {
  background: radial-gradient(circle at top left, #ffe6f5 0, #fff7fb 40%, #ffffff 100%);
}

.portal {
  max-width: 1100px;
  margin: 2.2rem auto 3rem;
  padding: 0 1.2rem;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI",
    "Noto Sans KR", sans-serif;
}

.portal-header {
  background: var(--portal-card-bg);
  border-radius: 18px;
  padding: 1.8rem 2rem;
  box-shadow: var(--portal-shadow);
  border: 1px solid var(--portal-border);
  margin-bottom: 1.6rem;
}

.portal-title {
  font-size: 1.9rem;
  font-weight: 800;
  margin: 0 0 0.4rem;
}

.portal-sub {
  font-size: 0.95rem;
  color: var(--text-sub);
  margin: 0.1rem 0;
}

.portal-grid {
  display: grid;
  grid-template-columns: 2.1fr 1fr;
  gap: 1.2rem;
}

.portal-card {
  background: var(--portal-card-bg);
  border-radius: 16px;
  border: 1px solid var(--portal-border);
  padding: 1.4rem 1.6rem;
  box-shadow: 0 8px 22px rgba(0, 0, 0, 0.03);
}

.portal-card h2 {
  font-size: 1.2rem;
  margin: 0 0 0.6rem;
  display: flex;
  align-items: center;
  gap: 0.4rem;
}

.portal-card h3 {
  font-size: 1rem;
  margin: 0.9rem 0 0.4rem;
}

.portal-list {
  margin: 0.2rem 0 0.4rem;
  padding-left: 1rem;
}

.portal-list li {
  margin: 0.18rem 0;
}

.portal-small {
  font-size: 0.85rem;
  color: var(--text-muted);
}

.portal a {
  color: var(--link);
  text-decoration: none;
}

.portal a:hover {
  color: var(--link-hover);
  text-decoration: underline;
}

.portal-checklist {
  list-style: none;
  padding-left: 0;
  font-size: 0.9rem;
  margin: 0.3rem 0 0;
}

.portal-checklist li {
  margin: 0.18rem 0;
}

@media (max-width: 820px) {
  .portal-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<div class="portal">

  <header class="portal-header">
    <p class="portal-small"><a href="https://idanakyoung.github.io/sapcode/">← SAP CODE 메인으로</a></p>
    <h1 class="portal-title">🎨 UX1 — UI5 Programming (HTML/JS)</h1>
    <p class="portal-sub">
      HTML/CSS/JavaScript 기초부터 SAP UI5까지 한 번에 정리하는 과정입니다.<br>
      실습 중심으로 UI 개발 감각을 다지는 것을 목표로 합니다.
    </p>
  </header>

  <section class="portal-grid">

    <!-- 왼쪽 메인 영역 -->
    <div>

      <section class="portal-card">
        <h2>🟦 JavaScript Track</h2>
        <p class="portal-small">JS 기본 문법을 복습하면서 UI5에서 쓰이는 핵심 개념을 정리합니다.</p>

        <h3>기초 문법 · 함수 · DOM</h3>
        <ul class="portal-list">
          <li>JS 1 — <a href="{{ '/ux1/JavaScript/Lesson1' | relative_url }}">Lesson 1 · 기본 문법</a></li>
          <li>JS 2 — <a href="{{ '/ux1/JavaScript/Lesson2' | relative_url }}">Lesson 2 · 조건문 / 반복문</a></li>
          <li>JS 3 — <a href="{{ '/ux1/JavaScript/Lesson3' | relative_url }}">Lesson 3 · 함수</a></li>
          <li>JS 4 — <a href="{{ '/ux1/JavaScript/Lesson4' | relative_url }}">Lesson 4 · 객체</a></li>
          <li>JS 5 — <a href="{{ '/ux1/JavaScript/Lesson5' | relative_url }}">Lesson 5 · DOM / 이벤트</a></li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🟩 SAP UI5 Track</h2>
        <p class="portal-small">View / Controller 구조와 Model, Data Binding, Routing을 단계적으로 정리합니다.</p>

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

    <!-- 오른쪽 사이드 영역 -->
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
