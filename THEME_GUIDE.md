# Theme Toggle - Hướng dẫn sử dụng

## Tính năng đã implement

### 1. **Context quản lý theme**
- File: `frontend/src/contexts/ThemeContext.tsx`
- Provider: `ThemeProvider` wrap toàn bộ app
- Hook: `useTheme()` để sử dụng trong components

### 2. **Nút chuyển đổi theme**
- **Desktop**: Nút ở góc phải header trong sidebar
- **Mobile**: Nút ở góc phải header bar (bên cạnh nút menu)
- Icon:
  - 🌞 Sun icon khi đang ở dark mode (click để chuyển sang light)
  - 🌙 Moon icon khi đang ở light mode (click để chuyển sang dark)

### 3. **Lưu trữ tùy chọn**
- Theme được lưu vào `localStorage` với key `'theme'`
- Tự động load lại theme khi refresh trang
- Mặc định: Dark mode

### 4. **Animation mượt mà**
- Transition duration: 300ms
- Smooth transition cho:
  - Background colors
  - Border colors
  - Text colors
- Hover effects với scale animation cho nút toggle

## Cách sử dụng

### Trong components khác:
```tsx
import { useTheme } from '../contexts/ThemeContext';

function MyComponent() {
  const { theme, toggleTheme } = useTheme();

  return (
    <div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white">
      <p>Current theme: {theme}</p>
      <button onClick={toggleTheme}>Toggle Theme</button>
    </div>
  );
}
```

### Tailwind CSS classes:
- Mặc định: Light mode styles
- Dark mode: Thêm prefix `dark:` trước class
- Ví dụ:
  ```tsx
  className="bg-white dark:bg-gray-900"
  className="text-gray-900 dark:text-white"
  className="border-gray-200 dark:border-gray-700"
  ```

## Màu sắc đã cấu hình

### Light Mode (mặc định):
- Background: `from-gray-100 via-gray-50 to-gray-100`
- Sidebar: `bg-white/95`
- Text: `text-gray-700`
- Border: `border-gray-200`

### Dark Mode:
- Background: `from-gray-900 via-gray-800 to-gray-900`
- Sidebar: `bg-gray-900/95`
- Text: `text-gray-300`
- Border: `border-gray-700`

## Files đã chỉnh sửa

1. `frontend/src/contexts/ThemeContext.tsx` - **MỚI**
2. `frontend/src/App.tsx` - Thêm ThemeProvider
3. `frontend/src/components/Layout.tsx` - Thêm nút toggle và dark mode classes
4. `frontend/src/index.css` - Cấu hình CSS variables và transitions
5. `frontend/tailwind.config.js` - Enable dark mode với selector strategy

## Kiểm tra

Để kiểm tra tính năng:
1. Chạy app: `cd frontend && npm run dev`
2. Click vào nút Sun/Moon icon ở header
3. Theme sẽ chuyển đổi mượt mà
4. Refresh trang - theme vẫn được giữ nguyên
5. Kiểm tra localStorage trong DevTools: `localStorage.getItem('theme')`
