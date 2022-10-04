<script>
import MenuDashboard from '@/components/menu_dashboard.vue';
import TokenUser from '@/config/token_helper';
import Estrelas from '@/components/estrelas.vue';
import api from '@/config/axios_config';
export default {
    components: {
        MenuDashboard,
        Estrelas
    },
    data() {
        return {
            loading: true,
            avaliacao: {
                star_motor: 3,
                star_pneus: 3,
                star_suspensao: 3,
                star_pintura: 3,
                comment_motor: "",
                comment_pneus: "",
                comment_suspensao: "",
                comment_pintura: "",
                consultancy: 0
            }
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.verificar_acesso();
        },
        captarEstrelaParteCarro(parte_carro, valor) {
            switch (parte_carro) {
                case "motor":
                    this.avaliacao.star_motor = valor;
                    break;
                case "pneus":
                    this.avaliacao.star_pneus = valor;
                    break;
                case "suspensao":
                    this.avaliacao.star_suspensao = valor;
                    break;
                case "pintura":
                    this.avaliacao.star_pintura = valor;
                    break;
            }
        },
        avaliar() {
            if (this.avaliacao.comment_motor.trim() !== "" && this.avaliacao.comment_pintura.trim() !== "" &&
                this.avaliacao.comment_suspensao.trim() !== "" && this.avaliacao.comment_pneus.trim() !== "") {
                const dados = {
                    star_motor: this.avaliacao.star_motor,
                    star_pneus: this.avaliacao.star_pneus,
                    star_suspensao: this.avaliacao.star_suspensao,
                    star_pintura: this.avaliacao.star_pintura,
                    comment_motor: this.avaliacao.comment_motor,
                    comment_pneus: this.avaliacao.comment_pneus,
                    comment_suspensao: this.avaliacao.comment_suspensao,
                    comment_pintura: this.avaliacao.comment_pintura,
                    consultancy: this.avaliacao.consultancy
                };
                api.post('Review/', dados, TokenUser.getHeaderToken()).then((res) => {
                    const consultoria_atualizada = {
                        status: "finalizada"
                    }
                    api.patch(`Consultancy/${this.avaliacao.consultancy}/`, consultoria_atualizada, TokenUser.getHeaderToken()).then((res) => {
                        this.$toast.success("Avaliação cadastrada", {
                            position: "top-right"
                        });
                        this.$router.push({ name: 'consultorias' });
                    }).catch(() => {
                        this.$toast.error("Erro ao cadastrar a consultoria", {
                            position: "top-right"
                        });
                    });
                }).catch((erro) => {
                    this.$toast.error("Erro ao cadastrar a consultoria", {
                        position: "top-right"
                    });
                });
            } else {
                this.$toast.error("Existem campos em branco", {
                    position: "top-right"
                });
            }
        },
        verificar_acesso() {
            //Verificar se o usuário é um mecânico
            if (TokenUser.getType() !== 2) {
                this.$router.push({ name: "consultorias" });
            } else {
                const id = parseInt(this.$route.params.id);
                /*
                    Verificar se o id da rota é um inteiro,
                    Verificar se existe uma consultoria com esse id,
                    Verificar se o status da consultoria é realizado
                    Verificar se o mecânico é o responsável pela consultoria,
                    Verificar se a consultoria tem avaliacao
                    Atualizar o status da consultoria para finalizada
                */

                // Verificar se o id da rota é um inteiro,
                // if (Number.isInteger(id) && id > 0) {
                api.get(`Consultancy/${id}`, TokenUser.getHeaderToken()).then((res) => {
                    const consultoria = res.data;
                    //Verificar se a consultoria tem status aceita e o mecânico logado é o responsável
                    if (consultoria.status === "aceita" && consultoria.mechanical === TokenUser.getUserId()) {
                        //Verifica se a consultoria já foi avaliada
                        api.get(`Review/${consultoria.id}/get_by_consultancy`, TokenUser.getHeaderToken())
                            .then((resposta) => {
                                this.$toast.error("A consultoria já foi avaliada!", {
                                    position: 'top-right'
                                });
                                this.$router.push({ name: "consultorias" });
                            }
                            ).catch((error) => {
                                this.avaliacao.consultancy = consultoria.id;
                                this.loading = false;
                            });
                    } else {
                        this.$router.push({ name: "consultorias" });
                    }
                }
                ).catch((erro) => {
                    this.$router.push({ name: "consultorias" });
                });
                // } else {
                //     this.$router.push({ name: "consultorias" });
                // }
            }
        }
    }
};
</script>
<template>
    <div class="row" id="inicio">
        <MenuDashboard />
        <div class="col-10 offset-2 corpo">
            <div class="col-11 mx-auto consultorias">
                <div class="row">
                    <div class="col-12">
                        <div class="form row">
                            <div class="d-flex align-items-center justify-content-center mt-5">
                                <div class="spinner-grow text-primary" style="width: 3rem; height: 3rem;" role="status" v-show="loading">
                                    <span class="sr-only">Loading...</span>
                                </div>
                                <div class="spinner-grow text-warning" style="width: 3rem; height: 3rem;" role="status" v-show="loading">
                                    <span class="sr-only">Loading...</span>
                                </div>
                                <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status" v-show="loading">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                            <form class="col-11 mx-auto mb-5 mt-5" @submit.prevent="avaliar" v-show="(!loading)">
                                <div class="mb-5 row">
                                    <router-link to="/consultorias" class="back"> Consultorias </router-link>
                                    <h5 class="highlight"> Avaliar Consultoria</h5>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label> Motor </label>
                                    </div>
                                    <div class="col-12" id="confirmar_senha">
                                        <textarea class="form-control" id="motor" placeholder="Comentário"
                                            v-model="avaliacao.comment_motor" maxlength="300" rows="3"
                                            required></textarea>
                                        <Estrelas :parte_carro="'motor'" @captar-nota="captarEstrelaParteCarro" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label> Pneus </label>
                                    </div>
                                    <div class="col-12" id="confirmar_senha">
                                        <textarea class="form-control" id="pneus" placeholder="Comentário"
                                            v-model="avaliacao.comment_pneus" maxlength="300" rows="3"
                                            required></textarea>
                                        <Estrelas :parte_carro="'pneus'" @captar-nota="captarEstrelaParteCarro" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label> Suspensão </label>
                                    </div>
                                    <div class="col-12" id="confirmar_senha">
                                        <textarea class="form-control" id="suspensao" placeholder="Comentário"
                                            v-model="avaliacao.comment_suspensao" maxlength="300" rows="3"
                                            required></textarea>
                                        <Estrelas :parte_carro="'suspensao'" @captar-nota="captarEstrelaParteCarro" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label> Pintura </label>
                                    </div>
                                    <div class="col-12" id="confirmar_senha">
                                        <textarea class="form-control" id="pintura" placeholder="Comentário"
                                            v-model="avaliacao.comment_pintura" maxlength="300" rows="3"
                                            required></textarea>
                                        <Estrelas :parte_carro="'pintura'" @captar-nota="captarEstrelaParteCarro" />
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button class="item-menu btn" type="submit"> Avaliar </button>
                                    <router-link :to="{ name: 'consultorias' }" class="botao-secundario btn"> Cancelar
                                    </router-link>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
