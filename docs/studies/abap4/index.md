---
title: ABAP4 — HANA, CDS & New Syntax
---

<style>
:root {
  --bg1: #fff4f8;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #ffd7e6;
  --shadow: 0 14px 34px rgba(255, 143, 180, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #c43d7a;
  --grad: linear-gradient(90deg,
    #ff8fbc 0%,
    #ffb3cf 35%,
    #ffd0e2 70%,
    #fff0f6 100%
  );
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fff8fb 40%, var(--bg2) 100%);
}

.abwrap {
  max-width: 1100px;
  margin: 2rem auto 3rem;
  padding: 0 1.1rem;
  font-family: system-ui, -apple-system, "Segoe UI", "Noto Sans KR", sans-serif;
  color: var(--text);
}

.abhead {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 18px;
  box-shadow: var(--shadow);
  padding: 1.5rem 1.7rem;
  margin-bottom: 1.2rem;
}

.abhead h1 {
  margin: 0.2rem 0 0.35rem;
  font-size: 1.85rem;
  font-weight: 850;
}

.abhead p {
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

.small {
  color: var(--muted);
  font-size: 0.88rem;
}

.tbl {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 14px;
  border: 1px solid rgba(255, 215, 230, 0.95);
  overflow: hidden;
}

.tbl th,
.tbl td {
  padding: 0.72rem 0.75rem;
  border-bottom: 1px solid rgba(255, 215, 230, 0.7);
  vertical-align: top;
}
.tbl th {
  background: #fff0f6;
  font-size: 0.88rem;
  text-align: left;
}
.tbl tr:last-child td {
  border-bottom: none;
}
.tbl .col-tag {
  width: 108px;
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
  background: #eef0f6;
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

.badge {
  font-size: 0.78rem;
  padding: 0.16rem 0.5rem;
  border-radius: 999px;
  border: 1px solid var(--border);
  background: #fff7fb;
  color: var(--sub);
}

.note {
  margin-top: 0.8rem;
  padding: 0.8rem;
  border-radius: 14px;
  border: 1px dashed rgba(255, 215, 230, 0.95);
  background: #fff8fb;
  font-size: 0.9rem;
}
</style>

<div class="abwrap">

  <div class="abhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🧩 ABAP4 — HANA, CDS & New Syntax</h1>
    <p>SAP HANA 기반 Open SQL, ADBC, CDS View, Association, Input Parameter, POU, 2차 시험 정리, ABAP New Syntax까지 이어지는 과정을 날짜 기준으로 정리한 페이지입니다.</p>
    <p class="small">기간: 2026.01.07 ~ 2026.02.06</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗓️ 학습 구성 <span class="badge">Date Index</span></h2>
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
            <td class="col-tag">2026.01.07</td>
            <td><a href="{{ '/studies/abap4/260107' | relative_url }}">260107</a></td>
            <td>SAP HANA / OPEN SQL</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.08</td>
            <td><a href="{{ '/studies/abap4/260108' | relative_url }}">260108</a></td>
            <td>New Open SQL / ADBC / HANA ALV</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.09</td>
            <td><a href="{{ '/studies/abap4/260109' | relative_url }}">260109</a></td>
            <td>Creating & Handling Database</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.12</td>
            <td><a href="{{ '/studies/abap4/260112' | relative_url }}">260112</a></td>
            <td>CDS View / Annotations / Relationships Between Database Tables</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.13</td>
            <td><a href="{{ '/studies/abap4/260113' | relative_url }}">260113</a></td>
            <td>Association / CDS Views Pushdown / Built-in Functions in CDS</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.14</td>
            <td><a href="{{ '/studies/abap4/260114' | relative_url }}">260114</a></td>
            <td>Input Parameters in CDS</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.15</td>
            <td><a href="{{ '/studies/abap4/260115' | relative_url }}">260115</a></td>
            <td>ABAP 2nd Exam</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.16</td>
            <td><a href="{{ '/studies/abap4/260116' | relative_url }}">260116</a></td>
            <td>ABAP 2nd Exam 풀이 1</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.19</td>
            <td><a href="{{ '/studies/abap4/260119' | relative_url }}">260119</a></td>
            <td>ABAP 2nd Exam 풀이 2</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.20~28</td>
            <td><a href="{{ '/studies/abap4/260120_28_pou1' | relative_url }}">260120~28 (POU1)</a></td>
            <td>POU (1)</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.20~28</td>
            <td><a href="{{ '/studies/abap4/260120_28_pou2' | relative_url }}">260120~28 (POU2)</a></td>
            <td>POU (2)</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.20~28</td>
            <td><a href="{{ '/studies/abap4/260120_28_pou3' | relative_url }}">260129 (POU3)</a></td>
            <td>POU (3)</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.20~28</td>
            <td><a href="{{ '/studies/abap4/260120_28_exam' | relative_url }}">260120~28 (Exam)</a></td>
            <td>ABAP 2nd Exam 정리</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.29</td>
            <td><a href="{{ '/studies/abap4/260129' | relative_url }}">260129</a></td>
            <td>ABAP 총정리 강의</td>
          </tr>
          <tr>
            <td class="col-tag">2026.01.30</td>
            <td><a href="{{ '/studies/abap4/260130' | relative_url }}">260130</a></td>
            <td>ABAP 사원-부서 추가 퀴즈 풀이</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.02</td>
            <td><a href="{{ '/studies/abap4/260202' | relative_url }}">260202</a></td>
            <td>ABAP New Syntax (Expressions 중심 프로그래밍)</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.03</td>
            <td><a href="{{ '/studies/abap4/260203' | relative_url }}">260203</a></td>
            <td>ABAP New Syntax - LOOP & VALUE # & CDS View & ASSOCIATION & OPEN SQL & JOIN & UNION</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.04</td>
            <td><a href="{{ '/studies/abap4/260204' | relative_url }}">260204</a></td>
            <td>ABAP New Syntax - LOCAL CLASS & CALCULATION & INTERNAL TABLES & CONSTRUCTOR</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.05</td>
            <td><a href="{{ '/studies/abap4/260205' | relative_url }}">260205</a></td>
            <td>ABAP New Syntax</td>
          </tr>
          <tr>
            <td class="col-tag">2026.02.06</td>
            <td><a href="{{ '/studies/abap4/260206' | relative_url }}">260206</a></td>
            <td>ABAP_Quiz_22</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📈 주요 개념</h2>
        <ul class="list">
          <li>SAP HANA 기반 Open SQL과 New Open SQL</li>
          <li>ADBC와 HANA ALV</li>
          <li>CDS View, Annotation, Association, Input Parameter</li>
          <li>ABAP 2차 시험 정리와 POU</li>
          <li>ABAP New Syntax 및 Expressions 중심 프로그래밍</li>
        </ul>
      </div>

      <div class="card">
        <h2>🔥 이해도 진행도</h2>

        <div class="prow"><span>HANA / Open SQL</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>CDS / Association / Annotation</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>POU / 시험 정리</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>ABAP New Syntax</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>💡 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>HANA 환경에서의 데이터 처리 방식 이해</li>
          <li>CDS 중심 모델링과 Pushdown 개념 학습</li>
          <li>2차 시험 및 POU 기반 복습 정리</li>
          <li>최신 ABAP 문법을 활용한 표현식 중심 프로그래밍</li>
        </ul>

        <div class="note">
          <code>전통적 ABAP를 넘어 HANA, CDS, New Syntax 기반으로 확장되는 마지막 심화 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com/" target="_blank">SAP Help Portal</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li>HANA / CDS / New Syntax 관련 강의 노트 및 시험 정리 자료</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
