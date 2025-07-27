import { ref } from "vue";

export const useUi = () => {
  const state = ref("light");

  const handleState = () => {
    state.value = state.value === "light" ? "dark" : "light";
  };

  return {
    state,
    handleState,
  };
};