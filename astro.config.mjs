import { defineConfig } from 'astro/config';

import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
  site: 'https://un1c0re.github.io',
  base:'cancer-neo',
  integrations: [
    tailwind(),
  ]
});