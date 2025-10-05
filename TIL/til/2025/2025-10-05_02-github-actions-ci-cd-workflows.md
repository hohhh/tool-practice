# 🧩 TIL | 2025-10-06 | GitHub Actions 고급 기능 설정

---

## 📌 학습 주제

- GitHub Actions의 고급 기능
  (Cache, Parallel, Outputs, 조건 실행(if), 스케줄 실행(Schedule / Cron), 중복 실행 방지)
- 워크플로우 구조 이해 및 효율적 파이프라인 구성
- Vercel 배포 자동화 프로세스 정리 (production.yml)
- 브랜치 전략 및 default branch 전환(dev -> main)

---

## ✅ 배운 핵심 개념

### 📂 1. Job 캐시(Cache)

- **의도:** 의존성(`node_modules`) 설치 속도 개선
- **핵심:** `actions/cache@v4`를 이용해 `~/.npm` 폴더 캐시함
- **캐시 키 구성:** `${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}`
  -> 의존성 변경 시 새로운 캐시 자동 생성
- **복원 우선순위:** `key` -> `restore-keys` 순서로 탐색

🧠 **결론:** 캐시는 반복 실행 시 빌드 속도를 단축시켜 CI 효율을 높인다.

---

### 📂 2. 병렬 실행 (Parallel Jobs)

- 여러 `jobs:` 를 동이해적으로 실행 가능
- `runs-on:` 을 동일하게 두면 병렬로 실행됨
- 각 Job은 서로 독립된 가상 머신(VM, Virtual Machine)에서 실행되며, 의존성은 공유되지 않음
  (= job 간에 디스크, 메모리, 환경이 완전히 분리되어 있어서 명시적으로 데이터를 주고받지 않으면 아무것도 공유되지 않는다는 뜻)

#### 🔹 **해결방법:**

| 구분               | 역할               | 해결 방식                                                      |
| ------------------ | ------------------ | -------------------------------------------------------------- |
| **1️⃣ `needs`**     | 실행 **순서 제어** | “이 job은 저 job이 끝나야 실행돼”를 정의                       |
| **2️⃣ `outputs`**   | **데이터 전달**    | 이전 job에서 만든 특정 값(문자열, 경로 등)을 다음 job으로 전달 |
| **3️⃣ `artifacts`** | **파일 공유**      | 실제 파일(빌드 결과물 등)을 job 간 공유                        |

```yaml
jobs:
  first_job:
    runs-on: ubuntu-latest
  second_job:
    runs-on: ubuntu-latest
```

🧠 **결론:** 동등 실행이 가능한 작업(예: 테스트 세트, Lint, 빌드)을 병렬 처리하여 시간을 단축할 수 있다.

---

### 📂 3. Job 간 의존 관계 (needs)

- 특정 Job이 완료되어야 다음 Job이 실행되도록 제어
- `needs: job_id` 로 연결
- `if: success()` 조건으로 성공 시에만 다음 Job 진행 가능

🧠 **결론:** 테스트 -> 빌드 -> 배포 순으로 명확한 파이프라인 제어 가능.

---

### 📂 4. Job 간 데이터 전달 (outputs)

- `outputs:` 키를 이용해 Job 간 변수 전달 가능
- 출력값 참조
  | 문법 | 의미 | 예시 |
  | ------------------------------ | ------------------------------------- | ----------------------------------- |
  | `steps.<id>.outputs.<key>` | step 내부에서 출력값 가져오기 | `${{ steps.build.outputs.path }}` |
  | `jobs.<job-id>.outputs.<key>` | job이 정의한 출력값 가져오기 | `${{ jobs.build.outputs.result }}` |
  | `needs.<job-id>.outputs.<key>` | 이전 job의 출력값 참조 (다른 job에서) | `${{ needs.build.outputs.result }}` |

- 예: build 결과나 토큰 값 전달 시 유용

🧠 **결론:** 워크플로우 내 Job 간 데이터 의존성이 필요한 경우 outputs로 연결.

---

### 📂 5. 조건 실행 (if)

- 특정 브랜치나 이벤트에 따라 단계 실행 제어 가능
- `if: github.ref == 'refs/heads/dev'`
- `if: github.ref == 'refs/heads/main'`

🧠 **결론:** 브랜치 별 환경(dev -> staging, main -> production) 분기 처리에 필수.

---

### 📂 6. 스케줄 실행 (Schedule / Cron)

- `on.schedule` 로 주기적인 워크플로우 실행 가능
- `*`: 모든 값(all)
- 예: `cron: '0 0 * * *'` -> 매일 자정(UTC)

#### 🔹 **표현식 규칙:**

`ubc88(0–59) uc2dc(0–23) uc77c(1–31) uc6d4(1–12) uc694일(0–6, 0=일요일)`

```
┌──────── 분 (0 - 59)
│ ┌────── 시간 (0 - 23)
│ │ ┌──── 일 (1 - 31)
│ │ │ ┌── 월 (1 - 12)
│ │ │ │ ┌ 요일 (0 - 6, 0=일요일)
│ │ │ │ │
│ │ │ │ │
* * * * *
```

🧠 **결론:** 정기 점검, 자동 빌드, 데이터 백업 등에 활용 가능.

---

### 📂 7. concurrency (중복 실행 방지)

```yaml
concurrency:
  group: prod-${{ github.ref }}
  cancel-in-progress: true
```

- 동일 브랜치에서 중복 실행되는 워크플로우를 자동 취소
- `group` 으로 구분 (브랜치별 관리)
- `cancel-in-progress: true` -> 최신 실행만 유지

🧠 **결론:** main 브랜치에서 불필요한 중복 배포 방지.

---

## 📚 참고 링크

1. [github actions로 테스트 자동화하기]()
2. [github actions의 다양한 이벤트]()
3. [github actions의 추가 기능]()
4. [Crontab Guru – Cron 표현식 도우미](https://crontab.guru/)

---

## 💡 한 줄 요약

> GitHub Actions의 고급 기능은 단순한 CI 도구를 넘어,
> **자동화-병렬 처리-스케줄링-배포**까지 기능하는 통합 파이프라인 엔진을 구축하게 한다.
> 코드 한 줄의 변경이 자동으로 테스트되고, 최적화와 배포로 이어지는 시스템 완성한다.
