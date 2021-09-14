window.Vue = require("vue");

import router from "./router.js";
import vuetify from "./plugins/vuetify.js";
import store from "./store/index.js";
import {i18n} from './i18n-setup.js';
import './googleOauth';
import './components-init';
import './plugins/axios';

// helper methods
import helpers from './helpers';

// Vue mixin includes all the global methods that needs to be available among all the comps
import globalMixin from './globalMixin'; 

// initials settings on the store
helpers.updateSettings();

// disble debug tools & console message on production mode
if (process.env.MIX_ENV_MODE === 'production') {
    Vue.config.devtools = false;
    Vue.config.debug = false;
    Vue.config.silent = true; 
}


Vue.config.disableNoTranslationWarning = true;
// get the user if he is logged before initializing the Vue instance
helpers.fetchUserIfExists().then(() => {
    new Vue({
        el: "#app",
        mixins: ["globalMixin"],
        vuetify,
        router,
        store,
        i18n
    });
})


