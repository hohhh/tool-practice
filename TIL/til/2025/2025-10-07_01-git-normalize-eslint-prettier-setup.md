# 🧩 TIL | 2025-10-07 | Git 개행 정규화 & ESLint/Prettier 설정 (feat. 오버스펙 설치 회고)

## 🌟 오늘의 목표

- 협업 환경(LF vs CRLF)에서 발생하는 개행 문자 문제 해결 과정 복기
- `.gitattributes`와 `core.autocrlf` 설정 차이 재확인
- ESLint(Airbnb) + Prettier 설정 과정 및 Next.js vs React 차이점 학습

### ⚙️ 프로젝트 환경

- Framework: Next.js (TypeScript)
- Linter: ESLint with Airbnb config
- Formatter: Prettier

---

## 📚 핵심 개념

### 개행 문자 차이

| OS                | 개행 문자     | 설명                        |
| :---------------- | :------------ | :-------------------------- |
| **Windows**       | `CRLF (\r\n)` | Carriage Return + Line Feed |
| **macOS / Linux** | `LF (\n)`     | Line Feed only              |

💡 서로 다른 환경에서 파일을 커밋하면,
**줄바꿈 문자 차이로 인해 diff에 불필요한 변경점이 생긴다.**

---

## 📂 실습 과정

### Part 1: Git 개행 문자 정규화

#### 1️⃣ `core.autocrlf` 설정: 자동 변환 비활성화

```bash
git config core.autocrlf false
```

- Git이 자동으로 CRLF <-> LF 변환하지 않게 함
- LF 그대로 유지, 로컬/원격 간 불일치 방지
- CRLF로 변경하고 싶을 시: true

#### 2️⃣ `.gitattributes` 생성 및 규칙 추가

```bash
# 모든 텍스트 파일은 LF로 통일
* text=auto eol=lf

# 이미지 및 폰트는 바이너리로 처리 (개행 변환 방지)
*.png  binary
*.jpg  binary
*.jpeg binary
*.gif  binary
*.ico  binary
*.woff binary
*.woff2 binary
*.ttf  binary
*.otf  binary
```

#### 3️⃣ 정규화 반영

```bash
git add --renormalize .
```

- 이미 커밋된 파일의 개행 문자도 `.gitattributes` 기준으로 재정렬

---

### Part 2: ESLint & Prettier 설정

#### 🔴 시행착오: 오버스펙 설치

처음에 Next.js와 React 구분 없이 모든 패키지를 설치했다:

```bash
# 내가 처음 설치한 명령어 (오버스펙)
npm i -D \
eslint@8.57.0 \              # Next.js는 이미 포함
eslint-config-next \          # Next.js는 이미 포함
eslint-config-airbnb@19.0.4 \
eslint-config-airbnb-typescript@18.0.0 \
@typescript-eslint/parser@7.17.0 \
@typescript-eslint/eslint-plugin@7.17.0 \
eslint-plugin-import@2.30.0 \
eslint-plugin-react@7.35.0 \        # Next.js는 이미 포함
eslint-plugin-react-hooks@4.6.2 \   # Next.js는 이미 포함
eslint-plugin-jsx-a11y@6.9.0 \      # Next.js는 이미 포함
prettier@3.3.3 \
eslint-config-prettier@9.1.0 \
eslint-plugin-prettier@5.2.1

# 추가로 중복 설치
npm i -D prettier eslint-config-prettier eslint-plugin-prettier
```

**🤔 알게 된 점**: Next.js는 많은 ESLint 플러그인을 이미 내장하고 있어서 중복 설치였지만, **명시적 버전 관리** 측면에서는 나쁘지 않다!

---

#### ✅ Framework별 올바른 설치 방법

##### 🔷 Next.js (TypeScript) - 최적화 버전

```bash
# Next.js 필수만 (이미 많은 것을 내장)
npm i -D \
eslint-config-airbnb@19.0.4 \
eslint-config-airbnb-typescript@18.0.0 \
@typescript-eslint/parser@7.17.0 \
@typescript-eslint/eslint-plugin@7.17.0 \
prettier@3.3.3 \
eslint-config-prettier@9.1.0 \
eslint-plugin-prettier@5.2.1
```

