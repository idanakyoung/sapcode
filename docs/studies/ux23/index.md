---
title: UX2+3 — Gateway & Fiori
---

<style>
:root {
  --bg1: #fffce5;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #ffe9aa;
  --shadow: 0 14px 34px rgba(255, 213, 102, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #d97706;
  --grad: linear-gradient(90deg,
    #fff0a6 0%,
    #ffe066 30%,
    #ffd166 60%,
    #fff3c4 100%
  );
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fffdf6 40%, var(--bg2) 100%);
}

.uxwrap {
  max-width: 1100px;
  margin: 2rem auto 3rem;
  padding: 0 1.1rem;
  font-family: system-ui, -apple-system, "Segoe UI", "Noto Sans KR", sans-serif;
  color: var(--text);
}

.uxhead {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 18px;
  box-shadow: var(--shadow);
  padding: 1.5rem 1.7rem;
  margin-bottom: 1.2rem;
}

.uxhead h1 {
  margin: 0.2rem 0 0.35rem;
  font-size: 1.85rem;
  font-weight: 850;
}

.uxhead p {
  margin: 0.2rem 0;
  color: var(--sub);
}

.topnav {
  font-size: 0.9rem;
  color: var(--muted);
  margin-bottom: 0.6rem;
}
.topnav a {
  color: var(--link);
  text-decoration: none;
}
.topnav a:hover {
  text-decoration: underline;
}

.grid {
  display: grid;
  grid-template-columns: 2.2fr 1fr;
  gap: 1rem;
}
@media (max-width: 920px) {
  .grid {
    grid-template-columns: 1fr;
  }
}

.card {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 16px;
  box-shadow: 0 10px 26px rgba(0, 0, 0, 0.04);
  padding: 1.2rem 1.3rem;
}

.card h2 {
  margin: 0 0 0.7rem;
  font-size: 1.12rem;
  font-weight: 800;
  display: flex;
  gap: 0.45rem;
}

.badge {
  font-size: 0.78rem;
  padding: 0.16rem 0.5rem;
  border-radius: 999px;
  border: 1px solid var(--border);
  background: #fffdee;
  color: var(--sub);
}

.small {
  color: var(--muted);
  font-size: 0.88rem;
}

.tbl {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 14px;
  border: 1px solid rgba(255, 225, 150, 0.9);
  overflow: hidden;
}

.tbl th,
.tbl td {
  padding: 0.72rem 0.75rem;
  border-bottom: 1px solid rgba(255, 225, 150, 0.65);
}
.tbl th {
  background: #fff8e6;
  font-size: 0.88rem;
  text-align: left;
}
.tbl tr:last-child td {
  border-bottom: none;
}
.tbl .col-tag {
  width: 92px;
  font-weight: 800;
}
.tbl a {
  color: var(--link);
  text-decoration: none;
}
.tbl a:hover {
  text-decoration: underline;
}

.kicker {
  font-size: 0.86rem;
  font-weight: 700;
  color: var(--sub);
  margin: 0.4rem 0 0.6rem;
}

.list {
  padding-left: 1.1rem;
  color: var(--sub);
}
.list li {
  margin: 0.25rem 0;
}

