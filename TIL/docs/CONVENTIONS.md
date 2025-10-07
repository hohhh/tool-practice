# 📝 Conventions & Guidelines

> MY-TIL-WIKI 작성 규칙과 가이드라인  
> **Last Updated**: 2025-01-06 | **Document Version**: 1.0

## 📋 Change Log

|    Date    | Version | Changes                                                  |
| :--------: | :-----: | :------------------------------------------------------- |
| 2025-10-06 |  v1.0   | 초기 문서 생성; 기본 커밋 룰 12종 정의; 파일명 규칙 초안 |

---

## 📜 Commit Rules

### - Core Rules

| 이모지 | 타입(Key)   | 의미                                       | 예시                                                              |
| :----: | :---------- | :----------------------------------------- | :---------------------------------------------------------------- |
|   📚   | **TIL**     | 날짜별 학습 로그                           | `📚 til: 프로젝트 세팅 및 CI/CD 워크플로우, 파이프라인 구성 정리` |
|   🔍   | **Topic**   | 주제별 정리 문서 (심화 학습/분석 중심)     | `🔍 topic: React Hooks 정리 업데이트`                             |
|   💻   | **Snippet** | 코드 조각, 설정, 함수 등 스니펫 추가/수정  | `💻 snippet: debounce 함수 추가`                                  |
|   🐛   | **Error**   | 에러 원인 및 해결 과정 기록                | `🐛 error: npm install 오류 해결 로그`                            |
|   📝   | **Docs**    | 운영 문서, 규칙, 참고자료 정리             | `📝 docs: 커밋 규칙 README에 추가`                                |
|   📌   | **Pin**     | 중요 표시 / 정리 예정 주제 표시            | `📌 pin: React Suspense -> 주제별 정리 필요`                      |
|   🧪   | **Test**    | 새로운 라이브러리, 설정, 기능 테스트       | `🧪 test: CI 워크플로우 검증용 테스트 추가`                       |
|   🎸   | **Misc**    | 흥미로운 발견, 아이디어, 잡동사니 아카이브 | `🎸 misc: 재미있는 npm 패키지 발견 (is-even)`                     |
|   🚚   | **Move**    | 파일명/폴더 구조 변경, 이동                | `🚚 move: TIL 파일명 정리`                                        |
|   🗑️   | **Remove**  | 불필요한 파일/폴더 삭제                    | `🗑️ remove: 중복 파일 제거`                                       |
|   🔧   | **Chore**   | 유지보수, 설정, 환경 정리 (.gitkeep 등)    | `🔧 chore: snippets 폴더 .gitkeep 추가`                           |
|   🎨   | **Style**   | 디자인, 비주얼, 색상 관련 수정             | `🎨 style: 다크 모드 색상 팔레트 추가`                            |

### - Optional Rules

| 이모지 | 타입(Key)   | 의미                  | 예시                                |
| :----: | :---------- | :-------------------- | :---------------------------------- |
|   📦   | **Package** | 패키지/환경 세팅 자료 | `📦 package: lint/format 초기 세팅` |
|   👷   | **WIP**     | 작업중/미완성         | `👷 wip: React Query 키 설계 초안`  |
|   👽   | **Inspire** | 참고/영감 자료        | `👽 inspire: Dribbble UI 레퍼런스`  |
|   🙏   | **Thanks**  | 도움받은 기록         | `🙏 thanks: @username 피드백 반영`  |

---

## 📁 File Naming Rules

### 📚 TIL (Today I Learned)

```bash
YYYY-MM-DD_NN-keyword-keyword.md

# 예시
2025-10-05_01-next-tailwind-jest-ci-cd-setup.md
2025-10-05_02-github-actions-ci-cd-workflows.md
```

- **날짜**: `YYYY-MM-DD` 형식 필수
- **순번**: `_NN` (같은 날 여러 개 작성 시)
- **키워드**: kebab-case로 2-4개

### 🔍 Topics

```bash
category-subcategory-topic.md

# 예시
react-hooks-useeffect-patterns.md
javascript-async-promise-handling.md
```

- 대분류 -> 중분류 -> 세부주제 순
- 모두 소문자, kebab-case

### 💻 Snippets

```bash
function-name.extension

# 예시
debounce.js
custom-hook.tsx
github-actions.yml
```

- 기능 명확히 표현
- 실제 확장자 사용

### 🐛 Error Logs

```bash
YYYY-MM-DD-error-keyword.md

# 예시
2025-01-06-npm-install-peer-deps.md
2025-01-06-react-hydration-mismatch.md
```

- 날짜 + 에러 핵심 키워드

### 📅 Reviews

```bash
# 주간
YYYY-WNN.md (예: 2025-W01.md)

# 월간
YYYY-MM.md (예: 2025-01.md)
```

---

## ✏️ Writing Guidelines

### 📌 제목 규칙

```
# H1 - 파일당 1개, 최상단만

## H2 - 주요 섹션

### H3 - 하위 섹션
```

### 💬 코드 블록

```language
// 언어명 명시 필수
const example = "code";
```

### 🔗 링크 작성

```
[외부 링크](https://...)
[내부 문서](../topics/react.md) # 상대 경로
```

### 🏷️ 태그 규칙

```
## 🏷️ Tags

`#react` `#hooks` `#performance`
```

- 백틱으로 감싸기
- 소문자만 사용
- 3-5개 적정

---

## ✅ Writing Checklist

**필수 (최소 요구사항)**

- [ ] 날짜와 제목
- [ ] 오늘 배운 핵심 1개 이상

**권장 (있으면 좋음)**

- [ ] 코드 예시
- [ ] 태그 추가
- [ ] 참고 자료 링크

### Good Example ⭕

# 📅 2025-01-06 | React useMemo 최적화

## 🎯 오늘의 목표

> useMemo의 적절한 사용 시점 파악하기

## 📚 핵심 개념

### useMemo란?

- 계산 비용이 큰 연산 메모이제이션
- 의존성 배열 변경 시에만 재계산

```javascript
const expensive = useMemo(() => {
  return heavyComputation(data);
}, [data]);
```

## 💡 Insight

> "모든 값을 메모이제이션하는 것은 오히려 성능 저하"

## 🏷️ Tags

`#react` `#performance` `#hooks`

### Bad Example ❌

# 오늘 배운 것

useMemo를 배웠다...

---

## 🚨 Guidelines

### MUST (필수) ✅

- 날짜와 제목 기록
- 최소 1개 이상의 배운 점
- 파일명 규칙 준수

### GOOD (권장) 💡

- 일관된 어조 유지
- 핵심 내용 우선 배치
- 코드 예시 포함
- 출처/참고 링크 명시
- 태그 3-5개 추가
- 기본 맞춤법 검사

### DON'T (하지 말 것) ❌

- 제목에 마침표
- 빈 줄 남발
- 이모지 과도 사용
- 절대 경로 사용
- 코드 블록 언어 미지정

### SKIP (신경 안 써도 됨) 🤷

- 완벽한 문법
- 모든 템플릿 섹션 채우기
- 긴 설명
- 형식적인 내용 및 구성 포함 시키기

> 💡 **Remember**: 미래의 내가 봐도 이해할 수 있게 작성하기!
