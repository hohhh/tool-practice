import { render } from "@testing-library/react";
import Home from "./page";

test("메인 페이지가 제대로 렌더링되는지 테스트", () => {
  const { container } = render(<Home />);
  expect(container).toBeTruthy(); // 렌더링 성공 여부만 확인
});
