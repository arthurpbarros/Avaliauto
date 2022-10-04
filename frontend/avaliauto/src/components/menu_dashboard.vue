<script>
import api from '@/config/axios_config';
import TokenUser from '@/config/token_helper';

export default {
    created() {
        this.init();
    },
    data(){
        return {
            nome: ""
        }
    },
    methods: {
        init(){
            this.nome = TokenUser.getName();
        },
        logout() {
            const config = TokenUser.getHeaderToken();
            api.get("User/logout/",config).then(
                (response) => {
                    sessionStorage.removeItem("token");
                    this.$toast.success(response.data.message, {
                        position: "top-right"
                    });
                    this.$router.push({ name: "login" });
                }
            ).catch(
                (e) => {
                    this.$toast.error("Erro ao fazer logout", {
                        position: "top-right"
                    });
                }
            );
        }
    }
};
</script>
<template>
    <div class="col-2 menu">
        <ul class="mt-5">
            <li class="info-user">
                <a href="">
                    <font-awesome-icon icon="fa-solid fa-user" /> <span class="texto-menu">{{nome}}</span>
                </a>
            </li>
            <li>
                <router-link to="/consultorias">
                    <font-awesome-icon icon="fa-solid fa-car" /> <span class="texto-menu">Consultorias</span>
                </router-link>
            </li>
            <li>
                <a href="">
                    <font-awesome-icon icon="fa-solid fa-wrench" /> <span class="texto-menu">Configurações</span>
                </a>
            </li>
            <li class="logout-user" @click="logout()">
                <div class="logout">
                    <font-awesome-icon icon="fa-solid fa-arrow-right-from-bracket" /> <span class="texto-menu logout">
                        Logout </span>
                </div>
            </li>
        </ul>
    </div>
</template>
<style scoped>
@media (max-width: 1100px) {
    .texto-menu {
        display: none;
    }

    ul li {
        width: 50px;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
}

.texto-menu {
    margin-left: 10px;
}

ul {
    list-style-type: none;
    padding: 0px;
    text-align: center;
}

ul li {
    height: 50px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    font-weight: 700;
    font-size: 0.8em;
    margin-bottom: 5px;
    text-transform: uppercase;
    transition: all 0.3s;
}

ul li:not(.info-user):not(.logout-user):hover {
    background-color: #f9db6d;
}

ul li:not(.info-user):not(.logout-user):hover a {
    color: black;
}

ul .info-user a {
    color: white;
}

li a {
    color: white;
    height: 100%;
    line-height: 50px;
}

ul .logout-user {
    background-color: rgb(221, 93, 93);
}

.logout {
    color: white;
}

.logout svg {
    color: white;
    -webkit-transform: rotate(180deg);
    transform: rotate(180deg);
}

.menu {
    position: fixed;
    height: 100vh;
    background-color: #1540a4;
}
</style>