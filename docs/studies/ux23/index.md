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
  vertical-align: top;
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
  width: 110px;
  font-weight: 800;
  white-space: nowrap;
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
    <p>Gateway와 UI5 Fiori를 날짜 기준으로 정리한 페이지입니다.</p>
    <p class="small">기간: 2026.02.09 ~ 2026.03.03</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗂️ 학습 구성 <span class="badge">Date Index</span></h2>

      <div class="kicker">① Gateway</div>
      <table class="tbl">
        <thead>
          <tr>
            <th>날짜</th>
            <th>정리 페이지</th>
            <th>주제</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="col-tag">2026.02.09</td>
            <td><a href="{{ '/studies/ux23/20260209' | relative_url }}">20260209</a></td>
            <td>ODATA & SAP Gateway Service 개념 및 생성</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.10</td>
            <td><a href="{{ '/studies/ux23/20260210' | relative_url }}">20260210</a></td>
            <td>SAP Gateway Association</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.11</td>
            <td><a href="{{ '/studies/ux23/20260211' | relative_url }}">20260211</a></td>
            <td>SAP Gateway Association & Filter & Paging</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.12</td>
            <td><a href="{{ '/studies/ux23/20260212' | relative_url }}">20260212</a></td>
            <td>SAP Gateway Data Create, Update, Delete</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.19</td>
            <td><a href="{{ '/studies/ux23/20260219' | relative_url }}">20260219</a></td>
            <td>SAP Gateway</td>
          </tr>
        </tbody>
      </table>

      <br>

      <div class="kicker">② UI5 Fiori</div>
      <table class="tbl">
        <thead>
          <tr>
            <th>날짜</th>
            <th>정리 페이지</th>
            <th>주제</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="col-tag">2026.02.20</td>
            <td><a href="{{ '/studies/ux23/20260220' | relative_url }}">20260220</a></td>
            <td>SAP UI5 BINDING CREATE & UPDATE & DELETE</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.23</td>
            <td><a href="{{ '/studies/ux23/20260223' | relative_url }}">20260223</a></td>
            <td>SAP UI5 SearchHelp + Filtering</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.24</td>
            <td><a href="{{ '/studies/ux23/20260224' | relative_url }}">20260224</a></td>
            <td>SAP UI5 Popup View</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.26</td>
            <td><a href="{{ '/studies/ux23/20260226' | relative_url }}">20260226</a></td>
            <td>SAP UI5 FIORI & CDS VIEW & METADATA EXTENTION</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.27</td>
            <td><a href="{{ '/studies/ux23/20260227' | relative_url }}">20260227</a></td>
            <td>SAP UI5 FIORI HIDDEN & SELECTIONFIELD & OBJECT PAGE & VALUE HELP & CHART</td>
          </tr>
          <tr>
            <td class="col-tag">2026.03.03</td>
            <td><a href="{{ '/studies/ux23/20260303' | relative_url }}">20260303</a></td>
            <td>SAP UI5 FIORI SERVICE_DEFINITION & SERVICE_BINDING & SEARCH_FIELD</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📌 주요 개념</h2>
        <ul class="list">
          <li>OData 서비스 구조 및 CRUD 처리</li>
          <li>Association, Filter, Paging</li>
          <li>UI5 Binding 및 SearchHelp / Popup View</li>
          <li>Fiori + CDS View + Metadata Extension</li>
          <li>Object Page, Value Help, Chart, Service Binding</li>
        </ul>
      </div>

      <div class="card">
        <h2>📈 이해도 진행도</h2>
        <div class="prow"><span>Gateway</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>UI5 Fiori</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>🪄 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>OData 서비스 생성과 Association, CRUD 구현</li>
          <li>Filter, Paging 등 Gateway 서비스 확장</li>
          <li>UI5 Binding과 SearchHelp, Popup View 실습</li>
          <li>Fiori Elements 및 CDS/Metadata 기반 화면 구성</li>
        </ul>
        <div class="note">
          <code>Gateway 백엔드 서비스와 UI5 Fiori 프론트를 연결해 실제 SAP UX 흐름을 완성하는 단계</code>
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