.meter {
  height: 14px;
  border-radius: 999px;
  background: #f3f4f6;
  border: 1px solid rgba(0, 0, 0, 0.06);
  overflow: hidden;
}
.meter span {
  display: block;
  height: 100%;
  background: var(--grad);
}
.prow {
  display: flex;
  justify-content: space-between;
  margin: 0.5rem 0;
}
.pct {
  font-weight: 850;
}
.note {
  margin-top: 0.8rem;
  padding: 0.8rem;
  border-radius: 14px;
  border: 1px dashed rgba(255, 225, 150, 0.9);
  background: #fffdf4;
  font-size: 0.9rem;
}
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🍋 UX2+3 — Gateway & Fiori</h1>
    <p>SAP Gateway를 통한 OData 서비스 개발과 SAP Fiori 앱 구조 및 개발 흐름을 함께 학습합니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗂️ Lesson Index <span class="badge">학습 구성</span></h2>

      <div class="kicker">① Gateway Track</div>
      <table class="tbl">
        <tr><td class="col-tag">GW 1</td><td><a href="{{ '/studies/ux23/Gateway/Lesson1' | relative_url }}">Lesson 1</a></td><td>RFC / Function Module</td></tr>
        <tr><td class="col-tag">GW 2</td><td><a href="{{ '/studies/ux23/Gateway/Lesson2' | relative_url }}">Lesson 2</a></td><td>SEGW 프로젝트 생성</td></tr>
        <tr><td class="col-tag">GW 3</td><td><a href="{{ '/studies/ux23/Gateway/Lesson3' | relative_url }}">Lesson 3</a></td><td>Entity / Association</td></tr>
        <tr><td class="col-tag">GW 4</td><td><a href="{{ '/studies/ux23/Gateway/Lesson4' | relative_url }}">Lesson 4</a></td><td>DPC / MPC 클래스 구조</td></tr>
        <tr><td class="col-tag">GW 5</td><td><a href="{{ '/studies/ux23/Gateway/Lesson5' | relative_url }}">Lesson 5</a></td><td>GET_ENTITY 구현</td></tr>
        <tr><td class="col-tag">GW 6</td><td><a href="{{ '/studies/ux23/Gateway/Lesson6' | relative_url }}">Lesson 6</a></td><td>PUT/POST 처리</td></tr>
      </table>

      <br>

      <div class="kicker">② Fiori Track</div>
      <table class="tbl">
        <tr><td class="col-tag">FIO 1</td><td><a href="{{ '/studies/ux23/Fiori/Lesson1' | relative_url }}">Lesson 1</a></td><td>SAP Fiori 개요</td></tr>
        <tr><td class="col-tag">FIO 2</td><td><a href="{{ '/studies/ux23/Fiori/Lesson2' | relative_url }}">Lesson 2</a></td><td>SAP Launchpad 이해</td></tr>
        <tr><td class="col-tag">FIO 3</td><td><a href="{{ '/studies/ux23/Fiori/Lesson3' | relative_url }}">Lesson 3</a></td><td>Fiori Elements 소개</td></tr>
        <tr><td class="col-tag">FIO 4</td><td><a href="{{ '/studies/ux23/Fiori/Lesson4' | relative_url }}">Lesson 4</a></td><td>Annotation 방식</td></tr>
        <tr><td class="col-tag">FIO 5</td><td><a href="{{ '/studies/ux23/Fiori/Lesson5' | relative_url }}">Lesson 5</a></td><td>Object Page 구성</td></tr>
        <tr><td class="col-tag">FIO 6</td><td><a href="{{ '/studies/ux23/Fiori/Lesson6' | relative_url }}">Lesson 6</a></td><td>List Report 구성</td></tr>
      </table>
    </div>

    <div class="card">
      <h2>📚 주요 개념</h2>
      <ul class="list">
        <li>RFC & OData 서비스 구조</li>
        <li>DPC / MPC / SEGW 개발 흐름</li>
        <li>Fiori 앱 구조 (Launchpad, Elements)</li>
        <li>Annotation 기반 UI 개발</li>
      </ul>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>🔥 이해도 진행도</h2>
        <div class="prow"><span>Gateway</span><span class="pct">40%</span></div>
        <div class="meter"><span style="width:40%"></span></div>

        <div class="prow"><span>Fiori</span><span class="pct">15%</span></div>
        <div class="meter"><span style="width:15%"></span></div>
      </div>

      <div class="card">
        <h2>💡 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>SAP Gateway 기반 OData 개발</li>
          <li>Fiori Launchpad 및 Elements 구조</li>
          <li>UI Annotation 실습</li>
          <li>SAP UX 기술의 전반적 이해</li>
        </ul>

        <div class="note">
          <code>Backend부터 Frontend까지 이어지는 SAP UX 개발 흐름 실전 학습</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com/" target="_blank">SAP Help Portal</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li><a href="https://experience.sap.com/" target="_blank">SAP Fiori Design Guidelines</a></li>
        </ul>
      </div>

    </aside>
  </div>
</div>
