import store from '@/store';
import { createRouter, createWebHistory } from 'vue-router';
import { routes } from './routes';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})
router.beforeEach(async(to, from, next) => {


  const token = localStorage.getItem('authToken');
  // const userMenus = JSON.parse(localStorage.getItem('userMenus') || '[]');
  const expiresIn = 3600 * 3000; 

  // console.log(userMenus)
  setTimeout(() => {
    localStorage.removeItem('authToken');
    // localStorage.removeItem('userMenus');
    localStorage.removeItem('userData');
    router.push('/login'); // Redirect ke halaman login
  }, expiresIn);

  // Fungsi untuk mengekstrak URL dari menu dan submenu
  const extractUrls = (menuItems) => {
    let urls = [];
    menuItems.forEach(item => {
      if (item.url) {
        urls.push(item.url);
      }
      if (item.items) {
        urls = urls.concat(extractUrls(item.items));
      }
      if (item.submenu) {
        urls = urls.concat(extractUrls(item.submenu));
      }
    });
    return urls;
  };

  let userPaths = [];
  const formData = new FormData();
    const parsedUser = JSON.parse(localStorage.getItem('userData'));

    if (parsedUser) {
      formData.append("id", parsedUser.id);

      try {
        const response = await store.dispatch("menuManagement/authlist", formData);
        userPaths = extractUrls(response); // Mengisi userPaths dengan URL dari respons
      } catch (error) {
        console.error("Error fetching menu:", error);
        next({ name: 'Login' });
        return;
      }
    }
  // Jika halaman yang diminta adalah login dan token belum ada, lanjutkan navigasi
  if (to.name === 'Login' && !token) {
    next();
  } 
  // Jika ada token dan mencoba mengakses login, arahkan ke dashboard
  else if (to.name === 'Login' && token) {
    next({ path: '/dashboard' });
  } 
  // Jika tidak ada token, arahkan ke halaman login
  else if (!token) {
    next({ name: 'Login' });
  }
  // Jika path yang diminta tidak ada di userPaths dan bukan halaman Unauthorized, arahkan ke Unauthorized
  else if (!userPaths.includes(to.path) && to.path !== '/page-not-found') {
    next({ path: '/page-not-found' });
  } 
  // Jika semua kondisi terpenuhi, lanjutkan navigasi
  else {
    next();
  }
});

export default function (app) {
  app.use(router)
}
export { router };

