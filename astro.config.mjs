import { defineConfig } from 'astro/config';
import tailwind from "@astrojs/tailwind";

import react from "@astrojs/react";

// https://astro.build/config
export default defineConfig({
  site: 'https://un1c0re.github.io',
  base: 'cancer-neo',
  integrations: [tailwind(), react()],
  server: {
    proxy: {
      '/api': 'http://localhost:3000',
    },
  },
});