<script>
import TokenUser from '@/config/token_helper';
export default {
    emits: ['excluir','aceitar'],
    data() {
        return {
            consultoria: {},
            tipo_usuario: 1
        }
    },
    props: {
        dados_consultoria: {
            type: Object,
            required: true
        }
    },
    created() {
        this.formatar_data_hora();
        this.tipo_usuario = TokenUser.getType();
    },
    methods: {
        formatar_data_hora() {
            this.consultoria = this.dados_consultoria;
            const data = new Date(this.consultoria.data_hora);
            const d = String(data.getDate()).padStart(2, '0');
            const m = String(data.getMonth() + 1).padStart(2, '0');
            const y = String(data.getFullYear()).padStart(4, '0');
            const hor = String(data.getHours()).padStart(2, '0');
            const min = String(data.getMinutes()).padStart(2, '0');
            this.consultoria.data = `${d}-${m}-${y}`;
            this.consultoria.hora = `${hor}h${min}min`;
        },
        excluir_consultoria(id){
            this.$emit("excluir",id);
        },
        aceitar_consultoria(id){
            this.$emit("aceitar",id);
        }
    }
};
</script>
<template>
    <div class="card-body">
        <h5 class="card-title">Consultoria #{{ consultoria.id }}</h5>
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
                <p class="card-text col-12">{{ consultoria.city }}</p>
            </div>
        </div>
        <div class="text-center">
            <!-- Link para visualizar consultoria -->
            <router-link :to="{ name: 'visualizar_consultoria',params: {id: consultoria.id}}" class="btn btn-primary acoes">
                <font-awesome-icon icon="fa-solid fa-circle-info" />
            </router-link>
            <!-- Ação de aceitar consultoria -->
            <button class="btn btn-success acoes" v-if="consultoria.status === 'pendente' && tipo_usuario === 2"
                @click="aceitar_consultoria(consultoria.id)">
                <font-awesome-icon icon="fa-solid fa-circle-check" />
            </button>
            <!-- Link para avaliar consultoria -->
            <router-link :to="{ name: 'avaliar', params: { id: consultoria.id } }" class="btn btn-secondary acoes"
                v-if="consultoria.status === 'aceita' && tipo_usuario === 2">
                <font-awesome-icon icon="fa-solid fa-star" />
            </router-link>
            <!-- Ação de apagar consultoria -->
            <button class="btn btn-danger acoes" v-if="tipo_usuario === 1 && consultoria.status !== 'finalizada'"
                @click="excluir_consultoria(consultoria.id)">
                <font-awesome-icon icon="fa-solid fa-trash" />
            </button>
        </div>
    </div>
</template>
<style scoped>
.card-title {
    /* font-family: 'Open Sans',sans-serif; */
    font-weight: 700;
    font-size: 1.1em;
    margin-bottom: 30px;
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
    float: left;
    margin-left: 20px;
    margin-right: 20px;
    margin-top: 3px;
}

.button svg,
a svg {
    color: white;
}

.acoes {
    margin-right: 5px;
}
</style>