// resources/js/themeState.js
import logodark from '@images/logoDark.png'
import logoutama from '@images/logoutama.png'
import { ref } from 'vue'

export const globalTheme = {
  name: ref(localStorage.getItem('theme') || 'light'),
  logo: ref(
    localStorage.getItem('theme') === 'dark' ? logodark : logoutama
  ),
}
