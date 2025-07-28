<template>
  <div class="portfolio-home">
    <section class="hero">
      <div class="hero-content">
        <h1 class="hero-title">
          <span class="name">松屋のガチ勢のポートフォリオ</span>
        </h1>
        <p class="hero-description">
          フルスタックエンジニア
        </p>
        <p class="hero-subtitle">
          美しく機能的なWebアプリケーションを作ることに情熱を注いでいます
        </p>
        <div class="hero-buttons">
          <button class="btn btn-primary">プロジェクトを見る</button>
          <button class="btn btn-secondary">お問い合わせ</button>
        </div>
      </div>
      <div class="hero-image">
        <div class="avatar-placeholder">
          <span>📸</span>
        </div>
      </div>
    </section>

    <section class="about">
      <div class="container">
        <h2 class="section-title">自己紹介</h2>
        <div class="about-content">
          <p>
            5年以上のWeb開発経験を持つフルスタックデベロッパーです。
            ユーザー体験を重視した設計と、パフォーマンスの高いアプリケーション開発を得意としています。
          </p>
          <p>
            常に新しい技術を学び、よりよいソリューションを提供することを心がけています。
          </p>
        </div>
      </div>
    </section>

    <!-- スキルセクション -->
    <section class="skills">
      <div class="container">
        <h2 class="section-title">スキル</h2>
        <div class="skills-grid">
          <div class="skill-category">
            <h3>フロントエンド</h3>
            <div class="skill-tags">
              <span class="skill-tag">Vue.js</span>
              <span class="skill-tag">React</span>
              <span class="skill-tag">TypeScript</span>
              <span class="skill-tag">Nuxt.js</span>
            </div>
          </div>
          <div class="skill-category">
            <h3>バックエンド</h3>
            <div class="skill-tags">
              <span class="skill-tag">Node.js</span>
              <span class="skill-tag">Python</span>
              <span class="skill-tag">PostgreSQL</span>
              <span class="skill-tag">MongoDB</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- プロジェクトセクション -->
    <section class="projects">
      <div class="container">
        <h2 class="section-title">主なプロジェクト</h2>
        <div class="projects-grid">
          <div class="project-card">
            <div class="project-image">
              <span>🚀</span>
            </div>
            <h3>ガチ松</h3>
            <p>松屋のことを研究したアプリケーション</p>
            <div class="project-tech">
              <span>Next.js</span>
              <span>Go</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- お問い合わせセクション -->
    <section class="contact">
      <div class="container">
        <h2 class="section-title">お問い合わせ</h2>
        <p class="contact-description">
          プロジェクトのご相談やお仕事のお話など、お気軽にご連絡ください。
        </p>
        <div class="contact-buttons">
          <a href="https://github.com/yourusername" class="btn btn-secondary" target="_blank">
            GitHub
          </a>
          <a href="https://x.com/yourusername" class="btn btn-secondary" target="_blank">
            X
          </a>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
// ページのメタ情報を設定
useHead({
  title: 'ポートフォリオ - 松屋のガチ勢',
  meta: [
    {
      name: 'description',
      content: 'フルスタックエンジニア 松屋のガチ勢のポートフォリオサイトです。Web開発の実績やスキルをご紹介しています。'
    }
  ]
})

// ページ読み込み時のアニメーション用
onMounted(() => {
  // 必要に応じてアニメーションロジックを追加
})
</script>

<style scoped>
.portfolio-home {
  min-height: 100vh;
}

/* ヒーローセクション */
.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding: 2rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  gap: 4rem;
}

.hero-content {
  flex: 1;
  max-width: 600px;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.greeting {
  display: block;
  font-size: 2rem;
  font-weight: 400;
  opacity: 0.9;
}

.name {
  background: linear-gradient(45deg, #fff, #f0f8ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-description {
  font-size: 1.5rem;
  margin-bottom: 1rem;
  opacity: 0.95;
}

.hero-subtitle {
  font-size: 1.1rem;
  opacity: 0.8;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.hero-buttons {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.hero-image {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.avatar-placeholder {
  width: 300px;
  height: 300px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 4rem;
  backdrop-filter: blur(10px);
  border: 2px solid rgba(255, 255, 255, 0.2);
}

/* ボタンスタイル */
.btn {
  padding: 1rem 2rem;
  border: none;
  border-radius: 50px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #fff;
  color: #667eea;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.btn-secondary {
  background: transparent;
  color: #fff;
  border: 2px solid #fff;
}

.btn-secondary:hover {
  background: #fff;
  color: #667eea;
  transform: translateY(-2px);
}

/* セクション共通スタイル */
section {
  padding: 5rem 0;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-title {
  font-size: 2.5rem;
  text-align: center;
  margin-bottom: 3rem;
  color: #333;
  font-weight: 700;
}

/* 自己紹介セクション */
.about {
  background: #f8fafc;
}

.about-content {
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
}

.about-content p {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 1.5rem;
  color: #555;
}

/* スキルセクション */
.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.skill-category {
  background: #fff;
  padding: 2rem;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.skill-category:hover {
  transform: translateY(-5px);
}

.skill-category h3 {
  margin-bottom: 1rem;
  color: #333;
  font-size: 1.3rem;
}

.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.skill-tag {
  background: #667eea;
  color: #fff;
  padding: 0.5rem 1rem;
  border-radius: 25px;
  font-size: 0.9rem;
  font-weight: 500;
}

/* プロジェクトセクション */
.projects {
  background: #f8fafc;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.project-card {
  background: #fff;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.project-card:hover {
  transform: translateY(-5px);
}

.project-image {
  font-size: 3rem;
  margin-bottom: 1rem;
  text-align: center;
}

.project-card h3 {
  margin-bottom: 1rem;
  color: #333;
  font-size: 1.3rem;
}

.project-card p {
  margin-bottom: 1.5rem;
  color: #666;
  line-height: 1.6;
}

.project-tech {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.project-tech span {
  background: #e2e8f0;
  color: #475569;
  padding: 0.3rem 0.8rem;
  border-radius: 15px;
  font-size: 0.8rem;
}

/* お問い合わせセクション */
.contact {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  text-align: center;
}

.contact .section-title {
  color: #fff;
}

.contact-description {
  font-size: 1.1rem;
  margin-bottom: 2rem;
  opacity: 0.9;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.contact-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.contact .btn-primary {
  background: #fff;
  color: #667eea;
}

.contact .btn-secondary {
  background: transparent;
  color: #fff;
  border: 2px solid #fff;
}

/* レスポンシブデザイン */
@media (max-width: 768px) {
  .hero {
    flex-direction: column;
    text-align: center;
    min-height: auto;
    padding: 3rem 1rem;
  }

  .hero-title {
    font-size: 2.5rem;
  }

  .greeting {
    font-size: 1.5rem;
  }

  .avatar-placeholder {
    width: 200px;
    height: 200px;
    font-size: 3rem;
  }

  .section-title {
    font-size: 2rem;
  }

  .container {
    padding: 0 1rem;
  }

  .skills-grid,
  .projects-grid {
    grid-template-columns: 1fr;
  }

  .hero-buttons,
  .contact-buttons {
    flex-direction: column;
    align-items: center;
  }

  .btn {
    width: 100%;
    max-width: 300px;
  }
}
</style>