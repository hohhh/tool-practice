// 테스트 코드
import Home from "./page";
import { render, screen } from "@testing-library/react";

test("메인 페이지가 제대로 렌더링되는지 테스트", () => {
  // 1. 메인 페이지 렌더링
  render(<Home />);

  // 2. "Hello" 텍스트를 가진 요소를 찾기
  const element = screen.getByText("Hello world!");

  // 3. 요소가 화면에 있는지 확인
  expect(element).toBeInTheDocument();
});
