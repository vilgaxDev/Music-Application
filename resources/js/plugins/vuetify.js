import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import "@mdi/font/css/materialdesignicons.css";
import ColorManager from "../colorManager";


const colorManager = new ColorManager();
// initializing the base/default colors 
const defaultPrimaryColor = colorManager.primaryColor || '#4245a8';
const defaultSecondaryColor = colorManager.secondaryColor || '#b084ab';
const defaultErrorColor = '#E53935';

const defaultThemes = {
    light: {
        primary : defaultPrimaryColor,
        secondary: defaultSecondaryColor,
        error: defaultErrorColor
    },
    dark: {
        primary : defaultPrimaryColor,
        secondary: defaultSecondaryColor,
        error: defaultErrorColor
    }
} 

const opts = {
    theme: {
        themes: defaultThemes
    },
    breakpoint: {
        thresholds: {
            xs: 500,
            sm: 540,
            md: 800,
            lg: 1280,
        },
        scrollBarWidth: 24,
    },
    icons: {
        iconfont: "mdi" // default - only for display purposes
    }
};

Vue.use(Vuetify);
export default new Vuetify(opts);
