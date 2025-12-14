---
title: UX2+3 — Gateway & Fiori
---

<style>
:root {
  --bg1: #fffce8;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #ffe9a7;
  --shadow: 0 14px 34px rgba(255, 215, 89, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #cc9900;
  --grad: linear-gradient(90deg, #ffd166 0%, #ffe066 50%, #ffff99 100%);
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fffef5 40%, var(--bg2) 100%);
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
  margin: .2rem 0 .35rem;
  font-size: 1.85rem;
  font-weight: 850;
}

.uxhead p {
  margin: .2rem 0;
  color: var(--sub);
}

.topnav {
  font-size: .9rem;
  color: var(--muted);
  margin-bottom: .6rem;
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
  box-shadow: 0 10px 26px rgba(0, 0, 0, .04);
  padding: 1.2rem 1.3rem;
}

.card h2 {
  margin: 0 0 .7rem;
  font-size: 1.12rem;
  font-weight: 800;
  display: flex;
  gap: .45rem;
}

.badge {
  font-size: .78rem;
  padding: .16rem .5rem;
  border-radius: 999px;
  border: 1px solid var(--border);
  background: #fffdf2;
  color: var(--sub);
}

.small {
  color: var(--muted);
  font-size: .88rem;
}

.tbl {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 14px;
  border: 1px solid rgba(255, 233, 167, .9);
  overflow: hidden;
}

.tbl th, .tbl td {
  padding: .72rem .75rem;
  border-bottom: 1px solid rgba(255, 233, 167, .65);
}

.tbl th {
  background: #fff9e6;
  font-size: .88rem;
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
  font-size: .86rem;
  font-weight: 700;
  color: var(--sub);
  margin: .4rem 0 .6rem;
}

.meter {
  height: 14px;
  border-radius: 999px;
  background: #f5f5f5;
  border: 1px solid rgba(0, 0, 0, .06);
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
  margin: .5rem 0;
}

.pct {
  font-weight: 850;
}

.note {
  margin-top: .8rem;
  padding: .8rem;
  border-radius: 14px;
  border: 1px dashed rgba(255, 233, 167, .9);
  background: #fffdf4;
  font-size: .9rem;
}

.list {
  padding-left: 1.1rem;
  color: var(--sub);
}

.list li {
  margin: .25rem 0;
}
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🍋 UX2+3 — Gateway & Fiori</h1>
    <p>Gateway와 Fiori 개발을 분리하여 학습합니다.<br> OData 서비스 구현과 Fiori Elements 앱 개발 흐름을 배웁니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗂️ 학습 구성 <span class="badge">Lesson Index</span></h2>

      <div class="kicker">① Gateway Track</div>
      <table class="tbl">
        <tr><td class="col-tag">GW 1</td><td><a href="{{ '/studies/ux2-3/Gateway/Lesson1' | relative_url }}">Lesson 1</a></td><td>OData 기본 개념</td></tr>
        <tr><td class="col-tag">GW 2</td><td><a href="{{ '/studies/ux2-3/Gateway/Lesson2' | relative_url }}">Lesson 2</a></td><td>RFC 기반 OData</td></tr>
        <tr><td class="col-tag">GW 3</td><td><a href="{{ '/studies/ux2-3/Gateway/Lesson3' | relative_url }}">Lesson 3</a></td><td>CRUD 구현</td></tr>
        <tr><td class="col-tag">GW 4</td><td><a href="{{ '/studies/ux2-3/Gateway/Lesson4' | relative_url }}">Lesson 4</a></td><td>Deep Entity</td></tr>
        <tr><td class="col-tag">GW 5</td><td><a href="{{ '/studies/ux2-3/Gateway/Lesson5' | relative_url }}">Lesson 5</a></td><td>Association / Navigation</td></tr>
      </table>

      <br>

      <div class="kicker">② Fiori Track</div>
      <table class="tbl">
        <tr><td class="col-tag">Fiori 1</td><td><a href="{{ '/studies/ux2-3/Fiori/Lesson1' | relative_url }}">Lesson 1</a></td><td>Fiori Launchpad 소개</td></tr>
        <tr><td class="col-tag">Fiori 2</td><td><a href="{{ '/studies/ux2-3/Fiori/Lesson2' | relative_url }}">Lesson 2</a></td><td>Annotation 이해</td></tr>
        <tr><td class="col-tag">Fiori 3</td><td><a href="{{ '/studies/ux2-3/Fiori/Lesson3' | relative_url }}">Lesson 3</a></td><td>Fiori Elements 앱 구조</td></tr>
        <tr><td class="col-tag">Fiori 4</td><td><a href="{{ '/studies/ux2-3/Fiori/Lesson4' | relative_url }}">Lesson 4</a></td><td>List Report / Object Page</td></tr>
        <tr><td class="col-tag">Fiori 5</td><td><a href="{{ '/studies/ux2-3/Fiori/Lesson5' | relative_url }}">Lesson 5</a></td><td>Extension 활용</td></tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📌 주요 개념</h2>
        <ul class="list">
          <li>OData 서비스 구조 및 CRUD 처리</li>
          <li>Deep Entity / Association 설계</li>
          <li>Fiori Launchpad 및 App Types</li>
          <li>Fiori Elements / Annotation 기반 개발</li>
        </ul>
      </div>

      <div class="card">
        <h2>📈 이해도 진행도</h2>
        <div class="prow"><span>Gateway</span><span class="pct">40%</span></div>
        <div class="meter"><span style="width:40%"></span></div>

        <div class="prow"><span>Fiori</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>
      </div>

      <div class="card">
        <h2>🪄 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>OData 서비스 구조 및 실습</li>
          <li>Fiori Launchpad 이해</li>
          <li>Fiori Elements 기반 앱 구성</li>
        </ul>
        <div class="note">
          <code>Business 사용자 중심의 SAP Fiori UX 앱을 위한 백엔드 ↔ 프론트 연결 학습</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://sapui5.hana.ondemand.com/" target="_blank">SAPUI5 SDK</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li><a href="https://community.sap.com/topics/fiori" target="_blank">SAP Fiori 커뮤니티</a></li>
        </ul>
      </div>

    </aside>
  </div>
</div>
