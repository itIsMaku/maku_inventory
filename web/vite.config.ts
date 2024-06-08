import { defineConfig, splitVendorChunkPlugin } from 'vite';
import react from '@vitejs/plugin-react';
import tsconfigPaths from 'vite-tsconfig-paths';

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [react(), tsconfigPaths(), splitVendorChunkPlugin()],
    base: './',
    build: {
        rollupOptions: {
            output: {
                manualChunks(id: string) {
                    if (id.includes('radix-ui')) {
                        return '@radix-ui';
                    }
                    if (id.includes('react-dom')) {
                        return '@react-dom';
                    }
                }
            }
        },
        outDir: 'build',
    },
    server: {
        watch: {
            usePolling: true,
            interval: 100
        }
    }
});
