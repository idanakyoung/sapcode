---
title: SAP CODE 아카데미
---

<style>
/* ===== SAPCODE 포털 레이아웃 ===== */

:root {
  --portal-bg: #fff7fb;
  --portal-card-bg: #ffffff;
  --portal-border: #ffd6ec;
  --portal-shadow: 0 12px 30px rgba(255, 143, 180, 0.22);

  --text-main: #222431;
  --text-sub: #5f6472;
  --text-muted: #9a9fb0;

  --accent: #ff7eb8;
  --accent-soft: #fff0f7;
  --accent-strong: #e74b8a;

  --link: #0066cc;
  --link-hover: #004c99;
}

body {
  background: radial-gradient(circle at top left, #ffe6f5 0, #fff7fb 40%, #ffffff 100%);
}

/* 페이지 폭 */
.portal {
  max-width: 1100px;
  margin: 2.2rem auto 3rem;
  padding: 0 1.2rem;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI",
    "Noto Sans KR", sans-serif;
}

/* 상단 헤더 카드 */
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
  letter-spacing: 0.02em;
}

.portal-sub {
  font-size: 0.95rem;
  color: var(--text-sub);
  margin: 0.1rem 0;
}

.portal-badges {
  margin-top: 0.8rem;
}

/* 메인 2열 레이아웃 */
.portal-grid {
  display: grid;
  grid-template-columns: 2.1fr 1fr;
  gap: 1.2rem;
}

/* 카드 공통 */
.portal-card {
  background: var(--portal-card-bg);
  border-radius: 16px;
  border: 1px solid var(--portal-border);
  padding: 1.4rem 1.6rem;
  box-shadow: 0 8px 22px rgba(0,0,0,0.03);
}

.portal-card h2 {
  font-size: 1.2rem;
  margin-top: 0;
  margin-bottom: 0.6rem;
  display: flex;
  align-items: center;
  gap: 0.4rem;
}

.portal-card h3 {
  font-size: 1rem;
  margin-top: 0.9rem;
  margin-bottom: 0.4rem;
}

/* 학습 목차 리스트 */
.portal-list {
  margin: 0.2rem 0 0.4rem;
  padding-left: 1rem;
}

.portal-list li {
  margin: 0.18rem 0;
}

.portal-list strong {
  color: #222431;
}

/* 로드맵 테이블 */
.portal-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.9rem;
  margin-top: 0.4rem;
}

.portal-table th,
.portal-table td {
  border: 1px solid #f0d7eb;
  padding: 0.4rem 0.5rem;
  vertical-align: top;
}

.portal-table thead {
  background: var(--accent-soft);
}

.portal-table th {
  font-weight: 700;
}

/* 체크리스트 */
.portal-checklist {
  list-style: none;
  padding-left: 0;
  margin: 0.3rem 0 0;
  font-size: 0.9rem;
}

.portal-checklist li {
  margin: 0.18rem 0;
}

/* 오른쪽 사이드 카드용 */
.portal-side-card {
  margin-bottom: 1rem;
}

.portal-small {
  font-size: 0.85rem;
  color: var(--text-muted);
}

/* 링크 */
.portal a {
  color: var(--link);
  text-decoration: none;
}

.portal a:hover {
  color: var(--link-hover);
  text-decoration: underline;
}

/* 모바일 대응 */
@media (max-width: 820px) {
  .portal-grid {
    grid-template-columns: 1fr;
  }
}
</style>


