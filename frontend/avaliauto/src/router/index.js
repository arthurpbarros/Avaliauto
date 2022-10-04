import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
    scrollBehavior(to, from, savedPosition) {
        // scroll to top
        return { top: 0 }
    },
    history: createWebHistory(),
    routes: [
        {
            path: "/",
            name: "login",
            component: () => import("../views/LoginView.vue")
        },
        {
            path: "/cadastro",
            name: "cadastro",
            component: () => import("../views/CadastroView.vue")
        },
        {
            path: "/consultorias",
            name: "consultorias",
            component: () => import("../views/ConsultoriasView.vue")
        },
        {
            path: "/consultorias/avaliar/:id",
            name: "avaliar",
            props: true,
            component: () => import("../views/AvaliarConsultoria.vue")
        },
        {
            path: "/consultorias/cadastrar",
            name: "cadastro_consultoria",
            component: () => import("../views/CadastrarConsultoria.vue")
        },
        {
            path: "/consultorias/visualizar/:id",
            name: "visualizar_consultoria",
            props: true,
            component: () => import("../views/VisualizarConsultoria.vue")
        }
        // {
        //   path: "*",
        //   name: "not_found",
        //   // route level code-splitting
        //   // this generates a separate chunk (About.[hash].js) for this route
        //   // which is lazy-loaded when the route is visited.
        //   component: () => import("../views/LoginView.vue"),
        // },
    ]
});

router.beforeEach((to, from) => {
    const paginas_permitidas = ["login", "cadastro"];
    const e_permitida = paginas_permitidas.indexOf(to.name) == -1 ? false : true;

    if (!e_permitida && !sessionStorage.getItem("token")) {
        return { name: "login" };
    }
})

export default router;
