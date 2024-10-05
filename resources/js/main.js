import App from '@/App.vue';
import { registerPlugins } from '@core/utils/plugins';
import Notifications from '@kyvg/vue3-notification';
import { createApp } from 'vue';
import Loading from './layouts/components/LoadingDialog.vue';
import CustomNotification from './layouts/components/Notify.vue';
import Splash from './layouts/components/ProgressBar.vue';
import './main.css';
import store from './store';


 
// Styles
import '@core-scss/template/index.scss';
import '@layouts/styles/index.scss';
import '@styles/styles.scss';

// Create vue app
const app = createApp(App)



// Register plugins
registerPlugins(app)


app.component('CustomNotification', CustomNotification);
app.component('Splash', Splash);
app.component('Loading', Loading);
app.use(Notifications)
// Mount vue app
app.use(store)
app.mount('#app')
