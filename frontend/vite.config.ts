import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  const isPublic = mode === 'public'

  return {
    plugins: [react()],
    server: isPublic
      ? {
          host: '0.0.0.0',
          allowedHosts: ['it5012.ttz3305012.uk'],
        }
      : {
          host: '127.0.0.1',
        },
  }
})
