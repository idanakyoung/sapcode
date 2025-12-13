---
title: ABAP1 — Foundation & Screen
---

<style>
:root {
  --portal-bg: #f7fbff;
  --portal-card-bg: #ffffff;
  --portal-border: #cfe6ff;
  --portal-shadow: 0 12px 30px rgba(84, 132, 255, 0.15);
  --text-main: #222431;
  --text-sub: #5f6472;
  --text-muted: #9a9fb0;
  --link: #0052a3;
  --link-hover: #003a73;
}

body {
  background: radial-gradient(circle at top left, #e3f1ff 0, #f7fbff 45%, #ffffff 100%);
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

/* 테이블 꾸미기 */
.portal-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 0.6rem;
  font-size: 0.95rem;
  overflow: hidden;
  border-radius: 12px;
}

.portal-table th,
.portal-table td {
  border: 1px solid rgba(207, 230, 255, 0.9);
  padding: 0.7rem 0.75rem;
  vertical-align: top;
}

.portal-table th {
  background: rgba(227, 241, 255, 0.6);
  text-align: left;
  font-weight: 700;
}

.portal-table td small {
  color: var(--text-muted);
}

@media (max-width: 820px) {
  .portal-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<div class="portal">

  <header class="portal-header">
    <p class="portal-small">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </p>
    <h1 class="portal-title">⚙️ ABAP1 — Foundation / Dictionary / Screen</h1>
    <p class="portal-sub">
      <strong>목표</strong> ABAP 언어 기초 + Data Dictionary + Screen Programming(PBO/PAI) 핵심 흐름을 이해하고 실습으로 남기기.
    </p>
  </header>

  <section class="portal-grid">

    <!-- 왼쪽(메인) -->
    <div>

      <section class="portal-card">
        <h2>📚 학습 구성</h2>

        <h3>① ABAP 기본 문법</h3>
        <ul class="portal-list">
          <li>DATA 선언, 타입, 구조(Structure)</li>
          <li>제어문 (IF, CASE, LOOP, DO ... ENDDO)</li>
          <li>내부 테이블 기본 개념</li>
        </ul>

        <h3>② ABAP Dictionary(DDIC)</h3>
        <ul class="portal-list">
          <li>Domain / Data Element / Table / View</li>
          <li>키/외래키, 테이블 하이라키 구조</li>
          <li>Search Help, Check Table</li>
        </ul>

        <h3>③ Screen Programming (Dynpro)</h3>
        <ul class="portal-list">
          <li>Screen Attributes, Layout, Element Attributes</li>
          <li>PBO / PAI, Flow Logic, MODULE 사용</li>
          <li>TABLES, OK_CODE, SCREEN 구조 활용</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🗂️ Lesson Index (ABAP1)</h2>
        <p class="portal-small">아래 표에서 레슨을 바로 열 수 있어요. (파일명 기준)</p>

        <table class="portal-table">
          <thead>
            <tr>
              <th style="width: 90px;">Lesson</th>
              <th>바로가기</th>
              <th style="width: 170px;">메모</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td><a href="{{ '/abap1/Lesson1' | relative_url }}">Lesson1</a></td>
              <td><small>기초 문법 / 첫 세팅</small></td>
            </tr>
            <tr>
              <td>2</td>
              <td><a href="{{ '/abap1/Lesson2' | relative_url }}">Lesson2</a></td>
              <td><small>실습/정리</small></td>
            </tr>
            <tr>
              <td>3</td>
              <td><a href="{{ '/abap1/Lesson3' | relative_url }}">Lesson3</a></td>
              <td><small>모듈화/구조화</small></td>
            </tr>
            <tr>
              <td>4</td>
              <td><a href="{{ '/abap1/Lesson4' | relative_url }}">Lesson4</a></td>
              <td><small>DDIC/기초</small></td>
            </tr>
            <tr>
              <td>5</td>
              <td><a href="{{ '/abap1/Lesson5' | relative_url }}">Lesson5</a></td>
              <td><small>DDIC/심화</small></td>
            </tr>
            <tr>
              <td>6</td>
              <td><a href="{{ '/abap1/Lesson6' | relative_url }}">Lesson6</a></td>
              <td><small>Screen/Dynpro</small></td>
            </tr>
            <tr>
              <td>7</td>
              <td><a href="{{ '/abap1/Lesson7' | relative_url }}">Lesson7</a></td>
              <td><small>PBO/PAI</small></td>
            </tr>
            <tr>
              <td>8</td>
              <td><a href="{{ '/abap1/Lesson8' | relative_url }}">Lesson8</a></td>
              <td><small>Flow Logic</small></td>
            </tr>
            <tr>
              <td>9</td>
              <td><a href="{{ '/abap1/Lesson9' | relative_url }}">Lesson9</a></td>
              <td><small>실습 정리</small></td>
            </tr>

            <tr>
              <td>10</td>
              <td><a href="{{ '/abap1/Lesson_10' | relative_url }}">Lesson_10</a></td>
              <td><small>추가 레슨</small></td>
            </tr>
            <tr>
              <td>11</td>
              <td><a href="{{ '/abap1/Lesson_11' | relative_url }}">Lesson_11</a></td>
              <td><small>추가 레슨</small></td>
            </tr>
            <tr>
              <td>12</td>
              <td><a href="{{ '/abap1/Lesson_12' | relative_url }}">Lesson_12</a></td>
              <td><small>추가 레슨</small></td>
            </tr>
            <tr>
              <td>13</td>
              <td><a href="{{ '/abap1/Lesson_13' | relative_url }}">Lesson_13</a></td>
              <td><small>추가 레슨</small></td>
            </tr>
          </tbody>
        </table>
      </section>

      <section class="portal-card">
        <h2>🔎 핵심 키워드</h2>
        <ul class="portal-list">
          <li>ABAP Program Type (Report, Module Pool 등)</li>
          <li>DDIC: Domain / Data Element / Transparent Table</li>
          <li>Screen: 요소명 ↔ ABAP 변수 동일(Identical Names)</li>
          <li>PBO: 출력 전 세팅 / PAI: 입력 처리</li>
        </ul>
      </section>

    </div>

    <!-- 오른쪽(사이드) -->
    <aside>
        <section class="portal-card">
          <h2>📈 이해도 / 진행 상태</h2>
        
          <div class="meter">
            <div class="meter-label">
              <span>ABAP 기본 문법</span>
              <span><strong>30%</strong></span>
            </div>
            <div class="meter-bar" style="--value: 30%;"></div>
          </div>
        
          <div class="meter">
            <div class="meter-label">
              <span>DDIC (Dictionary)</span>
              <span><strong>20%</strong></span>
            </div>
            <div class="meter-bar" style="--value: 20%;"></div>
          </div>
        
          <div class="meter">
            <div class="meter-label">
              <span>Screen (Dynpro)</span>
              <span><strong>10%</strong></span>
            </div>
            <div class="meter-bar" style="--value: 10%;"></div>
          </div>
        
          <p class="meter-hint">
            퍼센트는 여기만 수정하면 돼요 👉 <code>--value: 60%;</code><br>
            (숫자 텍스트 60%도 같이 바꾸면 깔끔!)
          </p>
        </section>    

      <section class="portal-card">
        <h2>🔗 참고</h2>
        <p class="portal-small">
          • DDIC 오브젝트 세부 설명은 <strong>ABAP Dictionary</strong> 공식 도움말 참고<br>
          • BC410 교재 Unit 1, 2 실습 정리와 함께 보면 이해가 빨라요
        </p>
      </section>

    </aside>

  </section>

</div>
