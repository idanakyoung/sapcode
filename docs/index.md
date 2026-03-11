---
title: SAP CODE 아카데미
---

<style>
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
  letter-spacing: 0.02em;
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

.portal-list {
  margin: 0.2rem 0 0.4rem;
  padding-left: 1rem;
}

.portal-list li {
  margin: 0.22rem 0;
}

.portal-list strong {
  color: #222431;
}

.portal-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.9rem;
  margin-top: 0.4rem;
}

.portal-table th,
.portal-table td {
  border: 1px solid #f0d7eb;
  padding: 0.45rem 0.55rem;
  vertical-align: top;
}

.portal-table thead {
  background: var(--accent-soft);
}

.portal-table th {
  font-weight: 700;
}

.portal-checklist {
  list-style: none;
  padding-left: 0;
  margin: 0.3rem 0 0;
  font-size: 0.9rem;
}

.portal-checklist li {
  margin: 0.22rem 0;
}

.portal-side-card {
  margin-bottom: 1rem;
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

@media (max-width: 820px) {
  .portal-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<div class="portal">

  <header class="portal-header">
    <h1 class="portal-title">🌼 SAP CODE 아카데미 공부 정리</h1>
    <p class="portal-sub"><strong>기간</strong> 2025.10.21 ~ 2026.07.15</p>
    <p class="portal-sub"><strong>목표</strong> ABAP + UI5/Fiori 통합 개발 역량 강화 및 실무형 프로젝트 완성</p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>📚 학습 목차</h2>
        <p class="portal-small">각 과정 이름을 클릭하면 상세 정리 페이지로 이동합니다.</p>

        <ul class="portal-list">
          <li>🎨 <strong>UX1</strong> — <a href="/sapcode/studies/ux1/">UX1 정리</a> · UI5 Programming (HTML / JS / Binding / Routing)</li>
          <li>⚙️ <strong>ABAP1</strong> — <a href="/sapcode/studies/abap1/">ABAP1 정리</a> · ABAP Overview / Basic Elements / Modularization / FM / BAPI / Internal Table</li>
          <li>🧱 <strong>ABAP2</strong> — <a href="/sapcode/studies/abap2/">ABAP2 정리</a> · Data Modeling / Open SQL / Dictionary / View / Search Help / Screen / ALV</li>
          <li>💾 <strong>ABAP3</strong> — <a href="/sapcode/studies/abap3/">ABAP3 정리</a> · Screen Program / Report 개발 / ALV Screen / ALV Grid / Multiple DB Tables</li>
          <li>🧩 <strong>ABAP4</strong> — <a href="/sapcode/studies/abap4/">ABAP4 정리</a> · BC414 Open SQL / BC401 Objects / Inheritance / Casting / Interface / OO Events</li>
          <li>🏗 <strong>ABAP5</strong> — <a href="/sapcode/studies/abap5/">ABAP5 정리</a> · HANA / New Open SQL / ADBC / CDS / Association / Input Parameter / POU / New Syntax</li>
          <li>🌐 <strong>Gateway</strong> — <a href="/sapcode/studies/ux23/">Gateway 정리</a> · OData / Association / Filter / Paging / CRUD</li>
          <li>🖥 <strong>UI5 Fiori</strong> — <a href="/sapcode/studies/ux23/">UI5 Fiori 정리</a> · Binding / Popup / SearchHelp / Metadata Extension / Object Page / Service Binding</li>
          <li>🚀 <strong>Project</strong> — <a href="/sapcode/studies/project/">Project 정리</a> · 통합 프로젝트</li>
          <li>🎓 <strong>Job Fair</strong> — <a href="/sapcode/studies/jobfair/">Job Fair 기록</a> · 수료 / 취업 준비</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🗺 과정별 로드맵 요약</h2>

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
              <td>10월 ~ 11월 초</td>
              <td>HTML/CSS/JS 기본 문법, SAP UI5 View/Controller, Data Binding, Event, Routing</td>
              <td>UI5 예제 화면, Lesson별 실습 코드, 화면 단위 정리 문서</td>
            </tr>
            <tr>
              <td><strong>ABAP1</strong></td>
              <td>11/14 ~ 11/24</td>
              <td>ABAP Overview, Basic Language Elements, Modularization, Function Module, BAPI, Internal Table</td>
              <td>기초 문법 정리, FM/BAPI 예제, Internal Table 실습, 개발 패턴 노트</td>
            </tr>
            <tr>
              <td><strong>ABAP2</strong></td>
              <td>11/25 ~ 12/12</td>
              <td>Data Modeling & Retrieval, Open SQL & Inner Join, Dictionary, Performance During Table Access, Views, Search Help, Screen, ALV, 1차 시험 정리</td>
              <td>Dictionary 객체 정리, SQL/Join 예제, Screen/ALV 예제, 시험 추가 정리 및 실습 요약</td>
            </tr>
            <tr>
              <td><strong>ABAP3</strong></td>
              <td>12/15 ~ 12/31</td>
              <td>Screen Program(1~4), 전공 리포트 개발, ALV Screen 생성, ALV Grid(1~4), Multiple Database Tables</td>
              <td>Screen Program 실습, Report Program 예제, ALV Grid 예제, 다중 테이블 조회 정리</td>
            </tr>
            <tr>
              <td><strong>ABAP4</strong></td>
              <td>12/31 ~ 1/6</td>
              <td>Open SQL(BC414), Objects(BC401), Inheritance, Casting, Interface, Object-Oriented Events, Repository Objects</td>
              <td>OO 개념 정리, 상속/캐스팅 예제, 인터페이스 실습, 객체지향 ABAP 정리</td>
            </tr>
            <tr>
              <td><strong>ABAP5</strong></td>
              <td>1/7 ~ 2/6</td>
              <td>SAP HANA/Open SQL, New Open SQL, ADBC, HANA ALV, CDS View, Annotation, Association, Built-in Functions, Input Parameters, POU, ABAP New Syntax</td>
              <td>CDS 예제, New Syntax 정리, 2차 시험/풀이, POU 정리, Quiz 및 실전형 코드 예제</td>
            </tr>
            <tr>
              <td><strong>Gateway</strong></td>
              <td>2/9 ~ 2/19</td>
              <td>OData & SAP Gateway Service 개념, Association, Filter, Paging, Create/Update/Delete</td>
              <td>Gateway Service 생성, Association 처리, CRUD 예제, OData 구조 정리</td>
            </tr>
            <tr>
              <td><strong>UI5 Fiori</strong></td>
              <td>2/20 ~ 3/4</td>
              <td>SAP UI5 Binding Create/Update/Delete, SearchHelp + Filtering, Popup View, Fiori + CDS View + Metadata Extension, Hidden, SelectionField, Object Page, Value Help, Chart, Service Definition/Binding/Search Field</td>
              <td>Fiori UI 화면 예제, Metadata Extension 정리, Service Binding 실습, UI5/Fiori 시험 정리</td>
            </tr>
            <tr>
              <td><strong>모듈 교육</strong></td>
              <td>3/5 ~ 3/11</td>
              <td>SD, MM, PP, FI, CO 개요 및 업무 흐름 이해</td>
              <td>모듈별 개념 정리, 프로세스 흐름 요약, 통합 프로젝트 사전 이해</td>
            </tr>
            <tr>
              <td><strong>Project</strong></td>
              <td>3월 ~ 7월</td>
              <td>ABAP + UI5/Fiori 통합 업무 시나리오 구현, 서비스 설계, 화면 개발, 발표 준비</td>
              <td>팀 프로젝트 결과물, 기술 문서, 설계서, 발표 자료</td>
            </tr>
            <tr>
              <td><strong>Job Fair</strong></td>
              <td>7월</td>
              <td>포트폴리오 정리, 발표 준비, 수료 및 취업 준비</td>
              <td>포트폴리오 사이트, 발표 자료, 피드백 기록</td>
            </tr>
          </tbody>
        </table>
      </section>

    </div>

    <aside>

      <section class="portal-card portal-side-card">
        <h2>📅 월별 진행 일정</h2>
        <pre style="font-size:0.85rem; line-height:1.4; background:#111827; color:#e5e7eb; border-radius:10px; padding:0.7rem 0.9rem; border:1px solid #0f172a;">
            10월        | UX1 시작 (UI5 / HTML / JS)
            11월 중순   | ABAP1 시작 (기초 문법 / Modularization / FM / BAPI)
            11월 말~12월 | ABAP2 진행 (Open SQL / Dictionary / View / Screen / ALV)
            12월 중순~말 | ABAP3 진행 (Screen Program / Report / ALV Grid / Multi DB)
            12월 말~1월 초 | ABAP4 진행 (OO ABAP / Inheritance / Casting / Interface)
            1월~2월 초 | ABAP5 진행 (HANA / CDS / New Syntax / POU / 시험 정리)
            2월 중순    | Gateway 진행 (OData / Association / Filter / Paging / CRUD)
            2월 말~3월 초 | UI5 Fiori 진행 (Binding / Popup / Metadata Extension / Service Binding)
            3월 초      | SD / MM / PP / FI / CO 모듈 교육
            3~7월       | 팀 프로젝트 (ABAP + UI5 통합 개발)
            7월         | Job Fair, 최종 발표, 수료식
            </pre>
          </section>

      <section class="portal-card portal-side-card">
        <h2>✅ 학습 진행 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] UX1 Lesson별 정리 완료</li>
          <li>[ ] ABAP1 기초 문법 / FM / BAPI / Internal Table 정리</li>
          <li>[ ] ABAP2 Open SQL / Dictionary / Screen / ALV 정리</li>
          <li>[ ] ABAP3 Screen Program / ALV Grid / Multi DB Tables 정리</li>
          <li>[ ] ABAP4 OO ABAP / Inheritance / Interface / Casting 정리</li>
          <li>[ ] ABAP5 CDS / HANA / New Syntax / POU / 시험 정리</li>
          <li>[ ] Gateway OData CRUD / Association / Paging 정리</li>
          <li>[ ] UI5 Fiori Binding / Metadata Extension / Service Binding 정리</li>
          <li>[ ] 모듈 교육 내용 정리</li>
          <li>[ ] Project 결과물 문서화</li>
          <li>[ ] Job Fair 준비 (포트폴리오, 발표 자료)</li>
        </ul>
      </section>

      <section class="portal-card portal-side-card">
        <h2>🛠 기술 스택</h2>
        <h3>Frontend</h3>
        <p class="portal-small">HTML, CSS, JavaScript, SAP UI5, SAP Fiori</p>
        <h3>Backend</h3>
        <p class="portal-small">SAP ABAP, Open SQL, New Open SQL, HANA, CDS View, ABAP OO</p>
        <h3>Integration</h3>
        <p class="portal-small">OData, SAP Gateway, Service Definition, Service Binding</p>
        <h3>Tools</h3>
        <p class="portal-small">Eclipse ADT, SAP GUI, GitHub, Notion</p>
      </section>

    </aside>
  </section>
</div>
