---
title: UX1 — UI5 Programming
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

body { background: radial-gradient(circle at top left, #ffe6f5 0, #fff7fb 40%, #ffffff 100%); }

.portal {
  max-width: 1100px;
  margin: 2.2rem auto 3rem;
  padding: 0 1.2rem;
  font-family: system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI","Noto Sans KR",sans-serif;
}
.portal-header {
  background: var(--portal-card-bg);
  border-radius: 18px;
  padding: 1.8rem 2rem;
  box-shadow: var(--portal-shadow);
  border: 1px solid var(--portal-border);
  margin-bottom: 1.6rem;
}
.portal-title { font-size: 1.9rem; font-weight: 800; margin: 0 0 .4rem; }
.portal-sub { font-size: .95rem; color: var(--text-sub); margin: .1rem 0; }
.portal-grid { display: grid; grid-template-columns: 2.1fr 1fr; gap: 1.2rem; }
.portal-card {
  background: var(--portal-card-bg);
  border-radius: 16px;
  border: 1px solid var(--portal-border);
  padding: 1.4rem 1.6rem;
  box-shadow: 0 8px 22px rgba(0,0,0,.03);
}
.portal-card h2 { font-size: 1.2rem; margin: 0 0 .6rem; display:flex;align-items:center;gap:.4rem; }
.portal-card h3 { font-size: 1rem; margin:.9rem 0 .4rem; }
.portal-list { margin:.2rem 0 .4rem; padding-left:1rem; }
.portal-list li { margin:.18rem 0; }
.portal-small { font-size:.85rem; color:var(--text-muted); }
.portal a { color:var(--link); text-decoration:none; }
.portal a:hover { color:var(--link-hover); text-decoration:underline; }
.portal-checklist { list-style:none; padding-left:0; font-size:.9rem; margin:.3rem 0 0; }
.portal-checklist li { margin:.18rem 0; }
@media (max-width:820px){ .portal-grid{grid-template-columns:1fr;} }
</style>

<div class="portal">

  <header class="portal-header">
    <p class="portal-small"><a href="https://idanakyoung.github.io/sapcode/">← SAP CODE 메인으로</a></p>
    <h1 class="portal-title">🎨 UX1 — UI5 Programming (HTML/JS)</h1>
    <p class="portal-sub"><strong>목표</strong> 웹 기초(HTML/CSS/JS)와 SAP UI5 View/Controller 구조를 이해하고, 간단한 UI5 애플리케이션을 스스로 만들 수 있는 수준까지.</p>
  </header>

  <section class="portal-grid">

    <!-- 왼쪽 메인 -->
    <div>

      <section class="portal-card">
        <h2>📚 학습 구성</h2>
        <p class="portal-small">UX1 과정은 JavaScript 기본기와 SAP UI5 프레임워크 파트로 나뉩니다.</p>

        <h3>① JavaScript Track</h3>
        <ul class="portal-list">
         <li>JS 1 — <a href="{{ '/ux1/JavaScript/Lesson1' | relative_url }}">Lesson 1 · 기본 문법</a></li>
          <li>JS 2 — <a href="{{ '/ux1/JavaScript/Lesson2' | relative_url }}">Lesson 2 · 조건문 / 반복문</a></li>
          <li>JS 3 — <a href="{{ '/ux1/JavaScript/Lesson3' | relative_url }}">Lesson 3 · 함수</a></li>
          <li>JS 4 — <a href="{{ '/ux1/JavaScript/Lesson4' | relative_url }}">Lesson 4 · 객체</a></li>
          <li>JS 5 — <a href="{{ '/ux1/JavaScript/Lesson5' | relative_url }}">Lesson 5 · DOM / 이벤트</a></li>
        </ul>

        <h3>② SAP UI5 Track</h3>
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

      <section class="portal-card">
        <h2>🔎 핵심 키워드</h2>
        <ul class="portal-list">
          <li>JavaScript: 변수/자료형, 함수, 스코프, 이벤트, DOM 조작</li>
          <li>UI5: MVC(Model-View-Controller), DataBinding, Routing</li>
          <li>View 타입: XML View / JS View</li>
          <li>Model: JSONModel, ODataModel 기본 사용법</li>
          <li>기본 컴포넌트: Input, Table, Button, Dialog 등</li>
        </ul>
      </section>

    </div>

    <!-- 오른쪽 사이드 -->
    <aside>

      <section class="portal-card">
        <h2>✅ 학습 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] JS 기본 문법으로 간단한 계산/조건 분기 만들기</li>
          <li>[ ] DOM 선택/이벤트 바인딩으로 버튼 클릭 이벤트 처리</li>
          <li>[ ] XML View + Controller로 간단 입력 폼 구현</li>
          <li>[ ] JSONModel을 바인딩해서 Table에 리스트 표시</li>
          <li>[ ] Routing으로 화면 전환(마스터/디테일) 실습</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔗 참고 링크</h2>
        <p class="portal-small">
          • <a href="https://ui5.sap.com">SAPUI5 공식 데모 / API</a><br>
          • <a href="https://developer.mozilla.org/ko/docs/Web/JavaScript">MDN JavaScript 문서</a>
        </p>
      </section>

    </aside>

  </section>

</div>
