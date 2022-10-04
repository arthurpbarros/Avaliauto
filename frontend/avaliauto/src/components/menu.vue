<script>
import api from "@/config/axios_config.js";
export default {
    components: {

    },
    data: () => {
        return {
            user: {
                email: "",
                password: ""
            }
        }
    },
    props: {
        mostrarMenu: {
            type: Boolean,
            default: true
        }
    },
    methods: {
        login() {
            if (this.user.email == "" || this.user.password == "") {
                this.$toast.error("Email ou senha nulo(a)", {
                    position: "top-right"
                });
            } else {
                // this.$refs['modal'].show();
                const data = { email: this.user.email, password: this.user.password };
                const resp = api.post("User/login/", data);
                resp.then(
                    (response) => {
                        const token_data = { 'token': `Token ${response.data.token}`, 'user_type': response.data.user_type, 'user_id': response.data.user_id, 'name': response.data.name };
                        sessionStorage.setItem("token", JSON.stringify(token_data));
                        this.$toast.success("Login efetuado com sucesso", {
                            position: "top-right"
                        });
                        this.removemodal_and_redirect("consultorias");
                    }
                ).catch(e => {
                    this.$toast.error(e.response.data.error, {
                        position: "top-right"
                    });
                });
            }
        },
        removemodal_and_redirect(nome_rota) {
            this.$refs["modal"].hide;
            document.body.style.overflow = "visible";
            document.body.classList.remove("modal-open");
            // document.body.style.paddingRight = "0px";
            const back = document.getElementsByClassName("modal-backdrop")[0];
            back.remove();
            this.$router.push({ name: nome_rota });
        },
        resetarMensagem(valor) {
            this.ativo = valor;
        }
    }
};
</script>
<template>
    <div class="row">
        <div class="col-12" id="menu">
            <div class="row">
                <div class="col-md-8 col-8" v-if="mostrarMenu">
                    <span class="item-menu-no-important">
                        <img src="../assets/logo.png" id="logo-menu" class="img-fluid">
                    </span>
                </div>
                <div class="col-md-4 col-4" v-if="mostrarMenu">
                    <b-button v-b-modal.modal-login variant="" class="item-menu botao-login">Login</b-button>
                </div>
                <div class="col-md-12 col-12 text-center" v-else>
                    <span class="item-menu-no-important">
                        <img src="../assets/logo.png" id="logo-menu-center" class="img-fluid">
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <b-modal id="modal-login" centered hide-footer ref="modal">
            <form @submit.prevent="login">
                <div class="text-center">
                    <img src="../assets/logoazul.png" id="logo">
                </div>
                <div>
                    <div class="mb-3 row">
                        <label for="staticEmail" class="col-sm-10 mx-auto texto-azul">Email</label>
                        <div class="col-sm-10 mx-auto">
                            <input type="text" class="form-control" id="email_login" placeholder="Email"
                                v-model="user.email" required>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="inputPassword" class="col-sm-10 mx-auto texto-azul">Senha</label>
                        <div class="col-sm-10 mx-auto">
                            <input type="password" class="form-control" id="senha_login" placeholder="Senha"
                                v-model="user.password" required>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="item-menu botao-login-center"> Login </button>
                        <button class="btn btn-link" @click="removemodal_and_redirect('cadastro')">Recuperar
                            senha</button>
                    </div>
                </div>
            </form>
        </b-modal>
    </div>
</template>
<style scoped>
/* @import "@/assets/base.css"; */
@import url('https://fonts.googleapis.com/css2?family=Koulen&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,700;1,700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@100;400;700&display=swap');

:root {
    --primary: #1540a4;
}

.no-padding {
    padding-left: 0;
    padding-right: 0;
}

input {
    padding: 5px 0 5px 0;
}

.texto-azul {
    color: #1540a4;
}

/* //menu item-menu-no-important logo-menu item-menu botao-login */
.bg-fundo-azul {
    background-color: #1540a4;
}

#logo-menu {
    width: 180px;
    margin-top: 8px;
    margin-bottom: 8px;
    margin-left: 5%;
    float: left;
}

#logo-menu-center {
    width: 180px;
    margin-top: 8px;
    margin-bottom: 8px;
}

* {
    font-family: 'Inter', sans-serif;
    /* font-family: 'Rubik', sans-serif;  */
    margin: 0px;
    padding: 0px;
}

#logo {
    width: 180px;
    margin-bottom: 20px;
}

#menu {
    background-color: #1540a4;
    min-height: 50px;
    width: 100%;
    color: #1540a4;
    font-size: 1em;
}

.botao-login {
    border: 0.05px solid #f9db6d;
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    margin-top: 5px;
    float: right;
    margin-right: 10px;
}

.item-menu {
    transition: all 0.4s;
    background-color: #f9db6d;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
}

.botao-login-center {
    border: 0.05px solid #f9db6d;
    height: 40px;
    padding-left: 10px;
    padding-right: 10px;
    margin-top: 5px;
    margin-right: 10px;
}

.item-menu:hover {
    /* border-bottom: 1px solid #1540a4; */
    color: #f9db6d;
    background-color: #1540a4;
    border-radius: 5px;
}

.item-menu-no-important {
    transition: all 0.4s;
    border-radius: 5px;
    line-height: 50px;
    padding: 8px;
    font-weight: bold;
    color: #f9db6d;
    text-align: center;
}

#corpo {
    background-color: #1540a4;
}

@media (min-width: 1041px) and (max-width: 1147px) {
    #h1-tipo-1-topo {
        margin-top: 10%;
    }
}

@media (min-width: 768px) and (max-width: 1040px) {
    #h1-tipo-1-topo {
        margin-top: 11%;
    }

    #h1-tipo-2 {
        margin-top: 10%;
        margin-bottom: 0%;
        /* background-color: #FBBC5C; */
    }

    #h1-tipo-1 {
        /* background-color: #1540a4; */
        margin-top: 10%;
        margin-bottom: 0%;
    }

    #h1-tipo-1,
    #h1-tipo-2,
    #h1-tipo-1-topo {
        font-size: 28pt;
        width: 95%;
    }

    p {
        margin-top: 5%;
        margin-bottom: 5%;
    }
}

@media (max-width: 767px) {

    #h1-tipo-1-topo,
    #h1-tipo-1,
    #h1-tipo-2 {
        margin-top: 10%;
    }

    .p-left {
        margin-top: 0%;
        margin-bottom: 10%;
        float: right;
    }

    #h1-tipo-2 {
        float: right;
    }
}
</style>