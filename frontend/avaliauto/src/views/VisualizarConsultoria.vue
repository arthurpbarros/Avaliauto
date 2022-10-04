<script>
import MenuDashboard from '@/components/menu_dashboard.vue';
import TokenUser from '@/config/token_helper';
import api from '@/config/axios_config';
import EstrelaEstatica from '@/components/estrelas_estaticas.vue'
export default {
    components: {
        MenuDashboard,
        EstrelaEstatica
    },
    data() {
        return {
            loading: true,
            id: this.$route.params.id,
            avaliacao: null,
            consultoria: null,
            cliente: null,
            mecanico: null
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.verificar_acesso();
        },
        verificar_acesso() {
            const consultoria_id = this.id;
            api.get(`Consultancy/${consultoria_id}`, TokenUser.getHeaderToken()).then(res => {
                this.consultoria = res.data;
                const self = this;
                api.get(`User/${this.consultoria.client}`, TokenUser.getHeaderToken()).then(user => {
                    self.cliente = user.data;
                });
                if (this.consultoria.mechanical !== null) {
                    api.get(`User/${this.consultoria.mechanical}`, TokenUser.getHeaderToken()).then(user => {
                        self.mecanico = user.data;
                    });
                }
                if (this.consultoria.status === "finalizada") {
                    api.get(`Review/${this.consultoria.id}/get_by_consultancy/`, TokenUser.getHeaderToken()).then(res => {
                        self.avaliacao = res.data;
                    });
                }
                if ((TokenUser.getType() === 1 && this.consultoria.client == TokenUser.getUserId())
                    || (TokenUser.getType() === 2 && this.consultoria.status === "pendente")
                    || (TokenUser.getType() === 2 && this.consultoria.mechanical === TokenUser.getUserId())
                ) {
                    this.formatar_data_hora();
                    self.loading = false;
                } else {
                    this.$router.push({ name: "consultorias" });
                }
            }).catch((erro) => {
                this.$router.push({ name: "consultorias" });
            });
        },
        formatar_data_hora() {
            const data = new Date(this.consultoria.data_hora);
            const d = String(data.getDate()).padStart(2, '0');
            const m = String(data.getMonth() + 1).padStart(2, '0');
            const y = String(data.getFullYear()).padStart(4, '0');
            const hor = String(data.getHours()).padStart(2, '0');
            const min = String(data.getMinutes()).padStart(2, '0');
            this.consultoria.data = `${d}-${m}-${y}`;
            this.consultoria.hora = `${hor}h${min}min`;
        }
    }
}
</script>
<template>
    <div class="row">
        <MenuDashboard />
        <div class="col-10 offset-2 corpo">
            <div class="col-11 mx-auto consultorias">
                <div class="row">
                    <div class="col-12">
                        <div class="form row">
                            <div class="d-flex align-items-center justify-content-center mt-5" v-if="loading">
                                <div class="spinner-grow text-primary" style="width: 3rem; height: 3rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                                <div class="spinner-grow text-warning" style="width: 3rem; height: 3rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                                <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                            <div class="col-11 mx-auto mb-5 mt-5" v-else>
                                <div class="mb-5 row">
                                    <router-link to="/consultorias" class="back"> Consultorias </router-link>
                                    <h5 class="highlight"> Visualizar Consultoria <span class="id_consultoria">#{{
                                            consultoria.id
                                    }}</span></h5>
                                </div>
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title"> Informações da Consultoria</h5>
                                        <div class="row mb-3">
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-calendar" />
                                                <p class="card-text ">{{ consultoria.data }}</p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-clock" />
                                                <p class="card-text "> {{ consultoria.hora }}</p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-car" />
                                                <p class="card-text ">{{ consultoria.vehicle_model }}</p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-street-view" />
                                                <p class="card-text col-12">{{ consultoria.street }},
                                                    {{ consultoria.number }}</p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-street-view" />
                                                <p class="card-text col-12">CEP: {{ consultoria.cep }}</p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-building" />
                                                <p class="card-text col-12">{{ consultoria.city
                                                }}-{{ consultoria.district }}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body" v-if="cliente !== null">
                                        <h5 class="card-title"> Informações do Cliente </h5>
                                        <div class="row mb-3">
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-user" />
                                                <p class="card-text ">{{ cliente.first_name }} {{ cliente.last_name }}
                                                </p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-envelope" />
                                                <a v-bind:href="'mailto:' + cliente.email">{{ cliente.email }}</a>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-phone" />
                                                <p class="card-text "> {{ cliente.tel }}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body" v-if="mecanico !== null">
                                        <h5 class="card-title"> Informações do Mecânico </h5>
                                        <div class="row mb-3">
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-user" />
                                                <p class="card-text "> {{ mecanico.first_name }} {{ mecanico.last_name }}
                                                </p>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-envelope" />
                                                <a v-bind:href="'mailto:' + mecanico.email">{{ mecanico.email }}</a>
                                            </div>
                                            <div class="col-12 icon-group">
                                                <font-awesome-icon icon="fa-solid fa-phone" />
                                                <p class="card-text "> {{ mecanico.tel }}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body" v-if="avaliacao !== null">
                                        <h5 class="card-title"> Avaliação </h5>
                                        <div class="row">
                                            <div class="col-sm-6 col-md-3">
                                                <EstrelaEstatica :valor="avaliacao.star_motor" :parte_carro="'Motor'"/>
                                            </div>
                                            <div class="col-sm-6 col-md-3">
                                                <EstrelaEstatica :valor="avaliacao.star_pintura" :parte_carro="'Pintura'"/>
                                            </div>
                                            <div class="col-sm-6 col-md-3">
                                                <EstrelaEstatica :valor="avaliacao.star_suspensao" :parte_carro="'Suspensão'"/>
                                            </div>
                                            <div class="col-sm-6 col-md-3">
                                                <EstrelaEstatica :valor="avaliacao.star_pneus" :parte_carro="'Pneus'"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
/* @media (max-width: 820px) and (min-width: 766px) {
    .icon-group svg {
        width: 100%;
    }

    .icon-group .card-text {
        width: 100%;
        text-align: center;
    }
} */

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

.corpo {
    background-color: whitesmoke;
    min-height: 100vh;
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

.spinner-grow {
    margin-right: 10px;
}

.id_consultoria {
    color: black;
}
</style>