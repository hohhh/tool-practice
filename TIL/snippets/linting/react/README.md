# React ESLint + Prettier 설정

## ⚛️ React 프로젝트 전용 설정

React 프로젝트는 Next.js와 달리 모든 ESLint 플러그인을 직접 설치해야 합니다.

## 🚀 빠른 시작

```bash
# 스크립트 실행
bash setup-react.sh
```

## 📦 수동 설치

### 1. 패키지 설치 (전체 필요)

```bash
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

### 2. 설정 파일 생성

#### `.eslintrc.json`

```json
{
  "extends": ["airbnb", "airbnb-typescript", "airbnb/hooks", "prettier"],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json",
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "plugins": ["@typescript-eslint", "react", "prettier"],
  "rules": {
    "prettier/prettier": [
      "error",
      {
        "endOfLine": "lf"
      }
    ],
    "react/react-in-jsx-scope": "off",
    "import/extensions": [
      "error",
      "ignorePackages",
      {
        "ts": "never",
        "tsx": "never"
      }
    ],
    "react/jsx-filename-extension": ["warn", { "extensions": [".tsx"] }],
    "react/function-component-definition": [
      "error",
      {
        "namedComponents": "arrow-function",
        "unnamedComponents": "arrow-function"
      }
    ],
    "react/require-default-props": "off",
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_"
      }
    ]
  },
  "env": {
    "browser": true,
    "es2021": true
  }
}
```

#### `.prettierrc`

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
  "endOfLine": "lf"
}
```

#### `.editorconfig`

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

#### `.vscode/settings.json`

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

#### `.eslintignore`

```
# Dependencies
node_modules/
.pnp
.pnp.js

# Production
build/
dist/

# TypeScript
*.tsbuildinfo

# Config files
vite.config.ts
webpack.config.js
```

#### `.prettierignore`

```
# Dependencies
node_modules
.pnp
.pnp.js

# Production
build
dist

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env*.local

# TypeScript
*.tsbuildinfo
```

### 3. Git 개행 문자 설정

```bash
# Git 자동 변환 비활성화
git config core.autocrlf false

# .gitattributes 생성
cat > .gitattributes << 'EOF'
* text=auto eol=lf
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.woff binary
*.woff2 binary
*.ttf binary
*.otf binary
EOF

# 정규화 적용
git add --renormalize .
```

### 4. package.json Scripts 추가

```json
{
  "scripts": {
    "lint": "eslint . --ext .ts,.tsx",
    "lint:fix": "eslint . --ext .ts,.tsx --fix",
    "format": "prettier --write \"**/*.{ts,tsx,json,css,md}\"",
    "type-check": "tsc --noEmit"
  }
}
```

## 📝 VS Next.js 차이점

### React는 모든 패키지 직접 설치 필요:

- ✅ `eslint` - 기본 린터
- ✅ `eslint-plugin-react` - React 전용 규칙
- ✅ `eslint-plugin-react-hooks` - Hooks 규칙
- ✅ `eslint-plugin-jsx-a11y` - 접근성 규칙
- ✅ `eslint-plugin-import` - import/export 규칙

### 설정 차이점:

- `next/core-web-vitals` 없음 (Next.js 전용)
- `env` 설정 추가 (browser, es2021)
- `ecmaFeatures.jsx` 명시적 설정 필요

## 🛠️ Create React App vs Vite

### Create React App (CRA)

- 기본 ESLint 설정 포함
- 위 설정으로 덮어쓰기 가능
- `npm run eject` 없이도 커스터마이징 가능

### Vite

- ESLint 설정 없음 (직접 설정 필요)
- 위 설정 그대로 사용 가능
- 빌드 속도 빠름

### tsconfig.json 예시 (Vite)

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "node",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

## 💡 자동 설정 스크립트

### `setup-react.sh`

```bash
#!/bin/bash

echo "⚛️ React TypeScript ESLint + Prettier 설정 시작..."

# ESLint & Prettier 설치 (React 전체 버전)
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

# Git 개행 문자 설정
git config core.autocrlf false

# .gitattributes 생성
cat > .gitattributes << 'EOF'
* text=auto eol=lf
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.woff binary
*.woff2 binary
*.ttf binary
*.otf binary
EOF

# 설정 파일 복사
cp "$(dirname "$0")/.eslintrc.json" .
cp "$(dirname "$0")/.prettierrc" .
cp "$(dirname "$0")/.eslintignore" .
cp "$(dirname "$0")/.prettierignore" .

# 정규화 적용
git add --renormalize .

echo "✅ React 린팅 설정 완료!"
```

## 🔍 문제 해결

### Module not found 에러

```bash
# node_modules 재설치
rm -rf node_modules package-lock.json
npm install
```

### React version 경고

`.eslintrc.json`에 React 버전 명시:

```json
{
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

### import/no-unresolved 에러

```json
// .eslintrc.json rules에 추가
{
  "rules": {
    "import/no-unresolved": "off"
  }
}
```

### 절대 경로 import 설정 (선택사항)

```json
// tsconfig.json
{
  "compilerOptions": {
    "baseUrl": "src",
    "paths": {
      "@/*": ["*"]
    }
  }
}
```

## 🎯 추가 권장 패키지

### 개발 생산성 향상

```bash
npm i -D \
  @tanstack/eslint-plugin-query \  # React Query 사용 시
  eslint-plugin-testing-library \   # Testing Library 사용 시
  eslint-plugin-jest-dom            # Jest DOM 사용 시
```

### Tailwind CSS 사용 시

```bash
npm i -D \
  eslint-plugin-tailwindcss \
  prettier-plugin-tailwindcss
```
