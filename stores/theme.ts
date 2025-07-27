import { defineStore } from "pinia";
import { ref, computed } from "vue";

export const useThemeStore = defineStore("theme", () => {
  // state
  const theme = ref('light')

  // getters
  const isDarkMode = computed(() => theme.value === 'dark')

  // actions
  const toggleTheme = () => {
    theme.value = theme.value === 'light' ? 'dark' : 'light'
  }

  // 公開したい変数や関数をreturnする
  return { theme, isDarkMode, toggleTheme }
});