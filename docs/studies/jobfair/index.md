---
title: JobFair — 취업 연계 / 포트폴리오 정리
---

<style>
:root {
  --bg1: #fff1f1;
  --bg2: #ffffff;
  --card: #ffffff;
  --border: #ffd6d6;
  --shadow: 0 14px 34px rgba(255, 107, 107, 0.18);
  --text: #1f2230;
  --sub: #5e6475;
  --muted: #9aa0b2;
  --link: #e63946;
  --grad: linear-gradient(90deg,
    #ff6b6b 0%,
    #ffa8a8 40%,
    #ffe3e3 100%
  );
}

body {
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fff7f7 40%, var(--bg2) 100%);
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
  background: #fff8f8;
  color: var(--sub);
}

.tbl {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  border-radius: 14px;
  border: 1px solid rgba(255, 214, 214, 0.9);
  overflow: hidden;
}
.tbl th, .tbl td {
  padding: 0.72rem 0.75rem;
  border-bottom: 1px solid rgba(255, 214, 214, 0.65);
}
.tbl th {
  background: #fff4f4;
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
  border: 1px dashed rgba(255, 214, 214, 0.9);
  background: #fff9f9;
  font-size: 0.9rem;
}
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🎯 JobFair — 취업 연계 / 포트폴리오 정리</h1>
    <p>이력서, 기술 포트폴리오, 면접 준비 등 실전 취업 준비를 위한 정리 과정입니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>🗂️ 과정 구성 <span class="badge">Lesson Index</span></h2>
      <table class="tbl">
        <tr><td class="col-tag">JF 1</td><td><a href="{{ '/studies/jobfair/Lesson1' | relative_url }}">Lesson 1</a></td><td>이력서 / 커리어 로드맵</td></tr>
        <tr><td class="col-tag">JF 2</td><td><a href="{{ '/studies/jobfair/Lesson2' | relative_url }}">Lesson 2</a></td><td>포트폴리오 구성</td></tr>
        <tr><td class="col-tag">JF 3</td><td><a href="{{ '/studies/jobfair/Lesson3' | relative_url }}">Lesson 3</a></td><td>GitHub 정리</td></tr>
        <tr><td class="col-tag">JF 4</td><td><a href="{{ '/studies/jobfair/Lesson4' | relative_url }}">Lesson 4</a></td><td>프로젝트 요약 정리</td></tr>
        <tr><td class="col-tag">JF 5</td><td><a href="{{ '/studies/jobfair/Lesson5' | relative_url }}">Lesson 5</a></td><td>Mock Interview</td></tr>
        <tr><td class="col-tag">JF 6</td><td><a href="{{ '/studies/jobfair/Lesson6' | relative_url }}">Lesson 6</a></td><td>최종 포트폴리오 업로드</td></tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>🔥 진행 현황</h2>
        <div class="prow"><span>포트폴리오</span><span class="pct">60%</span></div>
        <div class="meter"><span style="width:60%"></span></div>

        <div class="prow"><span>이력서 / 소개</span><span class="pct">40%</span></div>
        <div class="meter"><span style="width:40%"></span></div>

        <div class="prow"><span>면접 준비</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>
      </div>

      <div class="card">
        <h2>💼 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>커리어 기반 이력서 작성 및 정리</li>
          <li>프로젝트 포트폴리오 문서화</li>
          <li>면접용 GitHub 정리 및 발표 자료</li>
        </ul>
        <div class="note">
          <code>실전 취업 준비와 개발자 포트폴리오 완성을 위한 실습</code>
        </div>
      </div>

      <div class="card">
        <h2>🔗 참고 자료</h2>
        <ul class="list">
          <li><a href="https://resume.io/" target="_blank">이력서 템플릿 사이트</a></li>
          <li><a href="https://www.canva.com/" target="_blank">포트폴리오 디자인</a></li>
          <li><a href="https://github.com/" target="_blank">GitHub 활용법</a></li>
        </ul>
      </div>

    </aside>
  </div>
</div>
