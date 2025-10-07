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
echo "📌 package.json에 다음 scripts를 추가하세요:"
echo '
{
  "scripts": {
    "lint": "eslint . --ext .ts,.tsx",
    "lint:fix": "eslint . --ext .ts,.tsx --fix",
    "format": "prettier --write \"**/*.{ts,tsx,json,css,md}\""
  }
}'