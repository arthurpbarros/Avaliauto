<script>
import MenuDashboard from '@/components/menu_dashboard.vue';
import TokenUser from '@/config/token_helper';
import api from '@/config/axios_config';
import Consultoria from '@/components/consultoria.vue';
export default {
    components: {
        MenuDashboard,
        Consultoria
    },
    data() {
        return {
            tipo: 1,
            secao_ativa: "todas",
            consultorias: []
        }
    },
    mounted() {
        this.init();
    },
    computed: {
        qnt_consultorias() {
            return this.consultorias.length;
        }
    },
    watch: {
        consultorias(new_value,old_value){
            if(JSON.stringify(new_value) !== JSON.stringify(old_value)){
                this.alerta_secao();
            }
        }
    },
    methods: {
        async init() {
            this.tipo = TokenUser.getType();
            try{
                const res = await api.get("Consultancy/list_custom", TokenUser.getHeaderToken());
                this.consultorias = res.data;
            }catch(erro){

                alert(erro);
            };
        },
        alerta_secao() {
            let texto = "";
            switch (this.secao_ativa) {
                case "todas":
                    texto = "Consultorias listadas";
                    break;
                default:
                    texto = `Consultorias ${this.secao_ativa} listadas`
                    break;
            }
            this.$toast.success(texto, {
                position: 'top-right',
            });
        },
        resetarMensagem(valor) {
            this.ativo = valor;
        },
        async trocar_classe(secao) {
            this.$refs[this.secao_ativa].classList.remove("ativo");
            this.secao_ativa = secao;
            this.$refs[this.secao_ativa].classList.add("ativo");
            this.$refs[this.secao_ativa].blur();
            try{
                let res;
            switch (this.secao_ativa) {
                case "todas":
                    res = await api.get("Consultancy/list_custom", TokenUser.getHeaderToken());
                    this.consultorias = res.data;
                    break;
                case "pendentes":
                    res = await api.get("Consultancy/list_pending", TokenUser.getHeaderToken());
                    this.consultorias = res.data;
                    break;
                case "aceitas":
                    res = await api.get("Consultancy/list_accepted", TokenUser.getHeaderToken());
                    this.consultorias = res.data;
                    break;
                case "finalizadas":
                    res = await api.get("Consultancy/list_finished", TokenUser.getHeaderToken());
                    this.consultorias = res.data;
                    break;
            }
            }catch (erro) {}
        },
        async excluir_consultoria(id) {
            var self = this;
            try {
                await api.delete(`Consultancy/${id}/`, TokenUser.getHeaderToken());
                self.trocar_classe(this.secao_ativa);
                this.$toast.success(`Consultoria #${id} excluída`, {
                    position: "top-right"
                });
            } catch (erro) {
                self.trocar_classe(this.secao_ativa);
                this.$toast.erro(`Erro ao excluir a consultoria #${id}`, {
                    position: "top-right"
                });
            };
            
        },
        async aceitar_consultoria(id) {
            try {
                const dados = {
                    status: "aceita",
                    mechanical: TokenUser.getUserId()
                };
                await api.patch(`Consultancy/${id}/`, dados, TokenUser.getHeaderToken());
                this.consultorias = []
                this.trocar_classe(this.secao_ativa);
                this.$toast.success(`Consultoria #${id} foi aceita`, {
                    position: "top-right"
                });
            } catch (erro) {
                this.trocar_classe(this.secao_ativa);
                this.$toast.error(`Erro ao aceitar a consultoria #${id}`, {
                    position: "top-right"
                });
                console.log(erro.data)
            };
        }
    }
}
</script>
<template>
    <div class="row" id="inicio">
        <MenuDashboard />
        <div class="col-10 offset-2 corpo">
            <div class="row navegacao text-center col-11 mx-auto">
                <div class="col-lg-3 col-md-3 col-sm-6 col-6">
                    <button class="btn ativo" @click="trocar_classe('todas')" ref="todas">
                        <font-awesome-icon icon="fa-solid fa-list" />
                        <p class="navigation-name"> Todas as consultorias </p>
                    </button>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-6">
                    <button class="btn" @click="trocar_classe('pendentes')" ref="pendentes">
                        <font-awesome-icon icon="fa-solid fa-calendar-check" />
                        <p class="navigation-name"> Consultorias pendentes</p>
                    </button>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-6">
                    <button class="btn" @click="trocar_classe('aceitas')" ref="aceitas">
                        <font-awesome-icon icon="fa-solid fa-check" />
                        <p class="navigation-name"> Consultorias aceitas </p>
                    </button>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-6">
                    <button class="btn" @click="trocar_classe('finalizadas')" ref="finalizadas">
                        <font-awesome-icon icon="fa-solid fa-flag-checkered" />
                        <p class="navigation-name"> Consultorias finalizadas</p>
                    </button>
                </div>
            </div>
            <div class="col-11 mx-auto consultorias">
                <div class="row">
                    <div class="col-sm-12 col-md-6 mb-3" v-for="consultoria in consultorias">
                        <div class="card" :key="consultoria.id">
                            <Consultoria :dados_consultoria="consultoria" @excluir="excluir_consultoria"
                                @aceitar="aceitar_consultoria" />
                        </div>
                    </div>
                    <div class="col-12 text-center mb-3">
                        <a href="#inicio" class="btn btn-secondary" id="botao_topo" v-show="qnt_consultorias > 2">
                            Voltar ao topo </a>
                    </div>
                    <div class="offset-10 col-2 text-center mb-3 fixed-bottom" v-show="tipo === 1">
                        <router-link :to="{ name: 'cadastro_consultoria' }" class="btn text-dark" id="nova_consultoria">
                            +
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
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

#nova_consultoria:hover {
    background-color: #fad44c;
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
</style>