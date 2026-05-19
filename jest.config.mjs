import nextJest from 'next/jest.js'

// Cung cấp đường dẫn tới app Next.js để nó load file .env và next.config.js
const createJestConfig = nextJest({
    dir: './',
})

// Tuỳ chỉnh cấu hình Jest của ông ở đây
/** @type {import('jest').Config} */
const config = {
    // Add more setup options before each test is run
    setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
    testEnvironment: 'jest-environment-jsdom', // Môi trường để test giao diện React
}

export default createJestConfig(config)