import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

let routes = [{    
     path: '*',
        component: () =>
            import ('../views/404.vue'),
    },
    {
        path: '/',
        name: 'Home',
        mode: 'history',
        redirect: '/dashboard',
    },
    {
        path: '/dashboard',      
        name: 'Dashboard',
        layout: "dashboard",     
        component: () =>
            import ('../views/Dashboard.vue'),
    },
    {
        path: '/layout',
        name: 'Layout',
        layout: "dashboard",
        component: () =>
            import ('../views/Layout.vue'),
    },
    {
        path: '/recarga',
        name: 'Recarga',
        layout: "dashboard",
        component: () =>
            import ('../views/Recarga/List.vue'),
    },
    {
        path: '/recarga2',
        name: 'Recarga',
        layout: "dashboard",
        component: () =>
            import ('../views/Recarga/ListThow.vue'),
    },
    {
        path: '/perfil',
        name: 'Perfil',
        layout: "dashboard",
        component: () =>
            import ('../views/Perfil/View.vue'),
    },
   
    {
        path: '/clients',
        name: 'Clientes',
        layout: "dashboard",
        component: () =>
            import ('../views/Recarga/Clients.vue'),
    },
    {
        path: '/login',
        name: 'Login',
        component: () =>
            import ('../views/Login.vue'),
    }    
]


function addLayoutToRoute(route, parentLayout = "default") {
    route.meta = route.meta || {};
    route.meta.layout = route.layout || parentLayout;

    if (route.children) {
        route.children = route.children.map((childRoute) => addLayoutToRoute(childRoute, route.meta.layout));
    }
    return route;
}

routes = routes.map((route) => addLayoutToRoute(route));

const router = new VueRouter({
    mode: 'hash',
    //  mode: 'history',
    base: process.env.BASE_URL,
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (to.hash) {
            return {
                selector: to.hash,
                behavior: 'smooth',
            }
        }
        return {
            x: 0,
            y: 0,
            behavior: 'smooth',
        }
    }
})

export default router