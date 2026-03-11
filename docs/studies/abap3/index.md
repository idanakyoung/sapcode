---
title: ABAP3 — Open SQL & ABAP Objects
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
    <h1>💾 ABAP3 — Open SQL & ABAP Objects</h1>
    <p>BC414의 Open SQL과 BC401의 객체지향 ABAP 기초를 중심으로, 상속·캐스팅·인터페이스·이벤트·Repository Objects까지 학습한 과정을 정리합니다.</p>
    <p class="small">기간: 2025.12.31 ~ 2026.01.06</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>✏️ 학습 구성 <span class="badge">Lesson Index</span></h2>
      <table class="tbl">
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap3/Lesson1' | relative_url }}">Lesson 1</a></td>
          <td>OPEN SQL (BC414) (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap3/Lesson2' | relative_url }}">Lesson 2</a></td>
          <td>Objects (BC401) (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap3/Lesson3' | relative_url }}">Lesson 3</a></td>
          <td>Inheritance and Casting (1) (BC401)</td>
        </tr>
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap3/Lesson4' | relative_url }}">Lesson 4</a></td>
          <td>Interfaces and Casting (2) (BC401)</td>
        </tr>
        <tr>
          <td class="col-tag">01/02</td>
          <td><a href="{{ '/studies/abap3/Lesson5' | relative_url }}">Lesson 5</a></td>
          <td>Object-Oriented Events & Repository Objects (BC401)</td>
        </tr>
        <tr>
          <td class="col-tag">01/06</td>
          <td><a href="{{ '/studies/abap3/Lesson6' | relative_url }}">Lesson 6</a></td>
          <td>Objects (BC401)</td>
        </tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📈 주요 개념</h2>
        <ul class="list">
          <li>BC414 기반 Open SQL 문법 확장</li>
          <li>BC401 기반 객체지향 ABAP 구조</li>
          <li>Inheritance, Casting, Interface 개념</li>
          <li>Object-Oriented Events</li>
          <li>Repository Objects 이해</li>
        </ul>
      </div>

      <div class="card">
        <h2>🔥 이해도 진행도</h2>

        <div class="prow"><span>Open SQL</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>ABAP Objects</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>Inheritance / Casting / Interface</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>OO Events / Repository Objects</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>💡 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>Open SQL 심화 문법 이해</li>
          <li>ABAP Objects 기본 구조 학습</li>
          <li>상속, 캐스팅, 인터페이스 실습</li>
          <li>이벤트와 Repository Objects 개념 정리</li>
        </ul>

        <div class="note">
          <code>전통적 ABAP 로직에서 객체지향 ABAP로 넘어가는 핵심 전환 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com/" target="_blank">SAP Help Portal</a></li>
          <li><a href="https://developers.sap.com/" target="_blank">SAP Developers</a></li>
          <li>BC401 / BC414 관련 강의 자료</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
