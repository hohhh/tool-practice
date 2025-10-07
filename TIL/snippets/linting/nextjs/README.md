# Next.js ESLint + Prettier 설정

## 🚀 빠른 시작

```bash
# 스크립트 실행
bash setup-nextjs.sh
```

## 📦 수동 설치

### 1. 패키지 설치 (Next.js 최적화 버전)

```bash
npm i -D \
  eslint-config-airbnb@19.0.4 \
  eslint-config-airbnb-typescript@18.0.0 \
  @typescript-eslint/parser@7.17.0 \
  @typescript-eslint/eslint-plugin@7.17.0 \
  prettier@3.3.3 \
  eslint-config-prettier@9.1.0 \
  eslint-plugin-prettier@5.2.1
```

### 2. 설정 파일 생성

#### `.eslintrc.json`

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
        "endOfLine": "lf"
      }
    ],
    "react/react-in-jsx-scope": "off",
    "react/jsx-props-no-spreading": "off",
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_"
      }
    ]
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

## 📝 Next.js가 이미 제공하는 패키지들

Next.js는 다음 패키지들을 이미 포함하고 있어 별도 설치가 불필요합니다:

- ✅ `eslint`
- ✅ `eslint-config-next`
- ✅ `eslint-plugin-react`
- ✅ `eslint-plugin-react-hooks`
- ✅ `eslint-plugin-jsx-a11y`
- ✅ `eslint-plugin-import`

## 🎯 추가 옵션

### 오버스펙 버전 (명시적 버전 관리를 원할 경우)

```bash
npm i -D \
  eslint@8.57.0 \
  eslint-config-next \
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

**장점**: 팀원 간 정확한 버전 동기화, 명확한 의존성 표시  
**단점**: node_modules 크기 약간 증가 (무시 가능한 수준)

## 💡 자동 설정 스크립트

### `setup-nextjs.sh`

```bash
#!/bin/bash

echo "🚀 Next.js TypeScript ESLint + Prettier 설정 시작..."

# ESLint & Prettier 설치 (Next.js 최적화 버전)
npm i -D \
  eslint-config-airbnb@19.0.4 \
  eslint-config-airbnb-typescript@18.0.0 \
  @typescript-eslint/parser@7.17.0 \
  @typescript-eslint/eslint-plugin@7.17.0 \
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

# 정규화 적용
git add --renormalize .

echo "✅ Next.js 린팅 설정 완료!"
```

## 🔍 문제 해결

### ESLint 파싱 에러가 발생하는 경우

```json
// tsconfig.json에 추가
{
  "include": ["**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
```

### Prettier와 ESLint 충돌하는 경우

- `eslint-config-prettier`가 extends 배열의 **마지막**에 위치하는지 확인
- `.prettierrc`와 ESLint rules에서 같은 규칙이 중복 설정되지 않았는지 확인

### 특정 파일/폴더 제외하기

`.eslintignore` 생성:

```
node_modules/
.next/
out/
public/
*.config.js
```
