---
title: ABAP3 — HANA / CDS / New Syntax
---

<style>
:root {
  --bg1: #f8f4ff;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #e5d4ff;
  --shadow: 0 14px 34px rgba(175, 143, 255, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #6f3ccf;
  --grad: linear-gradient(90deg,
    #b197fc 0%,
    #d0b3ff 30%,
    #e2d0ff 70%,
    #f4ebff 100%
  );
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fdfaff 40%, var(--bg2) 100%);
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
  background: #f6f0ff;
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
  border: 1px solid rgba(229, 212, 255, 0.9);
  overflow: hidden;
}

.tbl th,
.tbl td {
  padding: 0.72rem 0.75rem;
  border-bottom: 1px solid rgba(229, 212, 255, 0.65);
}
.tbl th {
  background: #f3ebff;
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
  border: 1px dashed rgba(229, 212, 255, 0.9);
  background: #fbf8ff;
  font-size: 0.9rem;
}
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>💾 ABAP3 — HANA / CDS / New Syntax</h1>
    <p>HANA 기반 개발을 위한 ABAP 최신 기술 스택을 학습합니다. CDS, AMDP, New Syntax 등 중심으로 구성.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>✏️ 학습 구성<span class="badge">학습 구성</span></h2>
      <table class="tbl">
        <tr><td class="col-tag">AB3 1</td><td><a href="{{ '/studies/abap3/Lesson1' | relative_url }}">Lesson 1</a></td><td>New ABAP Syntax 소개</td></tr>
        <tr><td class="col-tag">AB3 2</td><td><a href="{{ '/studies/abap3/Lesson2' | relative_url }}">Lesson 2</a></td><td>내장 타입 & 인라인 선언</td></tr>
        <tr><td class="col-tag">AB3 3</td><td><a href="{{ '/studies/abap3/Lesson3' | relative_url }}">Lesson 3</a></td><td>LOOP AT GROUP</td></tr>
        <tr><td class="col-tag">AB3 4</td><td><a href="{{ '/studies/abap3/Lesson4' | relative_url }}">Lesson 4</a></td><td>CDS View 기본</td></tr>
        <tr><td class="col-tag">AB3 5</td><td><a href="{{ '/studies/abap3/Lesson5' | relative_url }}">Lesson 5</a></td><td>CDS View 심화</td></tr>
        <tr><td class="col-tag">AB3 6</td><td><a href="{{ '/studies/abap3/Lesson6' | relative_url }}">Lesson 6</a></td><td>AMDP 소개</td></tr>
        <tr><td class="col-tag">AB3 7</td><td><a href="{{ '/studies/abap3/Lesson7' | relative_url }}">Lesson 7</a></td><td>Open SQL 향상</td></tr>
        <tr><td class="col-tag">AB3 8</td><td><a href="{{ '/studies/abap3/Lesson8' | relative_url }}">Lesson 8</a></td><td>Annotation 활용</td></tr>
        <tr><td class="col-tag">AB3 9</td><td><a href="{{ '/studies/abap3/Lesson9' | relative_url }}">Lesson 9</a></td><td>CDS + UI 연동</td></tr>
        <tr><td class="col-tag">AB3 10</td><td><a href="{{ '/studies/abap3/Lesson10' | relative_url }}">Lesson 10</a></td><td>심화 실습</td></tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📈 주요 개념</h2>
        <ul class="list">
          <li>New ABAP Syntax (DATA, VALUE, LET, etc.)</li>
          <li>CDS View 정의 및 Annotation</li>
          <li>AMDP (ABAP Managed Database Procedure)</li>
          <li>Open SQL 향상 기능</li>
          <li>UI 연계 (CDS → OData → UI)</li>
        </ul>
      </div>

      <div class="card">
        <h2>🔥 이해도 진행도 </h2>
        <div class="prow"><span>New Syntax</span><span class="pct">40%</span></div>
        <div class="meter"><span style="width:40%"></span></div>

        <div class="prow"><span>CDS / AMDP</span><span class="pct">25%</span></div>
        <div class="meter"><span style="width:25%"></span></div>

        <div class="prow"><span>UI 연동</span><span class="pct">10%</span></div>
        <div class="meter"><span style="width:10%"></span></div>
      </div>

      <div class="card">
        <h2>💡 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>ABAP 최신 문법과 활용</li>
          <li>HANA Native 개발 이해</li>
          <li>CDS View, AMDP 실습</li>
          <li>Annotation과 UI 연동</li>
        </ul>

        <div class="note">
          <code>ABAP on HANA 기반 고급 개발 역량 향상을 위한 모듈</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com/" target="_blank">SAP Help Portal</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li><a href="https://learning.sap.com/" target="_blank">SAP Learning</a></li>
        </ul>
      </div>

    </aside>
  </div>
</div>
