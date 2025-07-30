// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  
  // モジュール
  modules: [
    '@pinia/nuxt',
  ],
  
  // SSG設定
  nitro: {
    prerender: {
      routes: ['/']
    }
  },
  
  // SEO設定
  app: {
    head: {
      title: 'MyPortfolio',
      meta: [
        { name: 'description', content: 'Personal portfolio website' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  }
})
