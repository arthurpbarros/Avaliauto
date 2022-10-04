<script>
import MenuDashboard from '@/components/menu_dashboard.vue';
import TokenUser from '@/config/token_helper';
import api from "@/config/axios_config";
import axios from 'axios';
export default {
    components: {
        MenuDashboard,
    },
    data() {
        return {
            consultoria: {
                data_hora: "",
                detail: "",
                cep: "",
                street: "",
                number: "",
                district: "",
                city: "",
                client: "",
                vehicle_manufacturer: "23",
                vehicle_model: "",
                vehicle_year: "2010"
            },
            marcas: [],
            modelos: [],
            horario_minimo: ""
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.verificar_acesso();
            this.consultoria.client = String(TokenUser.getUserId());
            this.definir_data_hora_minima();
            this.captar_marcas_veiculos();
            this.captar_modelo_marca();
        },
        captar_marcas_veiculos() {
            axios.get("https://parallelum.com.br/fipe/api/v1/carros/marcas").then(
                (res) => {
                    this.marcas = res.data;
                }
            );
        },
        captar_modelo_marca(event = null) {
            let id_modelo = this.consultoria.vehicle_manufacturer;
            if (event !== null) {
                this.consultoria.vehicle_manufacturer = event.target.value;
                id_modelo = event.target.value;
            }

            axios.get(`https://parallelum.com.br/fipe/api/v1/carros/marcas/${id_modelo}/modelos`).then(
                (res) => {
                    this.modelos = res.data.modelos;
                    this.consultoria.vehicle_model = this.modelos[0].nome;
                }
            );
        },
        definir_data_hora_minima() {
            const data = new Date();
            this.horario_minimo = data;
            data.setDate(data.getDate() + 4);
            const d = String(data.getDate()).padStart(2, '0');
            const m = String(data.getMonth() + 1).padStart(2, '0');
            const y = String(data.getFullYear()).padStart(4, '0');
            const hor = String(data.getHours()).padStart(2, '0');
            const min = String(data.getMinutes()).padStart(2, '0');
            this.consultoria.data_hora = `${y}-${m}-${d}T${hor}:${min}`;
        },
        resgatar_cep() {
            const cep = parseInt(this.consultoria.cep);
            if (Number.isInteger(cep) && this.consultoria.cep.length === 8) {
                axios.get(`https://viacep.com.br/ws/${this.consultoria.cep}/json/`).then((res) => {
                    const info = res.data;
                    if (res.data.erro) {
                        this.$toast.error("CEP inválido", {
                            position: "top-right"
                        })
                        this.consultoria.street = "";
                        this.consultoria.district = "";
                        this.consultoria.city = "";
                    } else {
                        this.consultoria.street = info.logradouro;
                        this.consultoria.district = info.uf;
                        this.consultoria.city = info.localidade;
                    }
                }).catch((erro) => {

                });
            }
        },
        verificar_acesso() {
            if (TokenUser.getType() > 1) {
                this.$router.push({ name: "consultorias" });
            }
        },
        verificar_data() {
            return 0;
        },
        cadastrar() {
            // console.log(this.consultoria);
            if (this.consultoria.cep.trim() !== "" && this.consultoria.cep.trim().length === 8
                && this.consultoria.street.trim() !== "" && this.consultoria.district.trim() !== ""
                && this.consultoria.city.trim() !== "" && this.consultoria.vehicle_model.trim() !== ""
                && this.consultoria.number.trim() !== "" && String(this.consultoria.vehicle_year).trim() !== ""
            ) {
                const data_atual = new Date();
                const data_hora_consultoria = new Date(this.consultoria.data_hora);
                const diferenca_dias = (data_hora_consultoria - data_atual) / (1000 * 3600 * 24);
                if (diferenca_dias < 3.0) {
                    this.$toast.error("A data mínima da consultoria deve ocorrer pelo menos 3 dias a partir de hoje", {
                        position: "top-right"
                    });
                } else {
                    const dados = {
                        data_hora: this.consultoria.data_hora,
                        detail: this.consultoria.detail,
                        cep: this.consultoria.cep,
                        street: this.consultoria.street,
                        number: this.consultoria.number,
                        district: this.consultoria.district,
                        city: this.consultoria.city,
                        client: this.consultoria.client,
                        // vehicle_manufacturer: this.consultoria.vehicle_manufacturer,
                        vehicle_model: this.consultoria.vehicle_model,
                        vehicle_year: this.consultoria.vehicle_year
                    };
                    api.post("Consultancy/", dados, TokenUser.getHeaderToken()).then((res) => {
                        this.$toast.success("Consultoria cadastrada com sucesso", {
                            position: "top-right"
                        });
                        this.$router.push({ name: "consultorias" });
                    }).catch((erro) => {
                        this.$toast.error("Erro ao cadastrar a consultoria", {
                            position: "top-right"
                        });
                    });
                }
            } else {
                if (this.consultoria.cep.trim().length !== 8) {
                    this.$toast.error("O Campo CEP deve ter exatamente 8 digítos númericos", {
                        position: "top-right"
                    });
                } else {
                    this.$toast.error("Existem campos em branco, corrija-os!", {
                        position: "top-right"
                    });
                }
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
                    <div class="col-12 vertical-centered">
                        <div class="form row">
                            <form class="col-11 mx-auto mb-3 mt-3" @submit.prevent="cadastrar">
                                <div class="mb-5 mt-5 row">
                                    <router-link to="/consultorias" class="back"> Consultorias </router-link>
                                    <h5 class="highlight"> Cadastrar Consultoria</h5>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-sm-8 col-12">
                                        <label> Data e hora *</label>
                                        <input type="datetime-local" class="form-control" id="data_hora"
                                            v-model="consultoria.data_hora">
                                    </div>
                                    <div class="col-sm-4 col-12" id="confirmar_senha">
                                        <label> CEP *</label>
                                        <input type="text" class="form-control" id="cep" placeholder="01311000"
                                            v-model="consultoria.cep" @input="resgatar_cep" maxlength="8" required>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-sm-9 col-12">
                                        <label> Endereço *</label>
                                        <input type="text" class="form-control" id="endereco"
                                            placeholder="Avenida Paulista" v-model="consultoria.street" readonly>
                                    </div>
                                    <div class="col-sm-3 col-12" id="confirmar_senha">
                                        <label> Número</label>
                                        <input type="text" class="form-control" id="numero" placeholder="1000"
                                            v-model="consultoria.number" maxlength="10" required>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-sm-6 col-12">
                                        <label> Cidade *</label>
                                        <input type="text" class="form-control" id="cidade" placeholder="São Paulo"
                                            v-model="consultoria.city" readonly>
                                    </div>
                                    <div class="col-sm-6 col-12" id="confirmar_senha">
                                        <label> Estado</label>
                                        <input type="text" class="form-control" id="estado" placeholder="SP"
                                            v-model="consultoria.district" readonly>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-12 col-sm-8">
                                        <label> Detalhes</label>
                                        <textarea class="form-control" id="detalhes"
                                            placeholder="Detalhes da consultoria" maxlength="255" rows="3"></textarea>
                                    </div>
                                    <div class="col-12 col-sm-4" id="confirmar_senha">
                                        <label> Ano do veículo *</label>
                                        <input type="number" class="form-control" id="cep" placeholder="2000" min="1940"
                                            max="2023" v-model="consultoria.vehicle_year" required>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-sm-6 col-12" id="confirmar_senha">
                                        <label> Marca *</label>
                                        <select class="form-select" aria-label="marca"
                                            @change="captar_modelo_marca($event)"
                                            v-model="consultoria.vehicle_manufacturer">
                                            <option v-for="marca in marcas" :key="marca.codigo" :value="marca.codigo">
                                                {{ marca.nome }}</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-6 col-12" id="confirmar_senha">
                                        <label> Modelo *</label>
                                        <select class="form-select" aria-label="modelo"
                                            v-model="consultoria.vehicle_model">
                                            <option v-for="modelo in modelos" :key="modelo.codigo" :value="modelo.nome">
                                                {{ modelo.nome }}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="text-center mb-4">
                                    <button class="item-menu btn" type="submit"> Cadastrar </button>
                                    <router-link to="/consultorias" class="botao-secundario btn"> Cancelar
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
@media (max-height: 1520px) {
    .form {
        margin-top: 30px;
        margin-bottom: 30px;
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
}

.vertical-centered {
    display: flex;
    flex-direction: column;
    justify-content: center;
    min-height: 100vh;
}

label {
    color: #1540a4;
    text-align: center;
}

.corpo {
    background-color: whitesmoke;
    min-height: 100vh;
}
</style>