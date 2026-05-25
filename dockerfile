# ---- GIAI ĐOẠN 1: Cài đặt và Build code ----
FROM node:22-alpine AS builder
WORKDIR /app

# Copy 2 file quản lý thư viện vào trước (để Docker tận dụng cache, chạy nhanh hơn ở những lần sau)
COPY package.json package-lock.json ./
RUN npm ci

# Copy toàn bộ code vào và tiến hành build Next.js
COPY . .
RUN npm run build


# ---- GIAI ĐOẠN 2: Chạy thực tế (Production) ----
# Ở giai đoạn này mình dùng lại môi trường Node trắng bóc, chỉ nhặt những đồ đã nấu chín ở Giai đoạn 1 mang sang
FROM node:22-alpine AS runner
WORKDIR /app

# Đặt biến môi trường production để app chạy mượt và tối ưu nhất
ENV NODE_ENV=production

# Nhặt các file cần thiết từ cục 'builder' phía trên đem qua
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Báo cho Docker biết container này sẽ mở port 3000 (mặc định của Next.js)
EXPOSE 3000

# Lệnh khởi động app
CMD ["npm", "start"]