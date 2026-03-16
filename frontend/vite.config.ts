import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  // use the public server settings only for the public deployment mode
  const isPublic = mode === 'public'

  return {
    // enable the react plugin for vite
    plugins: [react()],
    server: isPublic
      ? {
          // allow external access in the public mode
          host: '0.0.0.0',
          allowedHosts: ['it5012.ttz3305012.uk'],
        }
      : {
          // keep local development bound to localhost
          host: '127.0.0.1',
        },
  }
})
