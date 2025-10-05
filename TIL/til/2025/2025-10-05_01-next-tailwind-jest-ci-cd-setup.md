# 🧩 TIL | 2025-10-05 | Next.js + Tailwind + Jest + CI/CD 세팅 요약

---

## ⚙️ 프로젝트 환경

- **Framework:** Next.js (App Router)
- **Styling:** Tailwind CSS
- **Test:** Jest + @testing-library/react
- **CI/CD:** GitHub Actions
- **Deploy:** Vercel

---

## 📌 학습 주제

- 프로젝트 기본 세팅
- Jest 테스트 환경 세팅 및 GitHub Actions(CI) 연동
- CI/CD 개념 이해 및 자동화 흐름 점검
- 목적에 따른 깃모지 선택 기준 확인 (test/cicd)

---

## ✅ 배운 핵심 개념

### 📂 1. CI/CD란?

코드 변경을 자동으로 **검증(CI)** 하고,  
검증된 코드를 자동으로 **배포(CD)** 하는 자동화 프로세스  
🧠 한마디로, "**안전하게 배포하기 위한 자동화 시스템**”

#### 🔹 CI (Continuous Integration)

- **충돌, 에러를 조기에 발견**하는 과정

#### 🔹 CD (Continuous Delivery / Deployment)

- **Delivery:** 테스트를 통과한 코드를 자동으로 배포 “준비” 상태까지 진행
- **Deployment:** 모든 테스트를 통과하면 자동으로 “배포”까지 진행

#### 🔹 CI/CD가 필요한 이유

직접 브랜치 병합, 로컬 테스트, 수동 배포를 반복하면  
충돌, 누락, 버전 불일치 위험이 높아진다.  
CI/CD를 통해 **빌드 -> 테스트 -> 배포** 전 과정을 자동화하면  
개발자 개입 없이도 품질이 일관되게 유지된다.

---

### 📂 2. npm i vs npm ci

| 명령어                     | 의미           | 특징                                                      |
| :------------------------- | :------------- | :-------------------------------------------------------- |
| **npm i (install)**        | 의존성 설치    | `package.json` 기준으로 설치 (버전 변동 가능)             |
| **npm ci (clean install)** | CI 환경용 설치 | `package-lock.json`을 **정확히 따름**, 협업 시 사용       |
| 🧠 결론                    |                | CI/CD 환경에서는 **npm ci**로 **완전한 버전 일관성** 보장 |

---

### 📂 3. 커밋 이모지 & 스코프 정리

| 이모지 | Gitmoji 이름          | prefix | 사용 시점             | 의미                       | 예시                                             |
| :----: | :-------------------- | :----- | :-------------------- | :------------------------- | :----------------------------------------------- |
|   🧪   | `test_tube`           | test   | 테스트 코드 작성/검증 | CI 실행용, 결과 미확정     | `🧪 test: CI 워크플로우 검증용 테스트 추가`      |
|   💚   | `green_heart`         | test   | 테스트 성공/안정화 후 | 통과 상태 반영             | `💚 test: 테스트 성공 및 안정화`                 |
|   👷‍♂️   | `construction_worker` | ci     | CI/CD 환경 구성       | GitHub Actions, 파이프라인 | `👷‍♂️ ci: preview/production workflow 구성`        |
|   🧱   | `bricks`              | build  | 배포/빌드 환경 설정   | Vercel/배포 자동화         | `🧱 build: 배포 환경 구성 및 자동 배포 비활성화` |
|   🚧   | `construction`        | wip    | 작업 중/미완성        | 임시 저장, 부분 구현       | `🚧 wip: 메인 UI 작업 중`                        |

#### 🧠 사용 원칙 요약

```bash
🧱 build: ㅡ 빌드/배포 구성
🧪 test: ㅡ 테스트 검증 중
💚 test: ㅡ 테스트 성공
👷‍♂️ ci: ㅡ CI 설정
🚧 wip: ㅡ 진행 중(WIP)
```

## 📚 참고 링크

1. [Tailwind CSS 사용 이유와 사용법]()
2. [React Testing Library 소개와 컴포넌트 테스트 맛보기]()
3. [Next.js + Vercel 배포 가이드: 커스텀 CI/CD 설정하기]()
4. [gitmoji](https://gitmoji.dev/)

---

## 💡 한 줄 요약

> - Next.js + Tailwind + Jest + GitHub Actions + Vercel 조합은
>   "**로컬 개발 -> 자동 테스트(CI) -> 수동/자동 배포(CD)**" 흐름으로 완성된다.
> - 깃모지: 작업 성격을 직관적으로 보여주는 시각적 단서로 사용한다.
