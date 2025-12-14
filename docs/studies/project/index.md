---
title: Project — 통합 실무 프로젝트
---

<style>
:root {
  --bg1: #fff3e5;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #ffe4c2;
  --shadow: 0 14px 34px rgba(255, 173, 96, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #e17c00;
  --grad: linear-gradient(90deg,
    #ffbe7b 0%,
    #ffc98f 25%,
    #ffd7a8 55%,
    #ffe4c2 78%,
    #fff3e5 100%
  );
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fff8f2 40%, var(--bg2) 100%);
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
  background: #fff8f2;
  color: var(--sub);
}

.tbl {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 14px;
  border: 1px solid rgba(255, 228, 194, 0.9);
  overflow: hidden;
}

.tbl th,
.tbl td {
  padding: 0.72rem 0.75rem;
  border-bottom: 1px solid rgba(255, 228, 194, 0.65);
}
.tbl th {
  background: #fff4e6;
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
.note {
  margin-top: 0.8rem;
  padding: 0.8rem;
  border-radius: 14px;
  border: 1px dashed rgba(255, 228, 194, 0.9);
  background: #fffdf7;
  font-size: 0.9rem;
}
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🚀 Project — 통합 실무 프로젝트</h1>
    <p>지금까지 학습한 ABAP / UI5 / Gateway 기술을 통합하여 <strong>Business Application</strong> 을 완성합니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗂️ 과정 구성 <span class="badge">Lesson Index</span></h2>
      <table class="tbl">
        <tr><td class="col-tag">PJ 1</td><td><a href="{{ '/studies/project/Lesson1' | relative_url }}">Lesson 1</a></td><td>요구사항 분석</td></tr>
        <tr><td class="col-tag">PJ 2</td><td><a href="{{ '/studies/project/Lesson2' | relative_url }}">Lesson 2</a></td><td>데이터 모델 설계</td></tr>
        <tr><td class="col-tag">PJ 3</td><td><a href="{{ '/studies/project/Lesson3' | relative_url }}">Lesson 3</a></td><td>CDS View & Annotation</td></tr>
        <tr><td class="col-tag">PJ 4</td><td><a href="{{ '/studies/project/Lesson4' | relative_url }}">Lesson 4</a></td><td>OData 개발 (SEGW)</td></tr>
        <tr><td class="col-tag">PJ 5</td><td><a href="{{ '/studies/project/Lesson5' | relative_url }}">Lesson 5</a></td><td>UI5 화면 구성</td></tr>
        <tr><td class="col-tag">PJ 6</td><td><a href="{{ '/studies/project/Lesson6' | relative_url }}">Lesson 6</a></td><td>데이터 연결 및 테스트</td></tr>
        <tr><td class="col-tag">PJ 7</td><td><a href="{{ '/studies/project/Lesson7' | relative_url }}">Lesson 7</a></td><td>디버깅 / 오류 처리</td></tr>
        <tr><td class="col-tag">PJ 8</td><td><a href="{{ '/studies/project/Lesson8' | relative_url }}">Lesson 8</a></td><td>최종 배포 및 문서화</td></tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>🔥 이해도 진행도</h2>
        <div class="prow"><span>UI 개발</span><span class="pct">70%</span></div>
        <div class="meter"><span style="width:70%"></span></div>

        <div class="prow"><span>OData 연동</span><span class="pct">50%</span></div>
        <div class="meter"><span style="width:50%"></span></div>

        <div class="prow"><span>디버깅/테스트</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>
      </div>

      <div class="card">
        <h2>🧩 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>CDS / OData / UI5를 연동한 실전 프로젝트</li>
          <li>실제 업무에 가까운 요구사항 기반 개발</li>
          <li>UI/UX 구현부터 백엔드 연동까지 실습</li>
        </ul>
        <div class="note">
          <code>SAP 개발 전체 플로우를 경험하며 실무 감각을 키우는 모듈</code>
        </div>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li><a href="https://experience.sap.com/fiori-design-web/" target="_blank">Fiori Design Guideline</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li><a href="https://sapui5.hana.ondemand.com/" target="_blank">SAPUI5 SDK</a></li>
        </ul>
      </div>

    </aside>
  </div>
</div>
