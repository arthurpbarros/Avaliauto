<script>
import MenuComponent from '@/components/menu.vue';
import api from "@/config/axios_config.js";
export default {
    components: {
        MenuComponent,
    },
    data() {
        return {
            user: {
                email: "",
                nome: "",
                sobrenome: "",
                senha: "",
                c_senha: "",
                tipo: "1",
                telefone: ""
            }
        }
    },
    methods: {
        cadastrar(e) {
            e.preventDefault();
            //Verificar campos vazios
            if (this.user.email.trim() === "" || this.user.nome.trim() === "" || this.user.sobrenome.trim() === "" || this.user.senha.trim() === "" || this.user.c_senha.trim() === "" || this.user.telefone.trim() === "") {
                this.$toast.error("Existem campos em branco", {
                    position: "top-right"
                });
            } else if (this.user.c_senha === this.user.senha && this.user.senha.trim() !== "") {
                //Verificar telefone
                if (Number.isInteger(parseInt(this.user.telefone.trim())) && this.user.telefone.trim().length === 11) {
                    //Verificar senha
                    if (this.user.senha.trim().length >= 6 && this.user.senha.trim().length <= 50) {
                        const dados = {
                            email: this.user.email,
                            first_name: this.user.nome,
                            last_name: this.user.sobrenome,
                            tel: this.user.telefone,
                            password: this.user.senha,
                            type: this.user.tipo
                        };
                        const resp = api.post("User/", dados);
                        resp.then(
                            (response) => {
                                this.$toast.success("Usuário cadastrado!", {
                                    position: "top-right"
                                });
                                this.$router.push({ name: "login" });
                            }
                        ).catch(e => {
                            const erros = e.response.data;
                            console.log(erros);
                            let dado = "";
                            for (var erro in erros) {
                                dado = `${erro}: ${erros[erro]}`;
                                dado = dado.replace("first_name", "Primeiro nome");
                                dado = dado.replace("last_name", "Sobrenome");
                                dado = dado.replace("tel", "Telefone");
                                dado = dado.replace("password", "Senha");
                                dado = dado.replace("email", "Email");
                                this.$toast.error(dado, {
                                    position: "top-right"
                                })
                            }
                        });
                    } else {
                        this.$toast.error("Senha tem menos de 6 caracteres", {
                            position: "top-right"
                        });
                    }
                } else {
                    this.$toast.error("Telefone não tem 11 digítos ou tem caracteres inválidos", {
                        position: "top-right"
                    });
                }
            } else {
                this.$toast.error("As senhas não conferem", {
                    position: "top-right"
                });
            }
        },
        resetarMensagem(valor) {
            this.ativo = valor;
        }
    }
};
</script>
<template>
    <MenuComponent :mostrarMenu="false" />
    <div class="row centralizar">
        <div class="col-md-8 col-11 mx-auto mt-5 mb-4 pt-4 pb-4 rounded corpo">
            <h1 id="h1-tipo-2"> Cadastre-se na plataforma e comece a realizar consultorias </h1>
            <form>
                <div class="mb-3 row">
                    <div class="col-sm-5 offset-sm-1 col-12">
                        <label> Nome *</label>
                        <input type="text" class="form-control" id="nome" placeholder="Nome" v-model="user.nome">
                    </div>
                    <div class="col-sm-5 col-12" id="confirmar_senha">
                        <label> Sobrenome *</label>
                        <input type="text" class="form-control" id="sobrenome" placeholder="Sobrenome"
                            v-model="user.sobrenome">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="staticEmail" class="col-sm-10 offset-sm-1 col-form-label">Email *</label>
                    <div class="col-sm-10 offset-sm-1">
                        <input type="email" class="form-control" id="email" placeholder="Email" v-model="user.email">
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class="col-sm-5 offset-sm-1 col-12">
                        <label> Senha *</label>
                        <input type="password" class="form-control" id="senha" placeholder="Senha" v-model="user.senha">
                    </div>
                    <div class="col-sm-5 col-12" id="confirmar_senha">
                        <label> Confirmar Senha *</label>
                        <input type="password" class="form-control" id="csenha" placeholder="Confirmar Senha"
                            v-model="user.c_senha">
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class="col-sm-5 offset-sm-1 col-12">
                        <label> Tipo *</label>
                        <select class="form-select text-secondary" aria-label="Default select example"
                            v-model="user.tipo">
                            <option value="1" selected>Cliente</option>
                            <option value="2">Mecânico</option>
                        </select>
                    </div>
                    <div class="col-sm-5 col-12" id="confirmar_senha">
                        <label> Telefone *</label>
                        <input type="tel" class="form-control" id="tel" placeholder="00912345678"
                            v-model="user.telefone">
                    </div>
                </div>

                <div class="text-center">
                    <button class="item-menu btn" @click="cadastrar"> Cadastrar </button>
                    <router-link to="/" class="botao-secundario btn"> Cancelar
                    </router-link>
                </div>
            </form>
        </div>
    </div>
</template>
<style>
body {
    background-color: #1540a4 !important;
}
</style>
<style scoped>
@media (max-width: 575px) {
    #confirmar_senha {
        margin-top: 15px;
    }
}

input {
    color: rgb(88, 81, 13);
}

.item-menu {
    transition: all 0.4s;
    background-color: #f9db6d;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
    margin-right: 10px;
}

.botao-secundario {
    transition: all 0.4s;
    background-color: #ffffff;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
    margin-right: 10px;
}

.item-menu:hover {
    /* border-bottom: 1px solid #1540a4; */
    color: #f9db6d;
    background-color: #1540a4;
    border-radius: 5px;
}


.centralizar {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 90vh;
}

.corpo {
    -webkit-box-shadow: 1px 1px 10px 2px #aeb1b9;
    box-shadow: 1px 1px 10px 2px #aeb1b9;
    background-color: white;
    color: #1540a4;
    max-width: 600px;
}

#h1-tipo-2 {
    color: var(--primary);
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
    font-size: 1.5em;
    max-width: 80%;
    margin-left: 10%;
    /* margin-right: 10%; */
}
</style>