@media (max-width: 820px) and (min-width: 766px) {
    .icon-group svg {
        width: 100%;
    }

    .icon-group .card-text {
        width: 100%;
        text-align: center;
    }
}

.item-menu {
    transition: all 0.4s;
    background-color: #f9db6d;
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

.botao-secundario {
    transition: all 0.4s;
    background-color: #ffffff;
    border-radius: 5px;
    font-weight: bold;
    color: #1540a4;
    margin-right: 10px;
}

.back {
    font-weight: bold;
    color: gray;
    font-size: 1.1em;
}

h5.highlight {
    font-weight: bold;
    color: #1540a4;
    font-size: 1.2em;
    text-transform: uppercase;
}

.form {
    background-color: white;
    min-height: 90vh;
    margin-top: 5vh;
    margin-bottom: 5vh;
}

label {
    color: #1540a4;
    text-align: center;
}

textarea {
    margin-top: 20px;
    color: black;
}

.corpo {
    background-color: whitesmoke;
    min-height: 100vh;
}

.navegacao {
    margin-top: 20px;
    margin-bottom: 20px;
}

.navegacao button {
    text-transform: uppercase;
    font-size: 0.9em;
    font-weight: 700;
    color: #1540a4;
    margin-bottom: 20px;
    transition: all 0.3s;
    background-color: whitesmoke;
}

.navegacao button:not(.ativo):hover {
    background-color: #1540a4;
    color: whitesmoke;
    -webkit-box-shadow: 1px 1px 2px 2px #1540a4;
    box-shadow: 1px 1px 2px 2px #1540a4;
}

.navegacao .ativo {
    color: black;
    background-color: #f9db6d;
    -webkit-box-shadow: 1px 1px 2px 1px #f9db6d;
    box-shadow: 1px 1px 2px 1px #f9db6d;
}

.card-title {
    /* font-family: 'Open Sans',sans-serif; */
    font-weight: 700;
    font-size: 1.1em;
    margin-bottom: 30px;
}

.card {
    background-color: rgb(252, 252, 252);
    border: 1px solid #ececec;
    -webkit-box-shadow: 1px 1px 10px 2px #ececec;
    box-shadow: 1px 1px 10px 2px #ececec;
    transition: all 0.3s;
}

.card:hover {
    background-color: #ececec;
    -webkit-box-shadow: 1px 1px 10px 2px #aab4bd;
    box-shadow: 1px 1px 10px 2px #aab4bd;
}

.card-text {
    font-size: 12pt;
    /* font-family: 'Open Sans', sans-serif; */
}

.icon-group {
    margin-bottom: 10px;
}

.icon-group svg {
    color: #194abe;
    margin-right: 20px;
    float: left;
    margin-top: 3px;
}

.button svg {
    color: white;
}

.acoes {
    margin-right: 10px;
}

#nova_consultoria {
    float: right;
    margin-right: 20px;
    background-color: #f9db6d;
    font-weight: bold;
    border-radius: 50%;
    width: 60px;
    height: 60px;
    font-size: 30px;
    padding: 5px;
}
.spinner-grow{
    margin-right: 10px;
}
</style>