<div class="portal">

  <header class="portal-header">
    <h1 class="portal-title">🌼 SAP CODE 아카데미 공부 정리</h1>
    <p class="portal-sub"><strong>기간</strong> 2025.10.21 ~ 2026.07.15 (9개월 / 1,440시간)</p>
    <p class="portal-sub"><strong>목표</strong> ABAP + UI5/Fiori 통합 개발 역량 강화 및 실무형 프로젝트 완성</p>

  </header>

  <section class="portal-grid">

    <!-- ===== 왼쪽 메인 영역 ===== -->
    <div>

      <!-- 학습 목차 -->
      <section class="portal-card">
        <h2>📚 학습 목차</h2>
        <p class="portal-small">각 과정 이름을 클릭하면 상세 정리 페이지로 이동합니다.</p>

        <ul class="portal-list">
          <li>🎨 <strong>UX1</strong> — <a href="https://idanakyoung.github.io/sapcode/ux1/">UX1 정리</a> · UI5 Programming (HTML/JS)</li>
          <li>⚙️ <strong>ABAP1</strong> — <a href="https://idanakyoung.github.io/sapcode/abap1/">ABAP1 정리</a> · Dictionary / Screen / 기본 구조</li>
          <li>🧱 <strong>ABAP2</strong> — <a href="https://idanakyoung.github.io/sapcode/abap2/">ABAP2 정리</a> · Report / DB Update / OO</li>
          <li>💾 <strong>ABAP3</strong> — <a href="https://idanakyoung.github.io/sapcode/abap3/">ABAP3 정리</a> · CDS / HANA / New Syntax</li>
          <li>🌐 <strong>UX2+3</strong> — <a href="https://idanakyoung.github.io/sapcode/ux23/">UX2+3 정리</a> · Gateway / Fiori</li>
          <li>🚀 <strong>Project</strong> — <a href="https://idanakyoung.github.io/sapcode/project/">Project 정리</a> · 통합 프로젝트</li>
          <li>🎓 <strong>Job Fair</strong> — <a href="https://idanakyoung.github.io/sapcode/jobfair/">Job Fair 기록</a> · 수료 / 취업 준비</li>
        </ul>
      </section>

      <!-- 과정별 로드맵 -->
      <section class="portal-card">
        <h2>🗺️ 과정별 로드맵 요약</h2>

        <table class="portal-table">
          <thead>
            <tr>
              <th>과정</th>
              <th>기간</th>
              <th>주요 내용</th>
              <th>결과물 / 학습 증거</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>UX1</strong></td>
              <td>10월 ~ 12월 초</td>
              <td>HTML/CSS/JS 기본 문법, SAP UI5 View/Controller, DataBinding, Routing</td>
              <td>UI5 예제 화면, JS 실습 코드, Lesson별 정리 문서</td>
            </tr>
            <tr>
              <td><strong>ABAP1</strong></td>
              <td>11월 ~ 12월 초</td>
              <td>Data Dictionary, Table/Structure, Screen Programming(PBO/PAI)</td>
              <td>DDIC 테이블/뷰 정의, 모듈풀 프로그램, Screen 예제</td>
            </tr>
            <tr>
              <td><strong>ABAP2</strong></td>
              <td>12월 ~ 1월</td>
              <td>Report Program, Internal Table, Open SQL, ABAP OO 기초</td>
              <td>Select Report, ALV Report, OO 예제 클래스</td>
            </tr>
            <tr>
              <td><strong>ABAP3</strong></td>
              <td>1월 ~ 2월</td>
              <td>ABAP for HANA, CDS View, New Syntax, AMDP 개념</td>
              <td>CDS View 정의, HANA 기반 조회 프로그램</td>
            </tr>
            <tr>
              <td><strong>UX2+3</strong></td>
              <td>2월 ~ 3월</td>
              <td>OData Service, SAP Gateway, Fiori Launchpad 등록</td>
              <td>간단한 Fiori 앱, OData Service 구현</td>
            </tr>
            <tr>
              <td><strong>Project</strong></td>
              <td>3월 ~ 7월</td>
              <td>ABAP + UI5/Fiori 통합 업무 시나리오 구현</td>
              <td>팀 프로젝트 결과물, 화면 설계서, 기술 문서</td>
            </tr>
            <tr>
              <td><strong>Job Fair</strong></td>
              <td>7월</td>
              <td>포트폴리오 정리, 모의 인터뷰, 기업 설명회</td>
              <td>발표 자료, 포트폴리오 사이트, 피드백 기록</td>
            </tr>
          </tbody>
        </table>
      </section>

    </div>

    <!-- ===== 오른쪽 사이드 영역 ===== -->
    <aside>

      <!-- 월별 일정 -->
      <section class="portal-card portal-side-card">
        <h2>📅 월별 진행 일정</h2>
        <pre style="font-size:0.85rem; line-height:1.4; background:#111827; color:#e5e7eb; border-radius:10px; padding:0.7rem 0.9rem; border:1px solid #0f172a;">
10월  | UX1 시작 (UI5 / HTML / JS)
11월  | ABAP1 병행 시작
12월  | ABAP2 진입, ABAP1 마무리 / 멘토링
1월   | ABAP3 시작 (CDS, HANA)
2월   | UX2+3 시작 (Fiori / Gateway)
3~7월 | 팀 프로젝트 (ABAP + UI5 통합 개발)
7월   | Job Fair, 최종 발표, 수료식
        </pre>
      </section>

      <!-- 체크리스트 -->
      <section class="portal-card portal-side-card">
        <h2>✅ 학습 진행 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] UX1 전체 Lesson 정리</li>
          <li>[ ] ABAP1 Dictionary / Screen 실습</li>
          <li>[ ] ABAP2 Report + DB Update 예제</li>
          <li>[ ] ABAP3 CDS / New Syntax 정리</li>
          <li>[ ] UX2+3 OData + Fiori 앱 구현</li>
          <li>[ ] Project 결과물 문서화</li>
          <li>[ ] Job Fair 준비 (포트폴리오, 발표 자료)</li>
        </ul>
      </section>

      <!-- 기술 스택 -->
      <section class="portal-card portal-side-card">
        <h2>🛠 기술 스택</h2>
        <h3>Frontend</h3>
        <p class="portal-small">HTML, CSS, JavaScript, SAP UI5</p>
        <h3>Backend</h3>
        <p class="portal-small">SAP ABAP, HANA, CDS View</p>
        <h3>Integration</h3>
        <p class="portal-small">OData, SAP Gateway</p>
        <h3>Tools</h3>
        <p class="portal-small">Eclipse ADT, SAP GUI, GitHub, Notion</p>
      </section>

    </aside>

  </section>

</div>