**Next.js가 이미 제공하는 것들:**

- ✅ `eslint`
- ✅ `eslint-config-next`
- ✅ `eslint-plugin-react`
- ✅ `eslint-plugin-react-hooks`
- ✅ `eslint-plugin-jsx-a11y`
- ✅ `eslint-plugin-import`

##### 🔷 React (TypeScript) - 전체 설치 필요

```bash
# React는 모든 패키지 직접 설치 필요
npm i -D \
eslint@8.57.0 \
eslint-config-airbnb@19.0.4 \
eslint-config-airbnb-typescript@18.0.0 \
@typescript-eslint/parser@7.17.0 \
@typescript-eslint/eslint-plugin@7.17.0 \
eslint-plugin-import@2.30.0 \
eslint-plugin-react@7.35.0 \
eslint-plugin-react-hooks@4.6.2 \
eslint-plugin-jsx-a11y@6.9.0 \
prettier@3.3.3 \
eslint-config-prettier@9.1.0 \
eslint-plugin-prettier@5.2.1
```

---

#### 📝 설정 파일 구성

##### `.eslintrc.json` (Next.js + TypeScript + Airbnb)

```json
{
  "extends": ["next/core-web-vitals", "airbnb", "airbnb-typescript", "airbnb/hooks", "prettier"],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "plugins": ["@typescript-eslint", "prettier"],
  "rules": {
    "prettier/prettier": [
      "error",
      {
        "endOfLine": "lf" // LF 강제
      }
    ],
    "react/react-in-jsx-scope": "off", // Next.js는 자동 import
    "react/jsx-props-no-spreading": "off", // _app.tsx에서 필요
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_"
      }
    ]
  }
}
```

##### `.prettierrc` (개행 문자 LF 강제)

```json
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "always",
  "endOfLine": "lf" // 핵심: LF 강제
}
```

##### `.editorconfig` (추가 권장)

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
```

##### `.vscode/settings.json` (VS Code 자동화)

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.eol": "\n",
  "files.encoding": "utf8"
}
```

---

## 🔧 유용한 Scripts

```json
// package.json
{
  "scripts": {
    "lint": "eslint . --ext .ts,.tsx",
    "lint:fix": "eslint . --ext .ts,.tsx --fix",
    "format": "prettier --write \"**/*.{ts,tsx,json,css,md}\"",
    "type-check": "tsc --noEmit"
  }
}
```

---

## 💡 Insights

### 개발 도구 설치 구분

> 서비스 실행에 꼭 필요한 건 `npm i`, 개발 중에만 쓰는 도구는 `npm i -D`
>
> - **devDependencies (-D)**: ESLint, Prettier, Jest, Husky, TypeScript
> - **dependencies**: React, Next.js, Zustand, axios 등 런타임 의존성

### 개행 문자 정규화의 중요성

> 초기에 `.gitattributes`로 명시해두면, 협업 시 OS 차이로 인한 개행 문제를 미리 방지할 수 있다
>
> 변경 후에는 캐시 초기화 후 진행 추천:
>
> ```bash
> git rm --cached -r . && git reset --hard
> ```

### Framework별 설정 차이

> **Next.js**: 많은 것이 내장되어 있어 추가 설치 최소화 가능
> **React**: 모든 린팅 도구를 직접 설치하고 설정 필요
>
> 오버스펙으로 설치해도 충돌하지 않으니 그대로 사용해도 무방
> 명시적 버전 관리를 원한다면 오히려 좋아

### Prettier endOfLine 설정

> `.prettierrc`의 `"endOfLine": "lf"`가 핵심
> Git 설정과 함께 사용하면 완벽한 개행 문자 통일 가능

---

## 🏷️️ Tags

`#git` `#crlf` `#lf` `#normalize` `#gitattributes` `#eslint` `#prettier` `#airbnb` `#linting`
